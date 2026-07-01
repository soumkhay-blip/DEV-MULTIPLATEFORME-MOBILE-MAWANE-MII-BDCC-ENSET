package com.enset.mobilenatifp2

import android.app.DatePickerDialog
import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.ContextMenu
import android.view.GestureDetector
import android.view.MenuItem
import android.view.MotionEvent
import android.view.View
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.enset.mobilenatifp2.databinding.ActivityMainBinding
import java.util.Calendar
import kotlin.math.abs

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private lateinit var detecteurGestes: GestureDetector

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        configurerClick()
        configurerTouch()
        configurerSaisie()
        configurerSpinner()
        configurerMenuContextuel()
        configurerDate()
        configurerSwipe()

        binding.btnMeteo.setOnClickListener { ouvrirMeteo() }
    }

    private fun configurerClick() {
        binding.btnClick.setOnClickListener {
            Toast.makeText(this, "Button click", Toast.LENGTH_SHORT).show()
            binding.textResult.text = getString(R.string.simple_click)
        }
        binding.btnClick.setOnLongClickListener {
            Toast.makeText(this, "Button long click", Toast.LENGTH_SHORT).show()
            binding.textResult.text = getString(R.string.long_click)
            true
        }
    }

    private fun configurerTouch() {
        binding.zoneTouch.setOnTouchListener { vue, event ->
            val action = when (event.action) {
                MotionEvent.ACTION_DOWN -> "Touch : DOWN"
                MotionEvent.ACTION_MOVE -> "Touch : MOVE"
                MotionEvent.ACTION_UP -> "Touch : UP"
                else -> "Touch : ?"
            }
            binding.textResult.text = action
            vue.performClick()
            true
        }
    }

    private fun configurerSaisie() {
        binding.editNom.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                binding.textResult.text = getString(R.string.saisie, s?.toString() ?: "")
            }
            override fun afterTextChanged(s: Editable?) {}
        })
    }

    private fun configurerSpinner() {
        val options = resources.getStringArray(R.array.langages)
        binding.spinnerLangage.adapter =
            ArrayAdapter(this, android.R.layout.simple_spinner_dropdown_item, options)
        binding.spinnerLangage.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {
                binding.textResult.text = getString(R.string.selection, options[position])
            }

            override fun onNothingSelected(parent: AdapterView<*>?) {}
        }
    }

    private fun configurerMenuContextuel() {
        registerForContextMenu(binding.textContextMenu)
    }

    override fun onCreateContextMenu(
        menu: ContextMenu,
        v: View,
        menuInfo: ContextMenu.ContextMenuInfo?
    ) {
        super.onCreateContextMenu(menu, v, menuInfo)
        menu.setHeaderTitle(getString(R.string.menu_titre))
        menu.add(0, 1, 0, getString(R.string.menu_copier))
        menu.add(0, 2, 1, getString(R.string.menu_partager))
    }

    override fun onContextItemSelected(item: MenuItem): Boolean {
        binding.textResult.text = getString(R.string.menu_choisi, item.title)
        return true
    }

    private fun configurerDate() {
        binding.btnDate.setOnClickListener {
            val aujourdhui = Calendar.getInstance()
            DatePickerDialog(
                this,
                { _, annee, mois, jour ->
                    binding.textResult.text = getString(R.string.date_choisie, jour, mois + 1, annee)
                },
                aujourdhui.get(Calendar.YEAR),
                aujourdhui.get(Calendar.MONTH),
                aujourdhui.get(Calendar.DAY_OF_MONTH)
            ).show()
        }
    }

    private fun configurerSwipe() {
        detecteurGestes = GestureDetector(this, object : GestureDetector.SimpleOnGestureListener() {
            override fun onFling(
                e1: MotionEvent?,
                e2: MotionEvent,
                velocityX: Float,
                velocityY: Float
            ): Boolean {
                if (e1 == null) return false
                val deltaX = e2.x - e1.x
                if (abs(deltaX) > SEUIL && abs(velocityX) > SEUIL) {
                    if (deltaX < 0) {
                        binding.textResult.text = getString(R.string.swipe_gauche)
                        ouvrirMeteo()
                    } else {
                        binding.textResult.text = getString(R.string.swipe_droite)
                    }
                    return true
                }
                return false
            }
        })
        binding.activity1.setOnTouchListener { vue, event ->
            vue.performClick()
            detecteurGestes.onTouchEvent(event)
        }
    }

    private fun ouvrirMeteo() {
        startActivity(Intent(this, WeatherActivity::class.java))
    }

    companion object {
        private const val SEUIL = 150
    }
}
