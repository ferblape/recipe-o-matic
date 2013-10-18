class AdapterGenerator < Rails::Generators::NamedBase
  AdapterGenerator.source_root(File.expand_path("../templates", __FILE__))

  desc "Create a new adapter"
  def create_initializer_file
    template "adapter_template.rb", "app/models/recipe_fetcher/adapters/#{file_name}.rb"
    template "adapter_spec_template.rb", "spec/models/recipe_fetcher/adapters/#{file_name}_spec.rb"
  end
end
