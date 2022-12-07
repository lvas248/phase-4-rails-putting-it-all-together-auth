class RecipeSerializer < ActiveModel::Serializer
  attributes :title, :instructions, :minutes_to_complete, :id

  has_one :user

end
