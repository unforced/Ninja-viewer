require 'json'

top_500 = JSON.parse(File.read("results.json"))

repos = []
Dir.entries(".").each do |dir|
  if File.directory?(dir) && Dir.entries(dir).any?{|f| /json$/ === f}
    repos << dir
  end
end

File.open("repos.json",'w'){|f| f.puts(JSON.generate(top_500.select{|r| repos.include?("#{r["repository_owner"]}_#{r["repository_name"]}")}))}
