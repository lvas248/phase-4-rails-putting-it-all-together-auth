class RecipesController < ApplicationController
    before_action :authorize
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid

    def index
        render json: Recipe.all, status: :ok
    end

    def create
        recipe = Recipe.new(recipe_params)
        recipe.user = User.find(session[:user_id])
        recipe.save!
        # byebug
        render json: recipe, status: :created
        #throwing an error: User must exist
    end


    private

    def authorize
        return render json: {errors: ["not authorized"]}, status: :unauthorized unless session.include? :user_id
    end

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

    def render_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

end
