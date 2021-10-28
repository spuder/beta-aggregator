require "selenium-webdriver"
require 'yaml'

driver = Selenium::WebDriver.for :chrome
driver.navigate.to "https://www.roadtripryan.com/go/type/canyon"

canyon_list = driver.find_elements(:xpath, '//div[@class="card-footer"]//p[@class="card-text"]//a')
canyon_urls = canyon_list.map { |c| c.attribute('href') }
text = Hash.new { |h, k| h[k] = h.dup.clear }

canyon_urls.each do |url|
    puts "navigating to #{url}"
    # driver.get(url)
    driver.navigate.to url
    state = url.split("/")[-3]
    region = url.split("/")[-2]
    canyon = url.split("/")[-1]
    puts "state: #{state}"
    puts "region: #{region}"
    puts "canyon: #{canyon}"
    puts "finding beta"
    beta = driver.find_element(:id, "beta_overview")
    # Take each element in beta, if contains ':' add it to the text hash with the key as the canyon name
    beta.text.split("\n").each do |line|
    if line.include?(":")
        text["#{region}"]["#{canyon}"][line.split(":")[0].strip] = line.split(":")[1].strip
    end
    end
    # Get element of type class named alert-warning
    warning = driver.find_elements(:class, "alert-warning")
    # If there is a warning, add it to the text hash with the key as the canyon name
    if warning.length > 0
        text["#{region}"]["#{canyon}"]["warning"] = warning[0].text
    elsif warning.length == 0
        text["#{region}"]["#{canyon}"]["warning"] = "unknown"
    end
    #Get Tags
    tags = driver.find_elements(:class, "badge-default")
    text["#{region}"]["#{canyon}"]["tags"] = tags.map { |tag| tag.text } if tags.length > 0

end

# Write text to file
File.open("data/rtr-canyons.yaml", "w") { |file| file.write(text.to_yaml) }
