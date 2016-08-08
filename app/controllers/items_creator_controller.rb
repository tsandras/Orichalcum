class ItemsCreatorController < ActionController::Base

  def manager
    @template = Template.new
  end

  def save_template
    @template = Template.create(template_params)
  end

  def templates
    @template = Template.find_by_id params[:id]
  end

  private

  def template_params
    params.require(:template).permit(:name, :rarity, :image, :description)
  end
end
