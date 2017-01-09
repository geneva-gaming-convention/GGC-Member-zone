class WelcomeController < ApplicationController

  def index
    github = Github.new login:Rails.application.secrets.github_user, password:Rails.application.secrets.github_password
    @commits=[]
    data = github.repos.commits.all 'geneva-gaming-convention', 'GGC-Website', per_page: 5
    data.each do |commit|
      @commits << commit.commit
    end
  end

  def get_commits
    github = Github.new login:Rails.application.secrets.github_user, password:Rails.application.secrets.github_password
    @commits=[]
    data = github.repos.commits.all 'geneva-gaming-convention', 'GGC-Website', per_page: 5
    data.each do |commit|
      @commits << commit.commit
    end
    respond_to do |format|
      format.json { render(json: @commits ) }
      format.html { render(html: @commits ) }
    end
  end
end
