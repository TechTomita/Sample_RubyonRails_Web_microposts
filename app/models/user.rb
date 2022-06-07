class User < ApplicationRecord
    has_many :microposts
    
    has_many :relationships
    has_many :followings, through: :relationships, source: :follow
    has_many :reverse_of_relationship, class_name: "Relationship", foreign_key: "follow_id"
    has_many :followers, through: :reverse_of_relationship, source: :user
    
    has_many :favorites
    has_many :favorite_post, through: :favorites, source: :post
    
    validates :name, presence: true, length: {maximum: 50}
    validates :email, presence: true, length: {maximum: 255}, format: {with: /\A[\w\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}, uniqueness: {case_sensitive: false}
    
    before_save {self.email.downcase!}
    
    has_secure_password
    
    # フォロー機能
    def follow(other_user)
        unless self == other_user
            self.relationships.find_or_create_by(follow_id: other_user.id) #Relationshipのインスタンスを返す
        end
    end
    
    def unfollow(other_user)
        relationship = self.relationships.find_by(follow_id: other_user.id)
        relationship.destroy if relationship
    end
    
    def following?(other_user)
        self.followings.include?(other_user)
    end
    
    # タイムライン
    def feed_microposts
        Micropost.where(user_id: self.following_ids + [self.id])
    end
    
    # お気に入り機能
    def favorite(post_item)
        unless self.microposts.include?(post_item)
            self.favorites.find_or_create_by(post_id: post_item.id)
        end
    end
    
    def unfavorite(post_item)
        favorite = self.favorites.find_by(post_id: post_item.id)
        favorite.destroy if favorite
    end
    
    def favorite?(post_item)
        unless self.favorite_post.include?(post_item)
        end
    end
end
