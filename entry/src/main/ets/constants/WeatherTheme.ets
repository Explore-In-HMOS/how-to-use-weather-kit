/**
 * Weather Cards Library - Theme Constants
 * Enhanced from common/UIConstants.ets for standalone usage
 */

// ===== COLOR SYSTEM =====

// Primary color palette - Dark theme optimized for OLED displays
export class WeatherColors {
  // Background colors
  static readonly BACKGROUND = '#000000';          // Pure black for OLED efficiency
  static readonly CARD = '#1A1A1A';               // Dark gray for cards
  static readonly CARD_ELEVATED = '#2A2A2A';      // Slightly lighter for elevated cards
  
  // Text colors
  static readonly TEXT_PRIMARY = '#FFFFFF';        // White for main text
  static readonly TEXT_SECONDARY = '#CCCCCC';      // Light gray for details
  static readonly TEXT_TERTIARY = '#999999';       // Medium gray for subtle text
  static readonly TEXT_DISABLED = '#666666';       // Dark gray for disabled text
  
  // Accent colors
  static readonly ACCENT = '#1E90FF';              // Blue for interactive elements
  static readonly ACCENT_HOVER = '#4169E1';        // Darker blue for hover states
  static readonly WARNING = '#FF6B35';             // Orange for warnings/alerts
  static readonly SUCCESS = '#32CD32';             // Green for positive indicators
  static readonly ERROR = '#FF4444';               // Red for errors
  
  // Temperature-specific colors
  static readonly TEMP_HOT = '#FF6B35';            // Hot temperatures (>30°C)
  static readonly TEMP_WARM = '#FFD700';           // Warm temperatures (20-30°C)
  static readonly TEMP_MILD = '#87CEEB';           // Mild temperatures (10-20°C)
  static readonly TEMP_COOL = '#4169E1';           // Cool temperatures (0-10°C)
  static readonly TEMP_COLD = '#6495ED';           // Cold temperatures (<0°C)
  
  // Weather condition colors
  static readonly SUNNY_COLOR = '#FFD700';         // Gold for sunny
  static readonly CLOUDY_COLOR = '#B0C4DE';        // Light steel blue for clouds
  static readonly RAINY_COLOR = '#4682B4';         // Steel blue for rain
  static readonly SNOWY_COLOR = '#F0F8FF';         // Alice blue for snow
  static readonly STORMY_COLOR = '#696969';        // Dim gray for storms
  
  // UI element colors
  static readonly BORDER = '#333333';              // Border color
  static readonly BORDER_LIGHT = '#555555';        // Light border color
  static readonly DIVIDER = '#444444';             // Divider color
  static readonly SHADOW = 'rgba(0, 0, 0, 0.3)';   // Shadow color
  
  // TTS and interaction colors
  static readonly TTS_HIGHLIGHT = '#FFD700';       // Word highlighting during TTS
  static readonly TTS_BUTTON = '#0D2A4A';          // TTS button background
  static readonly PROGRESS = '#1E90FF';            // Progress indicators
  static readonly PROGRESS_BACKGROUND = '#333333'; // Progress track background
}

// Light theme alternative (for accessibility or user preference)
export class WeatherColorsLight {
  static readonly BACKGROUND = '#FFFFFF';
  static readonly CARD = '#F8F9FA';
  static readonly CARD_ELEVATED = '#FFFFFF';
  
  static readonly TEXT_PRIMARY = '#212529';
  static readonly TEXT_SECONDARY = '#6C757D';
  static readonly TEXT_TERTIARY = '#ADB5BD';
  static readonly TEXT_DISABLED = '#DEE2E6';
  
  static readonly ACCENT = '#0066CC';
  static readonly ACCENT_HOVER = '#0056B3';
  static readonly WARNING = '#FD7E14';
  static readonly SUCCESS = '#198754';
  static readonly ERROR = '#DC3545';
  
  static readonly BORDER = '#DEE2E6';
  static readonly BORDER_LIGHT = '#E9ECEF';
  static readonly DIVIDER = '#CED4DA';
  static readonly SHADOW = 'rgba(0, 0, 0, 0.15)';
}

// ===== TYPOGRAPHY SYSTEM =====

// Font sizes optimized for wearable displays
export class WeatherFonts {
  // Primary text sizes
  static readonly TEMPERATURE = 36;               // Large temperature display
  static readonly TEMPERATURE_LARGE = 48;         // Extra large for main temp
  static readonly TITLE = 18;                     // Card titles and headers
  static readonly TITLE_LARGE = 20;               // Larger titles
  static readonly BODY = 14;                      // Body text and details
  static readonly BODY_LARGE = 16;                // Larger body text
  static readonly CAPTION = 12;                   // Small details and labels
  static readonly CAPTION_SMALL = 10;             // Very small text
  
  // Icon sizes
  static readonly ICON_SMALL = 16;                // Small icons
  static readonly ICON_MEDIUM = 20;               // Medium icons
  static readonly ICON_LARGE = 24;                // Large icons
  static readonly ICON_EXTRA_LARGE = 32;          // Extra large icons
  
  // Line heights
  static readonly LINE_HEIGHT_TIGHT = 16;         // Tight line spacing
  static readonly LINE_HEIGHT_NORMAL = 20;        // Normal line spacing
  static readonly LINE_HEIGHT_RELAXED = 24;       // Relaxed line spacing
}


// ===== RESPONSIVE BREAKPOINTS =====

// Screen size breakpoints for different watch sizes
export class WeatherBreakpoints {
  static readonly SMALL_WATCH = 1.2;              // < 1.2 inch screens
  static readonly MEDIUM_WATCH = 1.6;             // 1.2 - 1.6 inch screens
  static readonly LARGE_WATCH = 2.0;              // > 1.6 inch screens
  
  // Responsive font scaling
  static getResponsiveFontSize(baseSize: number, screenSize: number): number {
    if (screenSize < WeatherBreakpoints.SMALL_WATCH) {
      return Math.max(baseSize * 0.9, 10 as number); // Scale down but maintain readability
    } else if (screenSize > WeatherBreakpoints.LARGE_WATCH) {
      return baseSize * 1.1; // Scale up for larger screens
    }
    return baseSize; // Default size for medium screens
  }
}