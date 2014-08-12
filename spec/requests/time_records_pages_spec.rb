
require 'spec_helper'

describe "Time Record pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user: user) }

  before { sign_in user }

  describe "time record creation" do
    before { visit users_project_path(user.id, project.id) }

    describe "with invalid information" do
      # there isn't any right now

    end

    describe "with valid information" do

      before { fill_in 'time_record_description', with: "Lorem ipsum" }
      it "should create a time_record" do
        expect { click_button "Create" }.to change(TimeRecord, :count).by(1)
      end
    end
  end

  describe "time record destruction" do
    before { FactoryGirl.create(:time_record, project: project) }

    describe "as correct user" do
      before { visit users_project_path(user.id, project.id) }

      it "should delete a time_record" do
        expect { click_link "delete" }.to change(TimeRecord, :count).by(-1)
      end
    end

    describe "as wrong user" do
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in wrong_user, no_capybara: true }

      before { visit users_project_path(user.id, project.id) }

      it "should not delete a time_record" do
        expect { click_link "delete" }.to not_change(TimeRecord, :count).by(-1)
      end
    end

  end
end
