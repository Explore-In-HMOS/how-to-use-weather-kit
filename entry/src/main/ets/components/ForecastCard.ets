/**
 * Weather Cards Library - Forecast Card Component
 * Extracted and enhanced from entry/pages/Index.ets for standalone usage
 */

import { 
  ForecastCardProps, 
  DailyForecast, 
  WeatherCondition, 
  TemperatureConverter,
  WeatherIconMap,
  ForecastCardOptions
} from '../types/WeatherTypes';
import { WeatherColors, WeatherFonts } from '../constants/WeatherTheme';
import { WeatherLayout, ForecastCardLayout } from '../constants/WearableLayout';
import { getWeatherIcon } from '../utils/WeatherIconHelper';

/**
 * Forecast Card Component
 * Displays multi-day weather forecast in a compact card format
 */
@Component
export struct ForecastCard {
  // Required props
  @Prop forecast: DailyForecast[];
  
  // Optional props with defaults (ArkTS requires default values instead of optional syntax)
  @Prop maxDays: number = 5;
  @Prop showIcons: boolean = true;
  @Prop showPrecipitation: boolean = false;
  @Prop temperatureUnit: 'C' | 'F' = 'C';
  @Prop title: string = 'Forecast';
  
  // Custom icons passed as constructor parameter (not @Prop due to ArkTS limitations)
  private customIcons?: WeatherIconMap;

  build() {
    Column({ space: WeatherLayout.ITEM_SPACING }) {
      // Card Header
      this.HeaderSection()
      
      // Forecast List
      this.ForecastListSection()
    }
    .width('100%')
    .height(this.calculateCardHeight())
    .padding({
      top: WeatherLayout.CARD_PADDING,
      bottom: WeatherLayout.CARD_PADDING,
      left: WeatherLayout.CARD_PADDING,
      right: WeatherLayout.CARD_PADDING + 8
    })
    .backgroundColor(WeatherColors.CARD)
    .borderRadius(WeatherLayout.BORDER_RADIUS)
    .alignItems(HorizontalAlign.Start)
  }
  
  @Builder
  HeaderSection() {
    Text(this.title)
      .fontSize(WeatherFonts.TITLE)
      .fontWeight(FontWeight.Medium)
      .fontColor(WeatherColors.TEXT_PRIMARY)
      .width('100%')
      .textAlign(TextAlign.Start)
      .height(ForecastCardLayout.HEADER_HEIGHT)
  }
  
  @Builder
  ForecastListSection() {
    Column({ space: ForecastCardLayout.FORECAST_ITEM_SPACING }) {
      ForEach(this.getDisplayForecast(), (day: DailyForecast, index: number) => {
        this.ForecastDayItem(day, index)
      }, (day: DailyForecast) => day.date)
    }
    .width('100%')
  }
  
