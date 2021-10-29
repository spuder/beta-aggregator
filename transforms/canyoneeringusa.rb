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
                    if value['RATINGS'].include?('\n')
                        new_data[area][canyon]['RANKINGS'] ||= []
                        new_data[area][canyon]['RATINGS'] = value['RATINGS'].split('\n').map do |rating|
                            # rating.split(':').map(&:strip).each_slice(2).to_h
                            new_data[area][canyon]['RANKINGS'] << rating.split(/[[:ascii:]]/).reject(&:empty?)[0].to_s.strip
                            rating.split(':').map{|m| m.gsub(/[[:^ascii:]]/,"").strip}.each_slice(2).to_h
                            
                        end
                    else
                        new_data[area][canyon]['RATINGS'] = data[area][canyon]['RATINGS'].gsub(/[[:^ascii:]]/, "").strip
                        new_data[area][canyon]['RANKING'] ||= data[area][canyon]['RATINGS'].split(/[[:ascii:]]/).reject(&:empty?)[0].to_s.strip
                    end
                end
            end
        end
        return new_data
    end

    def self.transform_season(data)
        new_data = Marshal.load(Marshal.dump(data))
        data.each do |area, values|
            values.each do |canyon, value|
                if value['SEASON']
                    seasons = ['Spring', 'Summer', 'Fall', 'Winter']
                    new_data[area][canyon]['SEASON'] = []
                    seasons.each do |season|
                        new_data[area][canyon]['SEASON'] << season if value['SEASON'].downcase.include?(season.downcase)
                    end
                end
            end
        end
        return new_data
    end

    def self.transform_flashflood(data)
        new_data = Marshal.load(Marshal.dump(data))
        data.each do |area, values|
            values.each do |canyon, value|
                if value['FLASH FLOOD RISK']
                    new_data[area][canyon]['FLASH FLOOD NOTES'] = value['FLASH FLOOD RISK']
                    new_data[area][canyon]['FLASH FLOOD RISK'] = []
                    risks = ['very high', 'high', 'medium', 'low', 'none', 'unkown', 'moderate']
                    risks.each do |risk|
                        new_data[area][canyon]['FLASH FLOOD RISK'] << risk if value['FLASH FLOOD RISK'].downcase.include?(risk.downcase)
                    end

                end
            end
        end
        return new_data
    end

    def self.transform_longest_rappel(data)
        new_data = Marshal.load(Marshal.dump(data))
        data.each do |area, values|
            values.each do |canyon, value|
                if value['LONGEST RAPPEL']
                    new_data[area][canyon].delete('LONGEST RAPPEL')
                    new_data[area][canyon]['LONGEST RAPPEL METERS'] = value['LONGEST RAPPEL'].to_s[/\(.*?\)/].to_s.gsub(/[(m)]/,"").strip
                    new_data[area][canyon]['LONGEST RAPPEL FEET'] = value['LONGEST RAPPEL'].to_s.gsub(/feet.*$/,"").strip
                end
            end
        end
        return new_data
    end
end