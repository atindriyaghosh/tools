# Unix Timestamp Converter

## Purpose
Bidirectional conversion between Unix timestamps (seconds/milliseconds) and human-readable dates in any timezone.

## Features
- Convert Unix timestamp to human-readable date
- Convert date to Unix timestamp (seconds and milliseconds)
- Auto-detect whether input is seconds or milliseconds
- Manual override for timestamp unit interpretation
- Display results in selected timezone
- Defaults to current time for date-to-timestamp conversion

## UI Layout
- **Header**: Title "Unix timestamp ↔ human readable" with sync emoji and subtitle
- **Section 1 - Timestamp to Date**:
  - Number input for Unix timestamp
  - Dropdown to select unit (Auto-detect / Seconds / Milliseconds)
  - Output timezone dropdown
  - Convert button
  - Result box showing ISO, local, and timezone-specific formats
- **Section 2 - Date to Timestamp**:
  - datetime-local input (empty = now)
  - Source timezone dropdown
  - Convert button
  - Result box showing ISO, Unix seconds, and Unix milliseconds
- **Footer**: Back link to index.html

## File Handling
- **Accepted formats**: N/A (no file uploads)
- **Size limits**: N/A
- **Validation requirements**:
  - Timestamp must be a valid number
  - datetime-local must be valid format
- **Output format**: Displayed in result boxes

## Libraries/APIs Required
- **Browser APIs**:
  - `Intl.supportedValuesOf('timeZone')` for timezone list
  - `Intl.DateTimeFormat` for formatting
  - `Date` object for conversions
  - Fallback timezone list for older browsers

## Implementation Notes
- **Edge cases**:
  - Empty timestamp input shows "Enter a timestamp"
  - Non-numeric input shows "Invalid number"
  - Empty date input uses current time
  - Invalid datetime-local shows "Invalid date/time"
  - Very old/future timestamps (valid JavaScript Date range)
- **Performance considerations**:
  - Simple calculations, no heavy processing
  - Timezone list populated once on load
- **State management**: None (stateless)
- **Error handling**:
  - Clear error messages in result boxes
  - Validates input before attempting conversion

### Auto-detection Algorithm
- If timestamp string length <= 10 digits: treat as seconds
- If timestamp string length > 10 digits: treat as milliseconds
- User can override with explicit unit selection

### Timezone-aware Conversions
Uses the same offset calculation method as timezone-converter:
1. Format date in target timezone using Intl.DateTimeFormat
2. Parse components and compute UTC offset
3. Apply offset for wall-clock time interpretation

## Category
Date/Time Tools

## Tool Card Info
- **Icon**: 🔁
- **Title**: Unix Timestamp
- **Description**: Convert Unix timestamps to dates and vice versa
