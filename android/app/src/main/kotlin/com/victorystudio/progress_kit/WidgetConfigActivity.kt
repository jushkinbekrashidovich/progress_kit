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

        // Get the widget ID from the intent
        val appWidgetId = intent.getIntExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, AppWidgetManager.INVALID_APPWIDGET_ID)

        if (appWidgetId == AppWidgetManager.INVALID_APPWIDGET_ID) {
            setResult(Activity.RESULT_CANCELED)
            finish()
            return
        }

        // Load progress titles
        progressList = getSavedProgressTitles()

        val listView: ListView = findViewById(R.id.progress_list_view)
        val adapter = ArrayAdapter(this, android.R.layout.simple_list_item_1, progressList)
        listView.adapter = adapter

        // Handle selection
        listView.setOnItemClickListener { _, _, position, _ ->
            val selectedTitle = progressList[position]

            // Save selection
            saveSelectedProgress(appWidgetId, selectedTitle)

            // Update widget
            val widgetManager = AppWidgetManager.getInstance(this)
            HomeScreenWidget.updateWidget(this, widgetManager, appWidgetId)

            // Return result and finish
            val resultIntent = Intent().putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId)
            setResult(Activity.RESULT_OK, resultIntent)
            finish()
        }

        // Handle cancel button
        val cancelButton: Button = findViewById(R.id.cancel_button)
        cancelButton.setOnClickListener {
            setResult(Activity.RESULT_CANCELED)
            finish()
        }
    }

    // Retrieve progress titles from SharedPreferences
    private fun getSavedProgressTitles(): List<String> {
        val progressJson = sharedPreferences.getString("ProgressList", "[]") ?: "[]"
        val progressList = mutableListOf<String>()

        try {
            val jsonArray = JSONArray(progressJson)
            for (i in 0 until jsonArray.length()) {
                val jsonObject = jsonArray.getJSONObject(i)
                val title = jsonObject.optString("title", "Untitled Progress")
                progressList.add(title)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }

        return progressList
    }

    // Save selected progress title for this widget
    private fun saveSelectedProgress(appWidgetId: Int, title: String) {
        sharedPreferences.edit().putString("Widget_$appWidgetId", title).apply()
    }
}
