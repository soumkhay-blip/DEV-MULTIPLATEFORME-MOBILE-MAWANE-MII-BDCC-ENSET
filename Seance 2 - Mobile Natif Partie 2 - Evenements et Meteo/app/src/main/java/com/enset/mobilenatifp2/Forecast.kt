package com.enset.mobilenatifp2

data class Forecast(
    val dateHeure: String,
    val tempMax: Double,
    val tempMin: Double,
    val pression: Int,
    val humidite: Int,
    val description: String,
    val principal: String
)
