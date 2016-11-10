class HomeController < ApplicationController
  def index
    @files = CloudStorageService.first_six_files
  end
end
