package org.arell;

import javax.swing.*;
import java.awt.*;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

public class sentencias {
    private JPanel sentencias;
    private JPanel seccionDeDatos;
    private JButton guardarButton;
    private JTextArea SeccionDatos;
    private JButton salirButton;

    public sentencias(List<String> sentenciasList) {
        SeccionDatos.setEditable(false);
        SeccionDatos.setText(String.join("\n", sentenciasList));

        JScrollPane scrollPane = new JScrollPane(SeccionDatos);
        scrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);
        scrollPane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);

        seccionDeDatos.setLayout(new BorderLayout());
        seccionDeDatos.add(scrollPane, BorderLayout.CENTER);

        guardarButton.addActionListener(e -> guardarSentenciasEnDescargas(sentenciasList));
    }

    public JPanel getPanel() {
        return sentencias;
    }

    private void guardarSentenciasEnDescargas(List<String> sentenciasList) {
        try {
            // Buscar la carpeta "Descargas" o "Downloads" en el nivel del usuario
            File carpetaDescargas = buscarCarpetaNivelUsuario("Downloads", "Descargas");
            if (carpetaDescargas == null) {
                JOptionPane.showMessageDialog(null, "No se pudo encontrar la carpeta de descargas.", "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }

            // Crear el archivo "sentencias.sql" en la carpeta encontrada
            File archivoSQL = new File(carpetaDescargas, "sentencias.sql");
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(archivoSQL))) {
                for (String sentencia : sentenciasList) {
                    writer.write(sentencia);
                    writer.newLine();
                }
            }

            JOptionPane.showMessageDialog(null, "Archivo guardado en: " + archivoSQL.getAbsolutePath(), "Éxito", JOptionPane.INFORMATION_MESSAGE);

        } catch (IOException e) {
            JOptionPane.showMessageDialog(null, "Error al guardar las sentencias.", "Error", JOptionPane.ERROR_MESSAGE);
            e.printStackTrace();
        }
    }

    private File buscarCarpetaNivelUsuario(String... nombresCarpeta) {
        // Obtener el directorio principal del usuario
        File directorioUsuario = new File(System.getProperty("user.home"));

        // Verificar si alguna carpeta en el nivel del usuario coincide con los nombres proporcionados
        File[] subdirectorios = directorioUsuario.listFiles();
        if (subdirectorios != null) {
            for (File subdirectorio : subdirectorios) {
                if (subdirectorio.isDirectory()) {
                    for (String nombre : nombresCarpeta) {
                        if (subdirectorio.getName().equalsIgnoreCase(nombre)) {
                            return subdirectorio;
                        }
                    }
                }
            }
        }

        return null; // No se encontró ninguna carpeta con los nombres especificados
    }
}
