require "selenium-webdriver"
require 'yaml'

driver = Selenium::WebDriver.for :chrome

driver.navigate.to "https://www.roadtripryan.com/go/type/canyon"

canyons = driver.find_elements(:xpath, '//div[@class="card-footer"]//p[@class="card-text"]//a')
canyons_list = []

canyons.each do |canyon|
    canyons_list << canyon.attribute("href")
end

puts canyons_list.to_yaml
driver.quit
