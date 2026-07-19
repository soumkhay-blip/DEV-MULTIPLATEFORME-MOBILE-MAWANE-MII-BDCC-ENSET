package com.example.tpcompose.ui

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import com.example.tpcompose.R

@Composable
fun SecondScreen(
    username: String,
    password: String,
    onBack: () -> Unit
) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(24.dp),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(text = stringResource(id = R.string.second_title), style = MaterialTheme.typography.titleLarge)
        Text(text = "${stringResource(id = R.string.username_label)} $username", modifier = Modifier.padding(top = 16.dp))
        Text(text = "${stringResource(id = R.string.password_label)} $password", modifier = Modifier.padding(top = 8.dp))

        Button(onClick = onBack, modifier = Modifier.padding(top = 24.dp)) {
            Text(text = stringResource(id = R.string.back))
        }
    }
}
