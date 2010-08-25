require 'open-uri'
require 'json'

class Harmful
  attr_accessor :title, :title_no_formatting, :url

  def self.load_json
    key = "ABQIAAAAWLOrTtZZMVqckifzzqf5ExTJ4z6FYubmaJQBWq"
    key << "BMMbq6Cm7PQhTpBR48VC90aX3PtU5LEktkiQhpnw"
    rsz = 8
    start = 0
    search_method = 'blogs'
    search_method = 'web'
    q = "'considered%20harmful'"
    url = "http://ajax.googleapis.com/ajax/services/search/"
    url << search_method
    url << "?v=1.0&q=#{q}&rsz=#{rsz}&start=#{start}"
    ret = {}
    open(url) do |f|
      text = f.read
      ret = JSON.parse(text)
    end
    ret
  end

  def self.all
    harmfuls = []
    json = load_json
    json['responseData']['results'].each do |result|
      harmful = Harmful.new
      harmful.title = result['title']
      harmful.title_no_formatting = result['titleNoFormatting']
      harmful.url = result['url']
      harmfuls << harmful
    end
    harmfuls.map! do |harmful|
      bolds = harmful.title.scan(/<b>[^<\/b]*<\/b>/)
      if bolds.length > 0
        harmful.title << bolds.length.to_s
      end
      harmful
    end
    harmfuls
  end
end
