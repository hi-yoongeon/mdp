require 'spec_helper'

describe PostsController do
<<<<<<< HEAD
  render_views
=======
 
  describe "GET 'show_post'" do
    it "should be successful" do
      get 'show_post'
      response.should be_success
    end
  end

>>>>>>> ab4d4b43fa3f07f5506a79570ea4e062e2b72729

  describe "GET 'show_post'" do
    it "should be successful" do
      get 'show_post'
      response.should be_success
    end
  end
end
