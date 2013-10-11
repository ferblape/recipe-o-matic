require 'spec_helper'

describe RecipeFetcher::Adapters::Mumumio do
  context 'given a recipe of curry' do
    # This is the original URL
    # let(:recipe_url) { 'http://www.nomas-demama.com/curry-rojo-vegetariano/' }
    let(:recipe_url) { 'spec/support/recipes/www-mumumio-com-recetas-pollo-crujiente-con-salsa-de-mostaza-y-miel.html' }
    let(:subject)    { RecipeFetcher::Adapters::Mumumio.new(recipe_url) }

    it 'should be able to extract the ingredients' do
      subject.ingredients.should == ['1 cda sésamo',
                                     '4 filetes pollo',
                                     '1 huevos',
                                     '1/2 taza pan rallado',
                                     '1/2 taza cereales',
                                     '150 ml mostaza',
                                     '75 ml mesas de cultivo',
                                     '75 ml aceite de oliva virgen extra',
                                     '2 cdas mayonesa',
                                     'sal']
    end

    it 'should be able to extract the text' do
      subject.text.should == %Q{<p>\n          <strong>Elaboración</strong>
          </p>
<p>Este rebozado es una pasada de crujiente gracias a los cereales y tiene un sabor muy bueno gracias al sésamo. Lo podéis utilizar con pescado también y os aseguro que los niños lo tomaran sin problemas. Por lo menos a los míos les encanta que cruja bien</p>
<p>PREPARACION DEL POLLO
<br>Preparamos una bolsa Zip con el pan rayado, el sésamo, y los cereales aplastados.
<br>Y ponemos una sarten con un dedo de AOVE a calentar.
<br>Pasamos las tiras de pollo por el huevo batido y las vamos metiendo en la bolsa del rebozado. Cuando tengamos unas cuantas tiras, 7 u 8, cerramos la bolsa la agitamos para que todas las tiras se impregnen del rebozado. Apretar de vez en cuando para que se agarré bien el rebozado.
<br>Hay que tener cuidado de que queden bien rebozadas.
<br>Sacamos las tiras y las vamos friendo en el aceite caliente hasta que estén doradas por los dos lado.</p>
<p>PREPARACION DE LA SALSA DE MOSTAZA
<br>Mezclar todo menos el aceite con unas barillas hasta qué este todo bien mezclado.
<br>Ir añadiendo el aceite con un chorlito mientras no paramos de batir.</p>
<p class="out_links">
          <a href="http://www.averquecocinamoshoy.com/2012/11/pollo-super-crujiente-con-salsa-de-mostaza-y-miel.html" target="_blank">Visitar blog</a>
        </p>}
    end

    it 'should be able to extract a image' do
      subject.image.should == 'http://s3.amazonaws.com/mumumio-production/recipes/206/big.jpeg'
    end
  end
end
