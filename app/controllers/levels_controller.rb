class LevelsController < ApplicationController
  def posts
    @posts = Post.find(:all)
  end
  
end
