Rails.application.routes.draw do

  get 'home', controller: 'home'
  get 'home/erd', controller: 'home'

  get 'items_creator/manager', controller: 'items_creator'
  post 'items_creator/save_template', controller: 'items_creator'
  get 'items_creator/templates/:id', to: 'items_creator#templates'
end
