# Timezone Converter

## Purpose
Converts a date/time from one IANA timezone to another while displaying DST information.

## Features
- Convert date/time between any IANA timezones
- Uses browser's native timezone list (Intl.supportedValuesOf)
- Detects and displays DST status for target timezone
- Defaults to current date/time if input is empty
- Defaults both dropdowns to user's local timezone
- Shows UTC representation alongside converted time

## UI Layout
- **Header**: Title "Timezone converter" with clock emoji and subtitle
- **Input Section**:
  - datetime-local input for date/time (optional, empty = now)
  - Flex row containing:
    - "From" timezone dropdown
    - "To" timezone dropdown
    - Convert button
- **Result Box**: Bordered card showing:
  - Source timezone and formatted time
  - Target timezone and formatted time
  - UTC ISO string
  - Target timezone offset in minutes
  - Whether timezone uses DST
  - Whether the date is currently in DST
- **DST Note**: Explanation of DST detection behavior
- **Footer**: Back link to index.html

## File Handling
- **Accepted formats**: N/A (no file uploads)
- **Size limits**: N/A
- **Validation requirements**:
  - Parse datetime-local format (YYYY-MM-DDTHH:mm)
  - Invalid format shows "Invalid date/time" message
- **Output format**: Displayed in result box

## Libraries/APIs Required
- **Browser APIs**:
  - `Intl.supportedValuesOf('timeZone')` for timezone list
  - `Intl.DateTimeFormat` for formatting and offset calculation
  - `Date` object for date manipulation
  - Fallback timezone list for older browsers

## Implementation Notes
- **Edge cases**:
  - Empty input uses current time
  - Invalid datetime-local format shows error
  - Timezone transitions (DST boundaries)
  - Same source and target timezone
- **Performance considerations**:
  - Timezone list is populated once on DOMContentLoaded
  - Calculations use native Intl APIs (fast)
- **State management**: None (stateless conversion)
- **Error handling**:
  - Invalid date/time: Shows "Invalid date/time" in result
- **Accessibility**:
  - Result box uses aria-live="polite" for screen readers
  - Semantic fieldset-like structure with labels

### DST Detection Algorithm
1. Get timezone offset for January 1 and July 1 of the same year
2. If offsets differ, timezone uses DST
3. Compare current date's offset to determine if in DST period
4. DST is typically the offset with the smaller absolute value

### Timezone Offset Calculation
Uses Intl.DateTimeFormat to format a date in the target timezone, then calculates the offset by comparing to UTC timestamp.

## Category
Date/Time Tools

## Tool Card Info
- **Icon**: 🕒
- **Title**: Timezone Converter
- **Description**: Convert dates/times between IANA timezones with DST info
