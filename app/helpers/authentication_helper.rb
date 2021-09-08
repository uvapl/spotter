module AuthenticationHelper
    def authenticated?
        return request.session['cas'].present? && request.session['cas']['user'].present?
    end

    def signed_in?
        return authenticated? && current_user.persisted?
    end

    def current_user
        @current_user ||= load_current_user
    end

    def require_user
        head :forbidden unless signed_in?
    end

    def require_admin
        unless signed_in? && current_user_admin?
            head :forbidden
        end
    end

    def require_assistant
        unless signed_in? && (current_user_assistant? || current_user_admin?)
            head :forbidden
        end
    end

    def current_user_admin?
        current_user.login.in?(admins)
    end

    def admins
        ENV['SPOTTER_ADMINS'] && ENV['SPOTTER_ADMINS'].split(":") || []
    end

    def current_user_assistant?
        current_user.login.in?(assistants)
    end

    def assistants
        ENV['SPOTTER_TAS'] && ENV['SPOTTER_TAS'].split(":") || []
    end

    private

    def load_current_user
        if request.session['cas'].present?
            login = request.session['cas']['user'].downcase
            return User.find_by_login(login) || User.new(login: login)
        else
            raise "Tried to load current_user before allowing CAS to intervene."
        end
    end
end
