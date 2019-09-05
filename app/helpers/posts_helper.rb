# frozen_string_literal: true

module PostsHelper
  def post_editor_title(post)
    post.new_record? ? 'Create Post' : 'Edit Post'
  end

  def post_editor_submit_button(post)
    post.new_record? ? 'Post' : 'Save Edit'
  end

  def authored_by_current_user(post)
    post.author == current_user
  end
end
