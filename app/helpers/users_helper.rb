module UsersHelper

  def must_be_ready_to_registration
    if !is_ready_for_registration
      @error_info = "Your account need to be ready for registration first ;)"
      render_403
    end
  end

  def is_ready_for_registration
    must_be_logged
    user = current_logged_user
    if user
      return user.address && user.validated #&& user.phone
    end
    return false
  end

end
