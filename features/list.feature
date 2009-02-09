Feature: List available repositories
  In order to write leet codez
  As a haxor
  I want to list all available git repositories

Scenario: list available repositories
  Given there are repositories being shared
  When I run gitjour list
  Then for each repository I should see its name
  And all available copies of that repository
  And a line saying the total amount of repositories shared
  
  
