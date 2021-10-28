# beta-aggregator

Takes all the best beta from roadtripryan.com and canyoneeringusa.com and combines it into one searchable database. 

### Examples

- Want to find all canyons that don't require permits in the Zions area? 
- Want to find all canyons with low flash flood risk and are good in fall? 
- Want to find all canyons with 2wd access? 
- Want to find all canyons that have a maximum rappell of 100 feet?
- Want to find all canyons that have less than 1 hour hike in/out? 

Finding the answers to these questions isn't straightforward or even possible without a lot of effort. 

# Setup

```
bundle install
rake scrape:roadtripryan
rake scrape:canyoneeringusa
```

This will create yaml files and save them in the `data` folder

# Development


## Testing

```
bundle install --with development
bundle exec rake test
```

A guardfile is included, it will watch for changes in the test directory and automatically trigger test
```
bundle exec guard
```


## Formatting

```
bundle exec rake rubocop
```