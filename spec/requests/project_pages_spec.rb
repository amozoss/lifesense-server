require 'spec_helper'

describe "ProjectPages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "project creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a project" do
        expect { click_button "Create" }.not_to change(Project, :count)
      end

      describe "error messages" do
        before { click_button "Create" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'project_name', with: "Lorem ipsum" }
      it "should create a project" do
        expect { click_button "Create" }.to change(Project, :count).by(1)
      end
    end
  end

  describe "project destruction" do
    before { FactoryGirl.create(:project, user: user) }
    let(:project_right_user) { FactoryGirl.create(:project, user: user) }
    describe "as correct user" do
      before { visit root_path }

      it "should delete a project" do
        expect { click_link "delete" }.to change(Project, :count).by(-1)
      end
    end

    describe "as wrong user" do
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in wrong_user, no_capybara: true }

      before { visit user_project_path(user.id, project_right_user.id) }

      #it "should not delete a project" do
        #expect { click_link "delete" }.not_to change(Project, :count).by(-1)
      #end
    end
  end

  describe "project page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:project) { FactoryGirl.create(:project, user: user, name: "Foo") }
    let!(:m1) { FactoryGirl.create(:time_record, project: project, started_at: 2.hours.ago, ended_at: 1.hour.ago, description: "Foo") }
    let!(:m2) { FactoryGirl.create(:time_record, project: project, started_at: 1.hour.ago, ended_at: 1.minute.ago, description: "Foo") }


    before do
      visit user_project_path(project.user_id, project)
      sign_in user
    end

    it { should have_content(project.name) }
    
    describe "time_records" do
      it { should have_content(m1.description) }
      it { should have_content(m2.description) }
    end
  end
end
