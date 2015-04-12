class RecipeFetcher::Adapters::Comidista
  SEPARATOR = "Preparación"

  def initialize(url)
    @url = url
  end

  def ingredients
    document.search("//div[contains(@class,'entry-more')]/ul/li").map do |li|
      li.text.strip
    end
  end

  def image
    document.search("//img[contains(@class,'asset-image')]").first.attributes['src'].value
  end

  def text
    sentences = document.search("//div[contains(@class,'entry-more')]").text.strip.split("\n").map(&:strip)
    separator_position = sentences.index(SEPARATOR)
    sentences[separator_position+1..-1].join("\n")
  end

  def name
    document.search("//h2[contains(@class,'entry-header')]").text.strip
  end

  private

  def document
    @document ||= Nokogiri.HTML(open(@url))
  end
end
