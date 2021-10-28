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
    
    # def test_canyoneeringusa_transform
    #     input_hash = Hash.new('cedar-mesa' => { 'cheesebox-canyon' => { 'RATINGS' => '3A II ★'}})
    #     output_hash = Hash.new('cedar-mesa' => { 'cheesebox-canyon' => { 'RATINGS' => '3A II'}})
    #     assert_equal input_hash, output_hash
    # end

end