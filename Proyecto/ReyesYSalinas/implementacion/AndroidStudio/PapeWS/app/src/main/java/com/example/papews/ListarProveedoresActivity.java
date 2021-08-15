package com.example.papews;

import android.os.Bundle;
import android.widget.ArrayAdapter;
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

public class ListarProveedoresActivity extends AppCompatActivity {

    private ListView lvProveedor;
    private ArrayAdapter<String> adapter;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_listar_proveedor);

        lvProveedor = findViewById(R.id.lvProveedor);
        adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1);

        lvProveedor.setAdapter(adapter);

        AndroidNetworking.get(Constantes.URL_LISTAR_PROVEEDOR)
                .setPriority(Priority.MEDIUM)
                .build()
                .getAsJSONObject(new JSONObjectRequestListener() {
                    @Override
                    public void onResponse(JSONObject response) {
                        try {
                            String respuesta = response.getString("respuesta");
                            if(respuesta.equals("200")){
                                JSONArray arrayProveedor = response.getJSONArray("data");
                                for(int i=0;i<arrayProveedor.length();i++){
                                    JSONObject jsonProveedor = arrayProveedor.getJSONObject(i);
                                    String razonsocial = "Razon Social: "+jsonProveedor.getString("razonsocial");
                                    String pnombrep = "Nombre: "+ jsonProveedor.getString("pnombrep");
                                    String apellidopp = "Apellido paterno: "+jsonProveedor.getString("apellidopp");
                                    String apellidomp = "Apellido materno: "+jsonProveedor.getString("apellidomp");
                                    String callep = "Calle: "+jsonProveedor.getString("callep");
                                    String coloniap = "Colonia: "+jsonProveedor.getString("coloniap");
                                    String cpp = "C.P.: "+jsonProveedor.getString("cpp");
                                    String numerocallep = "# Calle: "+jsonProveedor.getString("numerocallep");
                                    String estadop = "Estado: "+jsonProveedor.getString("estadop");

                                    String dataString = razonsocial + "\n" + pnombrep + "\n" + apellidopp + "\n" + apellidomp + "\n" + callep + "\n" + coloniap + "\n" + cpp + "\n" + numerocallep + "\n" + estadop;
                                    adapter.add(dataString);
                                }
                                adapter.notifyDataSetChanged();
                            }else{
                                Toast.makeText(ListarProveedoresActivity.this, "No hay productos disponibles", Toast.LENGTH_SHORT).show();
                            }
                        } catch (JSONException e) {
                            Toast.makeText(ListarProveedoresActivity.this, "Error: "+e.getMessage(), Toast.LENGTH_SHORT).show();
                        }
                    }

                    @Override
                    public void onError(ANError anError) {
                        Toast.makeText(ListarProveedoresActivity.this, "Error: "+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                    }
                });
    }
}
