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

    describe "as correct user" do
      before { visit root_path }

      it "should delete a project" do
        expect { click_link "delete" }.to change(Project, :count).by(-1)
      end
    end
  end
end
