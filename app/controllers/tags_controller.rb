class TagsController < ApplicationController
  before_filter :authentication_required, :only => [:new]
  respont_to :xml, :json

  def new
    if request.post? and parameters_required :tag
      tag = Tag.new(:tag => params[:tag])
      if tag.save
        __success(tag)
      else
        __error(:code => 0, :description => "Failed to save")
      end

    end
  end
  
end
