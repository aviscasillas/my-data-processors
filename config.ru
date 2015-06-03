lib = File.expand_path('../lib', __FILE__)
app = File.expand_path('../app', __FILE__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
$LOAD_PATH.unshift(app) unless $LOAD_PATH.include?(app)

require 'api.rb'
