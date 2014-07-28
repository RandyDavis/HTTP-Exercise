require 'unirest'

module Makerblog
  class Client
    def list_posts
      begin
        response = Unirest.get('http://makerblog.herokuapp.com/posts',
          headers: { "Accept" => "application/json" })
        posts =response.body
        posts.each do |post|
          puts "Name: #{post["name"]}\nTitle: #{post["title"]}\nContent: #{post["content"]}\n\n"
        end
        if response.code == 200
          puts "Passed"
        end
      rescue Exception => e
        puts e.message
        # puts e.backtrace.inspect
      end
    end

    def show_post(id)
      begin
        url = "http://makerblog.herokuapp.com/posts/#{id}"
        response = Unirest.get(url,
          headers: { "Accept" => "application/json"})
        post =response.body
        puts "Name: #{post["name"]}\nTitle: #{post["title"]}\nContent: #{post["content"]}\n\n"
        if response.code == 200
          puts "Passed"
        end
      rescue Exception => e
        puts e.message
        # puts e.backtrace.inspect
      end
    end

    def create_post(name, title, content)
      url = "http://makerblog.herokuapp.com/posts"
      payload = { :post => {'name' => name, 'title' => title, 'content' => content}}

      response = Unirest.post(url,
        headers: { "Accept" => "application/json",
                    "Content-Type" => "application/json"},
        parameters: payload)

      post =response.body
      puts "Name: #{post["name"]}\nTitle: #{post["title"]}\nContent: #{post["content"]}\n\n"
      if response.code == 201
        puts "Passed"
      end
    end

    def edit_post(id, options = {})
      url = "http://makerblog.herokuapp.com/posts/#{id}"
      params = {}

      params[:name] = options[:name] unless options[:name].nil?
      params[:title] = options[:title] unless options[:title].nil?
      params[:content] = options[:content] unless options[:content].nil?

      response = Unirest.put(url,
        parameters: { :post => params},
        headers: { "Accept" => "application/json",
                    "Content-Type" => "application/json"})

      post =response.body
      puts "Name: #{post["name"]}\nTitle: #{post["title"]}\nContent: #{post["content"]}\n\n" 
      if response.code == 200
        puts "Passed"
      end     
    end

    def delete_post(id)
      url = "http://makerblog.herokuapp.com/posts/#{id}"
      response = Unirest.delete(url,
        headers: { "Accept" => "application/json"})
      puts response.code
      if response.code == 204
        puts "Passed"
      end
    end
  end
end

client = Makerblog::Client.new
client.list_posts
client.show_post(5654555)
client.create_post("James", "Turtle Soup", "Ninja Turtles anybody?")
client.edit_post(19083)
client.delete_post(19083)










