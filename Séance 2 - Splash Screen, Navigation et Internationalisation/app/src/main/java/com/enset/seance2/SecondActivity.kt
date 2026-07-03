package com.enset.seance2

import android.content.Context
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.enset.seance2.databinding.ActivitySecondBinding

class SecondActivity : AppCompatActivity() {

    private lateinit var binding: ActivitySecondBinding

    override fun attachBaseContext(newBase: Context) {
        super.attachBaseContext(LocaleHelper.appliquer(newBase))
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivitySecondBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val nom = intent.getStringExtra("NOM") ?: ""
        binding.textBienvenue.text = getString(R.string.bienvenue, nom)

        binding.btnRetour.setOnClickListener { finish() }
    }
}
