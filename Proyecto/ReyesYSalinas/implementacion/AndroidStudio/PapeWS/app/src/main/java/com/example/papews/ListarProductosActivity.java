package com.example.papews;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
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

public class ListarProductosActivity extends AppCompatActivity {

    public static String NomProducto;

    private Button btnConsultaMenor;

    private ListView lvProductos;
    private ArrayAdapter<String> adapter;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_listar_producto);

        lvProductos = findViewById(R.id.lvProductos);
        btnConsultaMenor = findViewById(R.id.btnConsultaMenor);


        btnConsultaMenor.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                adapter.clear();
                consultaMenor();
            }
        });

        adapter = new ArrayAdapter(this, android.R.layout.simple_list_item_1){
            @NonNull
            @Override
            public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
                View view = super.getView(position, convertView, parent);
                if(getItem(position).toString().contains("Stock: 3 ")||getItem(position).toString().contains("Stock: 2 ")||getItem(position).toString().contains("Stock: 1 ")){
                    view.setBackgroundColor(getResources().getColor(android.R.color.holo_orange_light));
                }
                if (getItem(position).toString().contains("Stock: 0 ")){
                    view.setBackgroundColor(getResources().getColor(android.R.color.holo_red_light));
                }else{
                    view.setBackgroundColor(getResources().getColor(android.R.color.background_light));
                }
                return view;
            }
        };

        lvProductos.setAdapter(adapter);

        AndroidNetworking.get(Constantes.URL_LISTAR_PRODUCTO)
                .setPriority(Priority.MEDIUM)
                .build()
                .getAsJSONObject(new JSONObjectRequestListener() {
                    @Override
                    public void onResponse(JSONObject response) {
                        try {
                            String respuesta = response.getString("respuesta");
                            if(respuesta.equals("200")){
                                JSONArray arrayProductos = response.getJSONArray("data");
                                for(int i=0;i<arrayProductos.length();i++){
                                    JSONObject jsonProducto = arrayProductos.getJSONObject(i);
                                    String codigobarras = "Codigo de barras: "+jsonProducto.getString("codigobarras");
                                    String articulo = "Articulo: "+jsonProducto.getString("articulo");
                                    String fechac = "Fecha de compra: "+jsonProducto.getString("fechac");
                                    String precioc = "Precio de compra: "+jsonProducto.getDouble("precioc") + " $MXN";
                                    String marca = "Marca: "+jsonProducto.getString("marca");
                                    String descripcion = "Descripcion: "+jsonProducto.getString("descripcion");
                                    String preciov = "Precio de venta: "+jsonProducto.getDouble("preciov") + " $MXN";
                                    String stock = "Stock: "+jsonProducto.getString("stock")+" ";

                                    String dataString = codigobarras + "\n" + articulo + "\n" + fechac + "\n" + precioc + "\n" + marca + "\n" + descripcion + "\n" + preciov + "\n" + stock;
                                    adapter.add(dataString);

                                }
                                //lvProductos.getChildAt(4).setBackgroundColor(getResources().getColor(android.R.color.holo_red_light));
                                adapter.notifyDataSetChanged();
                            }else{
                                Toast.makeText(ListarProductosActivity.this, "No hay productos disponibles", Toast.LENGTH_SHORT).show();
                            }
                        } catch (JSONException e) {
                            Toast.makeText(ListarProductosActivity.this, "Error: "+e.getMessage(), Toast.LENGTH_SHORT).show();
                        }
                    }

                    @Override
                    public void onError(ANError anError) {
                        Toast.makeText(ListarProductosActivity.this, "Error: "+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                    }
                });

        lvProductos.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                lvProductos.getItemAtPosition(i);
                String articulo = lvProductos.getItemAtPosition(i).toString();
                //String marca = "Marca: "+jsonProductoSeleccionado.getString("marca");
                //String descripcion = "Descripcion: "+jsonProductoSeleccionado.getString("descripcion");
                NomProducto = articulo;
                startActivity(new Intent(ListarProductosActivity.this, PopupCantidadActivity.class));
            }
        });

        lvProductos.setOnItemLongClickListener(new AdapterView.OnItemLongClickListener() {
            @Override
            public boolean onItemLongClick(AdapterView<?> adapterView, View view, int i, long l) {
                lvProductos.getItemAtPosition(i);
                String articulo = lvProductos.getItemAtPosition(i).toString();
                NomProducto = articulo;
                startActivity(new Intent(ListarProductosActivity.this, PopupOperacionesVentaActivity.class));
                return false;
            }
        });
    }

    private void consultaMenor(){
        adapter = new ArrayAdapter(this, android.R.layout.simple_list_item_1){
            @NonNull
            @Override
            public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
                View view = super.getView(position, convertView, parent);
                if(getItem(position).toString().contains("Stock: 3 ")||getItem(position).toString().contains("Stock: 2 ")||getItem(position).toString().contains("Stock: 1 ")){
                    view.setBackgroundColor(getResources().getColor(android.R.color.holo_orange_light));
                }else{
                    view.setBackgroundColor(getResources().getColor(android.R.color.holo_red_light));
                }
                return view;
            }
        };

        lvProductos.setAdapter(adapter);
        AndroidNetworking.get(Constantes.URL_CONSULTA_MENOR)
                .addPathParameter("STOCK","3")
                .setPriority(Priority.MEDIUM)
                .build()
                .getAsJSONObject(new JSONObjectRequestListener() {
                    @Override
                    public void onResponse(JSONObject response) {
                        try {
                            String respuesta = response.getString("respuesta");
                            if(respuesta.equals("200")){
                                JSONArray arrayProductos = response.getJSONArray("data");
                                for(int i=0;i<arrayProductos.length();i++){
                                    JSONObject jsonProducto = arrayProductos.getJSONObject(i);
                                    String codigobarras = "Codigo de barras: "+jsonProducto.getString("codigobarras");
                                    String articulo = "Articulo: "+jsonProducto.getString("articulo");
                                    String preciov = "Precio de venta: "+jsonProducto.getDouble("preciov") + " $MXN";
                                    String stock = "Stock: "+jsonProducto.getString("stock")+" ";

                                    String dataString = codigobarras + "\n" + articulo + "\n"  + preciov + "\n" + stock;
                                    adapter.add(dataString);

                                }
                                //lvProductos.getChildAt(4).setBackgroundColor(getResources().getColor(android.R.color.holo_red_light));
                                adapter.notifyDataSetChanged();
                            }else{
                                Toast.makeText(ListarProductosActivity.this, "No hay productos disponibles", Toast.LENGTH_SHORT).show();
                            }
                        } catch (JSONException e) {
                            Toast.makeText(ListarProductosActivity.this, "Error: "+e.getMessage(), Toast.LENGTH_SHORT).show();
                        }
                    }

                    @Override
                    public void onError(ANError anError) {
                        Toast.makeText(ListarProductosActivity.this, "Error: "+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                    }
                });
    }
}
