package com.victorystudio.progress_kit

import android.app.Activity
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.ListView
import android.widget.ArrayAdapter
import android.content.SharedPreferences
import org.json.JSONArray

class WidgetConfigActivity : Activity() {

    private lateinit var progressList: List<String>
    private lateinit var sharedPreferences: SharedPreferences

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_widget_config)

        sharedPreferences = getSharedPreferences("ProgressKitPrefs", Context.MODE_PRIVATE)

        // Get the widget ID from intent
        val appWidgetId = intent.extras?.getInt(AppWidgetManager.EXTRA_APPWIDGET_ID, AppWidgetManager.INVALID_APPWIDGET_ID)
            ?: AppWidgetManager.INVALID_APPWIDGET_ID

        // If the ID is invalid, close the activity
        if (appWidgetId == AppWidgetManager.INVALID_APPWIDGET_ID) {
            finish()
            return
        }

        // Load progress titles from SharedPreferences
        progressList = getSavedProgressTitles()

        val listView: ListView = findViewById(R.id.progress_list_view)
        val adapter = ArrayAdapter(this, android.R.layout.simple_list_item_1, progressList)
        listView.adapter = adapter

        listView.setOnItemClickListener { _, _, position, _ ->
            val selectedTitle = progressList[position]

            // Save selected progress title to SharedPreferences
            saveSelectedProgress(appWidgetId, selectedTitle)

            // Set the result to return to the widget
            val resultIntent = Intent()
            resultIntent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId)
            setResult(Activity.RESULT_OK, resultIntent)

            // Update the widget
            val widgetManager = AppWidgetManager.getInstance(this)
            HomeScreenWidget.updateWidget(this, widgetManager, appWidgetId)

            // Close activity
            finish()
        }

        val cancelButton: Button = findViewById(R.id.cancel_button)
        cancelButton.setOnClickListener {
            setResult(Activity.RESULT_CANCELED)
            finish()
        }
    }

    private fun getSavedProgressTitles(): List<String> {
        val progressTitlesJson = sharedPreferences.getString("progressTitles", "[]") ?: "[]"
        val progressTitlesList = mutableListOf<String>()

        // Convert JSON array to a list of strings
        val jsonArray = JSONArray(progressTitlesJson)
        for (i in 0 until jsonArray.length()) {
            val title = jsonArray.getString(i)
            progressTitlesList.add(title)
        }

        return progressTitlesList
    }

    private fun saveSelectedProgress(appWidgetId: Int, title: String) {
        sharedPreferences.edit().putString("Widget_$appWidgetId", title).apply()
    }
}
