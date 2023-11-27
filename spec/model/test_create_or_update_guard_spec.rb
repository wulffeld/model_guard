require "spec_helper"

describe ModelGuard::CreateOrUpdateGuard do
  context "guarding .create" do
    describe "#guarded_create" do
      it "creates the record" do
        expect { CreateGuardedUser.guarded_create(name: "Joe") }.to change(User, :count).by(1)
      end

      context "when an array is passed" do
        it "creates the records" do
          expect { CreateGuardedUser.guarded_create([{ name: "Joe" }, { name: "Jane" }]) }.to change(User, :count).by(2)
        end
      end
    end

    describe "when trying to create directly" do
      it "raises an exception" do
        expect { CreateGuardedUser.create }.to raise_error(ModelGuard::DirectCreateOrUpdateException)
      end
    end
  end

  context "guarding #save" do
    describe "#guarded_save" do
      it "creates the record" do
        expect { CreateGuardedUser.new(name: "Joe").guarded_save }.to change(User, :count).by(1)
      end
    end

    describe "when trying to save directly" do
      it "raises an exception" do
        expect { CreateGuardedUser.new.save }.to raise_error(ModelGuard::DirectCreateOrUpdateException)
      end
    end
  end

  context "guarding #save!" do
    describe "#guarded_save!" do
      it "creates the record" do
        expect { CreateGuardedUser.new(name: "Joe").guarded_save! }.to change(User, :count).by(1)
      end
    end

    describe "when trying to save directly" do
      it "raises an exception" do
        expect { CreateGuardedUser.new.save! }.to raise_error(ModelGuard::DirectCreateOrUpdateException)
      end
    end
  end

  context "guarding #update" do
    let!(:test_model) { guarded_create(:update_guarded_user) }

    describe "#guarded_update" do
      it "updates the record" do
        expect { test_model.guarded_update(name: "Joe") }.to change { test_model.reload.name }.to("Joe")
      end
    end

    describe "when trying to update directly" do
      it "raises an exception" do
        expect { test_model.update(name: "Joe") }.to raise_error(ModelGuard::DirectCreateOrUpdateException)
      end
    end
  end

  context "guarding #update!" do
    let!(:test_model) { guarded_create(:update_guarded_user) }

    describe "#guarded_update!" do
      it "updates the record" do
        expect { test_model.guarded_update!(name: "Joe") }.to change { test_model.reload.name }.to("Joe")
      end
    end

    describe "when trying to update directly" do
      it "raises an exception" do
        expect { test_model.update!(name: "Joe") }.to raise_error(ModelGuard::DirectCreateOrUpdateException)
      end
    end
  end
end
