require 'rails_helper'

describe RecipeFetcher::Adapters::NoMasDeMama do
  context 'given a recipe of curry' do
    # This is the original URL
    # let(:recipe_url) { 'http://www.nomasdemama.com/curry-rojo-vegetariano/' }
    let(:recipe_url) { 'spec/support/recipes/www-nomasdemama-com-curry-rojo-vegetariano.html' }
    let(:subject)    { RecipeFetcher::Adapters::NoMasDeMama.new(recipe_url) }

    it 'should be able to extract the ingredients' do
      expect(subject.ingredients).to eq(['3 cucharadas grandes de pasta de curry rojo', 
                                     '3 zanahorias', '2 patatas', '7 ajos tiernos',
                                     '2 dientes de ajo', '100 g de brotes de soja',
                                     'Brotes de alfalfa (para decorar)',
                                     '400 g de garbanzos cocidos',
                                     '1 pastilla de caldo de verdura',
                                     '200 ml de leche de coco', '1 l de agua',
                                     'Sal y pimienta', 'Aceite de girasol'])
    end

    it 'should be able to extract the text' do
      expect(subject.text).to eq("- Me ha costado dos semanas poder traerme a Marc y a Adrià a comer a casa. Sí, esa que estrené en julio. Sí, esa cuyos muebles compramos, transportamos y montamos nosotros —Hèctor, Alberto, Juanma y yo—. Eso, por cierto, nos tiene que otorgar por narices el derecho a guarrearlos y estropearlos. Otra cosa muy diferente —seamos racionales— es que vayamos a hacerlo. Pero el derecho está, nos lo hemos ganado. Ahí queda. Retomando el tema de Marc, Adrià y la famosa comida, sucedió ayer. Volví algo pronto del estudio, a eso de la una de la tarde, para preparar canelones rellenos de mató —pero esa es otra historia— y dejar un poco decente el salón. Lo que más me sorprendió fue que a Marc y Adrià les gustara (y bastante, según me dijeron. No, no es por compromiso. Si algo de lo que cocino no les va, no se ahorran la opinión) este curry rojo que serví de primero. Realmente, nunca lo había probado, por lo que no tenía muy claro cómo se supone que tiene que saber. Eso sí, yo me lo he comido por gula, por si se estropea o, haciendo gala de mi pesimismo, por si la raza humana se va a la mierda mañana. Esas cosas.
- Calentamos una olla a fuego medio y rehogamos los ajos y los ajos tiernos picados en un chorro de aceite de girasol. Tras 1 minuto, agregamos la pasta de curry y sofreímos un par de minutos.
- Agregamos 2 cucharadas de leche de coco y las zanahorias, peladas y cortadas en rodajas gruesas, de 5 mm de grosor. Rehogamos durante 6-7 minutos y añadimos las patatas, peladas y cortadas en láminas finas, la pastilla de caldo, el resto de la leche de coco y el agua. Cuando suba el hervor, dejamos cocer 5 minutos.
- Escurrimos los garbanzos, los pasamos bajo el grifo y los incorporamos a la olla junto con los brotes de soja. Apagamos el fuego y dejamos reposar un par de minutos.
- Servimos el curry en cuencos, añadimos un poco más de leche de coco, los brotes de alfalfa y un poco de lima.")
    end

    it 'should be able to extract a image' do
      expect(subject.image).to eq('http://www.nomasdemama.com/wp-content/uploads/2013/09/IMG_1740_1.jpg')
    end
  end

  context 'given a recipe of potatoes and ribs' do
    # This is the original URL
    # let(:recipe_url) { 'http://www.nomasdemama.com/costillas-con-longaniza-y-patatas/' }
    let(:recipe_url) { 'spec/support/recipes/www-nomasdemama-com-costillas-con-longaniza-y-patatas.html' }
    let(:subject)    { RecipeFetcher::Adapters::NoMasDeMama.new(recipe_url) }

    it 'should be able to extract the ingredients' do
      expect(subject.ingredients).to eq(["200 g de longaniza a la pimienta",
                                     "1 l de agua",
                                     "1/2 vaso de vino blanco",
                                     "3 patatas grandes",
                                     "1 pimiento choricero",
                                     "1 cebolla grande",
                                     "1 tomate",
                                     "2 dientes de ajo",
                                     "1 rama de romero",
                                     "Sal y pimienta",
                                     "Aceite de oliva virgen extra"])
    end

    it 'should be able to extract the text' do
      expect(subject.text).to eq("- Llevaba bastante tiempo queriendo hacer un guisote de estos pistonudos en los que carne y patatas se juntan. Como la longaniza catalana es de los pocos embutidos similares a las salchichas que me gustan, quería aprovechar la oportunidad de incorporarla para ver qué tal encajaba. He de decir que estoy muy contento con el resultado. No tanto por obra mía como por la calidad de los ingredientes, que era, sencillamente, altísima. A pesar de que todavía no ha llegado el frío, está bien ir desempolvando este tipo de recetas para que luego la rasca no nos pille oxidados. Eso sí, os recomiendo hidratar el pimiento choricero con antelación y luego aprovechar únicamente la pulpa en lugar de incorporarlo al guiso, como he hecho yo, ya que luego no tendréis que estar quitando trozos de piel, lo cual es (admitámoslo) un auténtico coñazo. Hala, salud.\n- Calentamos una olla a fuego medio-fuerte, añadimos un chorrito de aceite de oliva virgen extra y doramos en él las costillas y la longaniza, cortada en trozos de unos 4 cm. Salpimentamos.\n- Una vez que la carne haya tomado color por todos los lados, la retiramos y la reservamos. Bajamos el fuego a medio y sofreímos en el mismo aceite la cebolla y el ajo picados. Salamos ligeramente para que suelten el agua.\n- Pasados unos 10 minutos, añadimos el tomate rallado y dejamos que se evapore un poco el agua. Incorporamos la rama de romero, el pimiento choricero —al que habremos quitado el rabo y que habremos despepitado— y el vino blanco.\n- Cuando el vino haya perdido el alcohol, agregamos el agua y la carne que habíamos reservado. Subimos el fuego y, cuando empiece a hervir, lo bajamos de nuevo para que la cocción sea pausada. Probamos y corregimos de sal. Es importante que esté un poco fuerte de sabor, ya que luego las patatas lo rebajarán ligeramente. Dejamos cocer durante 45 minutos.\n- Pelamos las patatas y las cortamos chascándolas ligeramente, de tal manera que luego suelten almidón. Las añadimos al guiso y dejamos que cuezan durante 15-20 minutos o hasta que estén blandas. Por último, si queremos trabar un poco el guiso, trituramos un par de ellas y removemos bien.")
    end

    it 'should be able to extract a image' do
      expect(subject.image).to eq('http://www.nomasdemama.com/blog/wp-content/uploads/2012/09/240-resultadolowres2.jpg')
    end
  end
end
