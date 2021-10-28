# - Split RATINGS (3BII) and RATINGS ★★★ (note some have multiple routes)
# - PERMIT-Standardize on 'Yes, No, Unkown'
# - ADd PERMIT Notes
# - LONGEST RAPPEL - Change to number
# - FLASH FLOOD - Standardize on 'None, Low, Medium, High, Very High'
# - Add FLASH FLOOD Notes
# - TIME REQUIRED - Standardize on hours
# - SEASON - Standardize on 'Spring, Summer, Fall, Winter'
# - ADD W3W GPS Location
# - Longest Rappel - Split Feet and Meters into separate fields

# Open yaml file
require 'yaml'

class CanyoneeringUSA

    data = YAML.load_file('data/canyoneeringusa.yaml')

    def self.transform_ratings(data)
        new_data = Marshal.load(Marshal.dump(data))
        data.each do |area, values|
            values.each do |canyon, value|
                if value['RATING']
                    new_data[area][canyon]['RATINGS'] = value['RATING']
                    new_data[area][canyon].delete('RATING')
                end
                if value['RATINGS']
                    if value['RATINGS'].include?("\n")
                        #TODO: implement
                    else
                        new_data[area][canyon]['RATINGS'] = data[area][canyon]['RATINGS'].gsub(/[[:^ascii:]]/, "").strip
                        new_data[area][canyon]['RANKING'] ||= data[area][canyon]['RATINGS'].split(/[[:ascii:]]/).reject(&:empty?)[0].to_s.strip

                    end

                    # value['RATINGS'].split("\n").each do |rating|
                    #     if rating.include?('★')
                    #         data[area][canyon]['RANKING'] ||= []
                    #         data[area][canyon]['RANKING'] << rating.split(/[[:ascii:]]/).reject(&:empty?)[0]
                    #     end
                    # end
                end
            end
        end
        return new_data
    end
end