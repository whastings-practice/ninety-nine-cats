class UserDecorator < Draper::Decorator
  delegate_all

  def form_url
    if object.persisted?
      h.user_url(object)
    else
      h.users_url
    end
  end

  def submit_text
    object.persisted? ? "Edit User" : "Add User"
  end
end
