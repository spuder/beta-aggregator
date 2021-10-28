require "selenium-webdriver"
require 'yaml'

driver = Selenium::WebDriver.for :chrome
activity='canyoneering'
state='utah'
region='capitol-reef'
canyon='epic-canyon'
driver.navigate.to "https://www.roadtripryan.com/go/t/#{state}/#{region}/#{canyon}"

# Find div with name "beta_overview"
beta = driver.find_element(:id, "beta_overview")
text = Hash.new { |h, k| h[k] = h.dup.clear }
# Take each element in beta, if contains ':' add it to the text hash with the key as the canyon name
beta.text.split("\n").each do |line|
  if line.include?(":")
    text["#{region}"]["#{canyon}"][line.split(":")[0].strip] = line.split(":")[1].strip
  end
end
# Get element of type class named alert-warning
warning = driver.find_element(:class, "alert-warning")
if warning != nil
  text["#{region}"]["#{canyon}"]["permit"] = warning.text
end


#Get Tags
tags = driver.find_elements(:class, "badge-default")
text["#{region}"]["#{canyon}"]["tags"] = tags.map { |tag| tag.text }


#TODO: Add state/activity


#TODO: Get GPS Coordinates / Map
#waypoints = driver.find_elements(:class, "table-striped")
## waypoints = driver.find_elements(:xpath, '//div[@class="card-footer"]//p[@class="card-text"]//a'
#puts waypoints.map { |waypoint| waypoint.text }

puts text.to_yaml
driver.quit
