require 'spec_helper'

describe Comment do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @attr = { :content => "Some comment", 
              :commentable => FactoryGirl.create(:answer, :user => @user,
                                                 :question => FactoryGirl.create(:question, :user => @user)) }
  end

  it "should create a new instance given valid attributes" do
    @user.comments.create!(@attr)
  end

  describe "user associations" do
    before(:each) do
      @comment = @user.comments.create!(@attr)
    end

    it "should have a user attribute" do
      @comment.should respond_to(:user)
    end

    it "should have the right associated user" do
      @comment.user_id.should == @user.id
      @comment.user.should    == @user
    end
  end

  describe "validations" do
    it "should require an user id" do
      Comment.new(@attr).should_not be_valid
    end

    it "should require a nonblank content" do
      @user.comments.build(:content => "    ").should_not be_valid
    end

    it "should require a commentable id" do
      @user.comments.build(:content => @attr).should_not be_valid
    end
  end

  describe "commentable(answer) associations" do
    before(:each) do
      @question = @user.questions.create!(:content => "Some question")
      @answer   = @user.answers.create!(:content => "Some answer", :question => @question)
      @comment  = @user.comments.create!(:content => "Some comment", :commentable => @answer)
    end

    it "should have an commentable attribute" do
      @comment.should respond_to(:commentable)
    end

    it "it should have the right associated answer" do
      @comment.commentable_id.should   == @answer.id
      @comment.commentable_type.should == Answer.name
      @comment.commentable.should      == @answer
    end
  end

  describe "commentable(reaction) associations" do
    before(:each) do
      @article  = @user.articles.create!(:content => "Some article")
      @reaction = @user.reactions.create!(:content => "Some reaction", :article => @article)
      @comment  = @user.comments.create!(:content => "Some comment", :commentable => @reaction)
    end

    it "should have an commentable attribute" do
      @comment.should respond_to(:commentable)
    end

    it "it should have the right associated answer" do
      @comment.commentable_id.should   == @reaction.id
      @comment.commentable_type.should == Reaction.name
      @comment.commentable.should      == @reaction
    end
  end
end
