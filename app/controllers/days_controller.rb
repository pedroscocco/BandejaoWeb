class DaysController < ApplicationController
  # GET /days
  # GET /days.json
  def index
    @days = Day.all

    render json: @days
  end

  # GET /days/1
  # GET /days/1.json
  def show
    @day = Day.find(params[:id])

    render json: @day
  end

  # POST /days
  # POST /days.json
  def create
    @day = Day.new(params[:day])

    if @day.save
      render json: @day, status: :created, location: @day
    else
      render json: @day.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /days/1
  # PATCH/PUT /days/1.json
  def update
    @day = Day.find(params[:id])

    if @day.update(params[:day])
      head :no_content
    else
      render json: @day.errors, status: :unprocessable_entity
    end
  end

  # DELETE /days/1
  # DELETE /days/1.json
  def destroy
    @day = Day.find(params[:id])
    @day.destroy

    head :no_content
  end
end
