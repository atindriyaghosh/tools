# DateTime Format Converter

## Purpose
Parses date/time strings using a specified format pattern and outputs them in another format.

## Features
- Parse arbitrary date/time strings using custom format patterns
- Output in different format patterns
- Support for standard formats (ISO, RFC2822) and custom patterns
- Add custom format patterns dynamically
- Timezone-aware conversions
- Token-based format system (YYYY, MM, DD, HH, mm, ss)

## UI Layout
- **Header**: Title "DateTime Format Converter" with letters emoji and subtitle
- **Input Section**:
  - Text input for date/time string
  - Flex row containing:
    - Input format dropdown
    - Output format dropdown
    - Timezone dropdown
    - Convert button
- **Custom Format Section**:
  - Text input for new format pattern
  - Add format button
- **Result Box**: Shows parsed ISO representation and formatted result
- **Token Reference**: Note listing supported tokens
- **Footer**: Back link to index.html

## File Handling
- **Accepted formats**: N/A (no file uploads)
- **Size limits**: N/A
- **Validation requirements**:
  - Input string must match selected input format pattern
  - Format patterns must contain valid tokens
- **Output format**: Displayed in result box

## Libraries/APIs Required
- **Browser APIs**:
  - `Intl.supportedValuesOf('timeZone')` for timezone list
  - `Intl.DateTimeFormat` for timezone offset calculation
  - `Date` object for manipulation
  - `RegExp` for pattern matching

## Implementation Notes
- **Standard Formats Included**:
  - `YYYY-MM-DD HH:mm:ss`
  - `YYYY-MM-DD`
  - `MM/DD/YYYY HH:mm`
  - `DD MMM YYYY HH:mm:ss`
  - `ISO` (outputs toISOString())
  - `RFC2822` (outputs toUTCString())

- **Supported Tokens**:
  - `YYYY` - 4-digit year
  - `MM` - 2-digit month (01-12)
  - `DD` - 2-digit day (01-31)
  - `HH` - 2-digit hour, 24-hour format (00-23)
  - `mm` - 2-digit minute (00-59)
  - `ss` - 2-digit second (00-59)

- **Edge cases**:
  - Empty input shows prompt message
  - Input doesn't match format shows parse error
  - ISO and RFC2822 use native Date parsing
  - Custom formats added persist only in session
  - Missing time components default to 0
  - Missing date components default to 1970-01-01

- **Performance considerations**:
  - Regex generated dynamically from pattern
  - No heavy computation

- **State management**:
  - Custom formats added to dropdowns (session only, not persisted)

- **Error handling**:
  - "Enter input string to convert" for empty input
  - "Unable to parse input using selected format" for mismatched format

### Pattern Parsing Algorithm
1. Escape special regex characters in pattern
2. Replace tokens with capturing groups: `YYYY` → `(\d{4})`, `MM/DD` → `(\d{1,2})`
3. Extract token order from original pattern
4. Match input against generated regex
5. Map captured groups to date components based on token order
6. Construct Date using timezone offset calculation

### Format Output Algorithm
1. For ISO: return `date.toISOString()`
2. For RFC2822: return `date.toUTCString()`
3. For custom patterns:
   - Calculate timezone offset
   - Adjust date to target timezone
   - Replace tokens with padded values

## Category
Date/Time Tools

## Tool Card Info
- **Icon**: 🔤
- **Title**: DateTime Format Converter
- **Description**: Parse and reformat date/time strings with custom patterns
