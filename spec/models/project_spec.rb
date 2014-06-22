require 'spec_helper'

describe Project do

  let(:user) { FactoryGirl.create(:user) }
  before do
    @project = user.projects.build(name: "Lorem ipsum")
  end

  subject { @project }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should be_valid }

  describe "when user_id is not present" do
    before { @project.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank name" do
    before { @project.name = " " }
    it { should_not be_valid }
  end

  describe "with name that is too long" do
    before { @project.name = "a" * 141 }
    it { should_not be_valid }
  end
end
