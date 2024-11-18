#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Estructura para representar un registro de la tabla PRODUCTO
typedef struct {
    char codBarras[20];
    double precio;
    char fechaCompra[11];
    int stock;
    char RS[50]; 
} Producto;

// Nodo para la lista dinámica
typedef struct Node {
    Producto data;
    struct Node* next;
} Node;

// Variables globales
unsigned long long codBarrasBase = 7501001234567; // Base para generar codigos de barras secuenciales

// Funciones para ingresar, borrar, actualizar y consultar informaciónn
void insertarProducto(Node** head, double precio, const char* fechaCompra, int stock, const char* RS);
void mostrarProductos(Node* head);
void actualizarProducto(Node* head, const char* codBarras);
void eliminarProducto(Node** head, const char* codBarras);

// Validaciones
int codigoBarrasExiste(Node* head, const char* codBarras);

// Funciones para poder guardar los datos en un archivo 
void guardarProductos(Node* head, const char* filename);
void cargarProductos(Node** head, const char* filename);

void menu();

// Función para crear un registro de producto
Producto crearProducto(const char* codBarras, double precio, const char* fechaCompra, int stock, const char* RS) {
    Producto p;
    strcpy(p.codBarras, codBarras);
    p.precio = precio;
    strcpy(p.fechaCompra, fechaCompra);
    p.stock = stock;
    strcpy(p.RS, RS);
    return p;
}

int main() {
    menu(); 
    return 0;
}

// Insertar un nuevo registro (CREATE)
void insertarProducto(Node** head, double precio, const char* fechaCompra, int stock, const char* RS) {
    // Generar el siguiente codigo de barras usando el codigo base de variable global
    char codBarras[20];
    sprintf(codBarras, "%llu", codBarrasBase++);

    // Validar si el codigo de barras ya existe
    if (codigoBarrasExiste(*head, codBarras)) {
        printf("Error: El codigo de barras '%s' ya existe.\n", codBarras);
        return;
    }

    // Crear el nuevo producto
    Producto nuevoProducto = crearProducto(codBarras, precio, fechaCompra, stock, RS);

    // Insertar el producto en la lista
    Node* nuevoNodo = (Node*)malloc(sizeof(Node));
    nuevoNodo->data = nuevoProducto;
    nuevoNodo->next = *head;
    *head = nuevoNodo;

    printf("Producto con codigo '%s' agregado exitosamente.\n", codBarras);
}

// Mostrar todos los registros (SELECT)
void mostrarProductos(Node* head) {
    if (head == NULL) {
        printf("No hay productos registrados.\n");
        return;
    }

    Node* actual = head;
    while (actual != NULL) {
        printf("CodBarras: %s, Precio: %.2f, FechaCompra: %s, Stock: %d, RS: %s\n",
            actual->data.codBarras, actual->data.precio, actual->data.fechaCompra,
            actual->data.stock, actual->data.RS);
        actual = actual->next;
    }
}

// Actualizar un registro (UPDATE)
void actualizarProducto(Node* head, const char* codBarras) {
    Node* actual = head;

    // Buscar el producto por su codigo de barras
    while (actual != NULL) {
        if (strcmp(actual->data.codBarras, codBarras) == 0) {
            int opcion;
            printf("Producto encontrado. ¿Que desea actualizar?\n");
            printf("1. Precio\n");
            printf("2. Fecha de compra\n");
            printf("3. Stock\n");
            printf("4. RS del proveedor\n");
            printf("Seleccione una opcion: ");
            scanf("%d", &opcion);

            switch (opcion) {
                case 1:
                    printf("Ingrese el nuevo precio: ");
                    scanf("%lf", &actual->data.precio);
                    printf("Precio actualizado exitosamente.\n");
                    break;
                case 2:
                    printf("Ingrese la nueva fecha de compra (YYYY-MM-DD): ");
                    scanf("%s", actual->data.fechaCompra);
                    printf("Fecha de compra actualizada exitosamente.\n");
                    break;
                case 3:
                    printf("Ingrese el nuevo stock: ");
                    scanf("%d", &actual->data.stock);
                    printf("Stock actualizado exitosamente.\n");
                    break;
                case 4:
                    printf("Ingrese la nueva RS del proveedor: ");
                    scanf("%d", &actual->data.RS);
                    printf("RS actualizada exitosamente.\n");
                    break;
                default:
                    printf("Opcion no válida.\n");
            }
            return;
        }
        actual = actual->next;
    }
    printf("Producto con codigo '%s' no encontrado.\n", codBarras);
}

