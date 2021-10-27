require "selenium-webdriver"
require 'yaml'

driver = Selenium::WebDriver.for :chrome
# activity='canyoneering'
# state='utah'
# region='capitol-reef'
# canyon='epic-canyon'
driver.navigate.to "https://www.canyoneeringusa.com/zion/technical/behunin"
text = Hash.new { |h, k| h[k] = h.dup.clear }


beta = driver.find_elements(:xpath, '//div[contains(@class, "sqs-block-code")]//div[contains(@class, "sqs-block-content")]//p')

beta.each do |b|
  text["#{b.text.split("\n")[0]}"] = b.text.split("\n")[1..-1].join("\n")
end

puts text.to_yaml
driver.quit
