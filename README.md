# model_guard

[![Gem Version](http://img.shields.io/gem/v/model_guard.svg)](https://rubygems.org/gems/model_guard)
[![Build Status](https://github.com/wulffeld/model_guard/workflows/CI/badge.svg?branch=main)](https://github.com/wulffeld/model_guard/actions?query=workflow%3ACI)
[![Gem Downloads](https://img.shields.io/gem/dt/model_guard.svg)](https://rubygems.org/gems/model_guard)
[![Maintainability](https://api.codeclimate.com/v1/badges/7b3c646f87ca2d6d691c/maintainability)](https://codeclimate.com/github/wulffeld/model_guard)

Two small concerns for ActiveRecord that can guard against direct creates, updates and destroys. Handy if you want to force the use of directing all
persistence through service objects and guard against accidental CRUD operations
in the console.

## Installation

Include the gem in your Gemfile:

```ruby
gem "model_guard"
```

## Usage

### Create / update protection

Protects against #save, #save!, #update, #update!. Instead use #guarded_save, #guarded_save!, #guarded_update, #guarded_update! or #guarded_create.

```ruby
class User < ActiveRecord::Base
  include ModelGuard::CreateOrUpdateGuard
end

CreateGuardedUser.guarded_create(name: "Joe")
user.guarded_update(name: "Joe")
```

or

```ruby
user.allow_direct_create_or_update!
user.save
```

### Destroy protection

```ruby
class User < ActiveRecord::Base
  include ModelGuard::DestroyGuard
end
```

Will raise an exception when calling `destroy` on an instance of `User`. Instead use `guarded_destroy`, `guarded_destroy!` or `guarded_delete`.

```ruby
user.guarded_destroy
user.guarded_destroy!
```

## Support

Submit suggestions or feature requests as a GitHub Issue or Pull
Request (preferred). If you send a pull request, remember to update the
corresponding unit tests and/or add new tests.

## Versioning

Semantic Versioning 2.0 as defined at <http://semver.org>.
