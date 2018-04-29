module ApplicationHelper
  def locale_time time
    l time, format: :show
  end
end
