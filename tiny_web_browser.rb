require "socket"

@host = "localhost"				# The web server
@port = 2000									# Default HTTP port
@path = "index.html"							# The file we want

# This is the HTTP request we send to fetch a file


def make_req(request)
@socket = TCPSocket.open(@host,@port)          # Connect to the server
@socket.print(request)                       # Send request
@response = @socket.read                      # Read complete response
puts @response
#Split response at first blank line into headers and body

#headers,body = response.split("\r\n\r\n", 2)
#print body
end								# And display it.






input = " "
while input != "exit"
	print "What would you like to do: "
	input = gets.chomp.downcase
	if input == "get"
		make_req("GET #{@path} HTTP/1.0\r\n\r\n")
	end

end



