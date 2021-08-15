package com.example.papews;

import android.os.Bundle;
import android.util.DisplayMetrics;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.androidnetworking.AndroidNetworking;



public class PopupCreditosActivity extends AppCompatActivity {

    public TextView txtCreditos;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.popup_creditos);
        txtCreditos = findViewById(R.id.txtCreditos);
        AndroidNetworking.initialize(getApplicationContext());

        DisplayMetrics medidaVentana = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(medidaVentana);

        int ancho = medidaVentana.widthPixels;
        int alto = medidaVentana.heightPixels;

        getWindow().setLayout((int)(ancho * 0.85), (int)(alto * 0.4));
        txtCreditos.setText("Proyectazo Base de Datos by:\n-Salinas Romero Daniel\n-Reyes Avila David\nProfesor: Fernando Arreola.\nAgradecimientos especiales a don rata");
    }
}
