module ApplicationHelper
    def gravatar_for(user)
        require 'digest/md5'
        email_address = user.email.downcase
        hash = Digest::MD5.hexdigest(email_address)
        image_url = "https://www.gravatar.com/avatar/#{hash}"
        image_tag(image_url, alt: user.name)
    end


    
end
