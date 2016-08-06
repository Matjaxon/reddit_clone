module PostsHelper

  def child_comments(comment)
    child_comments = Comment.where(parent_comment_id: comment.id)
    return nil if child_comments.empty?
    child_comments.each do |c_comment|
      puts "sdkj"
      "<h2> #{c_comment.author.username}</h2><br>#{c_comment.content}<br>".html_safe
      child_comments(c_comment)
    end
  end

  def comments_array(parent_comment, comments)
    return [] if comments.empty?
    return [] if comments.none? { |comment| parent_comment.id == comment.parent_comment_id }

    results = []
    child_comments = Comment.where(parent_comment_id: parent_comment.id)
    child_comments.each do |c_comment|
      results << comments_array(c_comment, comments)
    end
    results
  end
end
