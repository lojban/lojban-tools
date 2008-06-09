require 'curb'

LANGS = %w/ en /

desc 'List lojban wordlist languages'
task 'lojban:langs'  do
  puts "Lojban wordlists:", LANGS.sort.map { |l|  "  #{l}" }
end

desc 'Download lojban wordlists from jbovlaste (lojban.org)'
task 'lojban:update', :lang  do |t, args|
  lang = args[:lang] || 'en'
  unless LANGS.include? lang
    raise "Unknown language \"#{lang}\" -- see 'rake lojban:langs' for language list"
  end

  url = "http://jbovlaste.lojban.org/export/xml-export.html?lang=#{lang}"
  dest = File.join RAILS_ROOT, 'public/data', "lojban-#{lang}.xml"

  puts "Downloading #{lang} wordlist"
  Curl::Easy.download url, dest  do |curl|
    curl.verbose = true
    curl.headers['Accept'] = 'application/xml'
  end
end

desc 'Download lojban word frequencies from lojban.org'
task 'lojban:update:freqs'  do
  url = 'http://lojban.org/publications/wordlists/frequencies.txt'
  dest = File.join RAILS_ROOT, 'public/data', File.basename(url)

  puts "Downloading word frequencies"
  Curl::Easy.download url, dest  do |curl|
    curl.verbose = true
  end
end