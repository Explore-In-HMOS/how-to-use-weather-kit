/**
 * Weather Cards Library - Wearable Layout Constants
 * Enhanced from common/UIConstants.ets for wearable-optimized layouts
 */

// ===== CORE LAYOUT CONSTANTS =====

// Primary layout dimensions
export class WeatherLayout {
  // Card dimensions
  static readonly CARD_HEIGHT = 180;              // Standard card height
  static readonly CARD_HEIGHT_COMPACT = 140;      // Compact card height
  static readonly CARD_HEIGHT_LARGE = 220;        // Large card height
  static readonly CARD_PADDING = 16;              // Standard card padding
  static readonly CARD_PADDING_SMALL = 12;        // Small card padding
  static readonly CARD_PADDING_LARGE = 20;        // Large card padding
  
  // Border radius for consistent rounded corners
  static readonly BORDER_RADIUS = 16;             // Standard border radius
  static readonly BORDER_RADIUS_SMALL = 12;       // Small border radius
  static readonly BORDER_RADIUS_LARGE = 20;       // Large border radius
  static readonly BORDER_RADIUS_CIRCLE = 50;      // Circular elements
  
  // Spacing between elements
  static readonly ITEM_SPACING = 12;              // Standard item spacing
  static readonly ITEM_SPACING_SMALL = 8;         // Small spacing
  static readonly ITEM_SPACING_LARGE = 16;        // Large spacing
  static readonly SECTION_SPACING = 20;           // Spacing between sections
  
  // Icon dimensions
  static readonly ICON_SIZE = 24;                 // Standard icon size
  static readonly ICON_SIZE_SMALL = 16;           // Small icons
  static readonly ICON_SIZE_LARGE = 32;           // Large icons
  static readonly ICON_SIZE_EXTRA_LARGE = 48;     // Extra large icons
  
  // Button dimensions
  static readonly BUTTON_SIZE = 44;               // Standard button size
  static readonly BUTTON_SIZE_SMALL = 32;         // Small buttons
  static readonly BUTTON_SIZE_LARGE = 56;         // Large buttons
  static readonly BUTTON_PADDING = 12;            // Button padding
  static readonly BUTTON_PADDING_SMALL = 8;       // Small button padding
}

// ===== ARCLIST SPECIFIC CONSTANTS =====

// ArcList optimized settings for weather cards
export class WeatherArcListLayout {
  // ArcList spacing
  static readonly ARC_ITEM_SPACING = 8;           // Space between ArcList items
  static readonly ARC_ITEM_SPACING_COMPACT = 4;   // Compact spacing
  static readonly ARC_ITEM_SPACING_RELAXED = 12;  // Relaxed spacing
  
  // Card margins within ArcList
  static readonly ARC_CARD_MARGIN = 8;            // Horizontal card margins
  static readonly ARC_CARD_MARGIN_VERTICAL = 4;   // Vertical card margins
  
  // Focus and selection
  static readonly ARC_FOCUS_BORDER_WIDTH = 2;     // Focus indicator width
  static readonly ARC_SELECTION_SCALE = 1.02;     // Scale factor for selected items
}

// ===== RESPONSIVE LAYOUT SYSTEM =====

// Screen size specific layouts
export class WearableResponsiveLayout {
  // Small wearable devices (< 1.2 inch)
  static readonly SMALL_CARD_HEIGHT = 120;
  static readonly SMALL_CARD_PADDING = 12;
  static readonly SMALL_FONT_SCALE = 0.9;
  static readonly SMALL_ICON_SCALE = 0.8;
  static readonly SMALL_SPACING = 8;
  
  // Medium wearable devices (1.2 - 1.6 inch)
  static readonly MEDIUM_CARD_HEIGHT = 160;
  static readonly MEDIUM_CARD_PADDING = 16;
  static readonly MEDIUM_FONT_SCALE = 1.0;
  static readonly MEDIUM_ICON_SCALE = 1.0;
  static readonly MEDIUM_SPACING = 12;
  
  // Large wearable devices (> 1.6 inch)
  static readonly LARGE_CARD_HEIGHT = 200;
  static readonly LARGE_CARD_PADDING = 20;
  static readonly LARGE_FONT_SCALE = 1.1;
  static readonly LARGE_ICON_SCALE = 1.2;
  static readonly LARGE_SPACING = 16;
  
  // Get responsive values based on screen size
  static getCardHeight(screenSize: number): number {
    if (screenSize < 1.2) {
      return WearableResponsiveLayout.SMALL_CARD_HEIGHT
    };
    if (screenSize > 1.6) {
      return WearableResponsiveLayout.LARGE_CARD_HEIGHT
    };
    return WearableResponsiveLayout.MEDIUM_CARD_HEIGHT;
  }
  
  static getCardPadding(screenSize: number): number {
    if (screenSize < 1.2) {
      return WearableResponsiveLayout.SMALL_CARD_PADDING
    };
    if (screenSize > 1.6) {
      return WearableResponsiveLayout.LARGE_CARD_PADDING
    };
    return WearableResponsiveLayout.MEDIUM_CARD_PADDING;
  }
  
  static getSpacing(screenSize: number): number {
    if (screenSize < 1.2) {
      return WearableResponsiveLayout.SMALL_SPACING
    };
    if (screenSize > 1.6) {
      return WearableResponsiveLayout.LARGE_SPACING
    };
    return WearableResponsiveLayout.MEDIUM_SPACING;
  }
}

// ===== COMPONENT SPECIFIC LAYOUTS =====

