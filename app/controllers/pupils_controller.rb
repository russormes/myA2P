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
  end

  # GET /pupils/new
  def new
    @pupil = Pupil.new
  end

  # GET /pupils/1/edit
  def edit
  end

  # POST /pupils
  # POST /pupils.json
  def create
    uploaded_io = params[:pupil][:image_path]
    image_pathname = Rails.root.join('public',
                                        'uploads',
                                        uploaded_io.original_filename)
    File.open(image_pathname, 'wb') do |file|
      file.write(uploaded_io.read)
    end
    params[:pupil][:image_path] = image_pathname.to_s
    @pupil = Pupil.new(pupil_params)
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
    begin
      Pupil.import(params[:file])
      redirect_to root_url, notice: "Pupils imported."
    rescue
      redirect_to root_url, notice: "Invalid file format."
    end # end begin. 
  end # end def import.
  
  def upload
    uploaded_io = params[:pupil][:image_path]
    File.open(Rails.root.join('public',
                              'uploads',
                              uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pupil
      @pupil = Pupil.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pupil_params
      params.require(:pupil).permit(:given_name, :other_name, :family_name,
                                    :name_known_by, :dob, :gender, :image_path)
    end
end
