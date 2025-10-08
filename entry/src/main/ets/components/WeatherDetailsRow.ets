/**
 * Weather Cards Library - Weather Details Row Component
 * Extracted and enhanced from entry/pages/Index.ets for standalone usage
 */

import { WeatherDetailsRowProps, WeatherDetailIcons, WeatherDetailsOptions, WeatherValidationResult } from '../types/WeatherTypes';
import { WeatherColors, WeatherFonts } from '../constants/WeatherTheme';
import { WeatherLayout, WeatherDetailsLayout } from '../constants/WearableLayout';

/**
 * Weather Details Row Component
 * Displays humidity, wind speed, and UV index in a horizontal row
 */
@Component
export struct WeatherDetailsRow {
  // Props (ArkTS requires default values instead of optional syntax)
  @Prop humidity: number = -1; // Use sentinel value for "not provided"
  @Prop windSpeed: number = -1; // Use sentinel value for "not provided"
  @Prop uvIndex: number = -1; // Use sentinel value for "not provided"
  @Prop temperatureUnit: 'C' | 'F' = 'C';
  @Prop showHumidity: boolean = true;
  @Prop showWind: boolean = true;
  @Prop showUV: boolean = true;
  @Prop customIcons: WeatherDetailIcons = {};

  build() {
    Row({ space: WeatherDetailsLayout.COLUMN_SPACING }) {
      // Humidity Column
      if (this.showHumidity && this.humidity !== -1) {
        this.DetailColumn(
          this.getHumidityIcon(),
          $r('app.media.humidity'),
          `${this.humidity}%`,
          'Humidity'
        )
      }

      // Wind Speed Column
      if (this.showWind && this.windSpeed !== -1) {
        this.DetailColumn(
          this.getWindIcon(),
          $r('app.media.wind'),
          this.getFormattedWindSpeed(),
          'Wind'
        )
      }

      // UV Index Column
      if (this.showUV && this.uvIndex !== -1) {
        this.DetailColumn(
          this.getUVIcon(),
          $r('app.media.uv_index'),
          `UV ${this.uvIndex}`,
          'UV Index'
        )
      }
    }
    .justifyContent(FlexAlign.SpaceEvenly)
    .width('100%')
    .height(WeatherDetailsLayout.ROW_HEIGHT)
  }

  @Builder
  DetailColumn(
    iconResource: Resource | null,
    defaultIcon: Resource,
    value: string,
    label: string
  ) {
    Column({ space: 4 }) {
      // Icon (prefer custom resource, fallback to default SVG)
      Image(iconResource || defaultIcon)
        .width(WeatherDetailsLayout.ICON_SIZE)
        .height(WeatherDetailsLayout.ICON_SIZE)
        .fillColor(WeatherColors.TEXT_SECONDARY)
      
      // Value
      Text(value)
        .fontSize(WeatherFonts.CAPTION)
        .fontColor(WeatherColors.TEXT_SECONDARY)
        .fontWeight(FontWeight.Medium)
        .textAlign(TextAlign.Center)
        .height(WeatherDetailsLayout.VALUE_HEIGHT)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
      
      // Label (optional, for accessibility)
      if (this.shouldShowLabels()) {
        Text(label)
          .fontSize(WeatherFonts.CAPTION_SMALL)
          .fontColor(WeatherColors.TEXT_TERTIARY)
          .textAlign(TextAlign.Center)
          .height(WeatherDetailsLayout.LABEL_HEIGHT)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
    }
    .width(WeatherDetailsLayout.COLUMN_WIDTH)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  // ===== HELPER METHODS =====

  /**
   * Get humidity icon (custom or null for emoji fallback)
   */
  private getHumidityIcon(): Resource | null {
    return this.customIcons.humidity || null;
  }

  /**
   * Get wind icon (custom or null for emoji fallback)
   */
  private getWindIcon(): Resource | null {
    return this.customIcons.wind || null;
  }

  /**
   * Get UV index icon (custom or null for emoji fallback)
   */
  private getUVIcon(): Resource | null {
    return this.customIcons.uv || null;
  }

  /**
   * Format wind speed with appropriate unit
   */
  private getFormattedWindSpeed(): string {
    if (this.windSpeed === -1) return '';
    
    // For now, assuming input is in km/h
    // Could add mph conversion if needed
    return `${this.windSpeed} km/h`;
  }

  /**
   * Determine if labels should be shown
   * Show labels if there's enough space (more than 2 columns)
   */
  private shouldShowLabels(): boolean {
    const visibleColumns = this.getVisibleColumnCount();
    return visibleColumns <= 2; // Show labels when we have space
  }

  /**
   * Count visible columns
   */
  private getVisibleColumnCount(): number {
    let count = 0;
    if (this.showHumidity && this.humidity !== -1) count++;
    if (this.showWind && this.windSpeed !== -1) count++;
    if (this.showUV && this.uvIndex !== -1) count++;
    return count;
  }
}

// ===== STANDALONE UTILITY FUNCTIONS =====

/**
 * Create weather details row props from individual values
 */
export function createWeatherDetailsProps(
  humidity?: number,
  windSpeed?: number,
  uvIndex?: number,
  options?: WeatherDetailsOptions
): WeatherDetailsRowProps {
  return {
    humidity: humidity !== undefined ? humidity : -1,
    windSpeed: windSpeed !== undefined ? windSpeed : -1,
    uvIndex: uvIndex !== undefined ? uvIndex : -1,
    temperatureUnit: options?.temperatureUnit || 'C',
    showHumidity: options?.showAll !== false && humidity !== undefined,
    showWind: options?.showAll !== false && windSpeed !== undefined,
    showUV: options?.showAll !== false && uvIndex !== undefined,
    customIcons: options?.customIcons || {}
  };
}

/**
 * Validate weather detail values
 */
export class WeatherDetailsValidator {
  static isValidHumidity(humidity: number): boolean {
    return humidity >= 0 && humidity <= 100;
  }
  
  static isValidWindSpeed(windSpeed: number): boolean {
    return windSpeed >= 0 && windSpeed <= 300; // Reasonable max km/h
  }
  
  static isValidUVIndex(uvIndex: number): boolean {
    return uvIndex >= 0 && uvIndex <= 11; // Standard UV index scale
  }
  
  static validateAll(humidity?: number, windSpeed?: number, uvIndex?: number): WeatherValidationResult {
    return {
      humidity: humidity === undefined || humidity === -1 || WeatherDetailsValidator.isValidHumidity(humidity),
      windSpeed: windSpeed === undefined || windSpeed === -1 || WeatherDetailsValidator.isValidWindSpeed(windSpeed),
      uvIndex: uvIndex === undefined || uvIndex === -1 || WeatherDetailsValidator.isValidUVIndex(uvIndex)
    };
  }
}