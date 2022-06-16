json.(user, :id, :email, :name, :bio, :image)
json.token user.generate_jwt
