class RecipeFetcher::Adapters::NoMasDeMama
  def initialize(url)
    @url = url
  end

  def ingredients
    # First, most common, search
    ingredients = document.search("//div[@class='meta']/p").map(&:text).
      select{|n| n =~ /\A\—/ }.map do |n|
        n.gsub(/—/, '').strip
      end
    if ingredients.empty?
      candidates = document.search("//div[@class='meta']/p")
      p = candidates.sort{|p2,p1| p1.to_html.length <=> p2.to_html.length}.first

      ingredients = p.to_html.split(/<br[^>]*>/)[2..-1].map do |n|
        n.gsub(/—/, '').strip.gsub(/<[^>]+>/,'')
      end
    end

    ingredients
  end

  def image
    document.search("//div[@id='singlellarg']//img").map do |img|
      img.attributes['src'].value
    end.first
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
        text << html
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
end
