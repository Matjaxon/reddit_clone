class Comment < ActiveRecord::Base
  validates :author_id, :content, :post_id, presence: true

  belongs_to :author, class_name: 'User'
  belongs_to :post

  def comments_array(comments)
    return [self] if comments.none? { |comment| self.id == comment.parent_comment_id }
    puts "made it this far"
    results = []
    results << self
    nested_results = []
    child_comments = Comment.where(parent_comment_id: self.id)
    child_comments.each do |c_comment|
      nested_results.concat(c_comment.comments_array(comments))
    end
    results << nested_results
  end

end
