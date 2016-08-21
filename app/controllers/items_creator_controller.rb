# app/controllers/items_creator_controller.rb
class ItemsCreatorController < ApplicationController
  def manager
    @template = Template.new
    @templates = Template.all
  end

  def save_template
    @template = Template.create(template_params)
    render json: { template: @template }, statue: 200
  end

  def save_components
  end

  def templates
    @template = Template.find_by_id params[:id]
  end

  def templates_tree
    template = Template.find_by_id params[:id]
    render json: Template.tree(template)
  end

  private

  def template_params
    params.require(:template).permit(
      :name,
      :rarity,
      :image,
      :description,
      :image_data,
      :image_file_name
    )
  end
end
