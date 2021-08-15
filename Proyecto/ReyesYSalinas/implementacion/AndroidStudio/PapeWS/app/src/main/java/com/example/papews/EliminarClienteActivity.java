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

public class EliminarClienteActivity extends AppCompatActivity {

    private EditText edtRfcE;
    private Button btnEliminarC;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_eliminar_cliente);
        edtRfcE = findViewById(R.id.edtRfcE);
        btnEliminarC = findViewById(R.id.btnEliminarC);

        btnEliminarC.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                eliminarCliente();
            }
        });
    }

    private void eliminarCliente(){
        if(isValidarCampos()){
            String rfc = edtRfcE.getText().toString();

            Map<String,String> datos = new HashMap<>();
            datos.put("RFC",rfc);
            AndroidNetworking.post(Constantes.URL_ELIMINAR_CLIENTE)
                    .addJSONObjectBody(new JSONObject(datos))
                    .setPriority(Priority.MEDIUM)
                    .build()
                    .getAsJSONObject(new JSONObjectRequestListener() {
                        @Override
                        public void onResponse(JSONObject response) {
                            try {
                                String estado = response.getString("estado");
                                String error = response.getString("error");
                                Toast.makeText(EliminarClienteActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(EliminarClienteActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(EliminarClienteActivity.this, "Error: "+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }else{
            Toast.makeText(this, "Necesito el RFC", Toast.LENGTH_SHORT).show();
        }
    }

    private boolean isValidarCampos(){
        return !edtRfcE.getText().toString().trim().isEmpty();

    }
}
