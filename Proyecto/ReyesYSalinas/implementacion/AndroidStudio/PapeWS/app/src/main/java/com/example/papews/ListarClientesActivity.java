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

public class ListarClientesActivity extends AppCompatActivity {

    private ListView lvCliente;
    private ArrayAdapter<String> adapter;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_listar_cliente);

        lvCliente = findViewById(R.id.lvCliente);
        adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1);

        lvCliente.setAdapter(adapter);

        AndroidNetworking.get(Constantes.URL_LISTAR_CLIENTE)
                .setPriority(Priority.MEDIUM)
                .build()
                .getAsJSONObject(new JSONObjectRequestListener() {
                    @Override
                    public void onResponse(JSONObject response) {
                        try {
                            String respuesta = response.getString("respuesta");
                            if(respuesta.equals("200")){
                                JSONArray arrayCliente = response.getJSONArray("data");
                                for(int i=0;i<arrayCliente.length();i++){
                                    JSONObject jsonCliente = arrayCliente.getJSONObject(i);
                                    String rfc = "RFC: "+jsonCliente.getString("rfc");
                                    String pnombrec = "Nombre: "+ jsonCliente.getString("pnombrec");
                                    String apellidopc = "Apellido paterno: "+jsonCliente.getString("apellidopc");
                                    String apellidomc = "Apellido materno: "+jsonCliente.getString("apellidomc");
                                    String callec = "Calle: "+jsonCliente.getString("callec");
                                    String coloniac = "Colonia: "+jsonCliente.getString("coloniac");
                                    String cpc = "C.P.: "+jsonCliente.getString("cpc");
                                    String numerocallec = "# Calle: "+jsonCliente.getString("numerocallec");
                                    String estadoc = "Estado: "+jsonCliente.getString("estadoc");

                                    String dataString = rfc + "\n" + pnombrec + "\n" + apellidopc + "\n" + apellidomc + "\n" + callec + "\n" + coloniac + "\n" + cpc + "\n" + numerocallec + "\n" + estadoc;
                                    adapter.add(dataString);
                                }
                                adapter.notifyDataSetChanged();
                            }else{
                                Toast.makeText(ListarClientesActivity.this, "No hay productos disponibles", Toast.LENGTH_SHORT).show();
                            }
                        } catch (JSONException e) {
                            Toast.makeText(ListarClientesActivity.this, "Error: "+e.getMessage(), Toast.LENGTH_SHORT).show();
                        }
                    }

                    @Override
                    public void onError(ANError anError) {
                        Toast.makeText(ListarClientesActivity.this, "Error: "+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                    }
                });
    }
}
