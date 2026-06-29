package com.example.imc_app;

import android.graphics.Color;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class MainActivity extends AppCompatActivity {

    private EditText editTextPoids;
    private EditText editTextTaille;
    private Button btnCalculer;
    private TextView textViewImc;
    private TextView textViewCategorie;
    private ImageView imageViewCategorie;
    private ListView listViewHisto;

    private final List<String> historique = new ArrayList<>();
    private ArrayAdapter<String> adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        editTextPoids = findViewById(R.id.editTextPoids);
        editTextTaille = findViewById(R.id.editTextTaille);
        btnCalculer = findViewById(R.id.btnCalculer);
        textViewImc = findViewById(R.id.textViewImc);
        textViewCategorie = findViewById(R.id.textViewCategorie);
        imageViewCategorie = findViewById(R.id.imageViewCategorie);
        listViewHisto = findViewById(R.id.listViewHisto);

        adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, historique);
        listViewHisto.setAdapter(adapter);

        btnCalculer.setOnClickListener(view -> calculerImc());
    }

    private void calculerImc() {
        String poidsStr = editTextPoids.getText().toString().trim();
        String tailleStr = editTextTaille.getText().toString().trim();

        if (poidsStr.isEmpty() || tailleStr.isEmpty()) {
            Toast.makeText(this, R.string.msg_champs, Toast.LENGTH_SHORT).show();
            return;
        }

        double poids;
        double taille;
        try {
            poids = Double.parseDouble(poidsStr);
            taille = Double.parseDouble(tailleStr);
        } catch (NumberFormatException ex) {
            Toast.makeText(this, R.string.msg_invalide, Toast.LENGTH_SHORT).show();
            return;
        }

        if (poids <= 0 || taille <= 0) {
            Toast.makeText(this, R.string.msg_positif, Toast.LENGTH_SHORT).show();
            return;
        }

        double imc = poids / (taille * taille);
        String imcTexte = String.format(Locale.getDefault(), "%.2f", imc);
        textViewImc.setText(getString(R.string.label_imc, imcTexte));

        appliquerCategorie(imc);

        historique.add(getString(R.string.histo_ligne, poidsStr, tailleStr, imcTexte));
        adapter.notifyDataSetChanged();
    }

    private void appliquerCategorie(double imc) {
        int labelRes;
        int couleur;

        if (imc < 18.5) {
            labelRes = R.string.cat_maigreur;
            couleur = Color.parseColor("#2196F3");
        } else if (imc < 25) {
            labelRes = R.string.cat_normal;
            couleur = Color.parseColor("#4CAF50");
        } else if (imc < 30) {
            labelRes = R.string.cat_surpoids;
            couleur = Color.parseColor("#FF9800");
        } else if (imc < 35) {
            labelRes = R.string.cat_obesite1;
            couleur = Color.parseColor("#FF5722");
        } else if (imc < 40) {
            labelRes = R.string.cat_obesite2;
            couleur = Color.parseColor("#E53935");
        } else {
            labelRes = R.string.cat_obesite3;
            couleur = Color.parseColor("#B71C1C");
        }

        textViewCategorie.setText(labelRes);
        textViewCategorie.setTextColor(couleur);
        imageViewCategorie.setImageResource(R.drawable.ic_person);
        imageViewCategorie.setColorFilter(couleur);
    }
}
