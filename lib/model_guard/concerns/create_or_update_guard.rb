module ModelGuard
  class DirectCreateOrUpdateException < Exception; end

  module CreateOrUpdateGuard
    extend ActiveSupport::Concern

    included do
      class_eval do
        attr_accessor :model_guard_save_okay

        before_create do
          raise(DirectCreateOrUpdateException.new("Can't create object #{self.class.to_s} directly.")) unless @model_guard_save_okay
        end

        after_create do
          disallow_direct_create_or_update!
        end

        before_update do
          raise(DirectCreateOrUpdateException.new("Can't update object #{self.class.to_s} directly.")) unless @model_guard_save_okay
        end

        after_update do
          disallow_direct_create_or_update!
        end

        def allow_direct_create_or_update!
          @model_guard_save_okay = true
        end

        def disallow_direct_create_or_update!
          @model_guard_save_okay = false
        end

        def guarded_save
          allow_direct_create_or_update!
          save
        end

        def guarded_save!
          allow_direct_create_or_update!
          save!
        end

        def guarded_update(attributes)
          allow_direct_create_or_update!
          update(attributes)
        end

        def guarded_update!(attributes)
          allow_direct_create_or_update!
          update!(attributes)
        end

        def self.guarded_create(attributes = nil, &block)
          if attributes.is_a?(Array)
            attributes.collect do |attr|
              guarded_create(attr, &block)
            end
          else
            object = new(attributes, &block)
            object.allow_direct_create_or_update!
            object.save!
            object
          end
        end
      end
    end
  end
end
