class MenusController < ApplicationController
  # GET /menus
  # GET /menus.json
  def index
    @menus = Menu.all

    render json: @menus
  end

  # GET /
  def this_week
    now = Time.now
    this_week = Time.new(now.year, now.month, now.day)

    wdays = ((this_week.wday + 6) % 7)

    this_week = this_week - (60*60*24*wdays)

    @menus = Menu.where(date: this_week).take(2)

    render json: @menus
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
    id = params[:id]
    if id == 'last'
      @menu = Menu.last
    else
      @menu = Menu.find(id)
    end

    render json: @menu
  end

  def first
    
    @menu = Menu.first

    render json: @menu
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(params[:menu])

    if @menu.save
      render json: @menu, status: :created, location: @menu
    else
      render json: @menu.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
    @menu = Menu.find(params[:id])

    if @menu.update(params[:menu])
      head :no_content
    else
      render json: @menu.errors, status: :unprocessable_entity
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy

    head :no_content
  end
end
