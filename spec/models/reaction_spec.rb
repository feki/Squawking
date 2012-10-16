require 'spec_helper'

describe Reaction do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @attr = { :content => "Some reaction" }
  end

  it "should create a new instance given valid attributes" do
    @user.reactions.create!(@attr)
  end

  describe "validations" do
    it "should require an user id" do
      Reaction.new(@attr).should_not be_valid
    end

    it "should require a nonblank content" do
      @user.reactions.build(:content => "    ").should_not be_valid
    end
  end

  describe "user association" do
    before(:each) do
      @reaction = @user.reactions.create!(@attr)
    end

    it "should have an user attribute" do
      @reaction.should respond_to(:user)
    end

    it "should have the right associated user" do
      @reaction.user_id.should == @user.id
      @reaction.user.should    == @user
    end
  end

  describe "comments association" do
    before(:each) do
      @reaction = @user.reactions.create!(@attr)
      @comment  = @user.comments.create!(:commentable => @reaction, :content => "Some comment")
    end

    it "should have a comments attribute" do
      @reaction.should respond_to(:comments)
    end

    it "should have the right associated comments" do
      @reaction.comments.should == [@comment]
    end

    it "should destroy associated comments" do
      @reaction.destroy
      Comment.find_by_id(@comment.id).should be_nil
    end
  end
end
