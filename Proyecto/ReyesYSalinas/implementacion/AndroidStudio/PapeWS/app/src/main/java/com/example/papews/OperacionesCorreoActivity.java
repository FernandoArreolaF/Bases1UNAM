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

public class OperacionesCorreoActivity extends AppCompatActivity {

    private EditText edtCorreoC;
    private EditText edtRfcC;
    private EditText edtNuevoCorreo;

    private Button btnInsertarCorreo;
    private Button btnActualizarCorreo;
    private Button btnBorrarCorreo;
    private Button btnConsultaC;

    private ListView lvCorreo;
    private ArrayAdapter<String> adapter;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_correo_cliente);
        AndroidNetworking.initialize(getApplicationContext());

        edtCorreoC = findViewById(R.id.edtCorreoC);
        edtRfcC = findViewById(R.id.edtRfcC);
        edtNuevoCorreo = findViewById(R.id.edtNuevoCorreo);

        btnInsertarCorreo = findViewById(R.id.btnInsertarCorreo);
        btnActualizarCorreo = findViewById(R.id.btnActualizarCorreo);
        btnBorrarCorreo = findViewById(R.id.btnBorrarCorreo);
        btnConsultaC = findViewById(R.id.btnConsultaC);

        lvCorreo = findViewById(R.id.lvCorreo);
        adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1);


        btnInsertarCorreo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                guardarCorreo();
            }
        });

        btnActualizarCorreo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                actualizarCorreo();
            }
        });

        btnBorrarCorreo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                eliminarCorreo();
            }
        });

        btnConsultaC.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                adapter.clear();
                consultaCorreo();
            }
        });


    }

    private void guardarCorreo(){
        if(isValidarCampos()){
            String correo = edtCorreoC.getText().toString();
            String rfc = edtRfcC.getText().toString();

            Map<String,String> datos = new HashMap<>();
            datos.put("CORREO",correo);
            datos.put("RFC",rfc);

            JSONObject jsonData = new JSONObject(datos);
            AndroidNetworking.post(Constantes.URL_INSERTAR_CORREO)
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
                                Toast.makeText(OperacionesCorreoActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(OperacionesCorreoActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(OperacionesCorreoActivity.this, "Error"+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }
    }

    private void actualizarCorreo(){
        if(isValidarCampos()){
            String rfc = edtRfcC.getText().toString();
            String correo1 = edtCorreoC.getText().toString();
            String correo2 = edtNuevoCorreo.getText().toString();


            Map<String,String> datos = new HashMap<>();
            datos.put("RFC",rfc);
            datos.put("CORREO1", correo1);
            datos.put("CORREO2", correo2);


            JSONObject jsonData = new JSONObject(datos);
            AndroidNetworking.post(Constantes.URL_ACTUALIZAR_CORREO)
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
                                Toast.makeText(OperacionesCorreoActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(OperacionesCorreoActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(OperacionesCorreoActivity.this, "Error"+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }
    }

    private void eliminarCorreo(){
        if(isValidarCamposEliminar()){
            String correo = edtCorreoC.getText().toString();

            Map<String,String> datos = new HashMap<>();
            datos.put("CORREO",correo);
            AndroidNetworking.post(Constantes.URL_ELIMINAR_CORREO)
                    .addJSONObjectBody(new JSONObject(datos))
                    .setPriority(Priority.MEDIUM)
                    .build()
                    .getAsJSONObject(new JSONObjectRequestListener() {
                        @Override
                        public void onResponse(JSONObject response) {
                            try {
                                String estado = response.getString("estado");
                                String error = response.getString("error");
                                Toast.makeText(OperacionesCorreoActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(OperacionesCorreoActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(OperacionesCorreoActivity.this, "Error: "+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }else{
            Toast.makeText(this, "Necesito el correo", Toast.LENGTH_SHORT).show();
        }
    }

    private void consultaCorreo(){
        if(isValidarCamposConsulta()){


            lvCorreo.setAdapter(adapter);
            String rfc = edtRfcC.getText().toString();

            //Map<String,String> datos = new HashMap<>();
            //datos.put("RFC",rfc);
            //JSONObject jsonData = new JSONObject(datos);
            AndroidNetworking.get(Constantes.URL_LISTAR_CORREO)
                    .addPathParameter("RFC",rfc)
                    .setPriority(Priority.MEDIUM)
                    .build()
                    .getAsJSONObject(new JSONObjectRequestListener() {
                        @Override
                        public void onResponse(JSONObject response) {
                            try {
                                String respuesta = response.getString("respuesta");
                                if(respuesta.equals("200")){
                                    JSONArray arrayCorreo = response.getJSONArray("data");
                                    for(int i=0;i<arrayCorreo.length();i++){
                                        JSONObject jsonCorreo= arrayCorreo.getJSONObject(i);
                                        String correo = "Correo: "+jsonCorreo.getString("correo");

                                        String dataString = correo + "\n";
                                        adapter.add(dataString);
                                    }
                                    adapter.notifyDataSetChanged();
                                }else{
                                    Toast.makeText(OperacionesCorreoActivity.this, "No hay correos disponibles", Toast.LENGTH_SHORT).show();
                                }
                            } catch (JSONException e) {
                                Toast.makeText(OperacionesCorreoActivity.this, "Error: "+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(OperacionesCorreoActivity.this, "Error: "+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });

        }else{
            Toast.makeText(this, "Necesito el RFC", Toast.LENGTH_SHORT).show();
        }
    }

    private boolean isValidarCampos(){
        return !edtCorreoC.getText().toString().trim().isEmpty() &&
                !edtRfcC.getText().toString().trim().isEmpty();

    }
    private boolean isValidarCamposEliminar(){
        return !edtCorreoC.getText().toString().trim().isEmpty();

    }

    private boolean isValidarCamposConsulta(){
        return !edtRfcC.getText().toString().trim().isEmpty();

    }
}
