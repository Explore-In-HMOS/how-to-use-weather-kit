/**
 * Weather Cards Library - Type Definitions
 * Extracted and enhanced from entry/models/ for standalone usage
 */

// ===== CORE WEATHER TYPES =====

export enum WeatherCondition {
  SUNNY = 'sunny',
  PARTLY_CLOUDY = 'partly_cloudy',
  CLOUDY = 'cloudy',
  RAINY = 'rainy',
  STORMY = 'stormy',
  SNOWY = 'snowy',
  FOGGY = 'foggy',
  WINDY = 'windy'
}

// Helper function to get display name for weather condition
export function getWeatherConditionDisplayName(condition: WeatherCondition): string {
  switch (condition) {
    case WeatherCondition.SUNNY:
      return 'Sunny';
    case WeatherCondition.PARTLY_CLOUDY:
      return 'Partly Cloudy';
    case WeatherCondition.CLOUDY:
      return 'Cloudy';
    case WeatherCondition.RAINY:
      return 'Rainy';
    case WeatherCondition.STORMY:
      return 'Stormy';
    case WeatherCondition.SNOWY:
      return 'Snowy';
    case WeatherCondition.FOGGY:
      return 'Foggy';
    case WeatherCondition.WINDY:
      return 'Windy';
    default:
      return 'Unknown';
  }
}

// Current weather conditions
export interface CurrentWeather {
  temperature: number;          // Celsius
  condition: WeatherCondition;  // Weather condition enum
  humidity: number;            // Percentage (0-100)
  feelsLike: number;          // Apparent temperature in Celsius
  windSpeed: number;          // Kilometers per hour
  uvIndex: number;            // UV index (0-11 scale)
}

// Daily forecast data
export interface DailyForecast {
  date: string;               // ISO date string (YYYY-MM-DD)
  high: number;              // High temperature in Celsius
  low: number;               // Low temperature in Celsius
  condition: WeatherCondition;
  precipitationChance: number; // Percentage (0-100)
}

// Hourly forecast data (for detailed forecasting)
export interface HourlyForecast {
  time: string;              // ISO time string
  temperature: number;       // Temperature in Celsius
  condition: WeatherCondition;
  precipitationChance: number; // Percentage (0-100)
}

// Location information
export interface LocationInfo {
  city: string;
  region: string;
  country?: string;
}

// ===== COMPONENT PROP INTERFACES =====

// Props for CurrentWeatherCard component
// Note: ArkTS @Prop requires default values instead of optional parameters
// Use sentinel values: -999 for feelsLike, -1 for numeric values, empty string for strings
export interface CurrentWeatherCardProps {
  temperature: number;
  condition: WeatherCondition;
  feelsLike: number;              // Use -999 for "not provided"
  humidity: number;               // Use -1 for "not provided"
  windSpeed: number;              // Use -1 for "not provided"
  uvIndex: number;                // Use -1 for "not provided"
  location: string;               // Use empty string for "not provided"
  showDetails: boolean;           // Show humidity, wind, UV row
  temperatureUnit: 'C' | 'F';     // Temperature unit
  // Note: customIcons handled separately due to ArkTS @Prop limitations
}

// Props for ForecastCard component
export interface ForecastCardProps {
  forecast: DailyForecast[];
  maxDays?: number;               // Maximum days to show (default: 5)
  showIcons?: boolean;            // Show weather icons (default: true)
  showPrecipitation?: boolean;    // Show precipitation chance (default: false)
  temperatureUnit?: 'C' | 'F';    // Temperature unit
  // Note: customIcons handled separately due to ArkTS @Prop limitations
  title?: string;                 // Card title (default: "Forecast")
}

// Props for TTSAnnouncementCard component
// Note: ArkTS @Prop requires default values instead of optional parameters
export interface TTSAnnouncementCardProps {
  text: string;                   // Text to be announced
  words: string[];                // Pre-split words for highlighting (default: [])
  currentWordIndex: number;       // Current word being spoken (default: 0)
  showProgress: boolean;          // Show speech progress highlighting (default: true)
  title: string;                  // Card title (default: "Weather Announcement")
}

// Custom icons for weather details
export interface WeatherDetailIcons {
  humidity?: Resource;
  wind?: Resource;
  uv?: Resource;
}

// Props for WeatherDetailsRow component
// Note: ArkTS @Prop requires default values instead of optional parameters
// Use sentinel values: -1 for numeric values, empty object for customIcons
export interface WeatherDetailsRowProps {
  humidity: number;               // Use -1 for "not provided"
  windSpeed: number;              // Use -1 for "not provided"
  uvIndex: number;                // Use -1 for "not provided"
  temperatureUnit: 'C' | 'F';
  showHumidity: boolean;          // Default: true
  showWind: boolean;              // Default: true
  showUV: boolean;                // Default: true
  customIcons: WeatherDetailIcons; // Default: {}
}

// Options for creating weather details props
export interface WeatherDetailsOptions {
  temperatureUnit?: 'C' | 'F';
  showAll?: boolean;
  customIcons?: WeatherDetailIcons;
}

// Validation result for weather details
export interface WeatherValidationResult {
  humidity: boolean;
  windSpeed: boolean;
  uvIndex: boolean;
}

// Options for creating forecast card props
export interface ForecastCardOptions {
  maxDays?: number;
  showIcons?: boolean;
  showPrecipitation?: boolean;
  temperatureUnit?: 'C' | 'F';
  title?: string;
}

// Options for creating TTS announcement card props
export interface TTSCardOptions {
  showProgress?: boolean;
  title?: string;
  currentWordIndex?: number;
}

// ===== UTILITY TYPES =====

// Weather icon mapping interface (using direct property names for ArkTS compliance)
export interface WeatherIconMap {
  sunny?: Resource;
  partly_cloudy?: Resource;
  cloudy?: Resource;
  rainy?: Resource;
  stormy?: Resource;
  snowy?: Resource;
  foggy?: Resource;
  windy?: Resource;
}

// Temperature unit conversion utilities
export class TemperatureConverter {
  static celsiusToFahrenheit(celsius: number): number {
    return Math.round((celsius * 9/5) + 32);
  }
  
  static fahrenheitToCelsius(fahrenheit: number): number {
    return Math.round((fahrenheit - 32) * 5/9);
  }
  
  static formatTemperature(temp: number, unit: 'C' | 'F'): string {
    return `${temp}°${unit}`;
  }
}

// Data validation utilities
export class WeatherDataValidator {
  static isValidTemperature(temp: number): boolean {
    return temp >= -60 && temp <= 60; // Reasonable temperature range in Celsius
  }
  
  static isValidHumidity(humidity: number): boolean {
    return humidity >= 0 && humidity <= 100;
  }
  
  static isValidUvIndex(uvIndex: number): boolean {
    return uvIndex >= 0 && uvIndex <= 11;
  }
  
  static isValidWindSpeed(windSpeed: number): boolean {
    return windSpeed >= 0 && windSpeed <= 300; // Reasonable wind speed range in km/h
  }
  
  static validateCurrentWeather(weather: CurrentWeather): boolean {
    return WeatherDataValidator.isValidTemperature(weather.temperature) &&
           WeatherDataValidator.isValidTemperature(weather.feelsLike) &&
           WeatherDataValidator.isValidHumidity(weather.humidity) &&
           WeatherDataValidator.isValidUvIndex(weather.uvIndex) &&
           WeatherDataValidator.isValidWindSpeed(weather.windSpeed);
  }
}