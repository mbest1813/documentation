path = "destinations/"
Dir.entries(path).each do |f| 
  puts "- " + `sed -n 2p #{path + f}`
  puts "  url: /v2/clickstream/" + path + f.chomp("md").concat("html")
  puts "  output: web, pdf"
  puts " "
end