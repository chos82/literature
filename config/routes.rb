Literature::Engine.routes.draw do
  root to: "references#index"
  resources :references
end
