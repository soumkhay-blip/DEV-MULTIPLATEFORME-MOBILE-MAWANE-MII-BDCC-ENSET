package com.example.tpcompose.ui

import android.widget.Toast
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.combinedClickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import com.example.tpcompose.R

@OptIn(ExperimentalFoundationApi::class)
@Composable
fun ClickLongClickScreen() {
    val context = LocalContext.current
    var resultText by remember { mutableStateOf("") }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(24.dp),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(
            text = stringResource(id = R.string.click_text),
            style = MaterialTheme.typography.titleLarge
        )

        val clickResult = stringResource(id = R.string.click_result)
        val longClickResult = stringResource(id = R.string.longclick_result)

        Text(
            text = stringResource(id = R.string.click_button),
            color = Color.White,
            modifier = Modifier
                .padding(top = 32.dp)
                .background(color = Color(0xFF6200EE), shape = RoundedCornerShape(8.dp))
                .combinedClickable(
                    interactionSource = remember { MutableInteractionSource() },
                    indication = null,
                    onClick = {
                        Toast.makeText(context, "Button click", Toast.LENGTH_SHORT).show()
                        resultText = clickResult
                    },
                    onLongClick = {
                        Toast.makeText(context, "Button Long click", Toast.LENGTH_SHORT).show()
                        resultText = longClickResult
                    }
                )
                .padding(horizontal = 24.dp, vertical = 12.dp)
        )

        Text(
            text = resultText,
            color = Color(0xFFBB86FC),
            style = MaterialTheme.typography.bodyLarge,
            modifier = Modifier.padding(top = 24.dp)
        )
    }
}
