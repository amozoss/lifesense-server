require 'spec_helper'

describe "Time Record pages" do
  include ApplicationHelper

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user: user) }

  before { sign_in user }

  describe "time record creation" do
    before { visit user_project_path(user, project) }

    describe "with invalid information" do
      # there isn't any right now

    end

    describe "with valid information" do

      before { fill_in 'time_record_description', with: "Lorem ipsum" }
      it "should create a time_record" do
        expect { click_button "Start" }.to change(TimeRecord, :count).by(1)
      end
    end
  end

  describe "time record destruction" do
    before { FactoryGirl.create(:time_record, project: project) }

    describe "as correct user" do
      before { visit user_project_path(user.id, project.id) }

      it "should delete a time_record" do
        expect { click_link "delete" }.to change(TimeRecord, :count).by(-1)
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      before { visit user_project_path(wrong_user, project) }

      it "should not delete a time_record" do
        expect(page).not_to have_link("delete")
      end
    end

  end
end
