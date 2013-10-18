class RecipeFetcher::Adapters::Recetasdemama
  def initialize(url)
    @url = url
  end

  def ingredients
    document.search("//ul[contains(@class,'ingredients')]/li").map do |li|
      li.text.strip
    end
  end

  def image
    document.search("//div[contains(@class,'hrecipe')]//img").first.attributes['src'].value
  end

  def text
    document.search("//ol[contains(@class,'instructions')]/li").map do |li|
      "- #{li.text.strip}"
    end.join("\n")
  end

  def name
    document.search("//div[contains(@class,'hrecipe')]//h2").text.gsub(/Receta/, '').strip
  end

  private

  def document
    @document ||= Nokogiri.HTML(open(@url))
  end
end
