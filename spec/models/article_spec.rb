require 'spec_helper'

describe Article do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @attr = { content: "Some article", title: "Some title", project: FactoryGirl.create(:project) }
  end

  describe "validations" do
    it "should require an user id" do
      Article.new(@attr).should_not be_valid
    end

    it "should require a nonblank content" do
      @user.articles.build(@attr.merge(content: "    ")).should_not be_valid
    end

    it "should require a nonblank title" do
      @user.articles.build(@attr.merge(title: "    ")).should_not be_valid
    end

    it "should require a project id" do
      @user.articles.build(@attr.merge(project: nil)).should_not be_valid
    end
  end

  describe "user association" do
    before(:each) do
      @article = @user.articles.create!(@attr)
    end

    it "should have the user attribute" do
      @article.should respond_to(:user)
    end

    it "should have the right associated user" do
      @article.user_id.should == @user.id
      @article.user.should    == @user
    end
  end

  describe "reactions association" do
    before(:each) do
      @article  = @user.articles.create!(@attr)
      @reaction = @user.reactions.create!(content: "Some reaction", article: @article)
    end

    it "should have a reactions attribute" do
      @article.should respond_to(:reactions)
    end

    it "should have the right associated reactions" do
      @article.reactions.should == [@reaction]
    end

    it "should destroy associated reactions" do
      @article.destroy
      Reaction.find_by_id(@reaction.id).should be_nil
    end
  end

  describe "project association" do
    before(:each) do
      @article = @user.articles.create!(@attr)
    end

    it "should have the project attribute" do
      @article.should respond_to(:project)
    end

    it "should have the right associated project" do
      @article.project_id.should == @project.id
      @article.project.should    == @project
    end
  end
end
