package com.example.papews;

import android.os.Bundle;
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
import com.androidnetworking.interfaces.StringRequestListener;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class GananciasActivity extends AppCompatActivity {

    private EditText edtFecha1;
    private EditText edtFecha2;
    private Button btnCalcularG;
    private TextView txtGanancias;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ganancias_ventas);

        AndroidNetworking.initialize(getApplicationContext());
        edtFecha1 = findViewById(R.id.edtFecha1);
        edtFecha2 = findViewById(R.id.edtFecha2);
        btnCalcularG = findViewById(R.id.btnCalcularG);
        txtGanancias = findViewById(R.id.txtGanancias);

        btnCalcularG.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                calcularGanancias();
            }
        });
    }

    private void calcularGanancias(){
        if(isValidarCampos()){
            String fecha1 = edtFecha1.getText().toString();
            String fecha2 = edtFecha2.getText().toString();
            AndroidNetworking.get(Constantes.URL_GANANCIAS)
                    .addPathParameter("FECHA1",fecha1)
                    .addPathParameter("FECHA2", fecha2)
                    .setPriority(Priority.MEDIUM)
                    .build()
                    .getAsString(new StringRequestListener() {
                        @Override
                        public void onResponse(String response) {
                            String resultado = response.toString();
                            String sbuscado = "total";
                            int cont=0;
                            while(resultado.indexOf(sbuscado)>-1){
                                resultado=resultado.substring(resultado.indexOf(sbuscado)+sbuscado.length(),resultado.length());
                                cont++;
                            }
                            String ganancia = resultado.replace("\"","");
                            ganancia = ganancia.replace(":","");
                            ganancia = ganancia.replace("}","");
                            ganancia = ganancia.replace("]","");
                            ganancia = ganancia.replace(",","");
                            ganancia = ganancia.replace("e","");
                            ganancia = ganancia.replace("r","");
                            ganancia = ganancia.replace("o","");
                            txtGanancias.setText("Ganancias: $"+ganancia+" MXN");
                        }

                        @Override
                        public void onError(ANError anError) {

                        }
                    });
        }else{
            Toast.makeText(this, "Necesito las dos fechas", Toast.LENGTH_SHORT).show();
        }
    }

    private boolean isValidarCampos(){
        return !edtFecha1.getText().toString().trim().isEmpty() &&
                !edtFecha2.getText().toString().trim().isEmpty();

    }
}
