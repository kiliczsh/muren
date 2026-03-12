require "bundler/setup"
# This needs to come first so that muren require goes through zeitwerk loader
require "zeitwerk"
require "muren"

get "/" do
  "OK"
end
