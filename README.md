# Postgis Hands on Workshop

## Pre-requisites

1. A Postgres DB with Postgis extension installed and spatial data populated
   1. Clone this repo on your local machine
   2. Move to the root of the project
   3. Run `docker compose up`

2. A GUI tool to connect to database and query data
   1. Install DBVisualiser: https://www.dbvis.com/download/
   2. Open it and create a new database connection with below settings:
      1. server: `localhost`
      2. port: `6432`
      3. db: `postgis_workshop`
      4. user: `postgres`
      5. no password is being used for this DB

3. Another GUI tool to connect to the DB, similar to above but more catered towards visualizing spatial data. https://www.qgis.org/en/site/forusers/download.html#


## What is Postgis?
PostGIS is an extension for the PostgreSQL database management system that adds support for geographic objects.

## Why do we need Postgis or why should we study about it?
Because it allows us to store, index, and query data with a geographic component, such as location data or shapes. Some common use cases for PostGIS include storing data about geographical features, analyzing and querying spatial data, and creating maps.

## What is Geo Spatial Data?
   1. Point
   2. Lines
   3. Polygons
   4. MultiPolygons

## What is Spatial Index?
Spatial indexes are used in PostGIS to quickly search for objects in space. Practically, this means very quickly answering questions of the form:

"all the things inside this this" or
"all the things near this other thing"

- Just as binary search tree acts as an index for quickly searching on numeric data
- Similarly, Spatial indices help to quickly shorten the search space.

## Basic Operations/Joins on Spatial Data
    1. Nearby Search
    2. Point in a polygon
    3. Polygon intersections and unions

## What are Spatial reference systems and why they are important?

## Visualization of Spatial Data
### Using QGIS
    1. In QGIS create a new connection under postgres
    2. Connect to the DB, expand the tables and add the layer of states
### Using GeoJson.io
    1. Using DBVisualiser, run 
    
    ```
        Select ST_AsGeoJson(boundary) from states limit 1
    ```
    2. Copy paste the output on geojson.io


## References
   1. https://www.crunchydata.com/developers/playground/basics-of-postgis
   2. https://www.crunchydata.com/blog/postgis-for-newbies
   3. https://www.crunchydata.com/blog/the-many-spatial-indexes-of-postgis
   4. http://postgis.net/workshops/postgis-intro/
   5. https://www.crunchydata.com/blog/the-many-spatial-indexes-of-postgis
   6. https://access.crunchydata.com/documentation/pg_featureserv/latest/quickstart/
