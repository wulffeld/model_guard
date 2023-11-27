def guarded_create(attributes)
  object = build(attributes)
  object.guarded_save
  object
end
