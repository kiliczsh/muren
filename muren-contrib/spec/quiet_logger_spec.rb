require 'spec_helper'
require 'muren/quiet_logger'
require 'logger'

RSpec.describe Muren::QuietLogger do

  it 'logs just paths not excluded' do
    log = StringIO.new
    logger = Logger.new(log)
    mock_app do
      use Rack::CommonLogger, logger
      set :quiet_logger_prefixes, %w(quiet asset)
      register Muren::QuietLogger
      get('/log') { 'in log' }
      get('/quiet') { 'not in log' }
    end

    get('/log')
    get('/quiet')

    str = log.string
    expect(str).to include('GET /log')
    expect(str).to_not include('GET /quiet')
  end

  it 'warns about not setting quiet_logger_prefixes' do
    expect {
      mock_app do
        register Muren::QuietLogger
      end
    }.to output("You need to specify the paths you wish to exclude from logging via `set :quiet_logger_prefixes, %w(images css fonts)`\n").to_stderr
  end

end
