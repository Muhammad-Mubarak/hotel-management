require 'faker'
require 'bcrypt'

# Define the path to your image directory
image_path = Rails.root.join('app', 'public', 'images')

# Check if there are no users in the database
if User.count == 0
  5.times do
    password = Faker::Internet.password(min_length: 8, max_length: 20)
    user = User.create(
      username: Faker::Internet.unique.username,
      password_digest: BCrypt::Password.create(password),
      email: Faker::Internet.unique.email,
      role: ['Admin', 'Hotel Owner', 'Customer'].sample
    )

    # Create hotels for each user
    3.times do
      hotel = user.hotels.create(
        name: Faker::Company.unique.name,
        description: Faker::Lorem.paragraph,
        address: Faker::Address.full_address,
        phone_number: Faker::PhoneNumber.phone_number
      )

      # Attach images to hotels
      3.times do
        # Generate a random image file name
        image_file_name = Faker::File.file_name

        # Build the full path to the image file
        image_file_path = File.join(image_path, image_file_name)

        # Check if the image file exists
        if File.exist?(image_file_path)
          file = File.open(image_file_path)
          image_extension = File.extname(image_file_name).delete('.')
          image = ActiveStorage::Blob.create_after_upload!(
            io: file,
            filename: "#{Faker::Alphanumeric.alpha(number: 10)}.#{image_extension}",
            content_type: "image/#{image_extension}"
          )
          hotel.images.attach(image)
        else
          puts "Image file not found: #{image_file_path}"
        end
      end
    end
  end
end
