/**
 * Weather Cards Library - Current Weather Card Component
 * Extracted and enhanced from entry/pages/Index.ets for standalone usage
 */

import { 
  WeatherCondition, 
  getWeatherConditionDisplayName,
  TemperatureConverter,
  WeatherIconMap
} from '../types/WeatherTypes';
import { WeatherColors, WeatherFonts } from '../constants/WeatherTheme';
import { WeatherLayout, CurrentWeatherCardLayout } from '../constants/WearableLayout';
import { getWeatherIcon } from '../utils/WeatherIconHelper';
import { WeatherDetailsRow } from './WeatherDetailsRow';

/**
 * Current Weather Card Component
 * Displays current weather conditions with temperature, condition, and optional details
 */
@Component
export struct CurrentWeatherCard {
  // Required props
  @Prop temperature: number;
  @Prop condition: WeatherCondition;
  
  // Optional props with defaults (ArkTS requires default values instead of optional syntax)
  @Prop feelsLike: number = -999; // Use sentinel value for 'not provided'
  @Prop humidity: number = -1; // Use sentinel value for 'not provided'
  @Prop windSpeed: number = -1; // Use sentinel value for 'not provided'
  @Prop uvIndex: number = -1; // Use sentinel value for 'not provided'
  @Prop location: string = '';
  @Prop showDetails: boolean = true;
  @Prop temperatureUnit: 'C' | 'F' = 'C';
  
  // Custom icons passed as constructor parameter (not @Prop due to ArkTS limitations)
  private customIcons?: WeatherIconMap;
  
  build() {
    Column({ space: WeatherLayout.ITEM_SPACING }) {
      // Location Info (if provided)
      if (this.location && this.location.length > 0) {
        this.LocationSection()
      }
      
      // Main Temperature Display
      this.TemperatureSection()
      
      // Weather Condition Row
      this.ConditionSection()
      
      // Feels Like Temperature (if significantly different)
      if (this.feelsLike !== -999 && this.shouldShowFeelsLike()) {
        this.FeelsLikeSection()
      }
      
      // Weather Details Row (humidity, wind, UV)
      if (this.showDetails && this.hasDetailsToShow()) {
        WeatherDetailsRow({
          humidity: this.humidity !== -1 ? this.humidity : -1,
          windSpeed: this.windSpeed !== -1 ? this.windSpeed : -1,
          uvIndex: this.uvIndex !== -1 ? this.uvIndex : -1,
          temperatureUnit: this.temperatureUnit,
          showHumidity: this.humidity !== -1,
          showWind: this.windSpeed !== -1,
          showUV: this.uvIndex !== -1
        })
      }
    }
    .width('85%')
    .height(this.calculateCardHeight())
    .padding(WeatherLayout.CARD_PADDING)
    .backgroundColor(WeatherColors.CARD)
    .borderRadius(WeatherLayout.BORDER_RADIUS)
    .justifyContent(FlexAlign.Center)
  }
  
  @Builder
  LocationSection() {
    Text(this.location!)
      .fontSize(WeatherFonts.CAPTION)
      .fontColor(WeatherColors.TEXT_SECONDARY)
      .width('100%')
      .textAlign(TextAlign.Center)
      .margin({ bottom: 4 })
      .maxLines(1)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
  }
  
  @Builder
  TemperatureSection() {
    Text(this.getFormattedTemperature())
      .fontSize(WeatherFonts.TEMPERATURE)
      .fontWeight(FontWeight.Bold)
      .fontColor(WeatherColors.TEXT_PRIMARY)
      .textAlign(TextAlign.Center)
      .width('100%')
  }
  
