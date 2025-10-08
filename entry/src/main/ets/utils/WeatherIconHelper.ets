/**
 * Weather Cards Library - Weather Icon Helper
 * Simplified version with direct switch statements - no indexed access
 */

import { WeatherCondition, WeatherIconMap } from '../types/WeatherTypes';

// ===== WEATHER ICON HELPER CLASS =====

export class WeatherIconHelper {
  private customIcons?: Partial<WeatherIconMap>;
  private fallbackIcon: Resource;
  
  constructor(customIconMap?: Partial<WeatherIconMap>, fallbackIcon?: Resource) {
    this.customIcons = customIconMap;
    this.fallbackIcon = fallbackIcon || $r('app.media.partly_cloudy');
  }
  
  /**
   * Get weather icon resource for a given condition
   * Uses switch statement to avoid indexed access
   */
  getWeatherIcon(condition?: WeatherCondition): Resource {
    if (!condition) {
      return this.fallbackIcon;
    }
    
    // Check custom icons first
    if (this.customIcons) {
      const customIcon = this.getCustomIcon(condition);
      if (customIcon) {
        return customIcon;
      }
    }
    
    // Fall back to default icons
    return this.getDefaultIcon(condition);
  }
  
  /**
   * Get custom icon for condition using switch statement
   */
  private getCustomIcon(condition: WeatherCondition): Resource | undefined {
    if (!this.customIcons) return undefined;
    
    switch (condition) {
      case WeatherCondition.SUNNY:
        return this.customIcons.sunny;
      case WeatherCondition.PARTLY_CLOUDY:
        return this.customIcons.partly_cloudy;
      case WeatherCondition.CLOUDY:
        return this.customIcons.cloudy;
      case WeatherCondition.RAINY:
        return this.customIcons.rainy;
      case WeatherCondition.STORMY:
        return this.customIcons.stormy;
      case WeatherCondition.SNOWY:
        return this.customIcons.snowy;
      case WeatherCondition.FOGGY:
        return this.customIcons.foggy;
      case WeatherCondition.WINDY:
        return this.customIcons.windy;
      default:
        return undefined;
    }
  }
  
  /**
   * Get default icon for condition using switch statement
   */
  private getDefaultIcon(condition: WeatherCondition): Resource {
    switch (condition) {
      case WeatherCondition.SUNNY:
        return $r('app.media.sunny');
      case WeatherCondition.PARTLY_CLOUDY:
        return $r('app.media.partly_cloudy');
      case WeatherCondition.CLOUDY:
        return $r('app.media.cloudy');
      case WeatherCondition.RAINY:
        return $r('app.media.rainy');
      case WeatherCondition.STORMY:
        return $r('app.media.stormy');
      case WeatherCondition.SNOWY:
        return $r('app.media.snowy');
      case WeatherCondition.FOGGY:
        return $r('app.media.foggy');
      case WeatherCondition.WINDY:
        return $r('app.media.windy');
      default:
        return this.fallbackIcon;
    }
  }
  
  /**
   * Get weather condition specific color
   */
  getWeatherColor(condition?: WeatherCondition): string {
    if (!condition) {
      return '#FFFFFF';
    }
    
    switch (condition) {
      case WeatherCondition.SUNNY:
        return '#FFD700';        // Gold
      case WeatherCondition.PARTLY_CLOUDY:
        return '#87CEEB';        // Sky blue
      case WeatherCondition.CLOUDY:
        return '#B0C4DE';        // Light steel blue
      case WeatherCondition.RAINY:
        return '#4682B4';        // Steel blue
      case WeatherCondition.STORMY:
        return '#696969';        // Dim gray
      case WeatherCondition.SNOWY:
        return '#F0F8FF';        // Alice blue
      case WeatherCondition.FOGGY:
        return '#D3D3D3';        // Light gray
      case WeatherCondition.WINDY:
        return '#98D8E8';        // Light blue
      default:
        return '#FFFFFF';
    }
  }
  
  /**
   * Update custom icons for specific conditions
   */
  updateIcon(condition: WeatherCondition, icon: Resource): void {
    if (!this.customIcons) {
      this.customIcons = {};
    }
    
    switch (condition) {
      case WeatherCondition.SUNNY:
        this.customIcons.sunny = icon;
        break;
      case WeatherCondition.PARTLY_CLOUDY:
        this.customIcons.partly_cloudy = icon;
        break;
      case WeatherCondition.CLOUDY:
        this.customIcons.cloudy = icon;
        break;
      case WeatherCondition.RAINY:
        this.customIcons.rainy = icon;
        break;
      case WeatherCondition.STORMY:
        this.customIcons.stormy = icon;
        break;
      case WeatherCondition.SNOWY:
        this.customIcons.snowy = icon;
        break;
      case WeatherCondition.FOGGY:
        this.customIcons.foggy = icon;
        break;
      case WeatherCondition.WINDY:
        this.customIcons.windy = icon;
        break;
    }
  }
  
  /**
   * Set fallback icon for unknown conditions
   */
  setFallbackIcon(fallbackIcon: Resource): void {
    this.fallbackIcon = fallbackIcon;
  }
  
  /**
   * Create a weather icon component configuration
   */
  createIconConfig(
    condition?: WeatherCondition, 
    size: number = 24, 
    useCustomColor: boolean = true
  ): IconConfig {
    return {
      resource: this.getWeatherIcon(condition),
      size: size,
      color: useCustomColor ? this.getWeatherColor(condition) : undefined
    };
  }
}

// ===== ICON CONFIGURATION INTERFACE =====

export interface IconConfig {
  resource: Resource;
  size: number;
  color?: string;
}

// ===== ICON SIZE CONSTANTS =====

export class WeatherIconSizes {
  static readonly SMALL = 16;          // Small icons in details
  static readonly MEDIUM = 20;         // Medium icons in lists
  static readonly LARGE = 24;          // Large icons in cards
  static readonly EXTRA_LARGE = 32;    // Extra large icons in headers
  static readonly HERO = 48;           // Hero icons for main display
}

// ===== UTILITY FUNCTIONS =====

// Default helper instance for convenience
let defaultHelper: WeatherIconHelper | null = null;

/**
 * Get default weather icon helper instance
 */
function getDefaultHelper(): WeatherIconHelper {
  if (!defaultHelper) {
    defaultHelper = new WeatherIconHelper();
  }
  return defaultHelper;
}

/**
 * Quick function to get weather icon
 */
export function getWeatherIcon(condition?: WeatherCondition): Resource {
  return getDefaultHelper().getWeatherIcon(condition);
}

/**
 * Quick function to get weather color
 */
export function getWeatherColor(condition?: WeatherCondition): string {
  return getDefaultHelper().getWeatherColor(condition);
}

/**
 * Create icon configuration for quick use
 */
export function createWeatherIconConfig(
  condition?: WeatherCondition,
  size: number = WeatherIconSizes.LARGE,
  useCustomColor: boolean = true
): IconConfig {
  return getDefaultHelper().createIconConfig(condition, size, useCustomColor);
}