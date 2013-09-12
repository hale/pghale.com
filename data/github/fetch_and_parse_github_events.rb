require 'octokit'
require 'json'

PAGE_LIMIT = 10
FILENAME = "data.json"

def run!
  @access_token = prompt "please enter access token for Oktokit"

  existing_events = events_from_file(FILENAME)
  new_events = events_from_github
  events = existing_events.merge new_events

  write_json(events, FILENAME) if overwrite? FILENAME
end

def prompt question
  puts question
  print "> "
  gets.chomp
end

def events_from_file filename
  json = nil
  File.open(filename, 'r') do |f|
    json = JSON.load f
  end
  json
end

def events_from_github
  json_to_hash([].tap do |events|
    PAGE_LIMIT.times do |n|
      events << client.user_events(client.user.login, :page => n)
    end
  end.flatten)
end

def client
  @client ||= Octokit::Client.new :access_token => @access_token
end

def json_to_hash events
  {}.tap do |events_hash|
    events.each do |event|
      timestamp = event.created_at.to_i
      events_hash[timestamp] = events_hash[timestamp] ? events_hash[timestamp] + 1 : 1
    end
  end
end

def write_json object, filename
  File.open(filename, "w") do |f|
    f.write(object.to_json)
  end
end

def overwrite? filename
  prompt("overwrite #{filename}? Y/n") != "n"
end

def log thing
  puts thing.inspect
end

run! if __FILE__ == $0
