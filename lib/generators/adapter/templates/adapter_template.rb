class RecipeFetcher::Adapters::<%= file_name.capitalize %>
  def initialize(url)
    @url = url
  end

  def ingredients
  end

  def image
  end

  def text
  end

  def name
  end

  private

  def document
    @document ||= Nokogiri.HTML(open(@url))
  end
end
