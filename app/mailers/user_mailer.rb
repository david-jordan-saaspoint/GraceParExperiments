class UserMailer < ActionMailer::Base
#  default :from => "from@example.com"
 
  def registration_confirmation(user)
    recipients  user["email"]
    from        "webmaster@example.com"
    subject     "Thank you for Registering"
    body        :user => user
  end
end
