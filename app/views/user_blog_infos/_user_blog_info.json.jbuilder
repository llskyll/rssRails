json.extract! user_blog_info, :id, :userId, :userName, :created_at, :updated_at
json.url user_blog_info_url(user_blog_info, format: :json)