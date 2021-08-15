package com.example.papews;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.androidnetworking.AndroidNetworking;
import com.androidnetworking.common.Priority;
import com.androidnetworking.error.ANError;
import com.androidnetworking.interfaces.JSONObjectRequestListener;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class MainActivity extends AppCompatActivity {

    private EditText edtRazonSProd;
    private EditText edtCodigo;
    private EditText edtArticulo;
    private EditText edtPrecioC;
    private EditText edtMarca;
    private EditText edtPrecioV;
    private EditText edtStock;
    private EditText edtDescripcion;
    private EditText edtFechaC;
    private Button btnGuardarP;
    private EditText edtCantidadDada;
    private Button btnAgregarStock;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        AndroidNetworking.initialize(getApplicationContext());

        edtRazonSProd = findViewById(R.id.edtRazonSProd);
        edtCodigo = findViewById(R.id.edtCodigo);
        edtArticulo = findViewById(R.id.edtArticulo);
        edtPrecioC = findViewById(R.id.edtPrecioC);
        edtMarca = findViewById(R.id.edtMarca);
        edtPrecioV= findViewById(R.id.edtPrecioV);
        edtStock = findViewById(R.id.edtStock);
        edtDescripcion = findViewById(R.id.edtDescripcion);
        edtFechaC = findViewById(R.id.edtFechaC);
        btnGuardarP =findViewById(R.id.btnGuardarP);
        edtCantidadDada = findViewById(R.id.edtCantidadDada);
        btnAgregarStock = findViewById(R.id.btnAgregarStock);

        btnGuardarP.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                guardarProducto();
            }
        });

        btnAgregarStock.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                agregarStock();
            }
        });
    }

    private void agregarStock(){
        if(isValidarCamposAgregar()){
            String razonsocial = edtRazonSProd.getText().toString();
            String codigo = edtCodigo.getText().toString();
            String cantidad = edtCantidadDada.getText().toString();

            Map<String,String> datos = new HashMap<>();
            datos.put("RAZONSOCIAL", razonsocial);
            datos.put("CODIGOBARRAS", codigo);
            datos.put("CANTIDADDADA", cantidad);

            JSONObject jsonData = new JSONObject(datos);
            AndroidNetworking.post(Constantes.URL_AGREGAR_STOCK)
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
                                Toast.makeText(MainActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(MainActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }

                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(MainActivity.this, "Error"+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();

                        }
                    });
        }else{
            Toast.makeText(this,"Necesitas la Razon social, el codigo de barras y la cantidad dada para agregar stock", Toast.LENGTH_SHORT).show();
        }
    }

    private void guardarProducto(){
        if(isValidarCampos()){

            String razonsocial = edtRazonSProd.getText().toString();
            String codigo = edtCodigo.getText().toString();
            String articulo = edtArticulo.getText().toString();
            String precioc = edtPrecioC.getText().toString();
            String marca = edtMarca.getText().toString();
            String preciov = edtPrecioV.getText().toString();
            String stock = edtStock.getText().toString();
            String descripcion = edtDescripcion.getText().toString();
            String fechac = edtFechaC.getText().toString();

            Map<String,String> datos = new HashMap<>();
            datos.put("CODIGOBARRAS", codigo);
            datos.put("ARTICULO", articulo);
            datos.put("PRECIOC", precioc);
            datos.put("MARCA", marca);
            datos.put("PRECIOV", preciov);
            datos.put("STOCK", stock);
            datos.put("DESCRIPCION", descripcion);
            datos.put("FECHAC", fechac);
            datos.put("RAZONSOCIAL", razonsocial);

            JSONObject jsonData = new JSONObject(datos);

            AndroidNetworking.post(Constantes.URL_INSERTAR_PRODUCTO)
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
                                Toast.makeText(MainActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(MainActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }

                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(MainActivity.this, "Error"+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();

                        }
                    });
        }else{
            Toast.makeText(this,"No se puede insertar un producto si existen campos vacios", Toast.LENGTH_SHORT).show();
        }

    }
    //devuelve verdadero si es que no hay campos vacios
    //devuelve falso si es que hay como minimo un campo vacio
    private boolean isValidarCampos(){
        return  !edtRazonSProd.getText().toString().trim().isEmpty() &&
                !edtCodigo.getText().toString().trim().isEmpty() &&
                !edtArticulo.getText().toString().trim().isEmpty() &&
                !edtPrecioC.getText().toString().trim().isEmpty() &&
                !edtMarca.getText().toString().trim().isEmpty() &&
                !edtPrecioV.getText().toString().trim().isEmpty() &&
                !edtStock.getText().toString().trim().isEmpty() &&
                //!edtDescripcion.getText().toString().trim().isEmpty() &&
                !edtFechaC.getText().toString().trim().isEmpty();

    }

    private boolean isValidarCamposAgregar(){
        return  !edtRazonSProd.getText().toString().trim().isEmpty() &&
                !edtCodigo.getText().toString().trim().isEmpty() &&
                !edtCantidadDada.getText().toString().trim().isEmpty();


    }
}