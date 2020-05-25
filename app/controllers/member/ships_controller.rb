class Member::ShipsController < ApplicationController
  before_action :authenticate_member!
	before_action :set_ship, only: [:edit,:update,:destroy]
  def index
  	@ships = current_member.ships.all
  	@ship  = current_member.ships.new
  end

  def create
  	@ship = current_member.ships.new(ship_params)
  	if @ship.save
      flash[:notice]="配送先を登録しました"
  		redirect_to members_ships_path
  	else
  		@ships = current_member.ships.all
  		render :index
  	end
  end

  def edit
  end

  def update
  	if @ship.update(ship_params)
      flash[:success]="配送先情報を編集しました"
  		redirect_to members_ships_path
  	else
  		render :edit
  	end
  end

  def destroy
  	@ship.destroy
    flash[:danger]="#{@ship.name}様宛の配送先を１件削除しました"
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
