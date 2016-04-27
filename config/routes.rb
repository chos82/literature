Lit::Engine.routes.draw do
  #root to: "references#index"
  get 'reflist/:id', to: 'references#reflist'
  post '/create/:id', to: 'references#create'
  #resources :references
end
