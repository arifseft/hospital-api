json.user do
  json.id user.id
  json.email user.email
  json.full_name user.full_name
  json.token user_token.token
end
