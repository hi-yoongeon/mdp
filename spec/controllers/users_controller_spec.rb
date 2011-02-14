require 'spec_helper'

describe UsersController do
  
  describe "GET 'idnex'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

end
