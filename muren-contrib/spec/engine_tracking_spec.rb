# frozen_string_literal: true

require 'spec_helper'
require 'muren/engine_tracking'

RSpec.describe Muren::EngineTracking do
  def engine_app(&block)
    mock_app do
      helpers Muren::EngineTracking
      class_eval(&block)
    end
  end

  def current_engine_for(_engine)
    result = nil
    engine_app do
      get('/') do
        result = current_engine
        ''
      end
    end
    get('/')
    result
  end

  it 'defaults current_engine to :ruby' do
    expect(current_engine_for(:ruby)).to eq(:ruby)
  end

  %i[haml sass scss builder liquid markdown rdoc markaby nokogiri slim].each do |engine|
    it "#{engine}? returns true when current engine is :#{engine}" do
      result = nil
      engine_app do
        get('/') do
          result = with_engine(engine) { send(:"#{engine}?") }
          ''
        end
      end
      get('/')
      expect(result).to be true
    end

    it "#{engine}? returns false when current engine is :ruby" do
      result = nil
      engine_app do
        get('/') do
          result = send(:"#{engine}?")
          ''
        end
      end
      get('/')
      expect(result).to be false
    end
  end

  it 'ruby? returns true when current engine is :ruby' do
    result = nil
    engine_app do
      get('/') do
        result = ruby?
        ''
      end
    end
    get('/')
    expect(result).to be true
  end

  it 'ruby? returns false inside with_engine(:haml)' do
    result = nil
    engine_app do
      get('/') do
        result = with_engine(:haml) { ruby? }
        ''
      end
    end
    get('/')
    expect(result).to be false
  end

  it 'restores previous engine after with_engine' do
    result = nil
    engine_app do
      get('/') do
        with_engine(:haml) {}
        result = current_engine
        ''
      end
    end
    get('/')
    expect(result).to eq(:ruby)
  end

  it 'restores engine even if block raises' do
    result = nil
    engine_app do
      get('/') do
        begin
          with_engine(:haml) { raise 'oops' }
        rescue RuntimeError
          nil
        end
        result = current_engine
        ''
      end
    end
    get('/')
    expect(result).to eq(:ruby)
  end
end
