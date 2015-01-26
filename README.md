# Activejob::Locks

Activejob Locks is an [ActiveJob](https://github.com/rails/activejob) addon that will lock your workers based on the queue or the payload.  Activejob Locks is dependent on [Redlock](https://github.com/antirez/redlock-rb) which as they say "This code implements an algorithm which is currently a proposal, it was not formally analyzed. Make sure to understand how it works before using it in your production environments."  Use at your own risk.

## Installation

Add this line to your application's Gemfile:

    gem 'activejob-locks'

And then execute:

    $ bundle

## Usage

Add the following to the configuration file you use for active_job.  The value for redis needs to be an array of redis servers.

```ruby
    # config.active_job.queue_adapter = :sidekiq
    config.active_job.locks.redis = [Rails.application.config_for(:redis)["url"]]
    # or
    # config.active_job.locks.redis = ['redis://127.0.0.1:6379']
```

There are two ways lock workers currently.  The first is by queue.  So only one job will be allowed to run per queue.  This goes against the high concurrency that make background useful, but sometimes it just has to happen.  The second is by job payload.  This is done by getting the global_ids of the objects passed in if possible. Otherwise it assumes a string payload.

To configure locks add the following to the worker.


```ruby
class LockedJob < ActiveJob::Base
  # ttl:  Time for lock to be valid.  This allows for the process to completely disappear and not lock every job forever.  This should be set based on some reasonable time the jobs take to finish.  Default: 1 minute
  # requeue_wait:  How long to wait before retrying the job.  Default: Now
  lock_by :payload, ttl: 50.seconds
  # or
  # lock_by :queue, ttl: 20.seconds, requeue_wait: 3.seconds

  def perform(payload)
    # Something here
  end
end
```


## Thank you
Thank you to [activejob-stats](https://github.com/seuros/activejob-stats) for being an example to reference.

## Contributing

1. Fork it ( https://github.com/erickrause/activejob-locks )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request