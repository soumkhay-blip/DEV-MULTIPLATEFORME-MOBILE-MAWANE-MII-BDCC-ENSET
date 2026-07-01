package com.enset.mobilenatifp2

import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.MotionEvent
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.enset.mobilenatifp2.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.btnClick.setOnClickListener {
            Toast.makeText(this, "Button click", Toast.LENGTH_SHORT).show()
            binding.textResult.text = getString(R.string.simple_click)
        }

        binding.btnClick.setOnLongClickListener {
            Toast.makeText(this, "Button long click", Toast.LENGTH_SHORT).show()
            binding.textResult.text = getString(R.string.long_click)
            true
        }

        binding.zoneTouch.setOnTouchListener { _, event ->
            val action = when (event.action) {
                MotionEvent.ACTION_DOWN -> "Touch : DOWN"
                MotionEvent.ACTION_MOVE -> "Touch : MOVE"
                MotionEvent.ACTION_UP -> "Touch : UP"
                else -> "Touch : ?"
            }
            binding.textResult.text = action
            true
        }

        binding.editNom.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                binding.textResult.text = getString(R.string.saisie, s?.toString() ?: "")
            }
            override fun afterTextChanged(s: Editable?) {}
        })

        binding.btnMeteo.setOnClickListener {
            startActivity(Intent(this, WeatherActivity::class.java))
        }
    }
}
