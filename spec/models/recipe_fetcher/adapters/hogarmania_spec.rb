require 'rails_helper'

describe RecipeFetcher::Adapters::Hogarmania do
  context 'given a recive of mousse' do
    subject { RecipeFetcher::Adapters::Hogarmania.new(recipe_url) }

    #let(:recipe_url) { 'http://www.hogarmania.com/cocina/recetas/postres/200912/mousse-turron-388.html' }
    let(:recipe_url) { 'spec/support/recipes/www-hogarmania-com-mousse-turron.html' }

    let(:ingredients) do
      [
        '150 g de turrón blando (de Jijona)',
        '3 claras de huevo',
        '250 ml de leche',
        '14-16 frambuesas',
        'ralladura de 1 naranja',
        'galletas para acompañar',
        'menta para decorar',
      ]
    end

    context '#ingredients' do
      it 'should be able to extract the ingredientes' do
        expect(subject.ingredients).to eq(ingredients)
      end
    end

    context '#text' do
      it 'should be able to extract the text' do
        expect(subject.text).to eq(%Q{Elaboración de la receta Mousse de turrón\nPon la leche a calentar en un cazo. Agrega el turrón y la ralladura de naranja. Remueve hasta que se disuelva todo el turrón y aparta a un bol.\nMonta las claras a punto de nieve e incorpóralas al bol del turrón. Mezcla suavemente con movimientos envolventes hasta conseguir una masa homogénea. Tapa con un papel plástico y deja enfriar en el frigorífico.\nSirve en copa. Pon en el fondo algunas frambuesas y vierte por encima la mitad de la mousse de turrón. Coloca tejas (u otras galletas) troceadas encima y el resto de las frambuesas. Cubre con el resto de la mousse de turrón y decora con menta.\nMás recetas con turrón})
      end
    end

    context '#image' do
      it 'should be able to extract an image' do
        expect(subject.image).to eq('http://static.hogarutil.com/archivos/201105/mousse-de-turron-xl-668x400x80xX.jpg')
      end
    end

    context '#name' do
      it 'should be able to extract the name' do
        expect(subject.name).to eq('Mousse de turrón')
      end
    end
  end
end
