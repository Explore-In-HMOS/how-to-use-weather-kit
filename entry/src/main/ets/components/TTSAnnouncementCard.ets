/**
 * Weather Cards Library - TTS Announcement Card Component
 * Extracted and enhanced from entry/pages/Index.ets for standalone usage
 */

import { TTSAnnouncementCardProps, TTSCardOptions } from '../types/WeatherTypes';
import { WeatherColors, WeatherFonts } from '../constants/WeatherTheme';
import { WeatherLayout } from '../constants/WearableLayout';

/**
 * TTS Announcement Card Component
 * Displays text with word-by-word highlighting during TTS playback
 */
@Component
export struct TTSAnnouncementCard {
  // Required props
  @Prop text: string;
  
  // Optional props with defaults (ArkTS requires default values instead of optional syntax)
  @Prop words: string[] = [];
  @Prop currentWordIndex: number = 0;
  @Prop showProgress: boolean = true;
  @Prop title: string = 'Weather Announcement';
  
  // Internal state for word splitting if not provided
  @State private computedWords: string[] = [];

  aboutToAppear() {
    // Split text into words if not provided
    if (!this.words || this.words.length === 0) {
      this.computedWords = this.text.split(' ').filter(word => word.trim() !== '');
    } else {
      this.computedWords = this.words;
    }
  }

  build() {
    Column({ space: 12 }) {
      // Card Header (matches entry/Index.ets spacing)
      this.HeaderSection()
      
      // Animated Text Content
      this.TextContentSection()
    }
    .width('100%')
    .padding(WeatherLayout.CARD_PADDING)
    .backgroundColor(WeatherColors.CARD)
    .borderRadius(WeatherLayout.BORDER_RADIUS)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
  }
  
  @Builder
  HeaderSection() {
    // Simple header with icon and title, no button (matches entry/Index.ets exactly)
    Row({ space: 8 }) {
      Image($r('app.media.speak'))
        .width(20)
        .height(20)
        .fillColor(WeatherColors.TEXT_PRIMARY)
      
      Text(this.title)
        .fontSize(WeatherFonts.TITLE)
        .fontWeight(FontWeight.Medium)
        .fontColor(WeatherColors.TEXT_PRIMARY)
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }
  
  @Builder
  TextContentSection() {
    if (this.computedWords.length > 0 && this.showProgress) {
      // Animated text highlighting
      this.AnimatedTextHighlight()
    } else {
      // Static text display
      this.StaticTextDisplay()
    }
  }
  
  @Builder
  AnimatedTextHighlight() {
    Text() {
      ForEach(this.computedWords, (word: string, index: number) => {
        Span(`${word} `)
          .fontColor(this.getWordColor(index))
          .animation({
            duration: 150,
            curve: Curve.EaseOut
          })
      }, (word: string, index: number) => `${word}-${index}`)
    }
    .fontSize(WeatherFonts.BODY)
    .textAlign(TextAlign.Start)
    .width('100%')
    .lineHeight(20)
    .maxLines(8)
    .textOverflow({ overflow: TextOverflow.Ellipsis })
  }
  
  @Builder
  StaticTextDisplay() {
    Text(this.text || 'Loading announcement...')
      .fontSize(WeatherFonts.BODY)
      .fontColor(WeatherColors.TEXT_SECONDARY)
      .lineHeight(20)
      .width('100%')
      .textAlign(TextAlign.Start)
      .maxLines(8)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
  }
  
  // ===== HELPER METHODS =====
  
  /**
   * Get color for word based on current progress (matches entry/Index.ets exactly)
   */
  private getWordColor(index: number): string {
    const currentIndex = this.currentWordIndex;
    return index < currentIndex ? '#FFD700' : '#808080';
  }
  
  /**
   * Update component when text changes
   */
  onTextChange() {
    this.computedWords = this.text.split(' ').filter(word => word.trim() !== '');
  }
}

// ===== UTILITY FUNCTIONS =====

/**
 * Create TTS announcement card props (simplified for display-only usage)
 */
export function createTTSCardProps(
  text: string,
  options?: TTSCardOptions
): TTSAnnouncementCardProps {
  return {
    text,
    words: text.split(' ').filter(word => word.trim() !== ''),
    currentWordIndex: options?.currentWordIndex || 0,
    showProgress: options?.showProgress !== false,
    title: options?.title || 'Weather Announcement'
  };
}

/**
 * Text processing utilities for TTS
 */
export class TTSTextProcessor {
  /**
   * Split text into words, handling punctuation appropriately
   */
  static splitIntoWords(text: string): string[] {
    return text
      .split(/\s+/) // Split on whitespace
      .filter(word => word.trim() !== '') // Remove empty strings
      .map(word => word.trim()); // Trim each word
  }
  
  /**
   * Estimate speaking duration (rough approximation)
   */
  static estimateDuration(text: string, wordsPerMinute: number = 150): number {
    const words = TTSTextProcessor.splitIntoWords(text);
    return (words.length / wordsPerMinute) * 60 * 1000; // Return milliseconds
  }
  
  /**
   * Validate text for TTS
   */
  static isValidTTSText(text: string): boolean {
    return Boolean(text && text.trim().length > 0 && text.length <= 1000); // Reasonable length limit
  }
}