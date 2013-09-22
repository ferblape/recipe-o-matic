require 'spec_helper'

describe RecipeFetcher::Base do
  context 'when the url is supported by any adapter' do
    let(:recipe_url) { 'http://www.nomas-demama.com/curry-rojo-vegetariano/' }
    let(:subject)    { RecipeFetcher::Base.new(recipe_url) }

    it 'calls an adapter for a url' do
      subject.adapter.should be_kind_of(RecipeFetcher::Adapters::NoMasDeMama)
      subject.url.should == recipe_url
    end
  end

  context 'when the url is not supported' do
    it 'should raise NoAdapter exception' do
      expect {
        RecipeFetcher::Base.new('http://tol.do')
      }.to raise_error(RecipeFetcher::Base::NoAdapter)
    end
  end
end
