class UsersController < ApplicationController

    wrap_parameters format: []
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid

    #sign up feature    post /signup
    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
    end

    #logged in? Keeps user logged in when page refreshes    get /me
    def show
        user = User.find_by(id: session[:user_id])
        if user
            render json: user, status: :created
        else
            render json: {error: "No user logged in"}, status: :unauthorized
        end
    end



    private

    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end

    def render_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
