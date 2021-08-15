package com.example.papews;

import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
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

import static com.example.papews.ListarProductosActivity.NomProducto;

public class PopupOperacionesVentaActivity extends AppCompatActivity {

    public TextView txtProducto2;
    private EditText edtNoventaOp;
    private EditText edtCodigoOp;
    private EditText edtCantidadOp;
    private Button btnAgregarProd;

    private Button btnBorrarVenta;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_popup_operaciones_venta);
        AndroidNetworking.initialize(getApplicationContext());

        txtProducto2 = findViewById(R.id.txtProducto2);
        edtNoventaOp = findViewById(R.id.edtNoventaOp);
        edtCodigoOp = findViewById(R.id.edtCodigoOp);
        edtCantidadOp = findViewById(R.id.edtCantidadOp);
        btnAgregarProd = findViewById(R.id.btnAgregarProd);

        btnBorrarVenta = findViewById(R.id.btnBorrarVenta);

        btnAgregarProd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                agregarProdVenta();
            }
        });

        btnBorrarVenta.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                borrarProdVenta();
            }
        });

        DisplayMetrics medidaVentana = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(medidaVentana);

        int ancho = medidaVentana.widthPixels;
        int alto = medidaVentana.heightPixels;

        getWindow().setLayout((int)(ancho * 0.85), (int)(alto * 0.7));
        txtProducto2.setText(NomProducto);
    }

    private void borrarProdVenta(){
        if(isValidarCamposBorrar()){
            String noventa = edtNoventaOp.getText().toString();
            String codigo = edtCodigoOp.getText().toString();

            Map<String,String> datos = new HashMap<>();
            datos.put("CODIGOBARRAS",codigo);
            datos.put("NOVENTA",noventa);
            AndroidNetworking.post(Constantes.URL_BORRAR_PRODUCTO_VENTA)
                    .addJSONObjectBody(new JSONObject(datos))
                    .setPriority(Priority.MEDIUM)
                    .build()
                    .getAsJSONObject(new JSONObjectRequestListener() {
                        @Override
                        public void onResponse(JSONObject response) {
                            try {
                                String estado = response.getString("estado");
                                String error = response.getString("error");
                                Toast.makeText(PopupOperacionesVentaActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(PopupOperacionesVentaActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(PopupOperacionesVentaActivity.this, "Error: "+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }else{
            Toast.makeText(this, "Necesito el Núm. de venta y el codigo de barras", Toast.LENGTH_SHORT).show();
        }
    }

    /*private void actualizarCantidad(){
        if(isValidarCampos()){
            String noventa = edtNoventaOp.getText().toString();
            String codigo = edtCodigoOp.getText().toString();
            String cantidad = edtCantidadOp.getText().toString();

            Map<String,String> datos = new HashMap<>();
            datos.put("CODIGOBARRAS",codigo);
            datos.put("NOVENTA",noventa);
            datos.put("CANTIDADPROD",cantidad);

            JSONObject jsonData = new JSONObject(datos);
            AndroidNetworking.post(Constantes.URL_ACTUALIZAR_CANTIDAD)
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
                                Toast.makeText(PopupOperacionesVentaActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(PopupOperacionesVentaActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(PopupOperacionesVentaActivity.this, "Error"+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }else{
            Toast.makeText(this, "Rellena todos los campos", Toast.LENGTH_SHORT).show();
        }
    }*/

    private void agregarProdVenta(){
        if(isValidarCampos()){
            String noventa = edtNoventaOp.getText().toString();
            String codigo = edtCodigoOp.getText().toString();
            String cantidad = edtCantidadOp.getText().toString();

            Map<String,String> datos = new HashMap<>();
            datos.put("CODIGOBARRAS",codigo);
            datos.put("NOVENTA",noventa);
            datos.put("CANTIDADPROD",cantidad);

            JSONObject jsonData = new JSONObject(datos);
            AndroidNetworking.post(Constantes.URL_NUEVO_PRODUCTO_VENTA)
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
                                Toast.makeText(PopupOperacionesVentaActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(PopupOperacionesVentaActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(PopupOperacionesVentaActivity.this, "Error"+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }else{
            Toast.makeText(this, "Rellena todos los campos", Toast.LENGTH_SHORT).show();
        }
    }

    private boolean isValidarCampos(){
        return !edtNoventaOp.getText().toString().trim().isEmpty() &&
                !edtCodigoOp.getText().toString().trim().isEmpty() &&
                !edtCantidadOp.getText().toString().trim().isEmpty();

    }

    private boolean isValidarCamposBorrar(){
        return !edtNoventaOp.getText().toString().trim().isEmpty() &&
                !edtCodigoOp.getText().toString().trim().isEmpty();

    }
}
