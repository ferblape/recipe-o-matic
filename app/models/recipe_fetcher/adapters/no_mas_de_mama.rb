class RecipeFetcher::Adapters::NoMasDeMama
  def initialize(url)
    @url = url
  end

  def ingredients
    # First, most common, search
    ingredients = document.search("//div[@class='meta']/p").map(&:text).
      select{|n| n =~ /\A\—/ }.map do |n|
        clean_ingredient(n)
      end

    if ingredients.empty?
      candidates = document.search("//div[@class='meta']/p")
      p = candidates.sort{|p2,p1| p1.to_html.length <=> p2.to_html.length}.first

      ingredients = p.to_html.split(/<br[^>]*>/)[2..-1].map do |n|
        clean_ingredient(n)
      end
    end

    ingredients
  end

  def image
    if img = document.search("//div[@id='singlellarg']//img").first
      img.attributes['src'].value
    end
  end

  def text
    text = []
    document.search("//div[@id='singlellarg']").children.each do |node|
      next if node.name != 'p'
      break if node.name == 'div'
      first_sub_node = node.children.first
      next if first_sub_node && first_sub_node.name == 'img'

      html = node.to_html.strip
      if html.present?
        text << "- #{clean_str(html)}"
      end
    end

    text.join("\n")
  end

  def name
    document.search('//h1').text
  end

  private

  def document
    @document ||= Nokogiri.HTML(open(@url))
  end

  def clean_ingredient(str)
    strip_tags(str.gsub(/\A\s—\s/, '').gsub(/\A\s*—\s*/, ''))
  end

  def clean_str(str)
    strip_tags(str.gsub(/\d+\s–\s/, ''))
  end

  def strip_tags(str)
    str.gsub(/<[^>]+>/,'').strip
  end
end
