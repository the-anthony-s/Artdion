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

  # Return User's first name
  def first_name(user)
    user.first_name.to_s
  end

  # Return User's last name
  def last_name(user)
    user.last_name.to_s
  end

  # Return User's avatar
  def avatar(user, _type = :default)
    content_tag(:div, class: 'avatar') do
      if user.image_data?
        if Rails.env.production?
          if _type = :card
            card_avatar(user)
          else
            default_avatar(user)
          end
        else
          image_tag(
            user.image_url(:S100),
            class: 'lazyload avatar--media',
            alt: "Photo of #{name(user)}",
            'data-src': user.image_url,
            'data-sizes': 'auto',
            itemprop: 'thumbnailUrl'
          )
        end
      else
        image_tag(
          asset_path('avatar.jpg'),
          alt: "Photo of #{name(user)}",
          class: 'lazyload'
        )
      end
    end
  end

  # Avatar helper
  def default_avatar(user)
    ix_image_tag(
      user.image_url,
      url_params: { w: 150, h: 150, q: 60, fit: 'crop', crop: 'faces', bg: 'fff', auto: 'format' },
      tag_options: {
        alt: "Photo of #{name(user)}",
        class: 'lazyload avatar--media'
      }
    )
  end

  # Small avatar helper
  def card_avatar(user)
    ix_image_tag(
      user.image_url,
      url_params: { w: 26, h: 26, q: 60, fit: 'crop', crop: 'faces', bg: 'fff', auto: 'format' },
      tag_options: {
        alt: "Photo of #{name(user)}",
        class: 'lazyload avatar--media'
      }
    )
  end
end
