class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true

  belongs_to :moderator, foreign_key: :user_id, class_name: 'User'
  has_many :posts, through: :post_subs
  has_many :post_subs, dependent: :destroy, inverse_of: :sub


end
