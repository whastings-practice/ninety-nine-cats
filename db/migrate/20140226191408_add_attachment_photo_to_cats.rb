class AddAttachmentPhotoToCats < ActiveRecord::Migration
  def self.up
    change_table :cats do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :cats, :photo
  end
end
