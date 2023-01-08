# Postgis Hands on Workshop

## Pre-requisites

1. A Postgres DB with Postgis extension installed and geo spatial data populated
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
PostGIS is an extension for the PostgreSQL database management system that adds support for geographic objects. [link](https://docs.google.com/presentation/d/1qYXdeCIymLl32uoAHvAPrp1r-hK-_4Z8InG7sHEo6vc/edit#slide=id.gd85280829a_0_321)


## Why do we need Postgis or why should we study about it?
Because it allows us to store, index, and query data with a geographic component, such as location data or shapes. Some common use cases for PostGIS include storing data about geographical features, analyzing and querying spatial data, and creating maps.

## Geometry & Geography
- In PostGIS there is an important distinction between geometry and geography.
- Geometry being cartesian and geography adding additional calculations for the curvature of the earth. 
- In general, if you’re dealing with small areas like a city or building, no need to add in the extra computing overhead for geography.
- But if you’re trying to calculate something larger like airline routes, you do.
- Geometry less accurate, geography more accurate.
- Geometry has more supported operations, geography has lesser.

## What is Geo Spatial Data and some data types in Postgis? [refer](http://postgis.net/workshops/postgis-intro/geometries.html#representing-real-world-objects)
There are many data types supported in Postgis, we are concerned about:
   1. Point
      ```
      SELECT ST_ASText(ST_MakePoint(latitude, longitude)) from locations where id=1;
      SELECT ST_ASGeoJSON(ST_MakePoint(longitude, latitude)) from locations where id=1;
      ```
   2. MultiPolygons
      ```
      SELECT ST_ASText(boundary) from states where id=3;
      SELECT ST_ASGeoJSON(boundary) from states where id=3;
      ```

## Data representation [refer](http://postgis.net/workshops/postgis-intro/geometries.html#geometry-input-and-output)
- WKB: Well-known binary (WKB) representations are typically shown in hexadecimal strings.
  - `SELECT boundary AS geog from states limit 1;`
- WKT: Well-known text (WKT) is a text markup language for representing vector geometry objects.
  - `SELECT ST_ASText(boundary) AS geog from states where id=3;`
- GEOJSON
  - `SELECT ST_ASGeoJSON(boundary) AS geog from states where id=3;`

## Visualization of Spatial Data
### Using QGIS
    1. In QGIS create a new connection under postgres
    2. Connect to the DB, expand the tables and add the layer of states
### Using GeoJson.io
    1. Using DBVisualiser, run `SELECT id,state,country,ST_AsGeoJSON(boundary,4326) from states where id=3;`
    2. Copy paste the output on geojson.io (https://geojson.io/)

## What is a Spatial Index?
Spatial indexes are used in PostGIS to quickly search for objects in space. Practically, this means very quickly answering questions of the form:

"all the things inside this this" or
"all the things near this other thing"

- Just as binary search tree acts as an index for quickly searching on numeric data
- Similarly, Spatial indices help to quickly shorten the search space.


## Basic Operations/Joins on Spatial Data
    1. Nearby Search (https://postgis.net/docs/ST_DWithin.html) 
        ```
        SELECT *
        FROM locations
        WHERE ST_DWithin(ST_MakePoint(latitude, longitude), 'POINT(-73.796664 40.689469)', 162); --- returns 110 results out of 300

        SELECT *
        FROM locations
        WHERE ST_DWithin(ST_MakePoint(latitude, longitude), 'POINT(-73.796664 40.689469)', 161); --- returns 2 results out of 300
        ```
    2. Point in a polygon (https://postgis.net/docs/ST_Within.html)
        ```
        Select * from states, (Select latitude, longitude from locations where id=3) as location where ST_WITHIN(ST_MakePoint(location.longitude, location.latitude), boundary);
        
        Select * from states, (Select latitude, longitude from locations where id=3) as location where ST_WITHIN(ST_SetSRID(ST_MakePoint(location.longitude, location.latitude), 4326), boundary);
        ```
    3. Polygon intersections (https://postgis.net/docs/ST_Intersects.html)
        ```
        Select a.state, b.state from states as a, states as b where ST_Intersects(a.boundary, b.boundary) and a.id != b.id
        ```


## What are Spatial reference systems, SRIDs and why they are important?
- SRID stands for Spatial Reference Identifier.
- Each spatial column has an SRID. 
- An SRID corresponds to a spatial reference system based on a specific ellipsoid, and it can be used for either flat-earth mapping or round-earth mapping.
- A spatial column can contain objects with different SRIDs.
- The result of any spatial method derived from two spatial columns is valid only when these two columns have the same SRID.
- Find SRID of a column: `SELECT Find_SRID('public', 'states', 'boundary');`
- SRS=EPSG:4326 represents the World Geodetic System (also known as WGS1984)


## References
   1. https://www.crunchydata.com/developers/playground/basics-of-postgis
   2. https://www.crunchydata.com/blog/postgis-for-newbies
   3. https://www.crunchydata.com/blog/the-many-spatial-indexes-of-postgis
   4. http://postgis.net/workshops/postgis-intro/
   5. https://www.crunchydata.com/blog/the-many-spatial-indexes-of-postgis
   6. https://access.crunchydata.com/documentation/pg_featureserv/latest/quickstart/
   7. https://www.crunchydata.com/blog/topic/spatial
   8. https://www.youtube.com/c/CrunchyDataPostgres
   9. https://docs.google.com/presentation/d/1qYXdeCIymLl32uoAHvAPrp1r-hK-_4Z8InG7sHEo6vc/edit#slide=id.gd85280829a_0_61
