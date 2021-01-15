module UsersHelper
  def user_name(user)
    "#{user.first_name} #{user.last_name}" if user.first_name? && user.last_name?
  end

  def user_username(user)
    "@#{user.username}"
  end

  def user_initials(user)
    user.first_name.chars.first + user.last_name.chars.first
  end

  def user_avatar(user, size = :xsmall)
    # add image_data
    content_tag(:span, class: 'avatar') do
      user_initials(user)
    end
  end
end
