# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true

  belongs_to :author, foreign_key: :author_id, class_name: 'User'
  has_many :subs, through: :post_subs
  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :comments

end
