require_relative 'test_helper'
require 'erb'

class BaseTest < Minitest::Test
  setup do
    @base = Muren.new(Muren::Base)
    @base.set :views, __dir__ + "/views"
  end

  it 'allows unicode strings in ascii templates per default (1.9)' do
    next unless defined? Encoding
    @base.new!.erb(File.read(@base.views + "/ascii.erb").encode("ASCII"), {}, :value => "åkej")
  end

  it 'allows ascii strings in unicode templates per default (1.9)' do
    next unless defined? Encoding
    @base.new!.erb(:utf8, {}, :value => "Some Lyrics".encode("ASCII"))
  end
end
