require 'spec_helper'

describe Question do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @attr = { content: "Some question", project: FactoryGirl.create(:project) }
  end

  describe "validations" do
    it "should require an user id" do
      Question.new(@attr).should_not be_valid
    end

    it "should require a nonblack content" do
      @user.questions.build(@attr.merge(content: "    ")).should_not be_valid
    end

    it "should require a project id" do
      @user.questions.build(@attr.merge(project: nil)).should_not be_valid
    end
  end

  describe "user association" do
    before(:each) do
      @question = @user.questions.create!(@attr)
    end

    it "should have the user attribute" do
      @question.should respond_to(:user)
    end

    it "should have the right associated user" do
      @question.user_id.should == @user.id
      @question.user.should    == @user
    end
  end

  describe "answer associations" do
    before(:each) do
      @question = @user.questions.create!(@attr)
      @answer   = @user.answers.create!(content: "Some answer", question: @question)
    end

    it "should have an answers attribute" do
      @question.should respond_to(:answers)
    end

    it "should have the right associated answers" do
      @question.answers.should == [@answer]
    end

    it "should destroy associated answers" do
      @question.destroy
      Answer.find_by_id(@answer.id).should be_nil
    end
  end

  describe "project association" do
    before(:each) do
      @question = @user.questions.create!(@attr)
    end

    it "should have the project attribute" do
      @question.should respond_to(:project)
    end

    it "should have the right associated project" do
      @question.project_id.should == @project.id
      @question.project.should    == @project
    end
  end
end
