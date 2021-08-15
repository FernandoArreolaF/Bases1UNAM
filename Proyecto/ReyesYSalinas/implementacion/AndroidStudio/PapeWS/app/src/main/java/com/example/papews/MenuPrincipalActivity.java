package com.example.papews;

import android.content.DialogInterface;
import android.content.Intent;
import android.media.MediaPlayer;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;


import androidx.annotation.Nullable;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

public class MenuPrincipalActivity extends AppCompatActivity {

    private Button btnProducto;
    private Button btnProveedor;
    private Button btnCliente;
    private Button btnVenta;
    private Button btnCreditos;
    MediaPlayer cancion;


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_menu_principal);


        cancion = MediaPlayer.create(this, R.raw.cancioncompra);

        btnProducto = findViewById(R.id.btnProducto);
        btnProveedor = findViewById(R.id.btnProveedor);
        btnCliente = findViewById(R.id.btnCliente);
        btnVenta = findViewById(R.id.btnVenta);
        btnCreditos = findViewById(R.id.btnCreditos);



        btnCreditos.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(MenuPrincipalActivity.this, PopupCreditosActivity.class));
            }
        });
        btnCreditos.setOnLongClickListener(new View.OnLongClickListener() {
            @Override
            public boolean onLongClick(View view) {
                if(cancion.isPlaying()){
                    cancion.pause();
                }else{
                    cancion.start();
                }
                return false;
            }
        });


        btnProducto.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                irActivityOperacionesProducto();
            }
        });

        btnProveedor.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                irActivityOperacionesProveedor();
            }
        });

        btnCliente.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                irActivityOperacionesCliente();
            }
        });

        btnVenta.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                irActivityOperacionesVenta();
            }
        });
    }

    private void irActivityOperacionesProducto(){
        Intent intent = new Intent(this, MenuProducto.class);
        startActivity(intent);
    }

    private void irActivityOperacionesCliente(){
        Intent intent = new Intent(this, MenuClienteActivity.class);
        startActivity(intent);
    }

    private void irActivityOperacionesProveedor(){
        Intent intent = new Intent(this, MenuProveedorActivity.class);
        startActivity(intent);
    }

    private void irActivityOperacionesVenta(){
        Intent intent = new Intent(this, MenuVentaActivity.class);
        startActivity(intent);
    }
}
