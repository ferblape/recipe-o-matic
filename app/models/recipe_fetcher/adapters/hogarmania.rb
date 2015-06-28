class RecipeFetcher::Adapters::Hogarmania
  def initialize(url)
    @url = url
  end

  def ingredients
    document.search("ul.ingredientes li").map do |ingredient|
      ingredient.text.strip
    end
  end

  def image
    document.search(".m-video img").first.attributes['src'].value
  end

  def text
    text_paragraphs.join("\n\n")
  end

  def name
    document.search("h1").text.gsub(/Receta de /, "")
  end

  private

  def document
    @document ||= Nokogiri.HTML(open(@url))
  end

  def text_paragraphs
    document.search(".ficha h6:not(:first-child), .ficha p").map do |paragraph|
      paragraph.text.strip
    end
  end
end
