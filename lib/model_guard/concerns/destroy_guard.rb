module ModelGuard
  class DirectDestroyException < Exception; end

  module DestroyGuard
    extend ActiveSupport::Concern

    included do
      class_eval do
        attr_accessor :model_guard_destroy_okay

        before_destroy do
          raise(DirectDestroyException.new("Can't destroy #{self.class.to_s} directly.")) unless @model_guard_destroy_okay
        end

        def allow_direct_destroy!
          @model_guard_destroy_okay = true
        end

        def disallow_direct_destroy!
          @model_guard_destroy_okay = false
        end

        def guarded_destroy
          allow_direct_destroy! and destroy
        end

        def guarded_destroy!
          allow_direct_destroy! and destroy!
        end

        def guarded_delete
          allow_direct_destroy! and delete
        end

        def delete(**args)
          raise(DirectDestroyException.new("Can't delete #{self.class.to_s} directly.")) unless @model_guard_destroy_okay
          super(args)
        end
      end
    end
  end
end
