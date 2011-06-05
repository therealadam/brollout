# Brollout

Inspired by James Golick's rollout, brollout makes it easy to turn features on
and off in your application. You can disable a feature if you need to run
a site in degraded mode, you can turn a feature on for a percentage of your
users, or you can ramp a feature up by percentage of requests when you're
testing new infrastructure.

**This is just a sketch. Don't rage me, bro.**

## Bro! Show me that code

    # Store feature flags in Redis
    Brollout.adapter = Brollout::Adapter.new

    $friend_finder = Brollout.feature(:friend_finder, :on_off)
    $new_cache = Brollout.feature(:new_cache, :per_request_percentage)

    Brollout.register_strategy(:custom) do |user|
      user.admin? || per_user_percentage(user)
    end

    $better_sharing = Brollout.feature(:better_sharing, :custom)

    $simple = Brollout.feature(:simple, :on_off, Brollout::InMemory.new)
    $simple.activate!

    if $simple.active?
      # Do friend finder things
    else
      # Do something else
    end

    $new_cache.activate_for(0.5)

    if $new_cache.active?
      # Use the new cache
    else
      # Use the old cache
    end

    $better_sharing.activate_for(user)

    if $better_sharing.active?(user.id)
      # Show the new feature
    else
      # Show the old feature
    end

## Bro, how do I toggle and can I toggle my own toggle?

Brollout ships with the following toggle strategies:

- On/off
- Random percentage
- Per object ID
- Object ID modulo

In addition, you can implement your own toggle strategies by using the
`register_strategy`:

    Brollout.register_strategy(:custom) do |user|
      user.admin? || per_user_percentage(user)
    end

Pretty snazzy, no?

## Bro, you can stick it wherever you stick things

Brollout ships with adapters to store feature flags in per-process memory,
memcached, redis, or wherever it is you like to store things. Adapters
implement the following contract:

    adapter.on_off?(feature)
    adapter.per_object_id(feature)

## Bro, can I license that thing?

Yep! Brollout is copyright 2011 Adam Keys. Brollout is MIT licensed, so go
crazy, bro.
