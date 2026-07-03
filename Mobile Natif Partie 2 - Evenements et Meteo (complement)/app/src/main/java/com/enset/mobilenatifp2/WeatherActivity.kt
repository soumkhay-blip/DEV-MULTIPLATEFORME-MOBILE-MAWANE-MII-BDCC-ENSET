package com.enset.mobilenatifp2

import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.enset.mobilenatifp2.databinding.ActivityWeatherBinding
import org.json.JSONObject
import java.net.HttpURLConnection
import java.net.URL
import kotlin.concurrent.thread

class WeatherActivity : AppCompatActivity() {

    private lateinit var binding: ActivityWeatherBinding
    private lateinit var adapter: ForecastAdapter
    private val previsions = mutableListOf<Forecast>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityWeatherBinding.inflate(layoutInflater)
        setContentView(binding.root)

        adapter = ForecastAdapter(this, previsions)
        binding.listePrevisions.adapter = adapter

        binding.btnRechercher.setOnClickListener {
            val ville = binding.editVille.text.toString().trim()
            if (ville.isEmpty()) {
                Toast.makeText(this, getString(R.string.ville_vide), Toast.LENGTH_SHORT).show()
            } else {
                chargerMeteo(ville)
            }
        }
    }

    private fun chargerMeteo(ville: String) {
        binding.progression.visibility = android.view.View.VISIBLE
        val url = "https://api.openweathermap.org/data/2.5/forecast?q=$ville" +
                "&units=metric&lang=fr&appid=$API_KEY"
        thread {
            try {
                val connexion = URL(url).openConnection() as HttpURLConnection
                connexion.requestMethod = "GET"
                val code = connexion.responseCode
                if (code != 200) {
                    afficherErreur(getString(R.string.ville_introuvable))
                    return@thread
                }
                val corps = connexion.inputStream.bufferedReader().use { it.readText() }
                val liste = parser(corps)
                runOnUiThread {
                    binding.progression.visibility = android.view.View.GONE
                    binding.titreVille.text = ville
                    previsions.clear()
                    previsions.addAll(liste)
                    adapter.notifyDataSetChanged()
                }
            } catch (e: Exception) {
                afficherErreur(getString(R.string.erreur_reseau))
            }
        }
    }

    private fun parser(json: String): List<Forecast> {
        val resultat = mutableListOf<Forecast>()
        val racine = JSONObject(json)
        val tableau = racine.getJSONArray("list")
        for (i in 0 until tableau.length()) {
            val item = tableau.getJSONObject(i)
            val main = item.getJSONObject("main")
            val meteo = item.getJSONArray("weather").getJSONObject(0)
            resultat.add(
                Forecast(
                    dateHeure = item.getString("dt_txt"),
                    tempMax = main.getDouble("temp_max"),
                    tempMin = main.getDouble("temp_min"),
                    pression = main.getInt("pressure"),
                    humidite = main.getInt("humidity"),
                    description = meteo.getString("description"),
                    principal = meteo.getString("main")
                )
            )
        }
        return resultat
    }

    private fun afficherErreur(message: String) {
        runOnUiThread {
            binding.progression.visibility = android.view.View.GONE
            Toast.makeText(this, message, Toast.LENGTH_LONG).show()
        }
    }

    companion object {
        private const val API_KEY = "b6907d289e10d714a6e88b30761fae22"
    }
}
