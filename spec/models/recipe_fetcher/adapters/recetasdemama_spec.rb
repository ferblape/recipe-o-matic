require 'spec_helper'

describe RecipeFetcher::Adapters::Recetasdemama do
  context 'given a recipe of curry' do
    # This is the original URL
    # let(:recipe_url) { 'http://www.recetasdemama.es/2012/08/rollo-de-bonito/' }
    let(:recipe_url) { 'spec/support/recipes/www-recetasdemama-es-rollo-de-bonito.html' }
    let(:subject)    { RecipeFetcher::Adapters::Recetasdemama.new(recipe_url) }

    it 'should be able to extract the ingredients' do
      subject.ingredients.should == ["700 g bonito del norte",
                                     "150 g jamón  entreverado",
                                     "1  huevo cocido",
                                     "2  huevos crudos",
                                     "perejil",
                                     "200 g pan rallado casero sin gluten",
                                     "harina Special Line",
                                     "1  huevo batido para rebozar",
                                     "aceite de oliva virgen extra",
                                     "sal",
                                     "750  g tomates  maduros",
                                     "2  cebollas  grandes",
                                     "6  pimientos del piquillo",
                                     "1 vasito vino blanco seco"]
    end

    it 'should be able to extract the text' do
      subject.text.should == "- Con esta cantidad salen dos rollos grandes o tres medianitos.\n- En primer lugar se preparan los rollos de la manera siguiente: se corta el bonito en pequeño con cuchillo, porque con picadora se haría papilla, y se mezcla bien con el jamón finamente picado, el pan rallado, el perejil y los huevos. Se puede añadir un poco de sal, pero con moderación. Yo casi prefiero poner sal sólo en la salsita, para no pasarme. El pan rallado se va añadiendo poco a poco hasta conseguir una masita con una consistencia similar a la de las albóndigas\n- Se divide la masa en tres partes y se les da forma de rollo, y esta supercorqueta se pasa por harina y huevo batido y se frien en una sartén con abundante aceite de oliva. Hay que darles la vuelta para conseguir que quede dorado por todos lados.\n- Se retira buena parte del aceite, y se deja sólo el necesario para hacer el sofrito de la salsa. Para ello se pone a pochar la cebolla bien picadita. Antes de que tome color, se añaden los tomates picados y los pimientos cortados en tiras. Con estos pimientos la salsa queda muy roja. Y ya sólo queda añadir el vino blanco seco.\n- Se deja hacer el sofrito a fuego lento, después se paa por una batidora o un chino, para que quede homogénea y sin tropezones. Se vuelve a poner en la sartén, en este caso con los rollos de bonito y se deja cocer a fuego lento, para que el pescado tome el sabor de la salsa, pero sin que se pase de cocción.\n- Para servirlo, hay que esperar a que se enfríe un poco, porque no se debe cortar en caliente, para evitar que se desahaga del todo. Se corta en rodajas y se sirve con la salsa bien caliente, y el resto: al congelador. Vale la pena hacer en cantidad, porque congela estupendamente."
    end

    it 'should be able to extract a image' do
      subject.image.should == 'http://static3.recetasdemama.es/wp-content/uploads/2012/08/rollo-de-bonito-05991wtmk.jpg.jpg'
    end

    it 'should be able to extract a name' do
      subject.name.should == 'Rollo de bonito'
    end

  end
end
