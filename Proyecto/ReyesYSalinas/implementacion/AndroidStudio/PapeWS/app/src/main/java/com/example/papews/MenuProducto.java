package com.example.papews;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

public class MenuProducto extends AppCompatActivity {

    private Button btnInsertarProducto;
    private Button btnActualizarProducto;
    private Button btnBorrarProducto;
    private Button btnListarProducto;

    @Override
    protected void onCreate(@Nullable  Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_menu);
        btnInsertarProducto = findViewById(R.id.btnInsertarProducto);
        btnActualizarProducto = findViewById(R.id.btnActualizarProducto);
        btnBorrarProducto = findViewById(R.id.btnBorrarProducto);
        btnListarProducto = findViewById(R.id.btnListarProducto);

        btnInsertarProducto.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                irActivityInsertarProducto();
            }
        });

        btnActualizarProducto.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                irActivityActualizarProducto();
            }
        });

        btnBorrarProducto.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                irActivityEliminarProducto();
            }
        });

        btnListarProducto.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                irActivityListarProducto();
            }
        });
    }

    private void irActivityInsertarProducto(){
        Intent intent = new Intent(this, MainActivity.class);
        startActivity(intent);
    }

    private void irActivityActualizarProducto(){
        Intent intent = new Intent(this, ActualizarProductoActivity.class);
        startActivity(intent);
    }

    private void irActivityEliminarProducto(){
        Intent intent = new Intent(this, EliminarProductoActivity.class);
        startActivity(intent);
    }

    private void irActivityListarProducto(){
        Intent intent = new Intent(this, ListarProductosActivity.class);
        startActivity(intent);
    }
}
