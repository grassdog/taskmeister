require 'rubygems'
require 'bundler/setup'

require 'aruba/cucumber'
require 'aruba-doubles/cucumber'

$LOAD_PATH << File.expand_path('../../../lib', __FILE__)
require 'taskmeister'
require 'fileutils'

require 'aruba'
require 'aruba/in_process'

Aruba::InProcess.main_class = Taskmeister::Cli::Main
Aruba.process = Aruba::InProcess
