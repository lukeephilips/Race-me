require "rails_helper"

RSpec.describe ModelMailerMailer, type: :mailer do
  describe "race_invite" do
    let(:mail) { ModelMailerMailer.race_invite }

    it "renders the headers" do
      expect(mail.subject).to eq("Race invite")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
