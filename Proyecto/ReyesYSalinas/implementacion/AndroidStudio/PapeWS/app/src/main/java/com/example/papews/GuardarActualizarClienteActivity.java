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

public class GuardarActualizarClienteActivity extends AppCompatActivity {

    private EditText edtRfc;
    private EditText edtPnombrec;
    private EditText edtApellidopc;
    private EditText edtApellidomc;
    private EditText edtCallec;
    private EditText edtColoniac;
    private EditText edtCpc;
    private EditText edtNumerocallec;
    private EditText edtEstadoc;
    private EditText edtCorreoCliente;

    private Button btnGuardarC;
    private Button btnActualizarC;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_insertar_actualizar_cliente);
        AndroidNetworking.initialize(getApplicationContext());

        edtRfc = findViewById(R.id.edtRfc);
        edtPnombrec = findViewById(R.id.edtPnombrec);
        edtApellidopc = findViewById(R.id.edtApellidopc);
        edtApellidomc = findViewById(R.id.edtApellidomc);
        edtCallec = findViewById(R.id.edtCallec);
        edtColoniac = findViewById(R.id.edtColoniac);
        edtCpc = findViewById(R.id.edtCpc);
        edtNumerocallec = findViewById(R.id.edtNumerocallec);
        edtEstadoc = findViewById(R.id.edtEstadoc);
        edtCorreoCliente = findViewById(R.id.edtCorreoCliente);
        btnGuardarC = findViewById(R.id.btnGuardarC);
        btnActualizarC = findViewById(R.id.btnActualizarC);

        btnGuardarC.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                guardarCliente();
            }
        });

        btnActualizarC.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                actualizarCliente();
            }
        });
    }

    private void guardarCliente(){
        if(isValidarCampos()){
            String rfc = edtRfc.getText().toString();
            String nombre = edtPnombrec.getText().toString();
            String apellidop = edtApellidopc.getText().toString();
            String apellidom = edtApellidomc.getText().toString();
            String calle = edtCallec.getText().toString();
            String colonia = edtColoniac.getText().toString();
            String cp = edtCpc.getText().toString();
            String numerocalle = edtNumerocallec.getText().toString();
            String estado = edtEstadoc.getText().toString();
            String correo = edtCorreoCliente.getText().toString();

            Map<String,String> datos = new HashMap<>();
            datos.put("RFC",rfc);
            datos.put("PNOMBREC",nombre);
            datos.put("APELLIDOPC",apellidop);
            datos.put("APELLIDOMC",apellidom);
            datos.put("CALLEC",calle);
            datos.put("COLONIAC",colonia);
            datos.put("CPC",cp);
            datos.put("NUMEROCALLEC",numerocalle);
            datos.put("ESTADOC",estado);
            datos.put("CORREO",correo);

            JSONObject jsonData = new JSONObject(datos);
            AndroidNetworking.post(Constantes.URL_INSERTAR_CLIENTE)
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
                                Toast.makeText(GuardarActualizarClienteActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(GuardarActualizarClienteActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(GuardarActualizarClienteActivity.this, "Error"+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }
    }

    private void actualizarCliente(){
        if(isValidarCamposActu()){
            String rfc = edtRfc.getText().toString();
            String nombre = edtPnombrec.getText().toString();
            String apellidop = edtApellidopc.getText().toString();
            String apellidom = edtApellidomc.getText().toString();
            String calle = edtCallec.getText().toString();
            String colonia = edtColoniac.getText().toString();
            String cp = edtCpc.getText().toString();
            String numerocalle = edtNumerocallec.getText().toString();
            String estado = edtEstadoc.getText().toString();

            Map<String,String> datos = new HashMap<>();
            datos.put("RFC",rfc);
            datos.put("PNOMBREC",nombre);
            datos.put("APELLIDOPC",apellidop);
            datos.put("APELLIDOMC",apellidom);
            datos.put("CALLEC",calle);
            datos.put("COLONIAC",colonia);
            datos.put("CPC",cp);
            datos.put("NUMEROCALLEC",numerocalle);
            datos.put("ESTADOC",estado);

            JSONObject jsonData = new JSONObject(datos);
            AndroidNetworking.post(Constantes.URL_ACTUALIZAR_CLIENTE)
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
                                Toast.makeText(GuardarActualizarClienteActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(GuardarActualizarClienteActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(GuardarActualizarClienteActivity.this, "Error"+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }else{
            Toast.makeText(this, "Para actualizar el Cliente el campo correo debe estar vacío", Toast.LENGTH_SHORT).show();
        }
    }
    //de momento que todos los clientes tengan todos los campos rellenados
    private boolean isValidarCampos(){
        return !edtRfc.getText().toString().trim().isEmpty() &&
                !edtPnombrec.getText().toString().trim().isEmpty() &&
                !edtApellidopc.getText().toString().trim().isEmpty() &&
                !edtApellidomc.getText().toString().trim().isEmpty() &&
                !edtCallec.getText().toString().trim().isEmpty() &&
                !edtColoniac.getText().toString().trim().isEmpty() &&
                !edtCpc.getText().toString().trim().isEmpty() &&
                !edtNumerocallec.getText().toString().trim().isEmpty() &&
                !edtCorreoCliente.getText().toString().trim().isEmpty() &&
                !edtEstadoc.getText().toString().trim().isEmpty();

    }

    private boolean isValidarCamposActu(){
        return !edtRfc.getText().toString().trim().isEmpty() &&
                !edtPnombrec.getText().toString().trim().isEmpty() &&
                !edtApellidopc.getText().toString().trim().isEmpty() &&
                !edtApellidomc.getText().toString().trim().isEmpty() &&
                !edtCallec.getText().toString().trim().isEmpty() &&
                !edtColoniac.getText().toString().trim().isEmpty() &&
                !edtCpc.getText().toString().trim().isEmpty() &&
                !edtNumerocallec.getText().toString().trim().isEmpty() &&
                edtCorreoCliente.getText().toString().trim().isEmpty() &&
                !edtEstadoc.getText().toString().trim().isEmpty();

    }
}
