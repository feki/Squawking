require 'spec_helper'

describe Project do
  before(:each) do
    @user = FactoryGril.create(:user)
    @attr = { name: "Some project", description: "Description of some project" }
  end

  
end
