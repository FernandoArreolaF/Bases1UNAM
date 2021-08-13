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

public class ActualizarProductoActivity extends AppCompatActivity {
    private EditText edtCodigo;
    private EditText edtArticulo;
    private EditText edtPrecioC;
    private EditText edtMarca;
    private EditText edtPrecioV;

    private EditText edtDescripcion;
    private EditText edtFechaC;

    private Button btnActualizarP;

    @Override
    protected void onCreate(@Nullable  Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_actualizar_producto);
        edtCodigo = findViewById(R.id.edtCodigo);
        edtArticulo = findViewById(R.id.edtArticulo);
        edtPrecioC = findViewById(R.id.edtPrecioC);
        edtMarca = findViewById(R.id.edtMarca);
        edtPrecioV= findViewById(R.id.edtPrecioV);

        edtDescripcion = findViewById(R.id.edtDescripcion);
        edtFechaC = findViewById(R.id.edtFechaC);
        btnActualizarP = findViewById(R.id.btnActualizarP);

        btnActualizarP.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                actualizarProducto();

            }
        });
    }

    private void actualizarProducto(){
        if(isValidarCampos()){
            //se actualiza el producto
            String codigo = edtCodigo.getText().toString();
            String articulo = edtArticulo.getText().toString();
            String precioc = edtPrecioC.getText().toString();
            String marca = edtMarca.getText().toString();
            String preciov = edtPrecioV.getText().toString();
            String descripcion = edtDescripcion.getText().toString();
            String fechac = edtFechaC.getText().toString();

            Map<String,String> datos = new HashMap<>();
            datos.put("CODIGOBARRAS", codigo);
            datos.put("ARTICULO", articulo);
            datos.put("PRECIOC", precioc);
            datos.put("MARCA", marca);
            datos.put("PRECIOV", preciov);
            datos.put("DESCRIPCION", descripcion);
            datos.put("FECHAC", fechac);

            JSONObject jsonData = new JSONObject(datos);

            AndroidNetworking.post(Constantes.URL_ACTUALIZAR_PRODUCTO)
                    .addJSONObjectBody(jsonData)
                    .setPriority(Priority.MEDIUM)
                    .build()
                    .getAsJSONObject(new JSONObjectRequestListener() {
                        @Override
                        public void onResponse(JSONObject response) {
                            try {
                                String estado = response.getString("estado");
                                String error = response.getString("error");
                                Toast.makeText(ActualizarProductoActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(ActualizarProductoActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(ActualizarProductoActivity.this, "Error: "+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });

        }else{
            Toast.makeText(this,"Existen campos vacios, no se puede actualizar", Toast.LENGTH_SHORT).show();
        }
    }

    private boolean isValidarCampos(){
        return !edtCodigo.getText().toString().trim().isEmpty() &&
                !edtArticulo.getText().toString().trim().isEmpty() &&
                !edtPrecioC.getText().toString().trim().isEmpty() &&
                !edtMarca.getText().toString().trim().isEmpty() &&
                !edtPrecioV.getText().toString().trim().isEmpty() &&
                //!edtDescripcion.getText().toString().trim().isEmpty() &&
                !edtFechaC.getText().toString().trim().isEmpty();

    }
}
