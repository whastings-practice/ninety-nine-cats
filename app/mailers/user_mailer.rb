class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def reminder_email(user)
    mail(to: @user.email, subject: "Hope you're enoying Ninety-Nine Cats")
  end

  def welcome_email(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: 'Welcome to Ninety-Nine Cats!')
  end
end
