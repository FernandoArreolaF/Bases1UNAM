package org.example;

import com.google.gson.*;
import java.io.*;
import java.util.*;

// Clase para definir una columna con nombre y tipo de dato
class Columna {
    String nombre;
    String tipo;

    public Columna(String nombre, String tipo) {
        this.nombre = nombre;
        this.tipo = tipo.toUpperCase();
    }
}

// Clase para un registro con datos dinámicos (mapeo columna-valor)
class Registro {
    Map<String, Object> datos = new LinkedHashMap<>();

    public Registro(List<Columna> columnas, List<Object> valores) {
        for (int i = 0; i < columnas.size(); i++) {
            datos.put(columnas.get(i).nombre, valores.get(i));
        }
    }

    @Override
    public String toString() {
        return datos.toString();
    }
}

// Clase para representar una tabla con columnas y registros
class Tabla {
    String nombre;
    List<Columna> columnas = new ArrayList<>();
    List<Registro> registros = new ArrayList<>();

    public Tabla(String nombre) {
        this.nombre = nombre;
    }

    public void definirColumna(String nombre, String tipo) {
        columnas.add(new Columna(nombre, tipo));
    }

    public void insertarRegistro(List<Object> valores) {
        if (valores.size() != columnas.size()) {
            throw new IllegalArgumentException("Número de valores no coincide con el número de columnas.");
        }

        List<Object> valoresProcesados = new ArrayList<>();
        for (int i = 0; i < columnas.size(); i++) {
            valoresProcesados.add(validarTipo(columnas.get(i).tipo, valores.get(i)));
        }

        registros.add(new Registro(columnas, valoresProcesados));
        System.out.println("Registro insertado en la tabla " + nombre + ".");
    }

    public void consultarRegistros() {
        if (registros.isEmpty()) {
            System.out.println("No hay registros en la tabla " + nombre + ".");
            return;
        }
        for (Registro registro : registros) {
            System.out.println(registro);
        }
    }

    private Object validarTipo(String tipo, Object valor) {
        switch (tipo) {
            case "INT":
                if (valor instanceof Integer) return valor;
                if (valor instanceof String) return Integer.parseInt((String) valor);
                break;
            case "DOUBLE":
                if (valor instanceof Double) return valor;
                if (valor instanceof String) return Double.parseDouble((String) valor);
                break;
            case "VARCHAR":
                if (valor instanceof String) return valor;
                break;
            case "DATE":
                if (valor instanceof String && ((String) valor).matches("\\d{4}-\\d{2}-\\d{2}")) return valor;
                break;
            default:
                throw new IllegalArgumentException("Tipo de dato no soportado: " + tipo);
        }
        throw new IllegalArgumentException("El valor " + valor + " no es válido para el tipo " + tipo);
    }
}

// Clase principal para el simulador
public class SimuladorPostgres {
    private Map<String, Map<String, Tabla>> basesDeDatos = new HashMap<>();
    private String baseDeDatosActual;

    public void crearBaseDeDatos(String nombre) {
        basesDeDatos.put(nombre, new HashMap<>());
        baseDeDatosActual = nombre;
        System.out.println("Base de datos creada: " + nombre);
    }

    public void usarBaseDeDatos(String nombre) {
        if (basesDeDatos.containsKey(nombre)) {
            baseDeDatosActual = nombre;
            System.out.println("Usando base de datos: " + nombre);
        } else {
            System.out.println("Base de datos " + nombre + " no existe.");
        }
    }

    public void crearTabla(String nombreTabla, List<Columna> columnas) {
        if (baseDeDatosActual == null) {
            System.out.println("Primero selecciona una base de datos con el comando 'USE <base>'.");
            return;
        }
        Tabla tabla = new Tabla(nombreTabla);
        for (Columna columna : columnas) {
            tabla.definirColumna(columna.nombre, columna.tipo);
        }
        basesDeDatos.get(baseDeDatosActual).put(nombreTabla, tabla);
        System.out.println("Tabla creada: " + nombreTabla);
    }

    public void insertarEnTabla(String nombreTabla, List<Object> valores) {
        if (baseDeDatosActual == null) {
            System.out.println("Primero selecciona una base de datos con el comando 'USE <base>'.");
            return;
        }
        Tabla tabla = basesDeDatos.get(baseDeDatosActual).get(nombreTabla);
        if (tabla == null) {
            System.out.println("La tabla " + nombreTabla + " no existe.");
            return;
        }
        tabla.insertarRegistro(valores);
    }

