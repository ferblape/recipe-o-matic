require 'spec_helper'

describe RecipeFetcher::Adapters::NoMasDeMama do
  context 'given a recipe of curry' do
    # This is the original URL
    # let(:recipe_url) { 'http://www.nomas-demama.com/curry-rojo-vegetariano/' }
    let(:recipe_url) { 'spec/support/recipes/www-nomas-demama-com-curry-rojo-vegetariano.html' }
    let(:subject)    { RecipeFetcher::Adapters::NoMasDeMama.new(recipe_url) }

    it 'should be able to extract the ingredients' do
      subject.ingredients.should == ['3 cucharadas grandes de pasta de curry rojo', 
                                     '3 zanahorias', '2 patatas', '7 ajos tiernos',
                                     '2 dientes de ajo', '100 g de brotes de soja',
                                     'Brotes de alfalfa (para decorar)',
                                     '400 g de garbanzos cocidos',
                                     '1 pastilla de caldo de verdura',
                                     '200 ml de leche de coco', '1 l de agua',
                                     'Sal y pimienta', 'Aceite de girasol']
    end

    it 'should be able to extract the text' do
      subject.text.should == "<p>Me ha costado dos semanas poder traerme a Marc y a Adrià a comer a casa. Sí, esa que estrené en julio. Sí, esa cuyos muebles compramos, transportamos y montamos nosotros —Hèctor, Alberto, Juanma y yo—. Eso, por cierto, nos tiene que otorgar por narices el derecho a guarrearlos y estropearlos. Otra cosa muy diferente —seamos racionales— es que vayamos a hacerlo. Pero el derecho está, nos lo hemos ganado. Ahí queda. Retomando el tema de Marc, Adrià y la famosa comida, sucedió ayer. Volví algo pronto del estudio, a eso de la una de la tarde, para preparar canelones rellenos de mató —pero esa es otra historia— y dejar un poco decente el salón. Lo que más me sorprendió fue que a Marc y Adrià les gustara (y bastante, según me dijeron. No, no es por compromiso. Si algo de lo que cocino no les va, no se ahorran la opinión) este <em>curry</em> rojo que serví de primero. Realmente, nunca lo había probado, por lo que no tenía muy claro cómo se supone que tiene que saber. Eso sí, yo me lo he comido por gula, por si se estropea o, haciendo gala de mi pesimismo, por si la raza humana se va a la mierda mañana. Esas cosas.</p>
<p>1 – Calentamos una olla a fuego medio y rehogamos los ajos y los ajos tiernos picados en un chorro de aceite de girasol. Tras 1 minuto, agregamos la pasta de <em>curry</em> y sofreímos un par de minutos.</p>
<p>2 – Agregamos 2 cucharadas de leche de coco y las zanahorias, peladas y cortadas en rodajas gruesas, de 5 mm de grosor. Rehogamos durante 6-7 minutos y añadimos las patatas, peladas y cortadas en láminas finas, la pastilla de caldo, el resto de la leche de coco y el agua. Cuando suba el hervor, dejamos cocer 5 minutos.</p>
<p>3 – Escurrimos los garbanzos, los pasamos bajo el grifo y los incorporamos a la olla junto con los brotes de soja. Apagamos el fuego y dejamos reposar un par de minutos.</p>
<p>4 – Servimos el <em>curry</em> en cuencos, añadimos un poco más de leche de coco, los brotes de alfalfa y un poco de lima.</p>"
    end

    it 'should be able to extract the images' do
      subject.images.should == [
        'http://www.nomas-demama.com/wp-content/uploads/2013/09/IMG_1740_1.jpg',
        'http://www.nomas-demama.com/wp-content/uploads/2013/09/IMG_1735.jpg'
      ]
    end
  end
end
