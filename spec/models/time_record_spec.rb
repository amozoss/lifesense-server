require 'spec_helper'

describe TimeRecord do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @project = user.projects.build(name: "Lorem ipsum")
    @time_record = @project.time_records.build(started_at: Time.now, ended_at: Time.now, description: "Lorem ipsum")
  end

  subject { @time_record }

  it { should respond_to(:description) }
  it { should respond_to(:project_id) }
  it { should respond_to(:started_at) }
  it { should respond_to(:ended_at) }
  it { should respond_to(:project) }
  its(:project) { should eq @project }

  describe "when project_id is not present" do
    before { @time_record.project_id = nil }
    it { should_not be_valid }
  end
end
