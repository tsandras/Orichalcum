# app/controllers/rooms_controller.rb
class RoomsController < ApplicationController
  def show
    @messages = Message.all
  end
end
