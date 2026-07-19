package com.enset.seance2

import android.content.Context
import android.content.res.Configuration
import java.util.Locale

object LocaleHelper {
    private const val PREFS = "prefs_langue"
    private const val CLE = "langue"

    fun sauver(context: Context, langue: String) {
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
            .edit()
            .putString(CLE, langue)
            .apply()
    }

    fun langueCourante(context: Context): String {
        return context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
            .getString(CLE, "fr") ?: "fr"
    }

    fun appliquer(context: Context): Context {
        val locale = Locale(langueCourante(context))
        Locale.setDefault(locale)
        val config = Configuration(context.resources.configuration)
        config.setLocale(locale)
        return context.createConfigurationContext(config)
    }
}
