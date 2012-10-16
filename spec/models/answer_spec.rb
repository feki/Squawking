require 'spec_helper'

describe Answer do
  before(:each) do
    @user     = FactoryGirl.create(:user)
    @question = FactoryGirl.create(:question, :user => @user)
    @attr     = { :content => "Some answer", :question => @question }
  end

  it "should create a new instance given valid attributes" do
    @user.answers.create!(@attr)
  end

  describe "validations" do
    it "should require an user id" do
      Answer.new(@attr).should_not be_valid
    end

    it "should require a nonblack content" do
      @user.answers.build(:content => "   ").should_not be_valid
    end

    it "should require a question id" do
      @user.answers.build(@attr.merge(:question => nil)).should_not be_valid
    end
  end

  describe "user association" do
    before(:each) do
      @answer = @user.answers.create!(@attr)
    end

    it "should have a user attribute" do
      @answer.should respond_to(:user)
    end

    it "should have the right associated user" do
      @answer.user_id.should == @user.id
      @answer.user.should    == @user
    end
  end

  describe "comments association" do
    before(:each) do
      @answer = @user.answers.create!(@attr)
      @comment = @user.comments.create!(:commentable => @answer, :content => "Some comment")
    end

    it "should have a comments attribute" do
      @answer.should respond_to(:comments)
    end

    it "should have the right associated comment" do
      @answer.comments.should == [@comment]
    end

    it "should destroy associated comments" do
      @answer.destroy
      Comment.find_by_id(@comment.id).should be_nil
    end
  end

  describe "question association" do
    before(:each) do
      @answer = @user.answers.create!(@attr)
    end

    it "should have a question attribute" do
      @answer.should respond_to(:question)
    end

    it "should have the right associated user" do
      @answer.question_id.should == @question.id
      @answer.question.should    == @question
    end
  end
end
