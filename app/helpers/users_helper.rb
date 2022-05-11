module UsersHelper
    # 引数で与えられたユーザーのGravatar画像を返す
    def gravatar_for(user, options = { size: 80 })
        size = options[:size]
        # MD5でemailのdowncaseをhash化
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        # gravatarで生成される画像のurl
        # gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end # 引数で与えられたユーザーのGravatar画像を返す
end
