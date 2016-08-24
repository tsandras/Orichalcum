Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  get 'home', controller: 'home'
  get 'home/erd', controller: 'home'

  get 'rooms/show'

  get 'items_creator/manager', controller: 'items_creator'
  post 'items_creator/save_template', controller: 'items_creator'
  post 'items_creator/random_templates_tree', controller: 'items_creator'
  post 'items_creator/templates_tree', controller: 'items_creator'
  get 'items_creator/templates/:id', to: 'items_creator#templates'
end
