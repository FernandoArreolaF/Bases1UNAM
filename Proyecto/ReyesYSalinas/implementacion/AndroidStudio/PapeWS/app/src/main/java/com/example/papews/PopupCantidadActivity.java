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

public class PopupCantidadActivity extends AppCompatActivity {

    public TextView txtProducto;
    private EditText edtFechaCrea;
    private EditText edtRfcCrea;
    private EditText edtCodigoCrea;
    private EditText edtCantidadV;
    private Button btnCantidadV;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_popup_venta);
        AndroidNetworking.initialize(getApplicationContext());

        txtProducto = findViewById(R.id.txtProducto);
        edtFechaCrea = findViewById(R.id.edtFechaCrea);
        edtRfcCrea = findViewById(R.id.edtRfcCrea);
        edtCodigoCrea = findViewById(R.id.edtCodigoCrea);
        edtCantidadV = findViewById(R.id.edtCantidadV);
        btnCantidadV = findViewById(R.id.btnCantidadV);

        btnCantidadV.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                crearVenta();
            }
        });

        DisplayMetrics medidaVentana = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(medidaVentana);

        int ancho = medidaVentana.widthPixels;
        int alto = medidaVentana.heightPixels;

        getWindow().setLayout((int)(ancho * 0.85), (int)(alto * 0.7));
        txtProducto.setText(NomProducto);
    }

    private void crearVenta(){
        if(isValidarCampos()){
            String rfc = edtRfcCrea.getText().toString();
            String fechav = edtFechaCrea.getText().toString();
            String codigo = edtCodigoCrea.getText().toString();
            String cantidad = edtCantidadV.getText().toString();

            Map<String,String> datos = new HashMap<>();
            datos.put("FECHAV",fechav);
            datos.put("RFC",rfc);
            datos.put("CODIGOBARRAS",codigo);
            datos.put("CANTIDADPROD",cantidad);

            JSONObject jsonData = new JSONObject(datos);
            AndroidNetworking.post(Constantes.URL_CREAR_VENTA)
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
                                Toast.makeText(PopupCantidadActivity.this, estado, Toast.LENGTH_SHORT).show();
                            } catch (JSONException e) {
                                Toast.makeText(PopupCantidadActivity.this, "Error"+e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }

                        @Override
                        public void onError(ANError anError) {
                            Toast.makeText(PopupCantidadActivity.this, "Error"+anError.getErrorDetail(), Toast.LENGTH_SHORT).show();
                        }
                    });
        }else{
            Toast.makeText(this, "Rellena todos los campos", Toast.LENGTH_SHORT).show();
        }
    }

    private boolean isValidarCampos(){
        return !edtFechaCrea.getText().toString().trim().isEmpty() &&
                !edtRfcCrea.getText().toString().trim().isEmpty() &&
                !edtCodigoCrea.getText().toString().trim().isEmpty() &&
                !edtCantidadV.getText().toString().trim().isEmpty();

    }
}
