class SneakersController < ApplicationController
  def index 
    create_sneaker_release
    @sneaker_release = SneakerRelease.all

    @sneaker_release.first.date.to_date.respond_to? :strftime
    render json: @sneaker_release.to_json(except: [:id, :created_at, :updated_at])
  end

  private
  
  def create_sneaker_release
    releases_scraper = SolecollectorScraperController.new.scrap
    releases_scraper.each do |release|
      unless release_exists?(release[:name])
        date = 
          release[:date].to_date.respond_to?(:strftime) ? release[:date].to_date : release[:date]

        price =
          release[:price].strip!.gsub(/\n/, '').gsub(' ', '').gsub('$', ' $').strip

        SneakerRelease.create!(
          name: release[:name],
          price: price,
          date: date,
          image: release[:image]
        )
      end
    end
  end

  def release_exists?(name)
    SneakerRelease.where(name: name).count >= 1 ? true : false 
  end
  # for the future
  # def filter_sneaker_releases
  # end
end
