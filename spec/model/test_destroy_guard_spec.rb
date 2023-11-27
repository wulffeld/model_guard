require "spec_helper"

describe ModelGuard::DestroyGuard do
  let!(:test_model) { create(:destroy_guarded_user) }

  describe "#guarded_destroy" do
    it "destroys the object" do
      expect { test_model.guarded_destroy }.to change(User, :count).by(-1)
    end

    it "raises an exception" do
      expect { test_model.destroy }.to raise_error(ModelGuard::DirectDestroyException)
    end
  end

  describe "#guarded_destroy!" do
    it "destroys the object" do
      expect { test_model.guarded_destroy! }.to change(User, :count).by(-1)
    end

    it "raises an exception" do
      expect { test_model.destroy }.to raise_error(ModelGuard::DirectDestroyException)
    end
  end
end
