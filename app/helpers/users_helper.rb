module UsersHelper
  def user_name(user)
    return '[deleted]' if user.deleted_at?

    "#{user.first_name} #{user.last_name}" if user.first_name? && user.last_name?
  end

  def user_username(user)
    return '[deleted]' if user.deleted_at?

    "@#{user.username.downcase}"
  end

  def user_initials(user)
    return '[X]' if user.deleted_at?

    user.first_name.chars.first + user.last_name.chars.first
  end
end
