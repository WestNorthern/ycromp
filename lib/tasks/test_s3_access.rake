namespace :test_s3 do
    desc "Test S3 access"
    task access: :environment do
        require 'aws-sdk-s3'

        s3 = Aws::S3::Resource.new(
          access_key_id: ENV['AWS_ACCESS_KEY_ID'],
          secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
          region: 'us-east-2'
        )
        
        bucket = s3.bucket('ycromp-blog')
        obj = bucket.object('test-upload.txt')
        obj.put(body: 'Hello World')
        
        puts "Uploaded successfully!" if obj.exists?
    rescue Aws::S3::Errors::ServiceError => e
        puts "Error accessing S3: #{e.message}"
    end
end
  
  