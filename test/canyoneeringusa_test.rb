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
        output_hash = {'cedar-mesa' => {'cheesebox-canyon' => { 'FLASH FLOOD RISK' => ['very high', 'high'], 'FLASH FLOOD NOTES' => 'Very high: upstream, White Canyon drains a very large area.
      Avoid this hike when storms are in the area.'}}}        
      assert_equal(output_hash, CanyoneeringUSA.transform_flashflood(input_hash))
    end

    def test_canyoneerngusa_transform_longest_rappel
        input_hash = {'robber-root' => {'mind-bender' => { 'LONGEST RAPPEL' => '50 feet (15 m)'}}}
        output_hash = {'robber-root' => {'mind-bender' => { 'LONGEST RAPPEL FEET' => '50', 'LONGEST RAPPEL METERS' => '15'}}}       
      assert_equal(output_hash, CanyoneeringUSA.transform_longest_rappel(input_hash))
    end

    def test_canyoneerngusa_transform_longest_rappel_2
        input_hash = {'robber-root' => {'big-bad-ben' => { 'LONGEST RAPPEL' => 'One rappel to 60 feet (18 m)'}}}
        output_hash = {'robber-root' => {'big-bad-ben' => { 'LONGEST RAPPEL FEET' => '60', 'LONGEST RAPPEL METERS' => '18'}}}       
      assert_equal(output_hash, CanyoneeringUSA.transform_longest_rappel(input_hash))
    end
end