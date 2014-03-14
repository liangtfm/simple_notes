class InboundController < ApplicationController

  def twilio
    user = User.find_by_mobile(params["From"])

    if user
      post = user.posts.create!(title: Time.now, body: params["Body"])
      push_post(post)

      send_text(user.mobile, "Note added!")

      head :created
    else
      send_text(params["From"], "Account not found, did you update your mobile on your profile?")
    end
  end

end