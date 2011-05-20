# Brollout

Inspired by James Golick's rollout, brollout makes it easy to turn features on
and off in your application. You can disable a feature if you need to run
a site in degraded mode, you can turn a feature on for a percentage of your
users, or you can ramp a feature up by percentage of requests when you're
testing new infrastructure.

## Right, show me that code

    # Store feature flags in Redis
    Brollout.storage = Memcache.new

    # In an initializer or config file
    $friend_finder = Feature.new(:friend_finder)

    # In a console after you deploy new code
    $friend_finder.activate!

    # Somewhere in your app
    if $friend_finder.active?
      # Do friend finder things
    else
      # Do something else
    end

    $new_cache = PerRequestFeature.new(:new_cache)

    $new_cache.activate!(0.5)

    if $new_cache.active?
      # Use the new cache
    else
      # Use the old cache
    end

    $sekrit_new_feature = PerUserFeature.new(:sekrit_new_feature)

    $sekrit_new_feature.activate_for(user.id)

    if $sekrit_new_feature.active?(user.id)
      # Show the new feature
    else
      # Show the old feature
    end

## Use our toggles or toggle your own toggle

Brollout ships with the following toggle strategies:

- On/off
- Random percentage
- Per-user
- ID modulo

In addition, you can implement your own toggle strategies by using the
`StrategyFeature`:

    class MyAppFeature < StrategyFeature

      def strategies
        [:admin?, :on_off?]
      end

      def admin?(user)
        user.admin?
      end

    end

Pretty snazzy, no?

## License

Copyright 2011 Adam Keys. Brollout is MIT licensed.
