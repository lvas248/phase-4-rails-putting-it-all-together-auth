class SessionsController < ApplicationController

    #login feature
    def create
        user = User.find_by(username: params[:username])
        # byebug
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :ok
        else
            # Figure out what they are asking for - returns an array of error messages in body
            render json: {errors: ["Error"] }, status: :unauthorized
        end
    end

    def destroy
        if session[:user_id]
            session.delete :user_id
            head :no_content
        else
            render json: {errors: ["Error"] }, status: :unauthorized
        end
    end

    private

    def session_params
        params.permit(:username, :password)
    end
end
