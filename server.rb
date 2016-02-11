require 'socket'              # Get sockets from stdlib
require 'json'


def handle_request(request)
 	base = request.split
 	@method = base[0]
 	@path = base[1]
 	@vers = base[2]
end

def get_req
	if File.exist?(@path) == true
  		@client.puts "#{@vers} 200 OK"
  		@client.puts "Date: #{Time.now.ctime}"  # Send the time to the client
  		@client.puts "Content-Length: #{File.size(@path)} bytes" 
  		@client.puts " "
  		File.open(@path).each do |line|
  			@client.puts "#{line}"
  		end
  	else
  		@client.puts "404 Not Found!"
  	end
end

def post_req
	f = File.open("thanks.html")
	@params = {}
	@params  = JSON.parse(@path)
	@client.puts "#{@params}"
	replace = " <li>Vikings Name: #{@params["viking"]["name"]}</li>\n" +
			  " <li>Vikings Email: #{@params["viking"]["email"]}</li>"
	
	@client.puts "#{f.read.gsub("<%= yield %>", replace)}"

end







def handler
	if @method == "GET"
		get_req
	elsif @method == "POST"
		post_req
	end
end


@server = TCPServer.open(2000)  # Socket to listen on port 2000

loop do                        # Servers run forever
  @client = @server.accept       # Wait for a client to connect
  @request = @client.gets
 
  handle_request(@request)
  handler
  
  @client.close                 # Disconnect from the client

end