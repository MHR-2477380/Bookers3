class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :books, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # フォローしているユーザーを特定するための記述
  has_many :active_relationships, class_name: "Relationship", foreign_key:"following_id", dependent: :destroy
  # フォローされている人を特定するための記述
  has_many :passive_relationships, class_name: "Relationship", foreign_key:"follower_id", dependent: :destroy

  # 普段モデル名を記述するところをfollowingという名前に変更し、今後の記述に user.following と使えように定義する。
  has_many :followings, through: :active_relationships, source: :follower
  # 普段モデル名を記述するところをfollowerという名前に変更し、今後の記述に user.follower と使えように定義する。
  has_many :followers, through: :passive_relationships, source: :following

  # 自分がフォローしようとしているユーザーのフォロワーの中に、自分がいるかどうかを判定する。
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end


  validates :name, presence: true, uniqueness: true, length: { minimum: 2 , maximum: 20}
  validates :introduction, length: { maximum: 50 }


end
