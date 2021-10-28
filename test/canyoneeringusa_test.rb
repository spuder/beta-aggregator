require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(:color => true)]
require_relative '../transforms/canyoneeringusa'
require 'yaml'


class CanyoneeringUSATest < Minitest::Test
    def test_canyoneeringusa_transform
        input_hash = {'cedar-mesa' => { 'cheesebox-canyon' => { 'RATINGS' => '3A II ★★'}}}
        output_hash = {'cedar-mesa' => { 'cheesebox-canyon' => { 'RATINGS' => '3A II', 'RANKING' => '★★' }}}
        assert_equal(output_hash, CanyoneeringUSA.transform_ratings(input_hash))
    end

    def test_canyoneeringusa_transform_2
        input_hash = {'cedar-mesa' => { 'cheesebox-canyon' => { 'RATINGS' => 'Fry: 3B II★★★\nFrylette: 2B I★★'}}}
        output_hash = {'cedar-mesa' => { 'cheesebox-canyon' => { 'RATINGS' => [{'Fry' => '3B II'}, {'Frylette' => '2B I'}], 'RANKINGS' => ['★★★', '★★']}}}
        assert_equal(output_hash, CanyoneeringUSA.transform_ratings(input_hash))
    end
    
    def test_canyoneerngusa_transform_season
        input_hash = {'cedar-mesa' => {'gravel-canyon' => { 'SEASON' => 'Spring, summer, or fall'}}}
        output_hash = {'cedar-mesa' => {'gravel-canyon' => { 'SEASON' => ['Spring', 'Summer', 'Fall']}}}
        assert_equal(output_hash, CanyoneeringUSA.transform_season(input_hash))
    end

    def test_canyoneerngusa_transform_season_2
        input_hash = {'cedar-mesa' => {'gravel-canyon' => { 'SEASON' => 'Spring, summer, or fall'}}}
        output_hash = {'cedar-mesa' => {'gravel-canyon' => { 'SEASON' => ['Spring', 'Summer', 'Fall']}}}
        assert_equal(output_hash, CanyoneeringUSA.transform_season(input_hash))
    end

    def test_canyoneerngusa_transform_flashflood
        input_hash = {'cedar-mesa' => {'cheesebox-canyon' => { 'FLASH FLOOD RISK' => 'Very high: upstream, White Canyon drains a very large area.
      Avoid this hike when storms are in the area.'}}}
        output_hash = {'cedar-mesa' => {'cheesebox-canyon' => { 'FLASH FLOOD RISK' => ['very high', 'high']}}}        
      assert_equal(output_hash, CanyoneeringUSA.transform_flashflood(input_hash))
    end
end