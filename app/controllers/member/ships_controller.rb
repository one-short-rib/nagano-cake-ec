class Member::ShipsController < ApplicationController

	before_action :set_ship, only: [:edit,:update,:destroy]
  def index
  	@ships = current_member.ships.all
  	@ship = current_member.ships.new
  end

  def create
  	@ship = current_member.ships.new(ship_params)
  end

  def edit
  end

  def update
  	@ship.update(ship_params)
  	redirect_to members_ships_path
  end

  def destroy
  	@ship.destroy
  	redirect_to members_ships_path
  end

  private

  def set_ship
  	@ship = Ship.find(params[:id])
	end

  def ship_params
  	params.require(:ship).permit(:postal_code,:address,:name)
  end
end
