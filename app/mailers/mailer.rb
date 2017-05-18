class Mailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.race_invite.subject
  #
  def race_invite(sender, recipient, goal)
    @sender = sender
    @recipient = recipient
    @goal = goal

    mail to: @recipient.email
  end
  
  def new_user_invite(sender, recipient, goal)
    @sender = sender
    @recipient = recipient
    @goal = goal

    mail to: @recipient.email
  end
end
