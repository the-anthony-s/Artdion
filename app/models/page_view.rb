class PageView < Impression
  # counts for last 7 days (or custom range)
  scope :for_type, lambda { |type|
    where(impressionable_type: type)
  }

  # uniq counts for last 7 days (or custom range)
  scope :for_date_range, lambda { |start_date, end_date|
    where(created_at: start_date.beginning_of_day..end_date.end_of_day)
  }

  # page ranks by count
  scope :count_by_date, lambda {
    group('date(created_at)').count
  }

  # page ranks by uniq count
  scope :uniq_count_by_date, lambda {
    select(:ip_address).distinct.group('date(created_at)').count
  }
end