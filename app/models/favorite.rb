class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post, class_name: "Micropost"
end
