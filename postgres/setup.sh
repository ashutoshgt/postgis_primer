#!/usr/bin/env bash

psql -U postgres -d postgis_workshop -c "CREATE OR REPLACE LANGUAGE plpythonu;"
psql -U postgres -d postgis_workshop -c "CREATE EXTENSION IF NOT EXISTS postgis;"
psql -U postgres -d postgis_workshop -c "CREATE EXTENSION IF NOT EXISTS pgcrypto;"
psql -U postgres -d postgis_workshop < /opt/sql/postgis_workshop.drop.sql
psql -U postgres -d postgis_workshop < /opt/sql/postgis_workshop.sql
psql -U postgres -d postgis_workshop < /opt/sql/postgis_workshop.extra.sql
psql -U postgres -d postgis_workshop < /opt/sql/postgis_workshop.data.sql
