package com.enset.mobilenatifp2

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.ImageView
import android.widget.TextView

class ForecastAdapter(
    private val context: Context,
    private val elements: List<Forecast>
) : BaseAdapter() {

    override fun getCount(): Int = elements.size

    override fun getItem(position: Int): Any = elements[position]

    override fun getItemId(position: Int): Long = position.toLong()

    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        val vue = convertView ?: LayoutInflater.from(context)
            .inflate(R.layout.item_forecast, parent, false)
        val f = elements[position]

        vue.findViewById<TextView>(R.id.itemDate).text = f.dateHeure
        vue.findViewById<TextView>(R.id.itemDescription).text = f.description
        vue.findViewById<TextView>(R.id.itemTemp).text =
            context.getString(R.string.temp_min_max, f.tempMin, f.tempMax)
        vue.findViewById<TextView>(R.id.itemDetails).text =
            context.getString(R.string.pression_humidite, f.pression, f.humidite)

        val (icone, couleur) = iconePour(f.principal)
        val image = vue.findViewById<ImageView>(R.id.itemIcone)
        image.setImageResource(icone)
        image.setColorFilter(couleur)
        return vue
    }

    private fun iconePour(principal: String): Pair<Int, Int> = when (principal) {
        "Clear" -> R.drawable.ic_sun to 0xFFFFB300.toInt()
        "Thunderstorm" -> R.drawable.ic_bolt to 0xFF673AB7.toInt()
        "Rain", "Drizzle" -> R.drawable.ic_cloud to 0xFF2196F3.toInt()
        "Snow" -> R.drawable.ic_cloud to 0xFF90CAF9.toInt()
        else -> R.drawable.ic_cloud to 0xFF9E9E9E.toInt()
    }
}
