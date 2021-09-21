class ApplicationController < ActionController::Base
    include AuthenticationHelper
    before_action :require_authentication
end
