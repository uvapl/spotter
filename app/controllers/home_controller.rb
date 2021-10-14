class HomeController < ApplicationController
    # redirect to register or provide a bumper page
    def index
        unless signed_in?
            redirect_to(new_user_path(goto: params[:goto])) and return
        end
    end
end
