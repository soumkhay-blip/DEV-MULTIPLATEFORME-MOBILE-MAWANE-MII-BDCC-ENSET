package com.example.tpcompose.ui

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import com.example.tpcompose.R

@Composable
fun HomeScreen(
    onOpenClickDemo: () -> Unit,
    onOpenLoginDemo: () -> Unit
) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(24.dp),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(text = stringResource(id = R.string.home_title))

        Button(onClick = onOpenClickDemo, modifier = Modifier.padding(top = 24.dp)) {
            Text(text = stringResource(id = R.string.home_click_demo))
        }

        Button(onClick = onOpenLoginDemo, modifier = Modifier.padding(top = 12.dp)) {
            Text(text = stringResource(id = R.string.home_login_demo))
        }
    }
}
