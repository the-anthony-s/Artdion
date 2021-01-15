module ApplicationHelper
  ## Custom page title
  #   USAGE: content_for :title, 'Page Title'
  def title(page_title)
    content_for(:title) { page_title }
  end

  # Shrine helper
  def upload_server
    Rails.configuration.upload_server
  end
end
