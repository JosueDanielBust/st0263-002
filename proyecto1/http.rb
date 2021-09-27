require 'sinatra'
require 'sinatra/namespace'
require 'mongoid'

# DB
Mongoid.load! 'mongoid.config'

# Model
class Entry
  include Mongoid::Document

  field :key, type: String
  field :value, type: String

  validates :key, presence: true
  validates :value, presence: true

  index({ key: 'text' })

  scope :key, -> (key) { where( key: key ) }
end

# Serializer
class EntrySerializer
  def initialize( entry )
    @entry = entry
  end
  
  def as_json(*)
    data = {
      id: @entry.id.to_s,
      key: @entry.key,
      value: @entry.value
    }
    data[ :errors ] = @entry.errors if @entry.errors.any?
    data
  end
end

# Routes
get '/' do
  'Welcome! Go to /entries/'
end

namespace '/entries' do
  before do
    content_type 'application/json'
  end

  helpers do
    def base_url
      @base_url ||= "#{ request.env['rack.url_scheme'] }://{ request.env['HTTP_HOST'] }"
    end

    def json_params
      begin
        JSON.parse( request.body.read )
      rescue
        halt 400, { message: 'Invalid JSON' }.to_json
      end
    end

    def entry
      @entry ||= Entry.where( id: params[ :id ] ).first
    end

    def halt_not_found!
      halt( 404, { message: 'Entry not found' }.to_json ) unless entry
    end

    def serialize( entry )
      EntrySerializer.new( entry ).to_json
    end
  end

  get '/' do
    Entry.all.to_json
  end

  get '/:key' do
    entries = Entry.all

    [ :key ].each do |filter|
      entries = entries.send( filter, params[filter] ) if params[filter]
    end
    
    entries.map { |entry| EntrySerializer.new( entry ) }.to_json
  end

  get '/id/:id' do |id|
    halt_not_found!
    serialize( entry )
  end

  post '/' do
    entry = Entry.new(json_params)
    halt 422, serialize( entry ) unless entry.save
    response.headers['Location'] = "#{ base_url }/entries/id/#{ entry.id }"
    status 201
  end

  patch '/id/:id' do |id|
    halt_not_found!
    halt 422, serialize( entry ) unless entry.update_attributes( json_params )
    serialize( entry )
  end

  delete '/id/:id' do |id|
    entry.destroy if entry
    status 204
  end
end