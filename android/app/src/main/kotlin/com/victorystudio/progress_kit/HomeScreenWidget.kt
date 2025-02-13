package com.victorystudio.progress_kit

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews

class HomeScreenWidget : AppWidgetProvider() {

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        for (appWidgetId in appWidgetIds) {
            updateWidget(context, appWidgetManager, appWidgetId)
        }
    }

    companion object {
        fun updateWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
            val prefs = context.getSharedPreferences("ProgressKitPrefs", Context.MODE_PRIVATE)
            val selectedTitle = prefs.getString("Widget_$appWidgetId", "No Progress Selected")

            val views = RemoteViews(context.packageName, R.layout.home_screen_widget)
            views.setTextViewText(R.id.widget_title, selectedTitle)

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
