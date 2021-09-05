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

    def require_admin
        unless signed_in? && current_user.login.in?(admins)
            head :forbidden
        end
    end

    def require_user
        head :forbidden unless signed_in?
    end

    def admins
        ENV['SPOTTER_ADMINS'] && ENV['SPOTTER_ADMINS'].split(":") || []
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
