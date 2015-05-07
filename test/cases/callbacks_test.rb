require 'helper'

class FakeJob < ActiveJob::Base
  include ActiveJob::Locks::Callbacks

  def payload_lock
    true
  end

  public :payload_key
end

class FakeModel
  include GlobalID::Identification

  def find(id)
    # Needs to be here for the globalid, but not used in testing.
  end

  def id
    123
  end
end

class CallbacksTest < ActiveSupport::TestCase

  def test_true
    assert_equal true, true
  end

  def test_payload_key
    GlobalID.app = "LockTest"
    model = FakeModel.new
    key = FakeJob.new.payload_key([model, true, 1])
    assert_equal key, ["gid://LockTest/FakeModel/123", "true", "1"]
  end
end
