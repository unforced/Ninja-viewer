require 'bundler'
Bundler.require(:default)

set :environment, :production
set :port, 3003

get '/' do
  @repos = JSON.parse(File.read("public/data/repos.json")).collect{|r| "#{r["repository_owner"]}_#{r["repository_name"]}"}
  @repo = params[:repo]
  if @repo
    @dates = Dir.entries("public/data/#{@repo}").collect{|f| f.match(/#{@repo}_(\d{4}_\d{2})\.json/)}.compact.collect{|m| m[1]}.sort
  else
    @dates = []
  end
  haml :index
end
