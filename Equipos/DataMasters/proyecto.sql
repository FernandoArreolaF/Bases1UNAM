create database project;

CREATE TABLE supplier (
    id_supplier integer PRIMARY KEY,
    Name_supplier varchar(50) not null,
    Sup_Last_Name varchar(40) not null,
    Sup_Last_Name_Mom varchar(40) null,
    legal_enty_type varchar(40) not null,
    bussines_name varchar(40) null,
    street varchar(70) not null,
    out_num smallint not null,
    int_num smallint null,
    neighborhood varchar(50) not null,
    state varchar(20) not null,
    zip_code varchar(10) NOT NULL,
    municipality varchar(60) not null
);

CREATE TABLE product (
    id_product integer PRIMARY KEY,
    brand varchar(35) not null,
    sale_price numeric(10,2) not null,
    description varchar(200) not null
);

CREATE TABLE client (
    id_client integer PRIMARY KEY,
    client_name varchar(60) not null,
    rfc varchar(13) UNIQUE not null,
    client_last_name varchar(50) not null,
    client_last_name_mom varchar(50) null,
    email varchar(200) not null,
    street_c varchar(70) not null,
    out_num_c smallint not null,
    int_num_c smallint null,
    neighborhood_c varchar(50) not null,
    state_c varchar(20) not null,
    zip_code_c varchar(10) NOT NULL,
    municipality_c varchar(60) not null
);

CREATE TABLE sale (
    sale_number varchar(20) PRIMARY KEY,
    sale_date date not null,
    total_amount numeric(9,2) not null,
    id_client integer,
    FOREIGN KEY (id_client) REFERENCES client(id_client),
    CONSTRAINT sale_code_format CHECK (sale_number ~ '^VENT-\d{3,}$')
);

CREATE TABLE sale_status (
    id_sale_status integer PRIMARY KEY,
    description varchar(200) not null,
    status char(1) not null
); 

CREATE TABLE historical_status_order (
    id_his_sta_ord integer PRIMARY KEY,
    status_date date not null,
    id_sale_status integer,
    sale_number varchar(20),
    FOREIGN KEY (id_sale_status) REFERENCES sale_status(id_sale_status),
    FOREIGN KEY (sale_number) REFERENCES sale(sale_number) 
);

CREATE TABLE phone_number (
    supplier_phone_number integer PRIMARY KEY,
    id_supplier integer,
    FOREIGN KEY (id_supplier) REFERENCES supplier(id_supplier)
);

CREATE TABLE provides (
    id_supplier integer,
    id_product integer,
    FOREIGN KEY (id_supplier) REFERENCES supplier(id_supplier),
    FOREIGN KEY (id_product) REFERENCES product(id_product),

    PRIMARY KEY (id_supplier, id_product)
);

CREATE TABLE is_sold (
    sale_number varchar(20),
    id_product integer,
    FOREIGN KEY (sale_number) REFERENCES sale(sale_number),
    FOREIGN KEY (id_product) REFERENCES product(id_product),
    total_product numeric(9,2) not null,
    quantity integer not null CHECK (quantity > 0),
    unit_price  numeric(10,2) NOT NULL,

    PRIMARY KEY (sale_number, id_product)
);

CREATE TABLE merchandise (
  id_product integer PRIMARY KEY,
  FOREIGN KEY (id_product) REFERENCES product(id_product)
);

CREATE TABLE print (
  id_product integer PRIMARY KEY,
  FOREIGN KEY (id_product) REFERENCES product(id_product)
);

CREATE TABLE phone_recharge (
  id_product integer PRIMARY KEY,
  FOREIGN KEY (id_product) REFERENCES product(id_product)
);

CREATE TABLE stationery_item (
  id_product integer PRIMARY KEY,
  FOREIGN KEY (id_product) REFERENCES product(id_product)
);

CREATE TABLE inventory (
  id_product     integer PRIMARY KEY,
  barcode        varchar(50) NOT NULL UNIQUE,
  purchase_price numeric(10,2) NOT NULL,
  purchase_date  date NOT NULL,
  stock          integer NOT NULL CHECK (stock >= 0),
  photo_url      varchar(250) NOT NULL

  PRIMARY KEY (id_product) REFERENCES product(id_product),
);

CREATE INDEX idx_inventory_barcode ON inventory(barcode);