  @Builder
  ForecastDayItem(day: DailyForecast, index: number) {
    Row({ space: WeatherLayout.ITEM_SPACING }) {
      // Day Name
      Text(this.formatForecastDay(day.date, index))
        .fontSize(WeatherFonts.BODY)
        .fontColor(WeatherColors.TEXT_SECONDARY)
        .width(ForecastCardLayout.DAY_COLUMN_WIDTH)
        .textAlign(TextAlign.Start)
      
      // Weather Icon (if enabled)
      if (this.showIcons) {
        Image(this.getWeatherIconResource(day.condition))
          .width(WeatherFonts.ICON_MEDIUM)
          .height(WeatherFonts.ICON_MEDIUM)
          .fillColor(WeatherColors.TEXT_SECONDARY)
      }
      
      // Weather Condition
      Text(this.getConditionText(day.condition))
        .fontSize(WeatherFonts.CAPTION)
        .fontColor(WeatherColors.TEXT_SECONDARY)
        .layoutWeight(1)
        .textAlign(TextAlign.Start)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
      
      // Precipitation (if enabled)
      if (this.showPrecipitation && day.precipitationChance > 0) {
        Text(`${day.precipitationChance}%`)
          .fontSize(WeatherFonts.CAPTION)
          .fontColor(WeatherColors.TEXT_TERTIARY)
          .width(40)
          .textAlign(TextAlign.Center)
      }
      
      // Temperature Range
      this.TemperatureRange(day)
    }
    .width('100%')
    .height(ForecastCardLayout.FORECAST_ITEM_HEIGHT)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
  
  @Builder
  TemperatureRange(day: DailyForecast) {
    Row({ space: WeatherLayout.ITEM_SPACING_SMALL }) {
      // High Temperature
      Text(this.getFormattedTemperature(day.high))
        .fontSize(WeatherFonts.CAPTION)
        .fontColor(WeatherColors.TEXT_PRIMARY)
        .fontWeight(FontWeight.Medium)
        .textAlign(TextAlign.End)
        .width(32)
      
      // Low Temperature
      Text(this.getFormattedTemperature(day.low))
        .fontSize(WeatherFonts.CAPTION)
        .fontColor(WeatherColors.TEXT_SECONDARY)
        .textAlign(TextAlign.End)
        .width(32)
    }
    .width(ForecastCardLayout.TEMP_COLUMN_WIDTH)
  }
  
  // ===== HELPER METHODS =====
  
  /**
   * Get forecast data to display (limited by maxDays)
   */
  private getDisplayForecast(): DailyForecast[] {
    if (!this.forecast || this.forecast.length === 0) {
      return [];
    }
    
    return this.forecast.slice(0, this.maxDays);
  }
  
  /**
   * Format forecast day name
   */
  private formatForecastDay(date: string, index: number): string {
    if (index === 0) return 'Today';
    if (index === 1) return 'Tomorrow';
    
    try {
      const dateObj = new Date(date);
      const dayIndex = dateObj.getDay();
      
      switch (dayIndex) {
        case 0: return 'Sun';
        case 1: return 'Mon';
        case 2: return 'Tue';
        case 3: return 'Wed';
        case 4: return 'Thu';
        case 5: return 'Fri';
        case 6: return 'Sat';
        default: return 'Day';
      }
    } catch (error) {
      console.error('Error parsing date:', date, error);
      return 'Day';
    }
  }
  
  /**
   * Get formatted temperature with unit conversion
   */
  private getFormattedTemperature(temperature: number): string {
    const temp = this.temperatureUnit === 'F' 
      ? TemperatureConverter.celsiusToFahrenheit(temperature)
      : temperature;
    
    return `${temp}°`;
  }
  
  /**
   * Get weather condition text (shortened for space)
   */
  private getConditionText(condition: WeatherCondition): string {
    // Use shortened names for better fit in narrow space
    switch (condition) {
      case WeatherCondition.PARTLY_CLOUDY:
        return 'P. Cloudy';
      case WeatherCondition.CLOUDY:
        return 'Cloudy';
      case WeatherCondition.RAINY:
        return 'Rain';
      case WeatherCondition.STORMY:
        return 'Storm';
      case WeatherCondition.SNOWY:
        return 'Snow';
      case WeatherCondition.FOGGY:
        return 'Fog';
      case WeatherCondition.WINDY:
        return 'Windy';
      case WeatherCondition.SUNNY:
      default:
        return 'Sunny';
    }
  }
  
  /**
   * Get weather icon resource (custom or default)
   */
  private getWeatherIconResource(condition: WeatherCondition): Resource {
    if (this.customIcons) {
      // Use a switch statement instead of indexed access for ArkTS compliance
      switch (condition) {
        case WeatherCondition.SUNNY:
          return this.customIcons.sunny || getWeatherIcon(condition);
        case WeatherCondition.PARTLY_CLOUDY:
          return this.customIcons.partly_cloudy || getWeatherIcon(condition);
        case WeatherCondition.CLOUDY:
          return this.customIcons.cloudy || getWeatherIcon(condition);
        case WeatherCondition.RAINY:
          return this.customIcons.rainy || getWeatherIcon(condition);
        case WeatherCondition.STORMY:
          return this.customIcons.stormy || getWeatherIcon(condition);
        case WeatherCondition.SNOWY:
          return this.customIcons.snowy || getWeatherIcon(condition);
        case WeatherCondition.FOGGY:
          return this.customIcons.foggy || getWeatherIcon(condition);
        case WeatherCondition.WINDY:
          return this.customIcons.windy || getWeatherIcon(condition);
        default:
          return getWeatherIcon(condition);
      }
    }
    return getWeatherIcon(condition);
  }
  
  /**
   * Calculate card height based on content
   */
  private calculateCardHeight(): number {
    const forecastItems = this.getDisplayForecast().length;
    const headerHeight = ForecastCardLayout.HEADER_HEIGHT;
    const itemsHeight = forecastItems * ForecastCardLayout.FORECAST_ITEM_HEIGHT;
    const spacingHeight = Math.max(0, forecastItems - 1) * ForecastCardLayout.FORECAST_ITEM_SPACING;
    const padding = WeatherLayout.CARD_PADDING * 2;
    const extraSpacing = WeatherLayout.ITEM_SPACING; // Space between header and list
    
    return headerHeight + itemsHeight + spacingHeight + padding + extraSpacing;
  }
}

// ===== UTILITY FUNCTIONS =====

/**
 * Create forecast card props from forecast array
 */
export function createForecastCardProps(
  forecast: DailyForecast[],
  options?: ForecastCardOptions
): ForecastCardProps {
  return {
    forecast,
    maxDays: options?.maxDays || 5,
    showIcons: options?.showIcons !== false,
    showPrecipitation: options?.showPrecipitation || false,
    temperatureUnit: options?.temperatureUnit || 'C',
    title: options?.title || 'Forecast'
  };
}

/**
 * Validate forecast data
 */
export class ForecastValidator {
  static isValidForecast(forecast: DailyForecast[]): boolean {
    if (!forecast || forecast.length === 0) return false;
    
    return forecast.every(day => 
      day.date && 
      typeof day.high === 'number' && 
      typeof day.low === 'number' &&
      day.high >= day.low &&
      day.condition !== undefined
    );
  }
  
  static sanitizeForecast(forecast: DailyForecast[]): DailyForecast[] {
    if (!forecast) return [];
    
    return forecast.filter(day => 
      day && 
      day.date && 
      typeof day.high === 'number' && 
      typeof day.low === 'number'
    );
  }
}