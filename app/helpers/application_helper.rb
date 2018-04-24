module ApplicationHelper
  def avatar_for(user, options = { height: 100, width: 100 })
    avatar_url = "https://placeimg.com/#{options[:width]}/#{options[:height]}/people"
    image_tag(avatar_url, alt: user.username)
  end
end
