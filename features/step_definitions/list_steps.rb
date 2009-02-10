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
  @output = @new_stdout.string
  When "I put stdout back"
  # Build some regular expressions
  # "Gathering for up to 5 seconds..."
  intro_line = /^[\w\s]+(\d+\s\w+)\.{3}/
  # "=== surfcomp"
  repo_pattern = /^={3}\s([\w-]+)/
  # "\tdylanfm-surfcomp git://tubed.local/" (with optional port)
  service_pattern = /^\s+([\w\-]+)\s(git:\/\/[\w\d\.-]+(\/|\:\d+\/))/ 
  # "2 repositories shown."
  number_shown_pattern = /^(\d+)\s\w+\s\w+\./
  # Build a hash like @repositories so we can test list's output easier
  @list_repositories = Hash.new
  # Let's make sure there are the same amount of services in the output as there are in @repositories
  num_services = 0
  @repositories.each_value { |services| num_services += services.size }
  list_num_services = 0
  # Now let's process the list output
  @output.split('\n')
  @output.each do |line|
    if repo_pattern =~ line
      repo = Regexp.last_match(0).to_sym
      @current_repo = repo
      @list_repositories[repo] = [] unless @list_repositories.has_key? repo
    elsif service_pattern =~ line
      list_num_services += 1
      @list_repositories[@current_repo] << { :name => Regexp.last_match(0), :url => Regexp.last_match(1) }
    end
  end
  list_num_services.should == num_services
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