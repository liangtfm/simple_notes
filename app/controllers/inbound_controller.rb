class InboundController < ApplicationController

  def twilio
    user = User.find_by_mobile(params["From"])

    if user
      post = user.posts.create!(title: Time.now, body: params["Body"])
      send_text(params["From"], "Note added!")
      push_post(post)
    else
      send_text(params["From"], "Account not found, did you update your mobile on your profile?")
    end
  end

end