class ApplicationController < ActionController::Base
    include AuthenticationHelper
    before_action do
        head :unauthorized unless request.session['cas'].present?
    end
end
