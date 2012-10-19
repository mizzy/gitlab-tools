#!/usr/bin/env ruby

require 'gitlab'

Gitlab.endpoint      = ENV['GITLAB_ENDPOINT']
Gitlab.private_token = ENV['GITLAB_PRIVATE_TOKEN']

users = []
Gitlab.users.each do |user|
  unless user.email == 'gosukenator@gmail.com'
    users << user.id
  end
end

Gitlab.projects.each do |project|
  project_members = []
  Gitlab.team_members(project.id).each do |member|
    project_members << member.id
  end
  ( users - project_members ).each do |user_id|
    Gitlab.add_team_member(project.id, user_id, 'Developer')
  end
end


