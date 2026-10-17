package `in`.sreerajp.qr_studio

import android.content.Context
import android.content.SharedPreferences

/**
 * Small native preference store for the Scan bubble.
 *
 * Kept on the native side because the boot receiver and the Quick Settings
 * tile run without the Flutter engine. Holds no sensitive data: only on/off
 * flags and the last bubble position.
 */
object ScanBubblePrefs {
    private const val FILE = "scan_bubble_prefs"
    private const val KEY_ENABLED = "enabled"
    private const val KEY_START_ON_BOOT = "start_on_boot"
    private const val KEY_X = "pos_x"
    private const val KEY_Y = "pos_y"

    private fun prefs(context: Context): SharedPreferences =
        context.applicationContext.getSharedPreferences(FILE, Context.MODE_PRIVATE)

    fun isEnabled(context: Context): Boolean = prefs(context).getBoolean(KEY_ENABLED, false)

    fun setEnabled(context: Context, value: Boolean) {
        prefs(context).edit().putBoolean(KEY_ENABLED, value).apply()
    }

    fun isStartOnBoot(context: Context): Boolean = prefs(context).getBoolean(KEY_START_ON_BOOT, false)

    fun setStartOnBoot(context: Context, value: Boolean) {
        prefs(context).edit().putBoolean(KEY_START_ON_BOOT, value).apply()
    }

    fun getX(context: Context): Int = prefs(context).getInt(KEY_X, -1)

    fun getY(context: Context): Int = prefs(context).getInt(KEY_Y, -1)

    fun setPosition(context: Context, x: Int, y: Int) {
        prefs(context).edit().putInt(KEY_X, x).putInt(KEY_Y, y).apply()
    }

    /** Removes every saved value (used by "Delete all data"). */
    fun clear(context: Context) {
        prefs(context).edit().clear().commit()
    }
}
