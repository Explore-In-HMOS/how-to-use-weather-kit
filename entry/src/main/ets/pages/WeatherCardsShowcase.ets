import { ArcList, ArcListAttribute, ArcListItem, LengthMetrics } from '@kit.ArkUI';
import { CurrentWeatherCard } from '../components/CurrentWeatherCard';
import { ForecastCard } from '../components/ForecastCard';
import { TTSAnnouncementCard } from '../components/TTSAnnouncementCard';
import { WeatherDetailsRow } from '../components/WeatherDetailsRow';
import { WeatherLayout } from '../constants/WearableLayout';
import { WeatherColors, WeatherFonts } from '../constants/WeatherTheme';
import { WeatherCondition } from '../types/WeatherTypes';
import { WeatherIconHelper } from '../utils/WeatherIconHelper';

@Entry
@Component
struct WeatherCardsShowcase {
  @State isLoading: boolean = false;
  @State rotationAngle: number = 0;
  @State currentWordIndex: number = 0;
  private readonly mockAnnouncement: string =
    'Good morning! It\'s partly cloudy with a temperature of 22 degrees. Humidity is at 65 percent with light winds at 12 kilometers per hour.';
  private readonly mockWords: string[] = this.mockAnnouncement.split(' ').filter(word => word.trim() !== '');

  aboutToAppear(): void {
    this.startWordAnimation();
  }

