require 'acceptance/acceptance_helper'

feature 'Recipes' do
  scenario 'Create a recipe importing an URL' do
    FakeWeb.register_uri(:get, 'http://www.nomasdemama.com/blog/wp-content/uploads/2012/09/240-resultadolowres2.jpg',
                         body: 'xxxxx', content_type: 'image/jpg')

    FakeWeb.register_uri(:get, 'http://www.nomasdemama.com/costillas-con-longaniza-y-patatas/', 
                         body: File.read(Rails.root.join('spec', 'support', 'recipes', 'www-nomasdemama-com-costillas-con-longaniza-y-patatas.html')),
                         content_type: "text/html")

    visit homepage

    click_link '+ Nueva receta'

    page.should have_content('Guarda una nueva receta')

    fill_in 'recipe_original_url', with: 'http://www.nomasdemama.com/costillas-con-longaniza-y-patatas/'
    click_button 'Guardar'

    expect(page).to have_css 'h2.p-name', text: 'Costillas con longaniza y patatas'
  end

  scenario 'Create a recipe manually' do
    FakeWeb.register_uri(:get, 'http://www.nomasdemama.com/wp-content/uploads/2013/06/IMG_1157_1.jpg',
                         body: 'xxxxx', content_type: 'image/jpg')

    visit homepage

    click_link '+ Nueva receta'

    page.should have_content('Guarda una nueva receta')

    click_link 'guardar la receta a mano'

    fill_in 'Nombre', with: 'Cordero de emergencia'
    fill_in 'URL Original', with: 'http://www.nomasdemama.com/cordero-de-emergencia/'
    fill_in 'Imagen', with: 'http://www.nomasdemama.com/wp-content/uploads/2013/06/IMG_1157_1.jpg'
    fill_in 'Preparación', with: <<-TEXT
- Calentamos una sartén amplia a fuego medio-fuerte y doramos bien durante 15 minutos el cordero salpimentado junto con las cayenas y los ajos enteros y pelados. Si es necesario, se puede añadir un poco de aceite, pero no hay que abusar. Pasado ese tiempo, retiramos y reservamos.

- Cortamos la berenjena en cubos medianos (de alrededor de 2 cm de lado), añadimos un chorro generoso de aceite de oliva virgen extra a la sartén y los incorporamos. Salpimentamos y los dejamos hacerse durante unos 10 minutos. Tras 5 minutos, agregamos la cebolla picada.

- Añadimos el cuscús, lo mareamos ligeramente y lo mojamos todo con el caldo de verduras. Devolvemos el cordero a la sartén, esperamos 5 minutos a que el cuscús se hidrate y ya podemos servir.

- No he querido detallar cómo se hace el labneh porque, posiblemente, le dedicaré una entrada. Si no lo encontráis en ninguna tienda, podéis hacer salsa de yogur o utilizar algún queso cremoso de sabor fuerte.
TEXT
    fill_in 'recipe_ingredients_text', with: <<-TEXT
- 350 g de pecho de cordero
- 1/2 vaso de cuscús
- 1/2 vaso de caldo de verduras
- 5 dientes de ajo
- 1 berenjena
- 2 cayenas
- Yogur o labneh (opcional)
- Sal y pimienta
- Aceite de oliva virgen extra
TEXT

    click_button 'Guardar'

    expect(page).to have_css 'h2.p-name', text: 'Cordero de emergencia'
  end
end
