# Recipe-o-matic™

The best way to save recipes and plan what to cook during the week.

## Save recipes

Recipe:

- original_url
- plain_text

Food

- name
- stemmed_name

Ingredient:

- recipe_id
- amount
- unit
- ingredient_id


## Python

RubyPython.start
sys = RubyPython.import("sys")
sys.path.append("#{Rails.root}/vendor/Python-Inflector/")
inflector = RubyPython.import('inflector')
rules = RubyPython.import('rules.spanish')
i = inflector.Inflector(rules.Spanish)
RubyPython.stop
