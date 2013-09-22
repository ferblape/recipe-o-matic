require 'spec_helper'

describe TextToIngredientProcessor do
  def self.ingredient_examples
    @ingredient_examples ||= {
      '3 zanahorias' =>                   [3.0, nil, 'zanahorias'],
      '100 g de brotes de soja' =>        [100.0, 'gr', 'brotes de soja'],
      '1 pastilla de caldo de verdura' => [1.0, nil, 'pastilla de caldo de verdura'],
    }
      #'200 ml de leche de coco' =>        [200.0, 'ml', 'leche de coco'],
      #'1 l de agua' =>                    [1.0, 'l', 'agua'],
      #'100 gr de mantequilla' =>          [100.0, 'gr', 'mantequilla'],
      #'100 gr. de jamón' =>               [100.0, 'gr', 'jamon'],
      #'1 l. de leche de vaca' =>          [1.0, 'l', 'leche de vaca'],
      #'Sal y pimienta' =>                 [[nil, nil, 'sal'], [nil, nil, 'pimienta']],
      #'Aceite de girasol' =>              [nil, nil, 'aceite de girasol'],
      #'1 diente de ajo' =>                [1.0, nil, 'diente de ajo'],
      #'7 dientes de ajo' =>               [7.0, nil, 'dientes de ajo'],
      #'1/2 manzana Granny Smith' =>       [0.5, nil, 'manzana Granny Smith'],
      #'1 puñado de hojas verdes variadas' => [1.0, 'puñado', 'hojas verdes variadas'],
      #'4 trozos de queso tipo Arzúa-Ulloa (unos 60 g)' => [4.0, 'trozos', 'queso tipo Arzúa-Ulloa'],
      #'1 cucharada pequeña de su aceite' => [1.0, 'cucharada pequeña', 'su aceite'],
      #'1 cucharada grande de mantequilla' => [1.0, 'cucharada grande', 'mantequilla'],
      #'2 cucharadas pequeñas de mantequilla' => [2.0, 'cucharada pequeña', 'mantequilla'],
      #'2 cucharadas grandes de mantequilla' => [2.0, 'cucharada grande', 'mantequilla'],
      #'1 1/2 taza de agua' =>             [1.5, 'taza', 'agua'],
      #'2 vainas de cardamomo' =>          [2.0, 'puñado', 'sal'],
      #'Un puñado de sal' =>               [1.0, 'puñados', 'sal'],
      #'Dos puñados de sal' =>             [2.0, 'puñados', 'sal'],
      #'Tres puñados de sal' =>            [3.0, 'puñados', 'sal'],
      #'Cuatro puñados de sal' =>          [4.0, 'puñados', 'sal'],
      #'1 taza (alrededor de 300 g) de arroz basmati' => [1.0, 'taza', 'arroz basmati'],
      #'15-20 hebras de azafrán' =>        [15.0, nil, 'hebras de azafrán'],
      #'1/2 copa de vino blanco' =>        [0.5, 'copa', 'vino blanco'],
      #'1 pepino pequeño o 1/2 grande' =>  [1.0, nil, 'pepino pequeño'],
      #'2.5 l de caldo de verduras' =>     [2.5, 'l', 'caldo de verduras'],
      #'2-3 granos de pimienta' =>         [2.0, 'granos', 'pimienta'],
      #'15 hojas de albahaca fresca' =>    [15.0, 'hojas', 'albahaca fresca'],
      #'1/4 de cucharada pequeña de aceite' => [0.25, 'cucharada pequeña', 'aceite'],
      #'200g masa madre de espelta blanca' => [200.0, 'gramos', 'masa madre de espelta blanca'],
      #'1 cucharadita de azúcar' =>        [1.0, 'cucharada pequeña', 'azúcar']
      #
    #}
  end

  describe '#process' do
    ingredient_examples.each do |str, values|
      it "should return proper values for #{str}" do
        TextToIngredientProcessor.process(str, Food).should == values
      end
    end
  end
end
