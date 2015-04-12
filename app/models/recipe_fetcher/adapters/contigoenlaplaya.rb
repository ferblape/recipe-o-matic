class RecipeFetcher::Adapters::Contigoenlaplaya
  INGREDIENTS_STRING = "INGREDIENTES"

  def initialize(url)
    @url = url
  end

  def ingredients
    raw_text_tokens[0...last_ingredient_position].map do |ingredient|
      "- #{ingredient}"
    end.join("\n")
  end

  def image
    document.search("//div[contains(@class,'post-body')]//img").first.attributes['src'].value
  end

  def text
    raw_text_tokens[last_ingredient_position..-1].join("\n")
  end

  def name
    document.search("//div[contains(@class,'post')]//h3").text.strip
  end

  private

  def document
    @document ||= Nokogiri.HTML(open(@url))
  end

  def raw_text_tokens
    text = document.search("//div[contains(@class,'post-body')]").text.strip
    tokens = text.split("\n")
    index = tokens.index(INGREDIENTS_STRING)
    tokens[index+1..-1].select{|s| s.present? }
  end

  def last_ingredient_position
    raw_text_tokens.each_with_index do |ingredient, i|
      return i if ingredient.length > 120
    end

    return 0
  end
end
