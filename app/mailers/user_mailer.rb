class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: 'Welcome to Ninety-Nine Cats!')
  end
end
