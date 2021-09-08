class HomeController < ApplicationController
    # redirect to register or provide a bumper page
    def index
        unless signed_in?
            redirect_to(home_register_path(goto: params[:goto])) and return
        end
    end

    # provide user registration form
    def register
    end
end
