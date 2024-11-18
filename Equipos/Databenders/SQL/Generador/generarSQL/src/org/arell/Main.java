package org.arell;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.List;
import java.awt.Desktop;
import java.net.URI;

public class Main extends JFrame {
    private JTextField generadortextField1;
    private JButton visitarButton;
    private JPanel MainPanel;
    private JButton generarButton;

    public Main() {
        setContentPane(MainPanel);
        setTitle("Generador de inserciones sql");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(400, 350);
        setLocationRelativeTo(null);
        setVisible(true);

        generarButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    int cantidad = Integer.parseInt(generadortextField1.getText());

                    if (cantidad <= 0) {
                        JOptionPane.showMessageDialog(Main.this, "Por favor, introduce un número mayor a 0.", "error", JOptionPane.ERROR_MESSAGE);
                        return;
                    }

                    Generador generador = new Generador();
                    List<String> sentencias = generador.generarSentencias(cantidad);

                    JFrame frame = new JFrame("sentencias generadas");
                    frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
                    frame.setSize(600, 400);

                    sentencias panelSentencias = new sentencias(sentencias);
                    frame.setContentPane(panelSentencias.getPanel());
                    frame.setVisible(true);

                } catch (NumberFormatException ex) {
                    JOptionPane.showMessageDialog(Main.this, "Por favor, introduce un número válido.", "error", JOptionPane.ERROR_MESSAGE);
                }
            }
        });

        visitarButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    URI uri = new URI("https://github.com/FernandoArreolaF/Bases1UNAM");
                    if (Desktop.isDesktopSupported()) {
                        Desktop.getDesktop().browse(uri);
                    } else {
                        JOptionPane.showMessageDialog(Main.this, "No se puede abrir el navegador en este sistema.", "error", JOptionPane.ERROR_MESSAGE);
                    }
                } catch (Exception ex) {
                    JOptionPane.showMessageDialog(Main.this, "Error al intentar abrir el enlace.", "error", JOptionPane.ERROR_MESSAGE);
                    ex.printStackTrace();
                }
            }
        });
    }

    public static void main(String[] args) {
        new Main();
    }
}
