# Pupil controller
class PupilsController < ApplicationController
  before_action :set_pupil, only: [:show, :edit, :update, :destroy]

  # GET /pupils
  # GET /pupils.json
  def index
    @pupils = Pupil.all
  end

  # GET /pupils/1
  # GET /pupils/1.json
  def show
    @pupil_groups = @pupil.groups
  end

  # GET /pupils/new
  def new
    @pupil = Pupil.new
    @group_list = set_group_list
  end

  # GET /pupils/1/edit
  def edit
    @group_selected = Array.new
    @pupil.groups.each do |g|
      @group_selected.push(g.id)
    end
    @group_list = set_group_list
  end

  # POST /pupils
  # POST /pupils.json
  def create
    if (params[:pupil].has_key?(:image_path)) then
      params[:pupil][:image_path] = set_image
    end
    @pupil = Pupil.new(pupil_params)
    clean_select_multiple_params params[:groups]
    @pupil_groups = Group.find(params[:groups][:id])
    @pupil.groups = @pupil_groups
    logger.debug "The groups parameter contains: #{params[:groups][:id]}"
    logger.debug "The groups retrieved are: #{@pupil_groups}"
    respond_to do |format|
      if @pupil.save
        format.html { redirect_to @pupil, notice: 'Pupil was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pupil }
      else
        format.html { render action: 'new' }
        format.json { render json: @pupil.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pupils/1
  # PATCH/PUT /pupils/1.json
  def update
    respond_to do |format|
      clean_select_multiple_params params[:groups]
      @pupil_groups = Group.find(params[:groups][:id])
      @pupil.groups = @pupil_groups
      if (params[:pupil].has_key?(:image_path)) then
        params[:pupil][:image_path] = set_image
      end
      if @pupil.update(pupil_params)
        format.html { redirect_to @pupil, notice: 'Pupil was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pupil.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pupils/1
  # DELETE /pupils/1.json
  def destroy
    @pupil.destroy
    respond_to do |format|
      format.html { redirect_to pupils_url }
      format.json { head :no_content }
    end
  end

  def import
    Pupil.import(params[:file])
    redirect_to root_url, notice: 'Pupils imported.'
  rescue
    redirect_to root_url, notice: 'Invalid file format.'
  end # end def import.

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pupil
    @pupil = Pupil.find(params[:id])
  end
  
  def set_image
    rails_root = Rails.root
    uploaded_io = params[:pupil][:image_path]
    image_pathname = rails_root.join('public',
                                     'uploads',
                                     uploaded_io.original_filename)
    File.open(image_pathname, 'wb') do |file|
      file.write(uploaded_io.read)
    end
    img_addr = image_pathname.to_s.tap { |s| s.slice!(rails_root.to_s) }
    logger.debug " Image path with slice: #{img_addr.inspect}"
    return img_addr
  end

def set_group_list
  return Group.all
end

def clean_select_multiple_params hash = params
  hash.each do |k, v|
    case v
    when Array then v.reject!(&:blank?)
    when Hash then clean_select_multiple_params(v)
    end
  end
end

  # Never trust parameters from the scary internet, only allow the white
  # list through.
  def pupil_params
    params.require(:pupil).permit(:given_name, :other_name, :family_name,
                                  :name_known_by, :dob, :gender, :image_path)
  end
end