    public void consultarTabla(String nombreTabla) {
        if (baseDeDatosActual == null) {
            System.out.println("Primero selecciona una base de datos con el comando 'USE <base>'.");
            return;
        }
        Tabla tabla = basesDeDatos.get(baseDeDatosActual).get(nombreTabla);
        if (tabla == null) {
            System.out.println("La tabla " + nombreTabla + " no existe.");
            return;
        }
        tabla.consultarRegistros();
    }

    public void guardarBaseDeDatos(String nombreArchivo) {
        try (Writer writer = new FileWriter(nombreArchivo)) {
            Gson gson = new GsonBuilder().setPrettyPrinting().create();
            gson.toJson(basesDeDatos, writer);
            System.out.println("Base de datos guardada en " + nombreArchivo);
        } catch (IOException e) {
            System.out.println("Error al guardar la base de datos: " + e.getMessage());
        }
    }

    public void cargarBaseDeDatos(String nombreArchivo) {
        try (Reader reader = new FileReader(nombreArchivo)) {
            Gson gson = new Gson();
            basesDeDatos = gson.fromJson(reader, new HashMap<String, Map<String, Tabla>>() {}.getClass());
            System.out.println("Base de datos cargada desde " + nombreArchivo);
        } catch (IOException e) {
            System.out.println("Error al cargar la base de datos: " + e.getMessage());
        }
    }

    public void ejecutarPrompt() {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Simulador de PostgreSQL. Escribe tus comandos (escribe 'EXIT' para salir):");

        while (true) {
            String prompt = baseDeDatosActual != null ? baseDeDatosActual + "#" : "postgres#";
            System.out.print(prompt + " ");
            String input = scanner.nextLine().trim();

            if (input.equalsIgnoreCase("EXIT")) {
                System.out.println("Saliendo...");
                break;
            }

            try {
                procesarComando(input);
            } catch (Exception e) {
                System.out.println("Error: " + e.getMessage());
            }
        }

        scanner.close();
    }

    private void procesarComando(String comando) {
        if (comando.startsWith("CREATE DATABASE")) {
            String nombre = comando.split(" ")[2].replace(";", "");
            crearBaseDeDatos(nombre);
        } else if (comando.startsWith("USE")) {
            String nombre = comando.split(" ")[1].replace(";", "");
            usarBaseDeDatos(nombre);
        } else if (comando.startsWith("CREATE TABLE")) {
            String[] partes = comando.replace("CREATE TABLE ", "").split("\\(");
            String nombreTabla = partes[0].trim();
            String[] columnasDef = partes[1].replace(");", "").split(",");
            List<Columna> columnas = new ArrayList<>();
            for (String columna : columnasDef) {
                String[] def = columna.trim().split(" ");
                columnas.add(new Columna(def[0], def[1]));
            }
            crearTabla(nombreTabla, columnas);
        } else if (comando.startsWith("INSERT INTO")) {
            String[] partes = comando.replace("INSERT INTO ", "").split("VALUES");
            String nombreTabla = partes[0].split("\\(")[0].trim();
            String[] valores = partes[1].replace("(", "").replace(");", "").split(",");
            List<Object> listaValores = new ArrayList<>();
            for (String valor : valores) {
                valor = valor.trim();
                if (valor.startsWith("'") && valor.endsWith("'")) {
                    listaValores.add(valor.replace("'", ""));
                } else if (valor.matches("\\d+")) {
                    listaValores.add(Integer.parseInt(valor));
                } else if (valor.matches("\\d+\\.\\d+")) {
                    listaValores.add(Double.parseDouble(valor));
                } else {
                    listaValores.add(valor);
                }
            }
            insertarEnTabla(nombreTabla, listaValores);
        } else if (comando.startsWith("SELECT * FROM")) {
            String nombreTabla = comando.replace("SELECT * FROM ", "").replace(";", "").trim();
            consultarTabla(nombreTabla);
        } else if (comando.startsWith("SAVE")) {
            String nombreArchivo = comando.replace("SAVE ", "").replace(";", "").trim();
            guardarBaseDeDatos(nombreArchivo);
        } else if (comando.startsWith("LOAD")) {
            String nombreArchivo = comando.replace("LOAD ", "").replace(";", "").trim();
            cargarBaseDeDatos(nombreArchivo);
        } else {
            System.out.println("Comando no reconocido.");
        }
    }

    public static void main(String[] args) {
        SimuladorPostgres simulador = new SimuladorPostgres();
        simulador.ejecutarPrompt();
    }
}