module ApplicationHelper
  def locale_time time
    l time, format: :show if time
    t "updating"
  end

  def locale_date date
    l date, format: :default if date
    t "updating"
  end
end
