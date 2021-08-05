class ApplicationController < ActionController::Base
    include AuthenticationHelper
    before_action do
        I18n.locale = :nl
        head :unauthorized unless request.session['cas'].present?
    end
end
