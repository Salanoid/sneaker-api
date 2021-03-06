class SolecollectorScraperController < ApplicationController
  def scrap
    endpoint = "https://solecollector.com/sneaker-release-dates/all-release-dates/"
    unparsed_page = HTTParty.get(endpoint)
    parsed_page = Nokogiri::HTML(unparsed_page)
    solecollector_sneakers_info = Array.new

    parsed_page.css('div.release-group__container').each do |realease|
      solecollector_sneakers_info << 
        {
          name: realease.css('div.add-to-calendar').attr('data-release-name').value,
          price: realease.css('span').text,
          date: realease.css('.sneaker-release__date')[0].css('div').text,
          image: realease.css('img').attr('src').value
        }
    end
  end
end