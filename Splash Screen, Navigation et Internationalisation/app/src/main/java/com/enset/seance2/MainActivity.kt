package com.enset.seance2

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.enset.seance2.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun attachBaseContext(newBase: Context) {
        super.attachBaseContext(LocaleHelper.appliquer(newBase))
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.btnAller.setOnClickListener {
            val nom = binding.editNom.text.toString().trim()
            if (nom.isEmpty()) {
                Toast.makeText(this, getString(R.string.nom_vide), Toast.LENGTH_SHORT).show()
            } else {
                val intent = Intent(this, SecondActivity::class.java)
                intent.putExtra("NOM", nom)
                startActivity(intent)
            }
        }

        binding.btnFr.setOnClickListener { changerLangue("fr") }
        binding.btnAr.setOnClickListener { changerLangue("ar") }
    }

    private fun changerLangue(langue: String) {
        LocaleHelper.sauver(this, langue)
        recreate()
    }
}
