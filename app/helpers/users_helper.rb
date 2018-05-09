module UsersHelper
  def user_phone user
    return user.phone if user.phone
    t "updating"
  end

  def show_phone_form user
    return user.phone if user.phone
    t "users.common.update_phone"
  end

  def show_form_descriptions user
    return user.descriptions if user.descriptions
    t "users.common.update_descriptions"
  end
end
