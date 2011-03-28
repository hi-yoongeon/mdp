require 'spec_helper'

describe DummyDbsController do

  describe "GET 'make_dummy'" do
    it "should be successful" do
      get 'make_dummy'
      response.should be_success
    end
  end

end
