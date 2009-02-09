require 'stringio'
require 'spec'
$:.unshift(File.dirname(__FILE__) + '/../../lib')

require 'gitjour'

When "I capture stdout" do
  # Hijack stdout so we can read it
  @old_stdout, @new_stdout = $stdout, StringIO.new
  $stdout = @new_stdout
end

When "I put stdout back" do
  # Put it back
  $stdout = @old_stdout
end