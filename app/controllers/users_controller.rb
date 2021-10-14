class UsersController < ApplicationController

    # provide user registration form
    def new
    end

    def create
        current_user.update(params.require(:user).permit(:name, :email))
        if !current_user.valid?
            render :new, status: :unprocessable_entity
        else
            # goto "previous" url or else to root
            redirect_to params[:goto] || :root
        end
    end

    def logout
        session.delete['cas']
        @current_user = nil
        redirect_to root_url
    end

end
