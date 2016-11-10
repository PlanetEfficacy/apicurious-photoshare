require "rails_helper"

describe "CloudStorageService" do
  it "gets all of the files from the first storage bucket orderd by created_at" do
    files = CloudStorageService.files
    file = files.first

    expect(files.count).to eq(285)
    expect(file.name).to eq("2016-9-16 photo of the day.JPG")
  end

  it "gets the first six files from the first storage bucket orderd by created_at" do
    files = CloudStorageService.first_six_files
    file = files.first

    expect(files.count).to eq(6)
    expect(file.name).to eq("2016-9-16 photo of the day.JPG")
  end

end
