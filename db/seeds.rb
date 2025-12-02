# Map gun names to categories
gun_categories = {
  "MP5" => :smg,
  "320XCarry" => :pistol,
  "M1014" => :shotgun,
  "SigCross" => :sniper,
  "MK16" => :rifle
  # Add more mappings as needed
}

Dir.glob(Rails.root.join('public/images/guns/*.png')).each do |file_path|
  name = File.basename(file_path, '.png')
  category = gun_categories[name] || :rifle # default to :rifle if not found

  # Remove .to_s - just pass the symbol directly
  gun = Gun.find_or_create_by!(name: name, category: category)



  gun.base_image.attach(
    io: File.open(file_path),
    filename: File.basename(file_path),
    content_type: 'image/png'
  ) unless gun.base_image.attached?
end


# Map attachment names to types
attachment_types = {
  "AimpointT2Mount" => "optic",
  "PMAG30" => "magazine",
  "WARCOMP762" => "muzzle",
  "M640SctLght" => "light",
  "558_rs" => "optic",
  "Sandman" => "muzzle",
  "AngledGrip" => "grip",
  "Nomad" => "stock",
  "K2Grip" => "grip",
  "RVGBK" => "muzzle",
  "Riser" => "mount"
  # Add more as needed
}

Dir.glob(Rails.root.join('public/images/attachments/*.png')).each do |file_path|
  name = File.basename(file_path, '.png')
  attachment_type = attachment_types[name] || "misc"
  attachment = Attachment.find_or_create_by!(name: name, attachment_type: attachment_type)
  attachment.base_image.attach(
    io: File.open(file_path),
    filename: File.basename(file_path),
    content_type: 'image/png'
  ) unless attachment.base_image.attached?
end
