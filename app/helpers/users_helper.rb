module UsersHelper
  # Return User's name
  def name(user)
    return '[deleted]' if user.deleted_at?

    "#{user.first_name} #{user.last_name}" if user.first_name? && user.last_name?
  end

  # Return User's username
  def username(user)
    return '[deleted]' if user.deleted_at?

    "@#{user.username.downcase}"
  end

  # Return User's initials -> AS
  def initials(user)
    return '[X]' if user.deleted_at?

    user.first_name.chars.first + user.last_name.chars.first
  end

  # Return User's first name and last name first letter
  def familiar(user)
    "#{user.first_name} #{user.last_name.chars.first}"
  end

  # Return User's avatar
  def avatar(user, options = {})
    if user.image_data? && !user.deleted_at?
      opt = {
        url_params: {
          w: 150, h: 150, auto: 'format',
          fit: 'crop', crop: 'faces', bg: 'fff',
          fm: 'webp'
        },
        attribute_options: {
          src: 'data-src', srcset: 'data-srcset', sizes: 'data-sizes'
        },
        tag_options: {
          class: 'lazyload',
          role: 'presentation',
          alt: "Avatar of user #{name(user)}"
        }
      }.merge(options)

      content_tag(:div, class: 'avatar') do
        ix_image_tag URI(user.image_url).path, opt
      end
    else
      content_tag(:div, class: 'avatar') do
        image_tag(asset_path('avatar.jpg'), class: 'lazyload')
      end
    end
  end
end