  @Builder
  ConditionSection() {
    Row({ space: WeatherLayout.ITEM_SPACING }) {
      // Weather Icon
      Image(this.getWeatherIconResource())
        .width(WeatherLayout.ICON_SIZE)
        .height(WeatherLayout.ICON_SIZE)
        .fillColor(WeatherColors.TEXT_PRIMARY)
      
      // Weather Condition Text
      Text(getWeatherConditionDisplayName(this.condition))
        .fontSize(WeatherFonts.TITLE)
        .fontColor(WeatherColors.TEXT_SECONDARY)
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
  }
  
  @Builder
  FeelsLikeSection() {
    Text(`Feels like ${this.getFormattedFeelsLike()}`)
      .fontSize(WeatherFonts.CAPTION)
      .fontColor(WeatherColors.TEXT_TERTIARY)
      .textAlign(TextAlign.Center)
      .width('100%')
  }
  
  // ===== HELPER METHODS =====
  
  /**
   * Get formatted temperature string with unit
   */
  private getFormattedTemperature(): string {
    const temp = this.temperatureUnit === 'F' 
      ? TemperatureConverter.celsiusToFahrenheit(this.temperature)
      : this.temperature;
    
    return TemperatureConverter.formatTemperature(temp, this.temperatureUnit!);
  }
  
  /**
   * Get formatted feels like temperature
   */
  private getFormattedFeelsLike(): string {
    if (this.feelsLike === -999) return '';
    
    const temp = this.temperatureUnit === 'F' 
      ? TemperatureConverter.celsiusToFahrenheit(this.feelsLike)
      : this.feelsLike;
    
    return TemperatureConverter.formatTemperature(temp, this.temperatureUnit!);
  }
  
  /**
   * Get weather icon resource (custom or default)
   */
  private getWeatherIconResource(): Resource {
    if (this.customIcons) {
      // Use a switch statement instead of indexed access for ArkTS compliance
      switch (this.condition) {
        case WeatherCondition.SUNNY:
          return this.customIcons.sunny || getWeatherIcon(this.condition);
        case WeatherCondition.PARTLY_CLOUDY:
          return this.customIcons.partly_cloudy || getWeatherIcon(this.condition);
        case WeatherCondition.CLOUDY:
          return this.customIcons.cloudy || getWeatherIcon(this.condition);
        case WeatherCondition.RAINY:
          return this.customIcons.rainy || getWeatherIcon(this.condition);
        case WeatherCondition.STORMY:
          return this.customIcons.stormy || getWeatherIcon(this.condition);
        case WeatherCondition.SNOWY:
          return this.customIcons.snowy || getWeatherIcon(this.condition);
        case WeatherCondition.FOGGY:
          return this.customIcons.foggy || getWeatherIcon(this.condition);
        case WeatherCondition.WINDY:
          return this.customIcons.windy || getWeatherIcon(this.condition);
        default:
          return getWeatherIcon(this.condition);
      }
    }
    return getWeatherIcon(this.condition);
  }
  
  /**
   * Determine if feels like temperature should be shown
   * Show if difference is more than 2 degrees
   */
  private shouldShowFeelsLike(): boolean {
    if (this.feelsLike === -999) return false;
    return Math.abs(this.temperature - this.feelsLike) > 2;
  }
  
  /**
   * Check if there are weather details to show
   */
  private hasDetailsToShow(): boolean {
    return this.humidity !== -1 || 
           this.windSpeed !== -1 || 
           this.uvIndex !== -1;
  }
  
  /**
   * Calculate card height based on content
   */
  private calculateCardHeight(): number {
    let height = 0;
    
    // Add padding
    height += WeatherLayout.CARD_PADDING * 2;
    
    // Add space for location
    if (this.location && this.location.length > 0) {
      height += CurrentWeatherCardLayout.LOCATION_HEIGHT + 4; // margin bottom
    }
    
    // Add space for temperature (large font + spacing)
    height += WeatherFonts.TEMPERATURE_LARGE + WeatherLayout.ITEM_SPACING;
    
    // Add space for condition row
    height += CurrentWeatherCardLayout.CONDITION_ROW_HEIGHT + WeatherLayout.ITEM_SPACING;
    
    // Add space for feels like
    if (this.feelsLike !== -999 && this.shouldShowFeelsLike()) {
      height += WeatherFonts.CAPTION + WeatherLayout.ITEM_SPACING;
    }
    
    // Add space for details row
    if (this.showDetails && this.hasDetailsToShow()) {
      height += CurrentWeatherCardLayout.DETAILS_ROW_HEIGHT + WeatherLayout.ITEM_SPACING;
    }
    
    // Ensure minimum height and apply reasonable maximum
    return Math.max(height, CurrentWeatherCardLayout.MIN_HEIGHT);
  }
}