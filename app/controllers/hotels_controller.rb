class HotelsController < ApplicationController
  before_action :set_hotel, only: [:show, :update, :destroy]

  def index
    @hotels = Hotel.all
    render json: @hotels
  end

  def show
    render json: @hotel
  end

  def create
    @hotel = Hotel.new(hotel_params)
    if @hotel.save
      render json: @hotel, status: :created
    else
      render json: @hotel.errors, status: :unprocessable_entity
    end
  end

  def update
    if @hotel.update(hotel_params)
      render json: @hotel
    else
      render json: @hotel.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @hotel.destroy
    head :no_content
  end

  def upload_image
    @hotel = Hotel.find(params[:id])
    @hotel.images.attach(params[:image]) if params[:image].present?
    render json: @hotel
  end

  private

  def set_hotel
    @hotel = Hotel.find(params[:id])
  end

  def hotel_params
    params.require(:hotel).permit(:name, :description, :address, :phone_number)
  end
end
