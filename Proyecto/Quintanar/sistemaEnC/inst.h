#ifndef INST_INC
#define INST_INC


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <libpq-fe.h>
#include <math.h>

int menuInicio();
int menuConsumo();
int esFecha(char * fecha);
int potencia(int x, int y);
int esPrecio(char * cadena);
int esNumero(char * cadena);
int StringToInt(char * numero);
int obtenerNumeroFilas(PGconn *conn,char * cad);
int existeCodigoBarras(PGconn *conn, char ** codigoBarras);
void vacia_buffer();
void consumir(PGconn *conn);
void mostrarCompras(PGconn *conn);
void registrarCliente(PGconn *conn);
void registrarProducto(PGconn *conn);
void registrarProveedor(PGconn *conn);
void do_exit(PGconn *conn, PGresult *res);
void printSELECT(PGconn *conn, char * string);
void do_something(PGconn *conn, char * instruction);
void leerCadena(char ** cadena, char * msg, int MAXSIZE);
void UnirInfo(char **instruccion,char * clave, char * nombre, char ** domicilio,char * inicio);
void consumirRecarga(PGconn *conn, char **idRecarga, char ** precio, char ** cantidadArticulo);
void consumirProducto(PGconn *conn, char **codigoBarras, char ** precio, char ** cantidadArticulo );
void consumirImpresion(PGconn *conn, char ** idImpresion, char ** precio, char ** cantidadArticulo);
void unirInfoInventario(char ** instruccion,char * codigoBarras, char * precioCompra, char * fechaCompra, char * stock, char * inicio);
void unirInfoProducto(char ** instruccion, char * codigoBarras, char * precioVenta, char * marca, char * descripcion, char * idTipoProducto, char * inicio);
char ** obtenElementos(PGconn *conn,char * cad);

#endif