  build() {
    Column() {
      if (this.isLoading) {
        this.LoadingView()
      } else {
        this.ShowcaseView()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(WeatherColors.BACKGROUND)
  }

  @Builder
  LoadingView() {
    Column({ space: WeatherLayout.ITEM_SPACING }) {
      Image($r('app.media.partlycloudy'))
        .width(48)
        .height(48)
        .fillColor(WeatherColors.TEXT_PRIMARY)
        .rotate({ angle: this.rotationAngle })

      Text('Loading Weather Cards...')
        .fontSize(WeatherFonts.BODY)
        .fontColor(WeatherColors.TEXT_SECONDARY)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  ShowcaseView() {
    ArcList({}) {
      // Header Card
      ArcListItem() {
        this.HeaderCard()
      }

      ArcListItem() {
        TTSAnnouncementCard({
          text: this.mockAnnouncement,
          words: this.mockWords,
          currentWordIndex: this.currentWordIndex,
          showProgress: true,
          title: 'Weather Announcement'
        })
      }

      ArcListItem() {
        CurrentWeatherCard({
          temperature: 22,
          condition: WeatherCondition.PARTLY_CLOUDY,
          feelsLike: 25,
          humidity: 65,
          windSpeed: 12,
          uvIndex: 7,
          location: 'San Francisco, CA',
          showDetails: true,
          temperatureUnit: 'C'
        })
      }

      ArcListItem() {
        ForecastCard({
          forecast: [
            {
              date: '2025-09-20',
              high: 24,
              low: 16,
              condition: WeatherCondition.SUNNY,
              precipitationChance: 10
            },
            {
              date: '2025-09-21',
              high: 26,
              low: 18,
              condition: WeatherCondition.PARTLY_CLOUDY,
              precipitationChance: 20
            },
            {
              date: '2025-09-22',
              high: 20,
              low: 14,
              condition: WeatherCondition.RAINY,
              precipitationChance: 80
            },
            {
              date: '2025-09-23',
              high: 18,
              low: 12,
              condition: WeatherCondition.CLOUDY,
              precipitationChance: 30
            },
            {
              date: '2025-09-24',
              high: 23,
              low: 17,
              condition: WeatherCondition.SUNNY,
              precipitationChance: 5
            }
          ],
          maxDays: 5,
          showIcons: true,
          showPrecipitation: false,
          temperatureUnit: 'C',
          title: '5-Day Forecast'
        })
      }

      ArcListItem() {
        this.WeatherDetailsCard()
      }

      ArcListItem() {
        this.WeatherConditionsDemo()
      }

      ArcListItem() {
        this.TemperatureUnitsDemo()
      }
    }
    .space(LengthMetrics.px(8))
    .focusable(true)
    .focusOnTouch(true)
    .defaultFocus(true)
    .width('100%')
    .height('100%')
  }

  @Builder
  HeaderCard() {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
        Image($r('app.media.sunny'))
          .width(24)
          .height(24)
          .fillColor(WeatherColors.TEXT_PRIMARY)

        Text('Weather Kit')
          .fontSize(WeatherFonts.TITLE)
          .fontWeight(FontWeight.Bold)
          .fontColor(WeatherColors.TEXT_PRIMARY)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Text('Showcase of all available weather card components with mock data for HarmonyOS wearables.')
        .fontSize(WeatherFonts.BODY)
        .fontColor(WeatherColors.TEXT_SECONDARY)
        .lineHeight(20)
        .width('100%')
        .textAlign(TextAlign.Start)
        .maxLines(3)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

    }
    .width('85%')
    .padding(WeatherLayout.CARD_PADDING)
    .backgroundColor(WeatherColors.CARD)
    .borderRadius(WeatherLayout.BORDER_RADIUS)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  WeatherDetailsCard() {
    Column({ space: 12 }) {
      Text('Weather Details Row')
        .fontSize(WeatherFonts.TITLE)
        .fontWeight(FontWeight.Medium)
        .fontColor(WeatherColors.TEXT_PRIMARY)
        .width('100%')
        .textAlign(TextAlign.Start)

      WeatherDetailsRow({
        humidity: 75,
        windSpeed: 8,
        uvIndex: 5,
        temperatureUnit: 'C',
        showHumidity: true,
        showWind: true,
        showUV: true,
        customIcons: {}
      })

      Text('Displays humidity, wind speed, and UV index in a horizontal layout optimized for wearables.')
        .fontSize(WeatherFonts.CAPTION)
        .fontColor(WeatherColors.TEXT_SECONDARY)
        .width('100%')
        .textAlign(TextAlign.Start)
        .lineHeight(16)
    }
    .width('85%')
    .padding(WeatherLayout.CARD_PADDING)
    .backgroundColor(WeatherColors.CARD)
    .borderRadius(WeatherLayout.BORDER_RADIUS)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  WeatherConditionsDemo() {
    Column({ space: 12 }) {
      Text('Weather Conditions')
        .fontSize(WeatherFonts.TITLE)
        .fontWeight(FontWeight.Medium)
        .fontColor(WeatherColors.TEXT_PRIMARY)
        .width('100%')
        .textAlign(TextAlign.Start)

      Column({ space: 8 }) {
        Row({ space: 8 }) {
          this.MiniWeatherCard(WeatherCondition.SUNNY, 28, 'Sunny')
          this.MiniWeatherCard(WeatherCondition.RAINY, 16, 'Rainy')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        Row({ space: 8 }) {
          this.MiniWeatherCard(WeatherCondition.SNOWY, -2, 'Snowy')
          this.MiniWeatherCard(WeatherCondition.STORMY, 19, 'Stormy')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }

      Text('All weather conditions supported with corresponding icons and colors.')
        .fontSize(WeatherFonts.CAPTION)
        .fontColor(WeatherColors.TEXT_SECONDARY)
        .width('100%')
        .textAlign(TextAlign.Start)
    }
    .width('100%')
    .padding(WeatherLayout.CARD_PADDING)
    .backgroundColor(WeatherColors.CARD)
    .borderRadius(WeatherLayout.BORDER_RADIUS)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  MiniWeatherCard(condition: WeatherCondition, temperature: number, label: string) {
    Column({ space: 4 }) {
      Image(WeatherIconHelper.getWeatherIconExternal(condition))
        .width(20)
        .height(20)
        .fillColor(WeatherColors.TEXT_PRIMARY)

      Text(`${temperature}°`)
        .fontSize(WeatherFonts.CAPTION)
        .fontColor(WeatherColors.TEXT_PRIMARY)
        .fontWeight(FontWeight.Medium)

      Text(label)
        .fontSize(10)
        .fontColor(WeatherColors.TEXT_SECONDARY)
        .maxLines(1)
    }
    .width(60)
    .height(60)
    .backgroundColor(WeatherColors.BACKGROUND)
    .borderRadius(8)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(4)
    .border({
      width: 1,
      color: WeatherColors.TEXT_TERTIARY,
      radius: 8
    })
  }

  @Builder
  TemperatureUnitsDemo() {
    Column({ space: 8 }) {
      // Card Header
      Text('Temperature Units')
        .fontSize(WeatherFonts.TITLE)
        .fontWeight(FontWeight.Medium)
        .fontColor(WeatherColors.TEXT_PRIMARY)
        .width('100%')
        .textAlign(TextAlign.Start)

      // Side by side comparison
      Row({ space: 8 }) {
        // Celsius
        Column({ space: 8 }) {
          Text('Celsius')
            .fontSize(WeatherFonts.BODY)
            .fontColor(WeatherColors.TEXT_SECONDARY)
            .fontWeight(FontWeight.Medium)

          CurrentWeatherCard({
            temperature: 22,
            condition: WeatherCondition.PARTLY_CLOUDY,
            feelsLike: -999, // Don't show feels like
            humidity: -1, // Don't show details
            windSpeed: -1,
            uvIndex: -1,
            location: '',
            showDetails: false,
            temperatureUnit: 'C'
          })
        }
        .layoutWeight(1)

        Column({ space: 8 }) {
          Text('Fahrenheit')
            .fontSize(WeatherFonts.BODY)
            .fontColor(WeatherColors.TEXT_SECONDARY)
            .fontWeight(FontWeight.Medium)

          CurrentWeatherCard({
            temperature: 22,
            condition: WeatherCondition.PARTLY_CLOUDY,
            feelsLike: -999, // Don't show feels like
            humidity: -1, // Don't show details
            windSpeed: -1,
            uvIndex: -1,
            location: '',
            showDetails: false,
            temperatureUnit: 'F'
          })
        }
        .layoutWeight(1)
      }
      .width('100%')

      Text('Automatic temperature unit conversion (22°C = 72°F)')
        .fontSize(WeatherFonts.CAPTION)
        .fontColor(WeatherColors.TEXT_SECONDARY)
        .width('100%')
        .textAlign(TextAlign.Start)
    }
    .width('100%')
    .padding(WeatherLayout.CARD_PADDING)
    .backgroundColor(WeatherColors.CARD)
    .borderRadius(WeatherLayout.BORDER_RADIUS)
    .alignItems(HorizontalAlign.Start)
  }

  private startWordAnimation(): void {
    const intervalId = setInterval(() => {
      if (this.currentWordIndex < this.mockWords.length) {
        this.currentWordIndex++;
      } else {
        setTimeout(() => {
          this.currentWordIndex = 0;
        }, 2000);
      }
    }, 300);

    setTimeout(() => {
      clearInterval(intervalId);
    }, 30000);
  }
}