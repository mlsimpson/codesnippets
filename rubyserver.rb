#!/usr/bin/env ruby

require 'socket'
server = TCPServer.new("127.0.0.1", 80)
loop do
  socket = server.accept
  while socket.gets.chop.length > 0
  end
  socket.puts "HTTP/1.1 200 OK"
  socket.puts "Content-type: text/html"
  socket.puts ""
  socket.puts "<html>"
  socket.puts "<body>"
  socket.puts "<div>"
  socket.puts "<b>Yay!Your first networking application!</b>"
  socket.puts "</div>"
  socket.puts "</body>"
  socket.puts "</html>"
  socket.close
end
