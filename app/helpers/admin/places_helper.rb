module Admin
  module PlacesHelper
    def list_status_ransack
      Place.statuses.collect{|key, value| [t("activerecord.attributes.course.status_list.#{key}"), value]}
    end

    def selected_status
      return selected(:q, :status_eq) if params[:q]
      Place.statuses[:pending]
    end

    def selected object, atrribute
      params[object][atrribute] if params[object]
    end
  end
end
