package com.example.papews;

import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.androidnetworking.AndroidNetworking;
import com.androidnetworking.common.Priority;
import com.androidnetworking.error.ANError;
import com.androidnetworking.interfaces.JSONObjectRequestListener;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class OperacionesTelefonoActivity extends AppCompatActivity {

    private EditText edtTelefono;
    private EditText edtRazonSP;
    private EditText edtNuevoTel;

    private Button btnInsertarTel;
    private Button btnActualizarTel;
    private Button btnBorrarTel;
    private Button btnConsultaTel;

    private ListView lvTelefono;
    private ArrayAdapter<String> adapter;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_telefono_proveedor);
        AndroidNetworking.initialize(getApplicationContext());

        edtTelefono = findViewById(R.id.edtTelefono);
        edtRazonSP = findViewById(R.id.edtRazonSP);
        edtNuevoTel = findViewById(R.id.edtNuevoTel);

        btnInsertarTel = findViewById(R.id.btnInsertarTel);
        btnActualizarTel = findViewById(R.id.btnActualizarTel);
        btnBorrarTel = findViewById(R.id.btnBorrarTel);
        btnConsultaTel = findViewById(R.id.btnConsultaTel);

        lvTelefono = findViewById(R.id.lvTelefono);
        adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1);

        btnInsertarTel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                guardarTelefono();
            }
        });

        btnActualizarTel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                actualizarTelefono();
            }
        });

        btnBorrarTel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                eliminarTelefono();
            }
        });

        btnConsultaTel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                adapter.clear();
                consultaTelefono();
            }
        });
    }

    private void guardarTelefono(){
        if(isValidarCampos()){
            String telefono = edtTelefono.getText().toString();
            String razonsocial = edtRazonSP.getText().toString();

            Map<String,String> datos = new HashMap<>();
            datos.put("TELL",telefono);
            datos.put("RAZONSOCIAL",razonsocial);

            JSONObject jsonData = new JSONObject(datos);
            AndroidNetworking.post(Constantes.URL_INSERTAR_TELEFONO)
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
                                Toast.makeText(OperacionesTelefonoActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(OperacionesTelefonoActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(OperacionesTelefonoActivity.this, "Error"+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }
    }

    private void actualizarTelefono(){
        if(isValidarCampos()){
            String razonsocial = edtRazonSP.getText().toString();
            String telefono1 = edtTelefono.getText().toString();
            String telefono2 = edtNuevoTel.getText().toString();


            Map<String,String> datos = new HashMap<>();
            datos.put("RAZONSOCIAL",razonsocial);
            datos.put("TELL1",telefono1);
            datos.put("TELL2", telefono2);


            JSONObject jsonData = new JSONObject(datos);
            AndroidNetworking.post(Constantes.URL_ACTUALIZAR_TELEFONO)
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
                                Toast.makeText(OperacionesTelefonoActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(OperacionesTelefonoActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(OperacionesTelefonoActivity.this, "Error"+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }
    }

    private void eliminarTelefono(){
        if(isValidarCamposEliminar()){
            String telefono = edtTelefono.getText().toString();

            Map<String,String> datos = new HashMap<>();
            datos.put("TELL",telefono);
            AndroidNetworking.post(Constantes.URL_ELIMINAR_TELEFONO)
                    .addJSONObjectBody(new JSONObject(datos))
                    .setPriority(Priority.MEDIUM)
                    .build()
                    .getAsJSONObject(new JSONObjectRequestListener() {
                        @Override
                        public void onResponse(JSONObject response) {
                            try {
                                String estado = response.getString("estado");
                                String error = response.getString("error");
                                Toast.makeText(OperacionesTelefonoActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(OperacionesTelefonoActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(OperacionesTelefonoActivity.this, "Error: "+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }else{
            Toast.makeText(this, "Necesito el telefono", Toast.LENGTH_SHORT).show();
        }
    }

    private void consultaTelefono(){
        if(isValidarCamposConsulta()){


            lvTelefono.setAdapter(adapter);
            String razonsocial = edtRazonSP.getText().toString();

            //Map<String,String> datos = new HashMap<>();
            //datos.put("RFC",rfc);
            //JSONObject jsonData = new JSONObject(datos);
            AndroidNetworking.get(Constantes.URL_LISTAR_TELEFONO)
                    .addPathParameter("RAZONSOCIAL",razonsocial)
                    .setPriority(Priority.MEDIUM)
                    .build()
                    .getAsJSONObject(new JSONObjectRequestListener() {
                        @Override
                        public void onResponse(JSONObject response) {
                            try {
                                String respuesta = response.getString("respuesta");
                                if(respuesta.equals("200")){
                                    JSONArray arrayTelefono = response.getJSONArray("data");
                                    for(int i=0;i<arrayTelefono.length();i++){
                                        JSONObject jsonTelefono= arrayTelefono.getJSONObject(i);
                                        String tell = "Telefono: "+jsonTelefono.getString("tell");

                                        String dataString = tell + "\n";
                                        adapter.add(dataString);
                                    }
                                    adapter.notifyDataSetChanged();
                                }else{
                                    Toast.makeText(OperacionesTelefonoActivity.this, "No hay telefonos disponibles", Toast.LENGTH_SHORT).show();
                                }
                            } catch (JSONException e) {
                                Toast.makeText(OperacionesTelefonoActivity.this, "Error: "+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(OperacionesTelefonoActivity.this, "Error: "+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });

        }else{
            Toast.makeText(this, "Necesito la Razon Social", Toast.LENGTH_SHORT).show();
        }
    }

    private boolean isValidarCampos(){
        return !edtTelefono.getText().toString().trim().isEmpty() &&
                !edtRazonSP.getText().toString().trim().isEmpty();

    }
    private boolean isValidarCamposEliminar(){
        return !edtTelefono.getText().toString().trim().isEmpty();

    }

    private boolean isValidarCamposConsulta(){
        return !edtRazonSP.getText().toString().trim().isEmpty();

    }
}
