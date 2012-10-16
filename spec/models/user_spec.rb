require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :email => "user@example.com",
              :password => "foobar",
              :password_confirmation => "foobar"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should required an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should accept a valid email address" do
    addresses = %w[foo@bar.cz USER@bar.coo go@ss.com.cz]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject an invalid email address" do
    addresses = %w[invalid@daco @user.com u@.fd @.]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email address" do
    User.create!(@attr)
    User.new(@attr).should_not be_valid # user with the same email
  end

  describe "password validations" do
    it "should required a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end
  end

  describe "comments association" do
    before(:each) do
      @user = User.create(@attr)
      @answ = FactoryGirl.create(:answer, :user => @user, 
                                 :question => FactoryGirl.create(:question, :user => @user))
      @comm = FactoryGirl.create(:comment, :user => @user, :commentable => @answ)
    end

    it "should have a comments attribute" do
      @user.should respond_to(:comments)
    end

    it "should destroy associated comments" do
      @user.destroy
      Comment.find_by_id(@comm.id).should be_nil
    end
  end

  describe "answers association" do
    before(:each) do
      @user   = User.create(@attr)
      @answer = FactoryGirl.create(:answer, :user => @user)
    end

    it "should have an answers attribute" do
      @user.should respond_to(:answers)
    end

    it "should destroy associated answers" do
      @user.destroy
      Answer.find_by_id(@answer.id).should be_nil
    end
  end

  describe "questions association" do
    before(:each) do
      @user     = User.create(@attr)
      @question = FactoryGirl.create(:question, :user => @user)
    end

    it "should have a questions attribute" do
      @user.should respond_to(:questions)
    end

    it "should destroy associated questions" do
      @user.destroy
      Question.find_by_id(@question.id).should be_nil
    end
  end

  describe "reactions association" do
    before(:each) do
      @user     = User.create(@attr)
      @reaction = FactoryGirl.create(:reaction, :user => @user)
    end

    it "should have a reactions attribute" do
      @user.should respond_to(:reactions)
    end

    it "should destroy associated reactions" do
      @user.destroy
      Reaction.find_by_id(@reaction.id).should be_nil
    end
  end
end
