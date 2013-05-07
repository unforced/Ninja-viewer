require 'json'
Dir.entries(".").select{|d| File.directory?(d) && d != "." && d != ".."}.each do |d|
  Dir.entries(d).select{|f| /json$/ === f }.each do |f|
    json = JSON.parse(File.read(File.join(d,f)))
    new_json = {}
    new_json["nodes"] = []
    json["vertices"].each do |vert|
      new_json["nodes"] << {"id" => vert["_id"], "label" => vert["label"]}
    end
    new_json["links"] = []
    json["edges"].each do |edge|
      new_json["links"] << {"weight" => edge["weight"],
        "id" => edge["_id"], "target" => edge["_outV"],
        "source" => edge["_inV"], "value" => edge["_id"]}
    end
    File.open(File.join(d,f), 'w'){|file| file.puts(JSON.pretty_generate(new_json))}
  end
end
