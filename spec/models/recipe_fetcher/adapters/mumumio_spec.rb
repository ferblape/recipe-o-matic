require 'rails_helper'

describe RecipeFetcher::Adapters::Mumumio do
  context 'given a recipe of curry' do
    # This is the original URL
    # let(:recipe_url) { 'http://www.mumumio.com/recetas/pollo-crujiente-con-salsa-de-mostaza-y-miel' }
    let(:recipe_url) { 'spec/support/recipes/www-mumumio-com-recetas-pollo-crujiente-con-salsa-de-mostaza-y-miel.html' }
    let(:subject)    { RecipeFetcher::Adapters::Mumumio.new(recipe_url) }

    it 'should be able to extract the ingredients' do
      expect(subject.ingredients).to eq(['1 cda sésamo',
                                     '4 filetes pollo',
                                     '1 huevos',
                                     '1/2 taza pan rallado',
                                     '1/2 taza cereales',
                                     '150 ml mostaza',
                                     '75 ml mesas de cultivo',
                                     '75 ml aceite de oliva virgen extra',
                                     '2 cdas mayonesa',
                                     'sal'])
    end

    it 'should be able to extract the text' do
      expect(subject.text).to eq(%Q{- Elaboración\n- Este rebozado es una pasada de crujiente gracias a los cereales y tiene un sabor muy bueno gracias al sésamo. Lo podéis utilizar con pescado también y os aseguro que los niños lo tomaran sin problemas. Por lo menos a los míos les encanta que cruja bien\n- PREPARACION DEL POLLO\nPreparamos una bolsa Zip con el pan rayado, el sésamo, y los cereales aplastados.\nY ponemos una sarten con un dedo de AOVE a calentar.\nPasamos las tiras de pollo por el huevo batido y las vamos metiendo en la bolsa del rebozado. Cuando tengamos unas cuantas tiras, 7 u 8, cerramos la bolsa la agitamos para que todas las tiras se impregnen del rebozado. Apretar de vez en cuando para que se agarré bien el rebozado.\nHay que tener cuidado de que queden bien rebozadas.\nSacamos las tiras y las vamos friendo en el aceite caliente hasta que estén doradas por los dos lado.\n- PREPARACION DE LA SALSA DE MOSTAZA\nMezclar todo menos el aceite con unas barillas hasta qué este todo bien mezclado.\nIr añadiendo el aceite con un chorlito mientras no paramos de batir.\n- Visitar blog})
    end

    it 'should be able to extract a image' do
      expect(subject.image).to eq('http://s3.amazonaws.com/mumumio-production/recipes/206/big.jpeg')
    end
  end
end
