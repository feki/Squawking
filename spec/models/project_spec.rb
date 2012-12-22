require 'spec_helper'

describe Project do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @attr = { name: "Some project", description: "Description of some project" }
  end

  describe "validations" do
    it "should require a nonblank name" do
      Project.new(@attr.merge(name: "    ")).should_not be_valid
    end

    it "should require a nonblank description" do
      Project.new(@attr.merge(description: "    ")).should_not be_valid
    end
  end

  describe "articles association" do
    before(:each) do
      @project = Project.new(@attr)
      @article = @user.articles.create!(title: "Some title", content: "Some content", project: @project)
    end

    it "should have an articles attribute" do
      @project.should respond_to(:articles)
    end

    it "should have the right associated articles" do
      @project.articles.should == [@article]
    end

    it "should destroy associated articles" do
      @project.destroy
      Article.find_by_id(@article.id).should be_nil
    end
  end

  describe "questions association" do
    before(:each) do
      @project = Project.new(@attr)
      @question = @user.questions.create!(title: "Some title", content: "Some question", project: @project)
    end

    it "should have a questions attribute" do
      @project.should respond_to(:questions)
    end

    it "should have the right associated questions" do
      @project.questions.should == [@question]
    end

    it "should destroy associated questions" do
      @project.destroy
      Question.find_by_id(@question.id).should be_nil
    end
  end
end
