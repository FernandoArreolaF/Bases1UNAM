package com.example.papews;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

public class MenuClienteActivity extends AppCompatActivity {

    private Button btnInsertarCliente;
    private Button btnCorreo;
    private Button btnBorrarCliente;
    private Button btnListarCliente;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_menu_cliente);

        btnInsertarCliente = findViewById(R.id.btnInsertarCliente);
        btnCorreo = findViewById(R.id.btnCorreo);
        btnBorrarCliente = findViewById(R.id.btnBorrarCliente);
        btnListarCliente = findViewById(R.id.btnListarCliente);

        btnInsertarCliente.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                irActivityInsertarActualizarCliente();
            }
        });

        btnCorreo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                irActivityCorreo();
            }
        });

        btnBorrarCliente.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                irActivityBorrarCliente();
            }
        });

        btnListarCliente.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                irActivityListarCliente();
            }
        });
    }

    private void irActivityInsertarActualizarCliente(){
        Intent intent = new Intent(this, GuardarActualizarClienteActivity.class);
        startActivity(intent);
    }

    private void irActivityBorrarCliente(){
        Intent intent = new Intent(this, EliminarClienteActivity.class);
        startActivity(intent);
    }

    private void irActivityListarCliente(){
        Intent intent = new Intent(this, ListarClientesActivity.class);
        startActivity(intent);
    }

    private void irActivityCorreo(){
        Intent intent = new Intent(this, OperacionesCorreoActivity.class);
        startActivity(intent);
    }
}
