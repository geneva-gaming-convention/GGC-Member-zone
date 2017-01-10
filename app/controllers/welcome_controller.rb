class WelcomeController < ApplicationController

  def index
  end

  def get_commits
    github = Github.new login:Rails.application.secrets.github_user, password:Rails.application.secrets.github_password
    @commits=[]
    data = github.repos.commits.all 'geneva-gaming-convention', 'GGC-Website', per_page: 5
    data.each do |commit|
      @commits << commit.commit
    end
    render 'commits', :layout => false
  end
end
