require "selenium-webdriver"
require 'yaml'


areas = [
    "https://www.canyoneeringusa.com/cedar-mesa/intro",
    "https://www.canyoneeringusa.com/escalante/intro",
    "https://www.canyoneeringusa.com/swell/intro",
    "https://www.canyoneeringusa.com/north-wash/intro",
    "https://www.canyoneeringusa.com/robbers-roost/intro",
    "https://www.canyoneeringusa.com/swell/intro",
    # "https://www.canyoneeringusa.com/zion/technical"

]

@text = Hash.new { |h, k| h[k] = h.dup.clear }

def get_canyon_intro (url)
    area_name = url.split("/")[3]
    driver = Selenium::WebDriver.for :chrome
    canyons = driver.get url
    canyon_url_list = driver.find_elements(:xpath, '//div[@class="sqs-block-content"]/ul/li/p/a').map { |link| link.attribute('href') }
    puts canyon_url_list
    canyon_url_list.each do |canyon_url|
        canyon = canyon_url.split("/")[4]
        driver.get canyon_url
        beta = driver.find_elements(:xpath, '//div[contains(@class, "sqs-block-code")]//div[contains(@class, "sqs-block-content")]//p')
        beta.each do |b|
            if b.text.split("\n").length > 1
                @text[area_name][canyon]["#{b.text.split("\n")[0]}"] = b.text.split("\n")[1..-1].join("\n")
            else
                # TODO: make this more dynamic
                # Hard coded based on the rogue text box here: https://www.canyoneeringusa.com/cedar-mesa/gravel-canyon
                @text[area_name][canyon]["Skills Required"] = b.text

            end
        end
    end
    puts @text.to_yaml
end

def get_canyon_technical (url)
    puts url
end

areas.each do |area|
    area_name = area.split("/")[-1]
    get_canyon_intro(area) if area_name.include?("intro")
    get_canyon_technical(area) if area_name.include?("technical")
end

# Save text to a yaml file
File.open("data/canyoneeringusa.yaml", "w") do |f|
    f.write(@text.to_yaml)
end

