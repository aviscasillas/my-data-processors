# my-data-processors [![Build Status](https://travis-ci.org/aviscasillas/my-data-processors.png)](https://travis-ci.org/aviscasillas/my-data-processors)

This is just another repo to play with Ruby.
Now it's time for data processing :).

## First of all

Clone this repo and go to the working dir:

```bash
$ git clone git@github.com:aviscasillas/my-data-processors.git
$ cd my-data-processors
```

## What can you do with that?

Almost nothing xD.

There are just 3 rake tasks, provided to parse and calculate stuff fetching data from two kind of files (visits and spread).

**Every line in the file should go with tab-separated columns:**

- **id:** string, identifier for the data, eg: “google.com”.
- **date:** date string, YYYYMMDD, date the data corresponds to, eg: “20141202”.
- **data:** base64 encoded, gzipped JSON.

The data entry's format is the next:

##### For visits file
```js
{
  '<userid>': [[<seconds>, <num_pageviews>], ...],
  ...
}
```

##### For spread file
```js
{
  '<userid>': {
    '<timeslice>': [<seconds>, <num_pageviews>],
    ...
  }
}
```

> The “timeslice” values denotes which 15-minute interval in the day the entry describes. Its range is 0-95 (there are 96 15-minute intervals in the day)

### The tasks

#### unique_users_per_day

Calculates the total number of unique users, per day, on some identifier.

**Ie. for facebook.com**

```bash
$ rake 'unique_users_per_day[facebook.com, /your/full/path/to/the/visits/file]'
```

> Response is a hash containing num users per date (`{ 'date' => 'num_users', ... }`).

#### time_spent_average

Calculates the perday average number of seconds spent on some properties (ie. google.*) between some range of time
(ie. 20:00 and 23:00), by people that also have visited some other identifier (ie. facebook.com).

**Ie. for seconds spent on google and also visited facebook.com**

```bash
$ rake 'time_spent_average[google, facebook.com, 20:00, 23:00, /your/full/path/to/the/spread/file]'
```

> Response is a number (in seconds) representing average of visits per day of total users.

#### page_views_sd

Calculates the standard deviation of the amount of pageviews on some identifier, based on all data.

**Ie. for facebook.com**

```bash
$ rake 'page_views_sd[facebook.com, /your/full/path/to/the/visits/file, /your/full/path/to/the/spread/file]'
```

> Response is a float number representing the standard deviation.

## Extra Comments

The format of the files described above was not exactly what I found in the real case.

So, take into account that the file reader is a little tricky to solve the problems found (see: https://github.com/aviscasillas/my-data-processors/blob/master/lib/my_data_processors/support/file.rb#L9-L11).
