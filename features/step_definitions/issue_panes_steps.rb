# Mocha mocks

Before do
  # I hate database tests....
  User.destroy_all
  Project.destroy_all
  Enumeration.destroy_all
  IssueStatus.destroy_all
  NextIssue.destroy_all
  Issue.destroy_all
  @current_user = User.new(:mail => 'test@example.com', :firstname => 'Feature', :lastname => 'Test')
  @current_user.login = 'feature_test'
  @current_user.save!
  
  @project = Project.create!({ :identifier => 'test-project', :name => 'Test Project'})
  @low_priority = Enumeration.create!(:opt => 'IPRI', :name => 'Low')
  @new_status = IssueStatus.create!(:name => 'New', :is_closed => false)
end

Given /I am logged in/ do
  User.stubs(:current).returns(@current_user)
end

Given /I am on the stuff to do page/ do
  visit "/stuff_to_do"
end

Given /there are (\d+) next issues/ do |number|
  number.to_i.times do |n|
    issue = Issue.new(:project => @project, :subject => "Issue #{number}", :description => "Description #{number}", :priority => @low_priority, :status => @new_status, :assigned_to => @current_user)
    issue.save false # Skip all the extra associations Redmine uses
    NextIssue.create! :user => @current_user, :issue => issue
  end
end

Given /^there are (\d+) issues assigned to me$/ do |number|
  number.to_i.times do |n|
    issue = Issue.new(:project => @project, :subject => "Issue #{number}", :description => "Description #{number}", :priority => @low_priority, :status => @new_status, :assigned_to => @current_user)
    issue.save false # Skip all the extra associations Redmine uses
  end
end

Given /^there are (\d+) issues not assigned to me$/ do |number|
  number.to_i.times do |n|
    issue = Issue.new(:project => @project, :subject => "Issue #{number}", :description => "Description #{number}", :priority => @low_priority, :status => @new_status, :assigned_to => nil)
    issue.save false # Skip all the extra associations Redmine uses
  end
end


Then /^I should see a list of tasks called "(.*)"$/ do |named|
  response.should have_tag("ol##{named}")
end

Then /^I should see a row for (\d+) "(.*)" tasks$/ do |number, named|
  response.should have_tag("ol##{named}") do
    with_tag("li.issue", :minimum => number.to_i, :maximum => number.to_i)
  end
end

Then /^I should see a row for each task to do now$/ do
  response.should have_tag("li")
end

# TODO: Redmine needs so much built up, this test is unresponable (issue > project > custom fields, custom values, trackers)
# Then /^I should see the issue title in the row$/ do
#   response.should  have_tag("li", 'Issue 1 Title')
# end