// Current weather card layout
export class CurrentWeatherCardLayout {
  static readonly TEMPERATURE_SECTION_HEIGHT = 80;    // Temperature display area
  static readonly DETAILS_ROW_HEIGHT = 60;            // Weather details row
  static readonly LOCATION_HEIGHT = 24;               // Location text area
  static readonly CONDITION_ROW_HEIGHT = 32;          // Weather condition row
  static readonly MIN_HEIGHT = 180;                   // Minimum card height (increased)
  static readonly PREFERRED_HEIGHT = 240;             // Preferred card height (increased)
}

// Forecast card layout
export class ForecastCardLayout {
  static readonly HEADER_HEIGHT = 32;                 // Card header height
  static readonly FORECAST_ITEM_HEIGHT = 28;          // Each forecast row height
  static readonly FORECAST_ITEM_SPACING = 8;          // Spacing between forecast items
  static readonly ICON_COLUMN_WIDTH = 32;             // Weather icon column
  static readonly TEMP_COLUMN_WIDTH = 60;             // Temperature column
  static readonly DAY_COLUMN_WIDTH = 70;              // Day name column
  static readonly MAX_VISIBLE_DAYS = 5;               // Maximum days to show
}

// TTS announcement card layout
export class TTSCardLayout {
  static readonly HEADER_HEIGHT = 40;                 // Card header with title
  static readonly TEXT_AREA_MIN_HEIGHT = 80;          // Minimum text display area
  static readonly TEXT_AREA_MAX_HEIGHT = 120;         // Maximum text display area
  static readonly BUTTON_AREA_HEIGHT = 44;            // TTS button area
  static readonly PROGRESS_BAR_HEIGHT = 4;            // Progress indicator height
  static readonly LINE_HEIGHT = 20;                   // Text line height
  static readonly MAX_LINES = 6;                      // Maximum text lines
}

// Weather details row layout
export class WeatherDetailsLayout {
  static readonly ROW_HEIGHT = 60;                    // Total row height
  static readonly COLUMN_WIDTH = 60;                  // Each detail column width
  static readonly ICON_SIZE = 16;                     // Detail icons
  static readonly VALUE_HEIGHT = 20;                  // Value text height
  static readonly LABEL_HEIGHT = 16;                  // Label text height
  static readonly COLUMN_SPACING = 16;                // Spacing between columns
}

// ===== INTERACTION AREAS =====

// Touch target and interaction zones
export class WearableInteractionLayout {
  // Minimum touch targets for accessibility
  static readonly MIN_TOUCH_TARGET = 44;              // WCAG compliance
  static readonly COMFORTABLE_TOUCH_TARGET = 48;       // Comfortable for gloves
  static readonly LARGE_TOUCH_TARGET = 56;            // Large for primary actions
  
  // Gesture zones
  static readonly SWIPE_ZONE_HEIGHT = 60;             // Horizontal swipe detection
  static readonly EDGE_SWIPE_WIDTH = 20;              // Edge swipe detection width
  static readonly SCROLL_ZONE_MIN = 80;               // Minimum scrollable area
  
  // Focus and hover states
  static readonly FOCUS_OUTLINE_WIDTH = 2;            // Focus indicator width
  static readonly HOVER_SCALE = 1.05;                 // Hover scale effect
  static readonly PRESS_SCALE = 0.95;                 // Press scale effect
  
  // Rotary crown interaction
  static readonly CROWN_STEP_SIZE = 40;               // Pixels per crown step
  static readonly CROWN_SENSITIVITY = 1.0;            // Crown rotation sensitivity
}

// ===== ANIMATION LAYOUTS =====

// Animation and transition specific layouts
export class WeatherAnimationLayout {
  // Slide transitions
  static readonly SLIDE_DISTANCE = 40;                // Slide animation distance
  static readonly SLIDE_DURATION = 200;               // Slide animation duration
  
  // Fade transitions
  static readonly FADE_DURATION = 150;                // Fade animation duration
  static readonly FADE_DELAY = 50;                    // Staggered fade delay
  
  // Scale transitions
  static readonly SCALE_DURATION = 100;               // Scale animation duration
  static readonly SCALE_FACTOR = 0.95;                // Scale factor for press
  
  // Progress animations
  static readonly PROGRESS_DURATION = 300;            // Progress bar animation
  static readonly HIGHLIGHT_DURATION = 150;           // Text highlight duration
  
  // Loading animations
  static readonly LOADING_ROTATION_DURATION = 1000;   // Loading spinner rotation
  static readonly LOADING_PULSE_DURATION = 800;       // Loading pulse animation
}

// ===== UTILITY FUNCTIONS =====

// Layout calculation utilities
export class LayoutCalculator {
  // Calculate card height based on content
  static calculateCardHeight(
    hasHeader: boolean = true,
    hasContent: boolean = true,
    hasFooter: boolean = false,
    contentLines: number = 1
  ): number {
    let height = 0;
    
    if (hasHeader) {
      height += 40
    };
    if (hasContent) {
      height += Math.max(contentLines * 20, 60)
    };
    if (hasFooter) {
      height += 32
    };
    
    return Math.max(height + WeatherLayout.CARD_PADDING * 2, 120);
  }
  
  // Calculate responsive spacing
  static getResponsiveSpacing(baseSpacing: number, screenSize: number): number {
    const scale = WearableResponsiveLayout.getSpacing(screenSize) / WeatherLayout.ITEM_SPACING;
    return Math.round(baseSpacing * scale);
  }
  
  // Calculate touch target adjustment
  static adjustTouchTarget(size: number): number {
    return Math.max(size, WearableInteractionLayout.MIN_TOUCH_TARGET);
  }
}