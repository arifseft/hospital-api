json.user do |json|
  json.partial! 'api/v1/users/user_profile', user: @user
end
