class UsersController < ApplicationController
    def create
        current_user.update(params.require(:user).permit(:name, :email))
        redirect_to :root
    end

    def logout
        session.delete['cas']
        @current_user = nil
        redirect_to root_url
    end
end
