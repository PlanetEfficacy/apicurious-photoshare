class CloudStorageService

  def self.files
    gcloud = Google::Cloud.new
    storage = gcloud.storage
    bucket = storage.buckets.first
    files = bucket.files
    files.sort_by { |file| file.created_at }.reverse
  end

  def self.first_six_files
    gcloud = Google::Cloud.new
    storage = gcloud.storage
    bucket = storage.buckets.first
    files = bucket.files
    files.sort_by { |file| file.created_at }.reverse[0...6]
  end

end
