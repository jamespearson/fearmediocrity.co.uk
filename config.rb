require "active_support/all"
###
# Blog settings
###

# Time.zone = "UTC"
#
#sprockets.append_path '/source/js/plugins/'



activate  :blog do |blog|
  # blog.prefix = "blog"
  blog.permalink = ":year/:month/:day/:title/index.html"
  # blog.sources = ":year-:month-:day-:title.html"
  # blog.taglink = "tags/:tag.html"
  blog.layout = "article"

  blog.summary_separator = /(READMORE)/
  blog.summary_length = 250
  # blog.year_link = ":year.html"
  # blog.month_link = ":year/:month.html"
  # blog.day_link = ":year/:month/:day.html"
  blog.default_extension = ".md"

  blog.sources = "posts/:year-:month-:day-:title.html"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/:num"
end

activate :deploy do |deploy|
  deploy.method = :rsync
  deploy.host   = "fearmediocrity.co.uk"
  deploy.path   = "/var/www/fearmediocrity/public"
  deploy.build_before = true
  deploy.clean = true
  deploy.user = "root"
end

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'fearmediocrity-production' # The name of the S3 bucket you are targetting. This is globally unique.
  s3_sync.region                     = 'eu-west-1'     # The AWS region for your bucket.
  s3_sync.delete                     = true # We delete stray files by default.
  s3_sync.prefer_gzip                = true
  s3_sync.path_style                 = true
  #s3_sync.after_build                = true
end

activate  :syntax,
          :element => "pre>code"


page "/google152d413d2b447042.html", :directory_index => false
page "robots.txt", :layout => false
page "humans.txt", :layout => false
page "/feed.xml", :layout => false

default_caching_policy max_age:(60 * 60 * 24 * 365)

# Automatic image dimensions on image_tag helper
activate :automatic_image_sizes

set :layouts_dir, '_layouts'
set :partials_dir, '_partials'

set :css_dir, 'css'
set :images_dir, 'img'
set :js_dir, 'js'


set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true

# Build-specific configuration
configure :build do

  #activate :asset_host, host: 'http://testassets.fearmediocrity.co.uk'

  activate :asset_hash
  
  # For example, change the Compass output style for deployment
  activate :minify_css

  activate :minify_html
  
  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  require "middleman-smusher"
  activate :smusher

end

