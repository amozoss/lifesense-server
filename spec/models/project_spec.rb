require 'spec_helper'

describe Project do

  let(:user) { FactoryGirl.create(:user) }
  before do
    @project = user.projects.build(name: "Lorem ipsum")
  end

  subject { @project }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should respond_to(:time_records) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

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

 describe "time_record associations" do

    before { @project.save }

    let!(:older_time_record) do
      FactoryGirl.create(:time_record, project: @project, started_at: 1.day.ago)
    end
    let!(:newer_time_record) do
      FactoryGirl.create(:time_record, project: @project, started_at: 1.hour.ago)
    end

    it "should have the right time_records in the right order" do
      expect(@project.time_records.to_a).to eq [newer_time_record, older_time_record]
    end

    it "should destroy associated time_records" do
      time_records = @project.time_records.to_a
      @project.destroy
      expect(time_records).not_to be_empty
      time_records.each do |time_record|
        expect(TimeRecord.where(id: time_record.id)).to be_empty
      end
    end
  end

end
