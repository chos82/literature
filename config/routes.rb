Lit::Engine.routes.draw do
  root to: "references#reflist"
  get 'reflist/:id', to: 'references#reflist'
  post '/create/:id', to: 'references#create'
end
