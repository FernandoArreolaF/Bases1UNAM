package com.example.papews;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.androidnetworking.AndroidNetworking;
import com.androidnetworking.common.Priority;
import com.androidnetworking.error.ANError;
import com.androidnetworking.interfaces.JSONObjectRequestListener;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class GuardarActualizarProveedorActivity extends AppCompatActivity {

    private EditText edtRazonSocial;
    private EditText edtPnombrep;
    private EditText edtApellidopp;
    private EditText edtApellidomp;
    private EditText edtCallep;
    private EditText edtColoniap;
    private EditText edtCpp;
    private EditText edtNumerocallep;
    private EditText edtEstadop;

    private Button btnGuardarProv;
    private Button btnActualizarProv;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_insertar_actualizar_proveedor);
        AndroidNetworking.initialize(getApplicationContext());

        edtRazonSocial = findViewById(R.id.edtRazonSocial);
        edtPnombrep = findViewById(R.id.edtPnombrep);
        edtApellidopp = findViewById(R.id.edtApellidopp);
        edtApellidomp = findViewById(R.id.edtApellidomp);
        edtCallep = findViewById(R.id.edtCallep);
        edtColoniap = findViewById(R.id.edtColoniap);
        edtCpp = findViewById(R.id.edtCpp);
        edtNumerocallep = findViewById(R.id.edtNumerocallep);
        edtEstadop = findViewById(R.id.edtEstadop);

        btnGuardarProv = findViewById(R.id.btnGuardarProv);
        btnActualizarProv = findViewById(R.id.btnActualizarProv);

        btnGuardarProv.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                guardarProveedor();
            }
        });

        btnActualizarProv.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                actualizarProveedor();
            }
        });
    }

    private void guardarProveedor(){
        if(isValidarCampos()){
            String razonsocial = edtRazonSocial.getText().toString();
            String nombre = edtPnombrep.getText().toString();
            String apellidop = edtApellidopp.getText().toString();
            String apellidom = edtApellidomp.getText().toString();
            String calle = edtCallep.getText().toString();
            String colonia = edtColoniap.getText().toString();
            String cp = edtCpp.getText().toString();
            String numerocalle = edtNumerocallep.getText().toString();
            String estado = edtEstadop.getText().toString();

            Map<String,String> datos = new HashMap<>();
            datos.put("RAZONSOCIAL",razonsocial);
            datos.put("PNOMBREP",nombre);
            datos.put("APELLIDOPP",apellidop);
            datos.put("APELLIDOMP",apellidom);
            datos.put("CALLEP",calle);
            datos.put("COLONIAP",colonia);
            datos.put("CPP",cp);
            datos.put("NUMEROCALLEP",numerocalle);
            datos.put("ESTADOP",estado);

            JSONObject jsonData = new JSONObject(datos);
            AndroidNetworking.post(Constantes.URL_INSERTAR_PROVEEDOR)
                    .addJSONObjectBody(jsonData)
                    .setPriority(Priority.MEDIUM)
                    .build()
                    .getAsJSONObject(new JSONObjectRequestListener() {
                        @Override
                        public void onResponse(JSONObject response) {
                            try {
                                String estado = response.getString("estado");
                                String error = response.getString("error");
                                //Toast.makeText(MainActivity.this, estado, Toast.LENGTH_SHORT).show();
                                Toast.makeText(GuardarActualizarProveedorActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(GuardarActualizarProveedorActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(GuardarActualizarProveedorActivity.this, "Error"+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }
    }

    private void actualizarProveedor(){
        if(isValidarCampos()){
            String razonsocial = edtRazonSocial.getText().toString();
            String nombre = edtPnombrep.getText().toString();
            String apellidop = edtApellidopp.getText().toString();
            String apellidom = edtApellidomp.getText().toString();
            String calle = edtCallep.getText().toString();
            String colonia = edtColoniap.getText().toString();
            String cp = edtCpp.getText().toString();
            String numerocalle = edtNumerocallep.getText().toString();
            String estado = edtEstadop.getText().toString();

            Map<String,String> datos = new HashMap<>();
            datos.put("RAZONSOCIAL",razonsocial);
            datos.put("PNOMBREP",nombre);
            datos.put("APELLIDOPP",apellidop);
            datos.put("APELLIDOMP",apellidom);
            datos.put("CALLEP",calle);
            datos.put("COLONIAP",colonia);
            datos.put("CPP",cp);
            datos.put("NUMEROCALLEP",numerocalle);
            datos.put("ESTADOP",estado);

            JSONObject jsonData = new JSONObject(datos);
            AndroidNetworking.post(Constantes.URL_ACTUALIZAR_PROVEEDOR)
                    .addJSONObjectBody(jsonData)
                    .setPriority(Priority.MEDIUM)
                    .build()
                    .getAsJSONObject(new JSONObjectRequestListener() {
                        @Override
                        public void onResponse(JSONObject response) {
                            try {
                                String estado = response.getString("estado");
                                String error = response.getString("error");
                                //Toast.makeText(MainActivity.this, estado, Toast.LENGTH_SHORT).show();
                                Toast.makeText(GuardarActualizarProveedorActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(GuardarActualizarProveedorActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(GuardarActualizarProveedorActivity.this, "Error"+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }
    }

    //de momento que todos los campos de proveedor se rellenen
    private boolean isValidarCampos(){
        return !edtRazonSocial.getText().toString().trim().isEmpty() &&
                !edtPnombrep.getText().toString().trim().isEmpty() &&
                !edtApellidopp.getText().toString().trim().isEmpty() &&
                !edtApellidomp.getText().toString().trim().isEmpty() &&
                !edtCallep.getText().toString().trim().isEmpty() &&
                !edtColoniap.getText().toString().trim().isEmpty() &&
                !edtCpp.getText().toString().trim().isEmpty() &&
                !edtNumerocallep.getText().toString().trim().isEmpty() &&
                !edtEstadop.getText().toString().trim().isEmpty();

    }
}
