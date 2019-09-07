# frozen_string_literal: true

module CommentsHelper
  def comment_submit_button(comment)
    comment.new_record? ? 'Submit' : 'Save Edit'
  end
end
