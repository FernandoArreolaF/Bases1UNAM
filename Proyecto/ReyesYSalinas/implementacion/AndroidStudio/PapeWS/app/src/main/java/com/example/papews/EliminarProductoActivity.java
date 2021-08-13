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

public class EliminarProductoActivity extends AppCompatActivity {

    private EditText edtCodigo;
    private Button btnEliminarP;

    @Override
    protected void onCreate(@Nullable  Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_eliminar_producto);

        edtCodigo = findViewById(R.id.edtCodigo);
        btnEliminarP = findViewById(R.id.btnEliminarP);

        btnEliminarP.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                eliminarProducto();
            }
        });
    }

    private void eliminarProducto(){
        if(isValidarCampos()){
            String codigo = edtCodigo.getText().toString();

            Map<String,String> datos = new HashMap<>();
            datos.put("CODIGOBARRAS",codigo);
            AndroidNetworking.post(Constantes.URL_ELIMINAR_PRODUCTO)
                    .addJSONObjectBody(new JSONObject(datos))
                    .setPriority(Priority.MEDIUM)
                    .build()
                    .getAsJSONObject(new JSONObjectRequestListener() {
                        @Override
                        public void onResponse(JSONObject response) {
                            try {
                                String estado = response.getString("estado");
                                String error = response.getString("error");
                                Toast.makeText(EliminarProductoActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(EliminarProductoActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(EliminarProductoActivity.this, "Error: "+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }else{
            Toast.makeText(this, "Necesito el codigo de barras", Toast.LENGTH_SHORT).show();
        }
    }
    private boolean isValidarCampos(){
        return !edtCodigo.getText().toString().trim().isEmpty();

    }
}
