Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  get "/auth/:provider/callback" => "sessions#create"

end
