package com.example.papews;

import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

import androidx.annotation.NonNull;
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

public class ListarEliminarVentaActivity extends AppCompatActivity {

    private EditText edtNoventa;
    private EditText edtRfcV;
    private Button btnEliminarVenta;
    private Button btnConsultaV;
    private Button btnDetallesV;

    private ListView lvVentas;
    private ArrayAdapter<String> adapter;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_listar_ventas);

        AndroidNetworking.initialize(getApplicationContext());

        edtNoventa = findViewById(R.id.edtNoventa);
        edtRfcV = findViewById(R.id.edtRfcV);
        btnEliminarVenta = findViewById(R.id.btnEliminarVenta);
        btnConsultaV = findViewById(R.id.btnConsultaV);
        btnDetallesV = findViewById(R.id.btnDetallesV);
        lvVentas = findViewById(R.id.lvVentas);
        adapter = new ArrayAdapter(this, android.R.layout.simple_list_item_1){
            @NonNull
            @Override
            public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
                View view = super.getView(position, convertView, parent);
                if(position==0){
                    view.setBackgroundColor(getResources().getColor(android.R.color.holo_green_light));
                }else{
                    view.setBackgroundColor(getResources().getColor(android.R.color.background_light));
                }
                return view;
            }
        };

        btnEliminarVenta.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                eliminarVenta();
            }
        });

        btnConsultaV.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                adapter.clear();
                consultaVenta();
            }
        });

        btnDetallesV.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                adapter.clear();
                int op=0;
                if(op==0){
                    consultaDetallesVenta();
                    op=1;
                }
                if(op==1){
                    consultaRecibo();
                }

            }
        });
    }

    private void eliminarVenta(){
        if(isValidarCampos()){
            String noventa = edtNoventa.getText().toString();

            Map<String,String> datos = new HashMap<>();
            datos.put("NOVENTA",noventa);
            AndroidNetworking.post(Constantes.URL_ELIMINAR_VENTA)
                    .addJSONObjectBody(new JSONObject(datos))
                    .setPriority(Priority.MEDIUM)
                    .build()
                    .getAsJSONObject(new JSONObjectRequestListener() {
                        @Override
                        public void onResponse(JSONObject response) {
                            try {
                                String estado = response.getString("estado");
                                String error = response.getString("error");
                                Toast.makeText(ListarEliminarVentaActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(ListarEliminarVentaActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(ListarEliminarVentaActivity.this, "Error: "+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }else{
            Toast.makeText(this, "Necesito el Núm. de Venta", Toast.LENGTH_SHORT).show();
        }
    }

    private void consultaVenta(){
        if(isValidarCamposConsulta()){
            lvVentas.setAdapter(adapter);
            String rfc = edtRfcV.getText().toString();

            //Map<String,String> datos = new HashMap<>();
            //datos.put("RFC",rfc);
            //JSONObject jsonData = new JSONObject(datos);
            AndroidNetworking.get(Constantes.URL_LISTAR_VENTA)
                    .addPathParameter("RFC",rfc)
                    .setPriority(Priority.MEDIUM)
                    .build()
                    .getAsJSONObject(new JSONObjectRequestListener() {
                        @Override
                        public void onResponse(JSONObject response) {
                            try {
                                String respuesta = response.getString("respuesta");
                                if(respuesta.equals("200")){
                                    JSONArray arrayVenta = response.getJSONArray("data");
                                    for(int i=0;i<arrayVenta.length();i++){
                                        JSONObject jsonVenta= arrayVenta.getJSONObject(i);
                                        String noventa = "ID de Venta: "+jsonVenta.getString("noventa");

                                        String dataString = noventa + "\n";
                                        adapter.add(dataString);
                                    }
                                    adapter.notifyDataSetChanged();
                                }else{
                                    Toast.makeText(ListarEliminarVentaActivity.this, "No hay VENTAS disponibles", Toast.LENGTH_SHORT).show();
                                }
                            } catch (JSONException e) {
                                Toast.makeText(ListarEliminarVentaActivity.this, "Error: "+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(ListarEliminarVentaActivity.this, "Error: "+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }else{
            Toast.makeText(this, "Necesito el RFC", Toast.LENGTH_SHORT).show();
        }
    }

    private void consultaDetallesVenta(){
        if(isValidarCamposDetalles()){
            //lvVentas.setAdapter(adapter);
            String noventa = edtNoventa.getText().toString();

            //Map<String,String> datos = new HashMap<>();
            //datos.put("RFC",rfc);
            //JSONObject jsonData = new JSONObject(datos);
            AndroidNetworking.get(Constantes.URL_DETALLES_VENTA)
                    .addPathParameter("NOVENTA",noventa)
                    .setPriority(Priority.MEDIUM)
                    .build()
                    .getAsJSONObject(new JSONObjectRequestListener() {
                        @Override
                        public void onResponse(JSONObject response) {
                            try {
                                String respuesta = response.getString("respuesta");
                                if(respuesta.equals("200")){
                                    JSONArray arrayVenta = response.getJSONArray("data");
                                    for(int i=0;i<arrayVenta.length();i++){
                                        JSONObject jsonVenta= arrayVenta.getJSONObject(i);
                                        String noventa = "ID de Venta: "+jsonVenta.getString("noventa");
                                        String rfc = "RFC: "+jsonVenta.getString("rfc");
                                        String fechav = "Fecha de venta: "+jsonVenta.getString("fechav");
                                        String totalv = "Total de la venta: $"+jsonVenta.getString("totalv")+" MXN";

                                        String dataString = noventa + "\n" + rfc + "\n" + fechav + "\n" + totalv;
                                        adapter.add(dataString);
                                    }
                                    adapter.notifyDataSetChanged();
                                }else{
                                    Toast.makeText(ListarEliminarVentaActivity.this, "No hay VENTAS disponibles", Toast.LENGTH_SHORT).show();
                                }
                            } catch (JSONException e) {
                                Toast.makeText(ListarEliminarVentaActivity.this, "Error: "+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(ListarEliminarVentaActivity.this, "Error: "+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }else{
            Toast.makeText(this, "Necesito el Núm. de Venta", Toast.LENGTH_SHORT).show();
        }
    }

    private void consultaRecibo(){
        if(isValidarCamposDetalles()){
            lvVentas.setAdapter(adapter);
            String noventa = edtNoventa.getText().toString();

            //Map<String,String> datos = new HashMap<>();
            //datos.put("RFC",rfc);
            //JSONObject jsonData = new JSONObject(datos);
            AndroidNetworking.get(Constantes.URL_DETALLES_VENTA2)
                    .addPathParameter("NOVENTA",noventa)
                    .setPriority(Priority.MEDIUM)
                    .build()
                    .getAsJSONObject(new JSONObjectRequestListener() {
                        @Override
                        public void onResponse(JSONObject response) {
                            try {
                                String respuesta = response.getString("respuesta");
                                if(respuesta.equals("200")){
                                    JSONArray arrayVenta = response.getJSONArray("data");
                                    for(int i=0;i<arrayVenta.length();i++){
                                        JSONObject jsonVenta= arrayVenta.getJSONObject(i);
                                        String codigobarras = "Codigo de barras: "+jsonVenta.getString("codigobarras");
                                        String articulo = "Articulo: "+jsonVenta.getString("articulo");
                                        String marca = "Marca: "+jsonVenta.getString("marca");
                                        String preciov = "Precio de venta: "+jsonVenta.getString("preciov");
                                        String cantidadprod = "Cantidad: "+jsonVenta.getString("cantidadprod");
                                        String totalp = "Total por cantidad: "+jsonVenta.getString("totalp");

                                        String dataString = codigobarras + "\n" + articulo + "\n" + marca + "\n" + preciov + "\n" + cantidadprod + "\n" + totalp;
                                        adapter.add(dataString);
                                    }
                                    adapter.notifyDataSetChanged();
                                }else{
                                    Toast.makeText(ListarEliminarVentaActivity.this, "No hay VENTAS disponibles", Toast.LENGTH_SHORT).show();
                                }
                            } catch (JSONException e) {
                                Toast.makeText(ListarEliminarVentaActivity.this, "Error: "+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(ListarEliminarVentaActivity.this, "Error: "+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }
    }

    private boolean isValidarCampos(){
        return !edtNoventa.getText().toString().trim().isEmpty();

    }

    private boolean isValidarCamposConsulta(){
        return !edtRfcV.getText().toString().trim().isEmpty();

    }

    private boolean isValidarCamposDetalles(){
        return !edtNoventa.getText().toString().trim().isEmpty();

    }
}
