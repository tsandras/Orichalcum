desc 'Generate Template in database'
task generate_templates: :environment do
  Dir.foreach('app/assets/images/templates') do |item|
    next if item == '.' || item == '..' || item == 'vide.png'
    # file = StringIO.new("app/assets/images/templates/#{item}")
    # puts file.class.to_s
    file = File.open("app/assets/images/templates/#{item}", 'rb')
    ok = Template.create(
      name: item.split('.')[0],
      rarity: 2,
      description: 'This is a example',
      image_data: file,
      image_file_name: item,
      image_content_type: 'image/png'
    )
    file.close
    puts ok
  end
end
