if ENV["GITHUB_TOKEN"]
  $github = Github.new basic_auth: ENV["GITHUB_TOKEN"],
                       org: 'HungerStruck'
end
