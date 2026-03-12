require_relative 'test_helper'

class MurenTest < Minitest::Test
  it 'creates a new Muren::Base subclass on new' do
    app = Muren.new { get('/') { 'Hello World' } }
    assert_same Muren::Base, app.superclass
  end

  it "responds to #template_cache" do
    assert_kind_of Muren::TemplateCache, Muren::Base.new!.template_cache
  end
end
