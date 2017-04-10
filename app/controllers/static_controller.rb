class StaticController < ApplicationController
  require 'rest-client'

  def faq
    @faq_data = ""
    begin
      @faq_data = RestClient.get('https://ggc.ch/faq/')
      doc = Nokogiri::HTML(@faq_data)
      @faq_data = content = doc.search('div.faq-items').to_s
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
end
