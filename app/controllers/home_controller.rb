class HomeController < ApplicationController
    def index
        redirect_to planner_index_path and return if signed_in?
    end
end
