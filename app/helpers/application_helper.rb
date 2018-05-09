module ApplicationHelper
  def locale_time time
    return l time, format: :show if time
    t "updating"
  end

  def locale_date date
    return l date, format: :default if date
    t "updating"
  end
end
