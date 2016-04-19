Literature::Engine.routes.draw do
  root to: "references#index"

  resources :references do
    collection do
      post 'write_zotero'
    end
  end

end
