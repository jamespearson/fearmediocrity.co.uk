require "active_support/all"

I18n.enforce_available_locales = false
###
# Blog settings
###

# Time.zone = "UTC"



activate :blog do |blog|
  blog.name = "work"
  blog.layout = "work"
  blog.default_extension = ".md"
  blog.permalink = "work/:title/index.html"
  blog.sources = "posts/work/:year-:month-:day-:title.html"
end


# Blog posts
activate  :blog do |blog|
  blog.name = "blog"
  # blog.prefix = "blog"
  blog.permalink = ":year/:month/:day/:title/index.html"
  # blog.sources = ":year-:month-:day-:title.html"
  blog.taglink = ":tag/index.html"
  blog.layout = "article"

  blog.summary_separator = /(READMORE)/
  blog.summary_length = 250
  blog.year_link = ":year/index.html"
  blog.month_link = ":year/:month/index.html"
  # blog.day_link = ":year/:month/:day.html"
  blog.default_extension = ".md"

  blog.sources = "posts/blog/:year-:month-:day-:title.html"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/:num"
end

activate :autoprefixer do |config|
  config.browsers = ['last 2 versions', 'Explorer >= 9']
  config.cascade  = false
  config.inline   = true
  config.ignore   = ['hacks.css']
end

activate :deploy do |deploy|
  deploy.method = :rsync
  deploy.host   = "fearmediocrity.co.uk"
  deploy.path   = "/var/www/fearmediocrity/public"
  deploy.build_before = true
  deploy.clean = true
  deploy.user = "root"
end

activate :directory_indexes


activate :livereload
#
# activate  :syntax,
#           :element => "pre>code"


page "/google152d413d2b447042.html", :directory_index => false
page "robots.txt", :layout => false
page "humans.txt", :layout => false
page "/feed.xml", :layout => false


set :layouts_dir, '_layouts'
set :partials_dir, '_partials'

set :css_dir, 'css'
set :images_dir, 'img'
set :js_dir, 'js'



set :markdown, :tables => true, :autolink => true, :gh_blockcode => true, :fenced_code_blocks => true
set :markdown_engine, :redcarpet

# Build-specific configuration
configure :build do

  activate :asset_host, host: 'http://static.fearmediocrity.co.uk/public'

  activate :asset_hash

  activate :minify_css

  activate :minify_html
  
  # Minify Javascript on build
  activate :minify_javascript

  # Compress PNGs after build
  require "middleman-smusher"
  activate :smusher

end

after_configuration do
  sprockets.append_path File.join "#{root}", "bower_components"
end
