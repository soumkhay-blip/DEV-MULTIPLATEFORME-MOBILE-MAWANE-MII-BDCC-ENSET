package com.example.tpcompose.ui

import androidx.compose.runtime.Composable
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument

private object Routes {
    const val SPLASH = "splash"
    const val HOME = "home"
    const val CLICK_DEMO = "click_demo"
    const val LOGIN = "login"
    const val SECOND = "second/{username}/{password}"
}

@Composable
fun TpComposeNavHost() {
    val navController = rememberNavController()

    NavHost(navController = navController, startDestination = Routes.SPLASH) {
        composable(Routes.SPLASH) {
            SplashScreen(onTimeout = {
                navController.navigate(Routes.HOME) {
                    popUpTo(Routes.SPLASH) { inclusive = true }
                }
            })
        }
        composable(Routes.HOME) {
            HomeScreen(
                onOpenClickDemo = { navController.navigate(Routes.CLICK_DEMO) },
                onOpenLoginDemo = { navController.navigate(Routes.LOGIN) }
            )
        }
        composable(Routes.CLICK_DEMO) {
            ClickLongClickScreen()
        }
        composable(Routes.LOGIN) {
            LoginScreen(onSignedIn = { username, password ->
                navController.navigate("second/$username/$password")
            })
        }
        composable(
            Routes.SECOND,
            arguments = listOf(
                navArgument("username") { type = NavType.StringType },
                navArgument("password") { type = NavType.StringType }
            )
        ) { backStackEntry ->
            val username = backStackEntry.arguments?.getString("username").orEmpty()
            val password = backStackEntry.arguments?.getString("password").orEmpty()
            SecondScreen(
                username = username,
                password = password,
                onBack = { navController.popBackStack() }
            )
        }
    }
}
