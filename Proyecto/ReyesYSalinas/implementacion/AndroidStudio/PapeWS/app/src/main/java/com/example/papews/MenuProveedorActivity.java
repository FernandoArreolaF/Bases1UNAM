package com.example.papews;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

public class MenuProveedorActivity extends AppCompatActivity {

    private Button btnInsertarProveedor;
    private Button btnBorrarProveedor;
    private Button btnTelefono;
    private Button btnListarProveedor;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_menu_proveedor);

        btnInsertarProveedor = findViewById(R.id.btnInsertarProveedor);
        btnBorrarProveedor = findViewById(R.id.btnBorrarProveedor);
        btnTelefono = findViewById(R.id.btnTelefono);
        btnListarProveedor = findViewById(R.id.btnListarProveedor);

        btnInsertarProveedor.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                irActivityGuardarActualizarProveedor();
            }
        });

        btnBorrarProveedor.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                irActivityEliminarProveedor();
            }
        });

        btnTelefono.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                irActivityTelefonoProveedor();
            }
        });

        btnListarProveedor.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                irActivityListarProveedor();
            }
        });
    }

    private void irActivityGuardarActualizarProveedor(){
        Intent intent = new Intent(this, GuardarActualizarProveedorActivity.class);
        startActivity(intent);
    }

    private void irActivityEliminarProveedor(){
        Intent intent = new Intent(this, EliminarProveedorActivity.class);
        startActivity(intent);
    }

    private void irActivityListarProveedor(){
        Intent intent = new Intent(this, ListarProveedoresActivity.class);
        startActivity(intent);
    }

    private void irActivityTelefonoProveedor(){
        Intent intent = new Intent(this, OperacionesTelefonoActivity.class);
        startActivity(intent);
    }
}
