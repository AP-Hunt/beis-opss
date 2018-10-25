class UserSource < Source
  belongs_to_active_hash :user, inverse_of: :user_source

  def show
    user.present? ? user.full_name : "anonymous"
  end
end