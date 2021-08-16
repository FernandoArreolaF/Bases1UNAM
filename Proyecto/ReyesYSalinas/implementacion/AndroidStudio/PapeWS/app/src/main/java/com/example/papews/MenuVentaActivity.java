package com.example.papews;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

public class MenuVentaActivity extends AppCompatActivity {

    private Button btnListarVentas;
    private Button btnCrearVenta;
    private Button btnGanancias;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_menu_venta);

        btnListarVentas = findViewById(R.id.btnListarVentas);
        btnCrearVenta = findViewById(R.id.btnCrearVenta);
        btnGanancias = findViewById(R.id.btnGanancias);

        btnListarVentas.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                irActivityListarVentas();
            }
        });

        btnCrearVenta.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                irActivityCrearVenta();
            }
        });

        btnGanancias.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                irActivityCalcularG();
            }
        });
    }

    private void irActivityListarVentas(){
        Intent intent = new Intent(this, ListarEliminarVentaActivity.class);
        startActivity(intent);
    }

    private void irActivityCalcularG(){
        Intent intent = new Intent(this, GananciasActivity.class);
        startActivity(intent);
    }

    private void irActivityCrearVenta(){
        Intent intent = new Intent(this, ListarProductosActivity.class);
        startActivity(intent);
    }
}
