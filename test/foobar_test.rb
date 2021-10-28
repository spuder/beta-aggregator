require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../transforms/foobar'
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(:color => true)]


class FoobarTest < Minitest::Test
    def test_blerp1
        assert_equal 'FOO', Foobar.blerp('foo')
    end

    def test_baz
        input_hash = {'foo' => 42, 'bar' => 'baz'}
        output_hash = {'foo' => 42}
        assert_equal(output_hash, Foobar.baz(input_hash))
    end
end