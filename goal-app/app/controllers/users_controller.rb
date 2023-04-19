class UsersController < ApplicationController
    def new

    end

    def show

    end

    def index

    end

    def create
        @user = User.new(user_params)

        if @user.save
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new, status: 422
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
