require "rails_helper"

RSpec.describe Mailer, type: :mailer do
  before do
    @sender = FactoryGirl.create(:user)
    @recipient = User.new(email: "recip@test.com", name: "Dick Buttkiss")
    @goal = FactoryGirl.create(:goal)
  end
  describe "race_invite" do
    let(:mail) { Mailer.race_invite(@sender, @recipient, @goal) }

    it "renders the headers" do
      expect(mail.subject).to eq("Race invite")
      expect(mail.to).to eq([@recipient.email])
      expect(mail.from).to eq(["postmaster@sandbox051199645c3d467f9ac453945708305b.mailgun.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
