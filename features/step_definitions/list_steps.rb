Before do
  service_list = Gitjour::Application.send(:service_list).to_a #So we know what we're looking for in the output
  Gitjour::Application.instance_eval { remove_instance_variable :@list } #So the list isn't cached
  #I'm testing with local repos, so the results aren't going to change between steps
  #Build a more convenient hash of repos => services
  @repositories = service_list.inject({}) do |repos,service| 
    repo = service.repository.to_sym
    repos[repo] = [] unless repos.has_key? repo
    repos[repo] << service
    repos
  end
end

Given /^there are repositories being shared$/ do
  @repositories.should_not be_empty
end

When /^I run gitjour list$/ do
  When "I capture stdout"
  Gitjour::Application.run "list"
  output = @new_stdout.string
  When "I put stdout back"
end

Then /^for each repository I should see its name$/ do
  pending
end

Then /^all available copies of that repository$/ do
  pending
end

Then /^a line saying the total amount of repositories shared$/ do
  pending
end