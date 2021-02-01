module ApplicationHelper
  include Pagy::Frontend

  ## Custom page title
  #   USAGE: content_for :title, 'Page Title'
  def title(page_title)
    content_for(:title) { page_title }
  end

  # Shrine helper
  def upload_server
    Rails.configuration.upload_server
  end

  # Number formatting
  def formatted_number(number)
    number_to_human(
      number,
      format: '%n%u',
      precision: 1,
      significant: true,
      units: {
        thousand: 'K',
        million: 'M',
        billion: 'B'
      }
    )
  end
end
