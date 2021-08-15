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

public class EliminarProveedorActivity extends AppCompatActivity {

    private EditText edtRazonS;
    private Button btnEliminarProv;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_eliminar_proveedor);

        edtRazonS = findViewById(R.id.edtRazonS);
        btnEliminarProv = findViewById(R.id.btnEliminarProv);

        btnEliminarProv.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                eliminarProveedor();
            }
        });
    }

    private void eliminarProveedor(){
        if(isValidarCampos()){
            String razonsocial = edtRazonS.getText().toString();

            Map<String,String> datos = new HashMap<>();
            datos.put("RAZONSOCIAL",razonsocial);
            AndroidNetworking.post(Constantes.URL_ELIMINAR_PROVEEDOR)
                    .addJSONObjectBody(new JSONObject(datos))
                    .setPriority(Priority.MEDIUM)
                    .build()
                    .getAsJSONObject(new JSONObjectRequestListener() {
                        @Override
                        public void onResponse(JSONObject response) {
                            try {
                                String estado = response.getString("estado");
                                String error = response.getString("error");
                                Toast.makeText(EliminarProveedorActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(EliminarProveedorActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(EliminarProveedorActivity.this, "Error: "+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }else{
            Toast.makeText(this, "Necesito la Razon Social", Toast.LENGTH_SHORT).show();
        }
    }

    private boolean isValidarCampos(){
        return !edtRazonS.getText().toString().trim().isEmpty();

    }
}
