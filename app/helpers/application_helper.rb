module ApplicationHelper
  def locale_time time
    l time, format: :show if time
    t "updating"
  end
end