// Eliminar un registro (DELETE)
void eliminarProducto(Node** head, const char* codBarras) {
    Node* actual = *head;
    Node* anterior = NULL;

    // Buscar el producto por su codigo de barras
    while (actual != NULL) {
        if (strcmp(actual->data.codBarras, codBarras) == 0) {
            if (anterior == NULL) {
                *head = actual->next; // Eliminar el primer nodo
            } else {
                anterior->next = actual->next;
            }
            free(actual);
            printf("Producto eliminado exitosamente.\n");
            return;
        }
        anterior = actual;
        actual = actual->next;
    }
    printf("Producto con codigo '%s' no encontrado.\n", codBarras);
}

// Validar si un codigo de barras ya existe en la lista
int codigoBarrasExiste(Node* head, const char* codBarras) {
    Node* actual = head;
    while (actual != NULL) {
        if (strcmp(actual->data.codBarras, codBarras) == 0) {
            return 1; // Existe
        }
        actual = actual->next;
    }
    return 0; // No existe
}

// Guardar los productos en un archivo
void guardarProductos(Node* head, const char* filename) {
    FILE* file = fopen(filename, "w");
    if (file == NULL) {
        printf("Error al abrir el archivo '%s'.\n", filename);
        return;
    }

    Node* actual = head;
    while (actual != NULL) {
        fprintf(file, "%s,%.2f,%s,%d,%s\n",
                actual->data.codBarras, actual->data.precio, actual->data.fechaCompra,
                actual->data.stock, actual->data.RS);
        actual = actual->next;
    }

    fclose(file);
    printf("Productos guardados en '%s'.\n", filename);
}

// Cargar los productos desde un archivo
void cargarProductos(Node** head, const char* filename) {
    FILE* file = fopen(filename, "r");
    if (file == NULL) {
        printf("Error al abrir el archivo '%s'.\n", filename);
        return;
    }

    char line[200];
    while (fgets(line, sizeof(line), file)) {
        Producto p;
        sscanf(line, "%[^,],%lf,%[^,],%d,%[^\n]",
            p.codBarras, &p.precio, p.fechaCompra, &p.stock, p.RS);

        // Verifica si el codigo de barras ya existe
        if (codigoBarrasExiste(*head, p.codBarras)) {
            printf("Error: El codigo de barras '%s' ya existe. Registro omitido.\n", p.codBarras);
            continue;
        }

        // Inserta el producto en la lista
        Node* nuevoNodo = (Node*)malloc(sizeof(Node));
        nuevoNodo->data = p;
        nuevoNodo->next = *head;
        *head = nuevoNodo;
    }

    fclose(file);
    printf("Productos cargados desde '%s'.\n", filename);
}

// Menú interact
void menu() {
    Node* productos = NULL;
    int opcion;
    char filename[50];

    do {
        printf("\n--- MENU ---\n");
        printf("1. Insertar producto\n");
        printf("2. Mostrar productos\n");
        printf("3. Actualizar producto\n");
        printf("4. Eliminar producto\n");
        printf("5. Guardar productos en archivo\n");
        printf("6. Cargar productos desde archivo\n");
        printf("7. Salir\n");
        printf("Seleccione una opcion: ");
        scanf("%d", &opcion);

        switch (opcion) {
            case 1: {
                double precio;
                char fechaCompra[11], RS[50];
                int stock;
                printf("Ingrese precio: ");
                scanf("%lf", &precio);
                printf("Ingrese fecha de compra (YYYY-MM-DD): ");
                scanf("%s", fechaCompra);
                printf("Ingrese stock: ");
                scanf("%d", &stock);
                printf("Ingrese RS del proveedor: ");
                scanf(" %[^\n]", RS);
                insertarProducto(&productos, precio, fechaCompra, stock, RS);
                break;
            }
            case 2:
                mostrarProductos(productos);
                break;
            case 3: {
                char codBarras[20];
                printf("Ingrese el codigo de barras del producto a actualizar: ");
                scanf("%s", codBarras);
                actualizarProducto(productos, codBarras);
                break;
            }
            case 4: {
                char codBarras[20];
                printf("Ingrese el codigo de barras del producto a eliminar: ");
                scanf("%s", codBarras);
                eliminarProducto(&productos, codBarras);
                break;
            }
            case 5:
                printf("Ingrese el nombre del archivo para guardar: ");
                scanf("%s", filename);
                guardarProductos(productos, filename);
                break;
            case 6:
                printf("Ingrese el nombre del archivo para cargar: ");
                scanf("%s", filename);
                cargarProductos(&productos, filename);
                break;
            case 7:
                printf("Saliendo del programa...\n");
                break;
            default:
                printf("Opcion no valida. Intente de nuevo.\n");
        }
    } while (opcion != 7);
}


