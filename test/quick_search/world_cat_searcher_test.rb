require 'test_helper'

module QuickSearch
  class WorldCatSearcher
    # WorldCatSearch tests
    class Test < ActiveSupport::TestCase
      test 'truth' do
        assert_kind_of Module, QuickSearch::WorldCatSearcher
      end
    end
  end
end
