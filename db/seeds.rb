#recipe = Recipe.new
#recipe.original_url = "http://www.nomas-demama.com/curry-rojo-vegetariano/"
#recipe.name = "Curry Rojo Vegetariano"
#recipe.image = 'http://www.nomasdemama.com/wp-content/uploads/2013/09/IMG_1740_1.jpg'
#recipe.text = <<-HTML
#1 – Calentamos una olla a fuego medio y rehogamos los ajos y los ajos tiernos picados en un chorro de aceite de girasol. Tras 1 minuto, agregamos la pasta de curry y sofreímos un par de minutos.

#2 – Agregamos 2 cucharadas de leche de coco y las zanahorias, peladas y cortadas en rodajas gruesas, de 5 mm de grosor. Rehogamos durante 6-7 minutos y añadimos las patatas, peladas y cortadas en láminas finas, la pastilla de caldo, el resto de la leche de coco y el agua. Cuando suba el hervor, dejamos cocer 5 minutos.

#3 – Escurrimos los garbanzos, los pasamos bajo el grifo y los incorporamos a la olla junto con los brotes de soja. Apagamos el fuego y dejamos reposar un par de minutos.

#4 – Servimos el curry en cuencos, añadimos un poco más de leche de coco, los brotes de alfalfa y un poco de lima.
#HTML
#recipe.save!

#[
  #'— 3 cucharadas grandes de pasta de curry rojo',
  #'— 3 zanahorias',
  #'— 2 patatas',
  #'— 7 ajos tiernos',
  #'— 2 dientes de ajo',
  #'— 100 g de brotes de soja',
  #'— Brotes de alfalfa (para decorar)',
  #'— 400 g de garbanzos cocidos',
  #'— 1 pastilla de caldo de verdura',
  #'— 200 ml de leche de coco',
  #'— 1 l de agua',
  #'— Sal y pimienta',
  #'— Aceite de girasol'
#].each do |ingredient_str|
  #Ingredient.build_from_raw(ingredient_str, recipe)
#end


%W{
  http://www.nomasdemama.com/curry-rojo-vegetariano/
  http://www.nomasdemama.com/cordero-de-emergencia/
  http://www.nomasdemama.com/sopa-de-picadillo/
}.each do |url|
  Recipe.build_from_url(url)
  puts url
end

Recipe.all.each do |recipe|
  recipe.state = Recipe::STATES[:published]
  recipe.save!
end
