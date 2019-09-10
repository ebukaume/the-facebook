# frozen_string_literal: true

module PostsHelper
  def post_editor_title(post)
    post.new_record? ? 'Create Post' : 'Edit Post'
  end
end
