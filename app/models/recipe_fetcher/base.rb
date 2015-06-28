class RecipeFetcher::Base
  class NoAdapter < Exception; end

  attr_accessor :url, :adapter

  delegate :ingredients, :text, :image, :name, to: :adapter

  def initialize(url)
    @url = url

    @adapter = pick_adapter(@url)
  end

  private

  def pick_adapter(url)
    if url =~ /\Ahttp:\/\/www\.nomasdemama\.com/
      RecipeFetcher::Adapters::NoMasDeMama.new(url)
    elsif url =~ /\Ahttp:\/\/www\.mumumio\.com/
      RecipeFetcher::Adapters::Mumumio.new(url)
    elsif url =~ /\Ahttp:\/\/www\.recetasdemama\.es/
      RecipeFetcher::Adapters::Recetasdemama.new(url)
    elsif url =~ /\Ahttp:\/\/www\.contigoenlaplaya\.com/
      RecipeFetcher::Adapters::Contigoenlaplaya.new(url)
    elsif url =~ /\Ahttp:\/\/blogs\.elpais\.com\/el\-comidista/
      RecipeFetcher::Adapters::Comidista.new(url)
    elsif url =~ /\Ahttp:\/\/www\.hogarmania\.com/
      RecipeFetcher::Adapters::Hogarmania.new(url)
    else
      raise NoAdapter
    end
  end
end
