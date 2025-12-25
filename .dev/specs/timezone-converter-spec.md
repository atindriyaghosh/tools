# Timezone Converter

## Purpose
Converts a date and time from one IANA timezone to another, displaying the result in the target timezone, UTC, and DST status.

## Features
- Convert date/time between any IANA timezones
- Support for both 12-hour (AM/PM) and 24-hour time formats
- User-selectable time format with automatic time conversion when switching formats
- Uses browser's native timezone list (Intl.supportedValuesOf)
- Detects and displays DST status for target timezone
- Defaults to current date/time if inputs are empty
- Defaults both timezone dropdowns to user's local timezone
- Shows UTC representation alongside converted time

## UI Layout
- **Header**: Title "Timezone Converter" with subtitle
- **Time Format Tabs**: Two clickable tabs at the top
  - "24-hour" (default): Shows time in HH:MM format (e.g., 15:30)
  - "12-hour": Shows time in h:MM AM/PM format (e.g., 3:30 PM)
  - Active tab is highlighted with underline and blue color
  - Clicking a tab switches the format and converts the displayed time
- **Input Section** (2-column grid on desktop, 1-column on mobile):
  - Date input: "Date (default: current date)" - date picker
  - Time input: "Time" - text input that accepts format based on selected tab
  - Input Timezone: "Input Timezone" - dropdown with IANA timezones
  - Output Timezone: "Output Timezone" - dropdown with IANA timezones
  - Convert button: Full-width button below all inputs
- **Result Box**: Bordered card showing:
  - Input Timestamp (with source timezone): Human-readable date/time format
  - Output Timestamp (with target timezone): Human-readable date/time format
  - UTC Timestamp: ISO 8601 format
  - Daylight Saving Time: Shows if DST is observed and current status
- **Footer**: Back link to index.html

## File Handling
- **Accepted formats**: N/A (no file uploads)
- **Size limits**: N/A
- **Validation requirements**:
  - **Date input**: YYYY-MM-DD format (native date picker validation)
  - **Time input** (24-hour): HH:MM format (e.g., 15:30)
  - **Time input** (12-hour): h:MM AM/PM format (e.g., 3:30 PM)
  - Invalid time format shows "Invalid time format" message
- **Output format**: Displayed in result box

## Libraries/APIs Required
- **Browser APIs**:
  - `Intl.supportedValuesOf('timeZone')` for timezone list
  - `Intl.DateTimeFormat` for formatting and offset calculation
  - `Date` object for date manipulation
  - Fallback timezone list for older browsers

## Implementation Notes
- **Edge cases**:
  - Empty date input uses current date
  - Empty time input uses current time
  - Invalid time format shows error message
  - Switching time format tabs automatically converts the displayed time
  - Timezone transitions (DST boundaries)
  - Same source and target timezone
- **Performance considerations**:
  - Timezone list is populated once on DOMContentLoaded
  - Calculations use native Intl APIs (fast)
- **State management**: Active time format tab
- **Error handling**:
  - Invalid time: Shows "Invalid time format" in result
- **Accessibility**:
  - Result box uses aria-live="polite" for screen readers
  - Bold, colored labels for each input field
  - Semantic fieldset-like structure with labels

### DST Detection Algorithm
1. Get timezone offset for January 1 and July 1 of the same year
2. If offsets differ, timezone uses DST
3. Compare current date's offset to determine if in DST period
4. DST is typically the offset with the smaller absolute value

### Timezone Offset Calculation
Uses Intl.DateTimeFormat to format a date in the target timezone, then calculates the offset by comparing to UTC timestamp.

### Time Format Conversion
When switching between 12-hour and 24-hour formats:
1. Parse the current time value in the current format
2. Convert hours/minutes to 24-hour equivalent
3. Re-format using the new format
4. Update the input field

## Responsive Design
- **Desktop (>768px)**: 2-column grid layout (Date | Time in row 1, Input TZ | Output TZ in row 2)
- **Mobile (≤768px)**: 1-column stacked layout for all inputs

## Category
Date/Time Tools

## Tool Card Info
- **Icon**: 🕒
- **Title**: Timezone Converter
- **Description**: Convert a date and time between timezones. View the result in your target timezone, UTC, and DST information.
