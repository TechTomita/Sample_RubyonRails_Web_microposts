class User < ApplicationRecord
    has_many :microposts
    has_many :relationships
    has_many :followings, through: :relationships, source: :follow
    has_many :reverse_of_relationship, class_name: "Relationship", foreign_key: "follow_id"
    has_many :followers, through: :reverses_of_relatinship, source: :user
    
    validates :name, presence: true, length: {maximum: 50}
    validates :email, presence: true, length: {maximum: 255}, format: {with: /\A[\w\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}, uniqueness: {case_sensitive: false}
    
    before_save {self.email.downcase!}
    
    has_secure_password
end
