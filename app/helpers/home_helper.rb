# frozen_string_literal: true

module HomeHelper

  def data_class_for(type)
    if type == :notification
      return '' if false
    elsif type == :friend_request
      return '' if false
    end
    'no-data'
  end
end
