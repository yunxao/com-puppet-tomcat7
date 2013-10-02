require 'fileutils'
module Puppet::Parser::Functions
   newfunction(:my_create_directory) do |args|
       mkdir_p '/a/b/c'

   end
end
