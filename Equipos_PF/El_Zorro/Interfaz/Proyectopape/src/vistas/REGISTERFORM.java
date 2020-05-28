package vistas;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;
import modelo.INDAO;
import modelo.Inv;
import modelo.Producto;
import modelo.ProductoDAO;
import modelo.Registro;
import modelo.REGISTRODAO;
import modelo.RVDAO;
import modelo.Ventas;
import modelo.VENTASDAO;


public class REGISTERFORM extends javax.swing.JInternalFrame {
Registro in = new Registro ();
    REGISTRODAO pdao = new REGISTRODAO ();
    Ventas ven = new Ventas ();
    VENTASDAO vo = new VENTASDAO ();
    INDAO ind = new INDAO ();
    Inv p = new Inv ();
    RVDAO vdao = new RVDAO();
    
    DefaultTableModel modelo = new DefaultTableModel();
    int id;
    int idp;
    int idprov;
    int idcat;
    double Sb;
    double T;
    double Iva;
    int item;
    int cant;
    double pre;
    double tpagar;
    public REGISTERFORM() {
        
        initComponents();
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel4 = new javax.swing.JLabel();
        jTextField1 = new javax.swing.JTextField();
        jPanel1 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        TablaDetalle = new javax.swing.JTable();
        btnBuscar = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();
        txtId = new javax.swing.JTextField();
        txtCodProd = new javax.swing.JTextField();
        btnagregar = new javax.swing.JButton();
        btnEliminar = new javax.swing.JButton();
        jLabel7 = new javax.swing.JLabel();
        btnc = new javax.swing.JButton();
        jLabel8 = new javax.swing.JLabel();
        btnv = new javax.swing.JButton();
        txtStock = new javax.swing.JTextField();
        jLabel9 = new javax.swing.JLabel();
        txtIDV = new javax.swing.JTextField();
        txtPrecio = new javax.swing.JTextField();
        txtCantidad = new javax.swing.JTextField();
        jPanel4 = new javax.swing.JPanel();
        btnGV = new javax.swing.JButton();
        btnTOTAL = new javax.swing.JButton();
        txtTotalPagar = new javax.swing.JTextField();

        jLabel4.setText("SUBTOTAL:");

        jTextField1.setText("jTextField1");

        setClosable(true);
        setIconifiable(true);
        setMaximizable(true);
        setResizable(true);
        setTitle("REGISTRAR VENTA");

        jPanel1.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        TablaDetalle.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "NUM", "CODBARRAS", "IDVENTA", "CANTIDAD", "PRECIO UNIT", "TOTAL"
            }
        ));
        jScrollPane1.setViewportView(TablaDetalle);

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addComponent(jScrollPane1)
                .addContainerGap())
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 53, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(41, Short.MAX_VALUE))
        );

        btnBuscar.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        jLabel1.setText("CODBARRAS:");

        jLabel2.setText("PRECIO-VENTA:");

        jLabel5.setText("IDVENTAS:");

        txtId.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtIdActionPerformed(evt);
            }
        });

        txtCodProd.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtCodProdActionPerformed(evt);
            }
        });

        btnagregar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Img/add.png"))); // NOI18N
        btnagregar.setText("ADD");
        btnagregar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnagregarActionPerformed(evt);
            }
        });

        btnEliminar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Img/cancelar.png"))); // NOI18N
        btnEliminar.setText("Eliminar");

        jLabel7.setText("CANTIDAD:");

        btnc.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Img/add.png"))); // NOI18N
        btnc.setText("Buscar");
        btnc.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btncActionPerformed(evt);
            }
        });

        jLabel8.setText("STOCK:");

        btnv.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Img/add.png"))); // NOI18N
        btnv.setText("Buscar");
        btnv.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnvActionPerformed(evt);
            }
        });

        txtStock.setEditable(false);
        txtStock.setBackground(new java.awt.Color(204, 204, 255));
        txtStock.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtStockActionPerformed(evt);
            }
        });

        jLabel9.setText("FECHA");

        txtIDV.setEditable(false);
        txtIDV.setBackground(new java.awt.Color(204, 204, 255));
        txtIDV.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtIDVActionPerformed(evt);
            }
        });

        txtPrecio.setEditable(false);
        txtPrecio.setBackground(new java.awt.Color(204, 204, 255));
        txtPrecio.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtPrecioActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout btnBuscarLayout = new javax.swing.GroupLayout(btnBuscar);
        btnBuscar.setLayout(btnBuscarLayout);
        btnBuscarLayout.setHorizontalGroup(
            btnBuscarLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(btnBuscarLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(btnBuscarLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(btnBuscarLayout.createSequentialGroup()
                        .addGroup(btnBuscarLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addGroup(btnBuscarLayout.createSequentialGroup()
                                .addGroup(btnBuscarLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(jLabel5)
                                    .addComponent(jLabel1))
                                .addGap(25, 25, 25)
                                .addGroup(btnBuscarLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(txtCodProd, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 93, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addComponent(txtId, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 93, javax.swing.GroupLayout.PREFERRED_SIZE)))
                            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, btnBuscarLayout.createSequentialGroup()
                                .addComponent(jLabel2)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addGroup(btnBuscarLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                    .addComponent(txtPrecio, javax.swing.GroupLayout.DEFAULT_SIZE, 93, Short.MAX_VALUE)
                                    .addComponent(txtCantidad))))
                        .addGap(18, 18, 18)
                        .addGroup(btnBuscarLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addGroup(btnBuscarLayout.createSequentialGroup()
                                .addComponent(btnc)
                                .addGap(18, 18, 18)
                                .addComponent(jLabel8)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(txtStock, javax.swing.GroupLayout.PREFERRED_SIZE, 93, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(btnBuscarLayout.createSequentialGroup()
                                .addComponent(btnv)
                                .addGap(18, 18, 18)
                                .addComponent(jLabel9)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(txtIDV, javax.swing.GroupLayout.PREFERRED_SIZE, 93, javax.swing.GroupLayout.PREFERRED_SIZE))))
                    .addGroup(btnBuscarLayout.createSequentialGroup()
                        .addComponent(jLabel7)
                        .addGap(281, 281, 281)
                        .addComponent(btnagregar)
                        .addGap(26, 26, 26)
                        .addComponent(btnEliminar)))
                .addContainerGap(77, Short.MAX_VALUE))
        );
        btnBuscarLayout.setVerticalGroup(
            btnBuscarLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(btnBuscarLayout.createSequentialGroup()
                .addGap(29, 29, 29)
                .addGroup(btnBuscarLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(txtId, javax.swing.GroupLayout.PREFERRED_SIZE, 29, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(btnv)
                    .addComponent(jLabel5, javax.swing.GroupLayout.PREFERRED_SIZE, 22, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel9, javax.swing.GroupLayout.PREFERRED_SIZE, 22, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(txtIDV, javax.swing.GroupLayout.PREFERRED_SIZE, 29, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGroup(btnBuscarLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(btnBuscarLayout.createSequentialGroup()
                        .addGap(25, 25, 25)
                        .addGroup(btnBuscarLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(txtCodProd, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(btnc)
                            .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 22, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel8, javax.swing.GroupLayout.PREFERRED_SIZE, 22, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(18, 18, 18)
                        .addGroup(btnBuscarLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 22, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(txtPrecio, javax.swing.GroupLayout.PREFERRED_SIZE, 29, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(18, 18, 18)
                        .addGroup(btnBuscarLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel7, javax.swing.GroupLayout.PREFERRED_SIZE, 22, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(txtCantidad, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addContainerGap(73, Short.MAX_VALUE))
                    .addGroup(btnBuscarLayout.createSequentialGroup()
                        .addGap(36, 36, 36)
                        .addComponent(txtStock, javax.swing.GroupLayout.PREFERRED_SIZE, 29, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addGroup(btnBuscarLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(btnEliminar, javax.swing.GroupLayout.PREFERRED_SIZE, 25, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(btnagregar))
                        .addContainerGap())))
        );

        jPanel4.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        btnGV.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Img/calcular.png"))); // NOI18N
        btnGV.setText("GENERAR VENTA");
        btnGV.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnGVActionPerformed(evt);
            }
        });

        btnTOTAL.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Img/money.png"))); // NOI18N
        btnTOTAL.setText("TOTAL A PAGAR");
        btnTOTAL.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnTOTALActionPerformed(evt);
            }
        });

        txtTotalPagar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtTotalPagarActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addGap(129, 129, 129)
                .addComponent(btnGV)
                .addGap(31, 31, 31)
                .addComponent(btnTOTAL)
                .addGap(18, 18, 18)
                .addComponent(txtTotalPagar, javax.swing.GroupLayout.PREFERRED_SIZE, 93, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(btnGV)
                    .addComponent(btnTOTAL)
                    .addComponent(txtTotalPagar, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap())
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addComponent(btnBuscar, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addContainerGap())
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jPanel4, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(18, 18, 18))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(btnBuscar, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 21, Short.MAX_VALUE)
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(35, 35, 35))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void txtIdActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtIdActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtIdActionPerformed

    private void txtTotalPagarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtTotalPagarActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtTotalPagarActionPerformed

    private void txtCodProdActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtCodProdActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtCodProdActionPerformed

    private void btnGVActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnGVActionPerformed
        add();
        /*
        if (txtTotalPagar.getText().equals("")) {
            JOptionPane.showMessageDialog(this, "Debe ingresar Datos");
        } else {
            add();
            actualizarStock();            
            JOptionPane.showMessageDialog(this, "Se Realizo con Exito");
            nuevo();
            
        }*/
    }//GEN-LAST:event_btnGVActionPerformed

    private void txtStockActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtStockActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtStockActionPerformed

    private void txtIDVActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtIDVActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtIDVActionPerformed

    private void btnTOTALActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnTOTALActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_btnTOTALActionPerformed

    private void txtPrecioActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtPrecioActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtPrecioActionPerformed

    private void btnvActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnvActionPerformed
        buscarIdVenta();
    }//GEN-LAST:event_btnvActionPerformed

    private void btncActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btncActionPerformed
        buscarProducto();
    }//GEN-LAST:event_btncActionPerformed

    private void btnagregarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnagregarActionPerformed
        agregarProducto();
    }//GEN-LAST:event_btnagregarActionPerformed

    //Metodo agregar 2
     void add() {
         
       
        int cb = Integer.parseInt(txtCodProd.getText());
        int idventa = Integer.parseInt(txtId.getText());
        int pre = Integer.parseInt(txtPrecio.getText());
        int can = Integer.parseInt(txtCantidad.getText());
        T = Double.parseDouble(txtTotalPagar.getText());
        //OrdenarBien
        
        Object[] ob = new Object[5];
        ob[0] = cb;
        ob[1] = idventa;
        ob[2] =pre;
        ob[3] = can;
        ob[4] = T;
        vdao.add(ob);
        
    }
       
    
       void eliminar() {
         
        int fila = TablaDetalle.getSelectedRow();       
        if (fila == -1) {
            JOptionPane.showMessageDialog(this, "Debe seleccionar una Fila");
        } else {
            pdao.eliminar(id);
        }
    }
    
    
    void actualizarStock() {
        for (int i = 0; i < modelo.getRowCount(); i++) {
            Inv pr = new Inv();
            idp = Integer.parseInt(TablaDetalle.getValueAt(i, 1).toString());
            cant = Integer.parseInt(TablaDetalle.getValueAt(i, 3).toString());
            pr= ind.listarID(idp);
            int sa = pr.getStock() - cant;
            ind.actualizarStock(sa, idp);
        }
    }
    
    void nuevo(){ // Para limpiar las cajas de texto
        limpiarTabla();// Limpiamos la tabla
        
        
        
        txtIDV.setText("");
        
        txtCodProd.setText("");
        txtPrecio.setText("");
        txtStock.setText("");
        txtTotalPagar.setText("");
        txtIDV.requestFocus();
    }
    void limpiarTabla(){
        for (int i = 0; i < modelo.getRowCount(); i++) {
            modelo.removeRow(i);
            i=i-1;
        }
    }
    
    void buscarIdVenta() {
        int id = Integer.parseInt(txtId.getText());
        if (txtId.getText().equals("")) {
            JOptionPane.showMessageDialog(this, "Debe ingresar el IdVenta");
        } else {
            ven  = vo.listarID(id);
            if (ven .getVn() != 0) {//p=proveedor 
                txtIDV.setText(ven.getFeha());
                
            } else {
                JOptionPane.showMessageDialog(this, "IdVenta No registrado");
                txtId.requestFocus();
            }
        }
    }

 void buscarProducto() {
        int id = Integer.parseInt(txtCodProd.getText());
        if (txtCodProd.getText().equals("")) {
            JOptionPane.showMessageDialog(this, "Debe ingresar el codproducto");
        } else {
            p = ind.listarID(id);
            if (p.getIdc() != 0) {
                
                txtPrecio.setText("" + p.getPc());
                txtStock.setText("" + p.getStock());
            } else {
                JOptionPane.showMessageDialog(this, "Producto no registrado");
                txtCodProd.requestFocus();
            }
        }
    }

       void agregarProducto() {
        double total;
        modelo = (DefaultTableModel) TablaDetalle.getModel();
        item = item + 1; //Es el contador de la tabla numero
        idp = p.getCod();
        
        String nomp = txtCodProd.getText();
        pre = Double.parseDouble(txtPrecio.getText());
        cant = Integer.parseInt(txtCantidad.getText());
        int stock = Integer.parseInt(txtStock.getText());
        
        total = cant * pre;
        ArrayList lista = new ArrayList();
        if (stock > 0) {
            lista.add(item);//Agrega al numero
            lista.add(idp);//Agreag id producto
            lista.add(nomp);//Agrega el nombre del produto
            lista.add(cant);//Agrega a la cantidad
            lista.add(pre);//Agrega al precio
            lista.add(total);//Agrega al total
            
            Object[] ob = new Object[6];
            ob[0] = lista.get(0);
            ob[1] = lista.get(1);
            ob[2] = lista.get(2);
            ob[3] = lista.get(3);
            ob[4] = lista.get(4);
            ob[5] = lista.get(5);
            modelo.addRow(ob);
            TablaDetalle.setModel(modelo);
            calculatTotal();
        } else {
            JOptionPane.showMessageDialog(this, "Stock PRoducto no Disponible");
        }
    }
       
        void calculatTotal() {
        tpagar = 0;
        for (int i = 0; i < TablaDetalle.getRowCount(); i++) {
            cant = Integer.parseInt(TablaDetalle.getValueAt(i, 3).toString());
            pre = Double.parseDouble(TablaDetalle.getValueAt(i, 4).toString());
            tpagar = tpagar + (cant * pre);
        }
        txtTotalPagar.setText("" + tpagar + "0");
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JTable TablaDetalle;
    private javax.swing.JPanel btnBuscar;
    private javax.swing.JButton btnEliminar;
    private javax.swing.JButton btnGV;
    private javax.swing.JButton btnTOTAL;
    private javax.swing.JButton btnagregar;
    private javax.swing.JButton btnc;
    private javax.swing.JButton btnv;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTextField jTextField1;
    private javax.swing.JTextField txtCantidad;
    private javax.swing.JTextField txtCodProd;
    private javax.swing.JTextField txtIDV;
    private javax.swing.JTextField txtId;
    private javax.swing.JTextField txtPrecio;
    private javax.swing.JTextField txtStock;
    private javax.swing.JTextField txtTotalPagar;
    // End of variables declaration//GEN-END:variables
}
