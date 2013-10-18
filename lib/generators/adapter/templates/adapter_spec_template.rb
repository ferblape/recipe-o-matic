require 'spec_helper'

describe RecipeFetcher::Adapters::<%= file_name.capitalize %> do
  context 'given a recipe of curry' do
    # This is the original URL
    # let(:recipe_url) { '' }
    let(:recipe_url) { 'spec/support/recipes/' }
    let(:subject)    { RecipeFetcher::Adapters::<%= file_name.capitalize %>.new(recipe_url) }

    it 'should be able to extract the ingredients' do
      subject.ingredients.should == []
    end

    it 'should be able to extract the text' do
      subject.text.should == ""
    end

    it 'should be able to extract a image' do
      subject.image.should == ''
    end
  end
end
