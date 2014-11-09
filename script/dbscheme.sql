-- Anlegen der Datenbank
DROP DATABASE shop;
CREATE DATABASE shop;
USE shop;

-- Anlegen der Tables
CREATE TABLE ware (
  wid   INTEGER       NOT NULL auto_increment,
  name  VARCHAR(50)   NOT NULL,
  besch VARCHAR(600),
  bild  BLOB,
  PRIMARY KEY (wid)
);

CREATE TABLE bestehtaus (
  pid INTEGER NOT NULL,
  sid INTEGER NOT NULL,
  PRIMARY KEY (pid, sid),
  FOREIGN KEY (pid) REFERENCES ware(wid),
  FOREIGN KEY (sid) REFERENCES ware(wid)
)
