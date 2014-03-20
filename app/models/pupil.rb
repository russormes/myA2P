# A2p Pupil class definition
class Pupil < ActiveRecord::Base
  has_many :pupil_groups, dependent: :destroy
  has_many :groups, through: :pupil_groups
  
  validates :given_name, presence: true
  validates :family_name, presence: true
  #validates :image_path, allow_blank: true, url: true
  # So far I can't figure out how to check the url is well formed and
  # actually points to the image file. TODO!
  validates :image_path, allow_blank: true, format: {
    with: /\.(gif|jpg|png)\z/i,
    message: 'URL must point to GIF/JPG/PNG file'
  }

  # Define an importer for pupil data from csv or excel files.
  # Does not handle updating existing files yet.
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      pupil_hash = Hash[[header, spreadsheet.row(i)].transpose]
      pupil = Pupil.where(id: pupil_hash['id'])
      pupil.count == 1 ? pupil.first.update_attributes(pupil_hash) :
                         Pupil.create!(pupil_hash)
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::CSV.new(file.path)
    when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
    else fail "Unknown file type: #{file.original_filename}"
    end
  end
  
  #def self.add_image()
  #end

  def name
    [given_name, family_name].join ' '
  end
end
