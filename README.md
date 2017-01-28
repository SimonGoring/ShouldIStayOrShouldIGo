# ShouldIStayOrShouldIGo

This project is intended as a skill building exercise as part of the [UBC R Stats Group](http://minisciencegirl.github.io/studyGroup/).  The project is intended to develop an interactive map that can be used by individuals to tell whether it's (on average) faster to walk or wait for a bus at any one point in the city of Vancouver.

The project uses the [Translink API](https://developer.translink.ca/).  If you intend to work on this project, or want to have it functional on your local instance, please be sure to [register for the open API](https://developer.translink.ca/Account/Register).

The project is an implementation of the [wait/walk dillema](https://en.wikipedia.org/wiki/Wait/walk_dilemma), which seems to conclude that ["laziness almost always works"](http://www.nytimes.com/interactive/2008/12/14/magazine/2008_IDEAS.html?_r=0#b-ideas-5).  The problem is described more fully in [Chen et al. (2008)](https://arxiv.org/abs/0801.0297) (and extended in [Morton (2008)](https://arxiv.org/abs/0802.3653)) where the hypothetical Jason realizes that "the laziest possible waiting strategy [will] prevail".

I (Simon Goring) propose that this is not always the case.  For example, when the arrival time of the bus is known and the distance to the station is fixed, there are clearly (knowable) times when the the bus is more or less frequent, and during which walking to the station is clearly the best strategy if minimizing travel time is the goal.

## Development

We welcome contributions from any individual, whether code, documentation, or issue tracking. All participants are expected to follow the [code of conduct](https://github.com/ROpensci/neotoma/blob/master/code_of_conduct.md) for this project.

* [Simon Goring](http://goring.org) - Department of Geography, University of Wisconsin - Madison

### Development Plan

At the January 25th meeting of the UBC R Study Group](https://github.com/minisciencegirl/studyGroup/issues/154) we discussed some basic planning elements for the project.  Components included:

1.  Using the TransLink API to generate a long table with the elements `stop` (numeric bus stop, from TransLink), `lat` and `long` (geospatial coding for the stops), `hour` (time of day), `day` (day of week), `wait` (average time until bus arrives) and `time` (time until bus reaches station).
2. Walking time will be calculated based (at present) on the straight-line distance from stop to station.  It may become interesting to implement an [open source route mapper](https://wiki.openstreetmap.org/wiki/Routing) at some point.
3.  The model to calculate whether to wait, or to take the bus, would then be implemented as some function of t<sub>w</sub> (the walking time) and t<sub>wait</sub> + t<sub>ride</sub> (the time required for the bus to arrive, plus the time the bus takes to travel to a point).

We will calculate the probability that it is better to wait or walk at the level of the individual stop, to provide a leaflet map with color coded markers.  There will be the addition of a `resolution` parameter, that will then aggregate the individual points to some sort of gridded raster.

## Using This Repository

The repository is coded as a [Shiny](https://shiny.rstudio.com/) app.  We recommend using RStudio, given its integration with Shiny.  The Translink API requires the use of a private key that is passed as part of the API string:

`http://api.translink.ca/rttiapi/v1/stops/60980/estimates?apikey=[APIKey]`

Because this key is private, and unique to the user, it should be stored in a file that is ignored by the version control system, otherwise it will get pushed up to GitHub where it could be harvested.  The key will be placed in a file called `config.txt` in the `data` folder.  The `config.txt` file should contain only the key (for example):

```
pgGF7DjW77F7bSCFfuQrda7G
```

The file can then be read within the `server.r` file.

