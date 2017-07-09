class WelcomeController < ApplicationController

  def index
  end

  def get_commits
    github = Github.new login:Rails.application.secrets.github_user, password:Rails.application.secrets.github_password
    @commits=[]
    data=[]
    branches = github.repos.branches 'geneva-gaming-convention', 'GGC-Member-zone' do |branch|
      if Rails.application.secrets.github_branch && branch.name == Rails.application.secrets.github_branch
        @branch_title = branch.name.capitalize
        data = github.repos.commits.list 'geneva-gaming-convention', 'GGC-Member-zone', :sha => branch.name, per_page: 5
      else
        @branch_title = ""
        data = github.repos.commits.all 'geneva-gaming-convention', 'GGC-Member-zone', :sha => "preprod",per_page: 5
      end
    end
    data.each do |commit|
      @commits << commit.commit
    end
    render 'commits', :layout => false
  end

  def get_events
    @events = Event.all.order(date: :desc)
    if @events
      render 'events', :layout => false
    else
      render partial: 'application/empty_state', locals: {title: "Events", info: "No events available yet..."}
    end
  end
end
