CREATE USER papeleria WITH
LOGIN
SUPERUSER
CREATEDB
PASSWORD 'papeleria1234';

CREATE DATABASE papeleria_system_test;

\c papeleria_system_test;