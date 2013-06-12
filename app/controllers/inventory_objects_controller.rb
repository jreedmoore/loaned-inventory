require 'csv'

class InventoryObjectsController < ApplicationController
  # GET /inventory_objects
  # GET /inventory_objects.json
  def index
    @inventory_objects = InventoryObject.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory_objects }
    end
  end

  # GET /inventory_objects/1
  # GET /inventory_objects/1.json
  def show
    @inventory_object = InventoryObject.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_object }
    end
  end

  # GET /inventory_objects/new
  # GET /inventory_objects/new.json
  def new
    @inventory_object = InventoryObject.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_object }
    end
  end

  # GET /inventory_objects/1/edit
  def edit
    @inventory_object = InventoryObject.find(params[:id])
  end

  # POST /inventory_objects
  # POST /inventory_objects.json
  def create
    @inventory_object = InventoryObject.new(params[:inventory_object])

    respond_to do |format|
      if @inventory_object.save
        format.html { redirect_to @inventory_object, notice: 'Inventory object was successfully created.' }
        format.json { render json: @inventory_object, status: :created, location: @inventory_object }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory_object.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_objects/1
  # PUT /inventory_objects/1.json
  def update
    @inventory_object = InventoryObject.find(params[:id])

    respond_to do |format|
      if @inventory_object.update_attributes(params[:inventory_object])
        format.html { redirect_to @inventory_object, notice: 'Inventory object was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory_object.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_objects/1
  # DELETE /inventory_objects/1.json
  def destroy
    @inventory_object = InventoryObject.find(params[:id])
    @inventory_object.destroy

    respond_to do |format|
      format.html { redirect_to inventory_objects_url }
      format.json { head :no_content }
    end
  end
  
  def import
  end
  
  def upload
	if params[:csv] then
		csv = CSV.new(params[:csv].read, :headers => :downcase, 
					 :header_converters=> lambda {|f| f.strip},
				     :converters=> lambda {|f| f ? f.strip : nil})
		@good = []
		@bad = []
		csv.each do |row|
				#Type Version Id1 Id2 Id3
				if (row['id1'] || row['id2'] || row['id3']) then
				type = InventoryObjectType.new.findcreate(row['type'])
				version = type.versions.findcreate(row['version'])
				
				object = InventoryObject.create(id1: row['id1'], id2: row['id2'], id3: row['id3'])
				
				@good << row if object
				@bad << row unless object
			end
		end
	end
  end
end
