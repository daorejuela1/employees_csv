Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "employees#index"
  resources :employees, only: [:index, :new, :create]
  get "/exportar_csv", to: "employees#send_csv"
end
