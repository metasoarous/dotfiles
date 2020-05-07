
# Postgres

Because we can't _all_ have EAV yet...


## Changing password & creating user

Note that this doesn't force you to remember the postgres admin password

  sudo -u postgres psql

To set the admin password

  \password postgres

To create a new user or update a user

  CREATE USER csmall with PASSWORD 'sdfkjdflkjsdflkj' CREATEDB;

If you forget CREATEDB or some other, or just need to change

  ALTER USER csmall with CREATEDB;


## Taking a postgres export/backup from heroku and getting it up in a makshift db

If you ever do something stupid and need to manually boot up a db to recover some data

First from pg

  CREATE DATABASE polisyesterday with OWNER = csmall;

Next do pg resore

  pg_restore --verbose --clean --no-acl --no-owner -h localhost -d polisyesterday yesterday.dump

Back in pg, connect to the db and do whatever querying you need to do to fix things, and save out using copy.
Note that you may have to use a tmp directory cause of permissions

  \connect polisyesterday
  Copy (Select * From foo) To '/tmp/mapping.csv' With CSV DELIMITER ',';

Now from the session where you need to fix things, you can use this data by setting a temp table and copying
into it.

  create temp table ownermapping;
  copy ownermapping from '/tmp/mapping.csv' with (format csv);

Specific details of how to update owners:

  UPDATE conversations
  SET owner = ownermapping.owner
  FROM ownermapping
  WHERE ownermapping.zid = conversations.zid;


