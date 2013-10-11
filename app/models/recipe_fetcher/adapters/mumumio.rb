class RecipeFetcher::Adapters::Mumumio
  def initialize(url)
    @url = url
  end

  def ingredients
    document.search("//div[contains(@class,'menur_i_s')]//tr").map(&:text).map do |ingredient|
      ingredient.gsub(/\-\n/,'').gsub(/\s+/, ' ').strip.downcase
    end
  end

  def image
    document.search("//div[@class='entry-header']//img").first.attributes['src'].value
  end

  def text
    text = []
    document.search("//div[@class='entry-content']").children.each do |node|
      next if node.name != 'p'
      first_sub_node = node.children.first

      html = node.to_html.strip
      if html.present?
        text << html
      end
    end

    text.join("\n")
  end

  def name
    document.search("//h2[@class='entry-title']").text
  end

  private

  def document
    @document ||= Nokogiri.HTML(open(@url))
  end
end
