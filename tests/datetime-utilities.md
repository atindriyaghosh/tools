# Manual Test Scenarios — datetime-utilities.html

This document lists manual test scenarios to verify the functionality of `datetime-utilities.html`.

Each scenario includes steps, sample input, and expected output.

---

## 1) Timezone conversion — basic

- Feature: Convert a specific local date/time from one IANA timezone to another.
- Steps:
  1. Open `datetime-utilities.html` in a browser.
  2. In the "Date & time" field, enter `2023-07-15T14:30`.
  3. Set "From" to `America/New_York` and "To" to `Europe/London`.
  4. Click "Convert".
- Expected:
  - The result shows the source formatted in `America/New_York`, the target formatted in `Europe/London`, and an ISO (UTC) timestamp.
  - The target time should be 19:30 BST (or equivalent) and the DST fields should reflect whether the date falls into DST.

---

## 2) Timezone conversion — default (current date/time)

- Feature: When no date/time is provided, conversion uses the current instant.
- Steps:
  1. Clear the "Date & time" input.
  2. Select any valid From/To timezones (e.g., `UTC` → `Asia/Tokyo`).
  3. Click "Convert".
- Expected:
  - The tool converts the current instant and displays values for source, target, and UTC.

---

## 3) DST detection edge cases

- Feature: Correct DST detection for dates near DST transition.
- Steps:
  1. Use a timezone with DST (e.g., `America/New_York`).
  2. Test dates around March/November (e.g., `2023-03-12T01:30`, `2023-11-05T01:30`).
  3. Click "Convert".
- Expected:
  - The DST fields indicate whether DST is used and whether the provided date is in DST.
  - Verify offsets change as expected between dates that are on different side of the transition.

---

## 4) Unix timestamp → human readable (seconds and ms)

- Feature: Convert timestamps to readable date/time in chosen timezone.
- Steps:
  1. Enter `1690000000` in the Unix timestamp field and set unit to Auto or Seconds.
  2. Choose `UTC` as output timezone and click "Convert to Date".
  3. Repeat with `1690000000000` (milliseconds) and unit Auto or Milliseconds.
- Expected:
  - Correct ISO UTC and formatted timezone output; seconds vs milliseconds handled properly.

---

## 5) Human date → Unix timestamp

- Feature: Convert a local date/time (with explicit source timezone) to Unix seconds/ms.
- Steps:
  1. Enter `2024-01-01T00:00` in the "Date & time" field under "Date to timestamp".
  2. Set Source timezone to `Europe/London` and click "Convert to Unix".
- Expected:
  - Displays the ISO UTC timestamp, Unix seconds and Unix ms for the correct instant.

---

## 6) Format conversion — known patterns

- Feature: Convert from a known input format to another format (including ISO/RFC).
- Steps:
  1. In the Format converter, set Input format to `YYYY-MM-DD HH:mm:ss` and Output format to `ISO`.
  2. Enter `2023-07-15 14:30:00` and set Timezone to `America/New_York`.
  3. Click "Convert".
- Expected:
  - Parsed ISO (UTC) and result in ISO string that matches the interpreted instant.

---

## 7) Format conversion — custom format

- Feature: Add a new custom format and use it to parse/format dates.
- Steps:
  1. In the add-format input, enter `DD/MM/YYYY HH:mm` and click "Add format".
  2. Select it as the Input format and set Output format to `ISO`.
  3. Enter `15/07/2023 14:30` and click "Convert".
- Expected:
  - The custom format is accepted, parsing succeeds, and output ISO matches expectation.

---

## 8) Invalid input handling

- Feature: Graceful handling of unparsable or invalid inputs.
- Steps:
  1. Enter `not-a-date` in various inputs (timestamp & format converter) and click the respective convert buttons.
- Expected:
  - The tool displays an error message (e.g., "Unable to parse input") and does not crash.

---

## 9) UI interaction checks

- Feature: Buttons enabled/disabled appropriately; select all/deselect all behavior for pages is not applicable here.
- Steps:
  1. Verify Convert buttons are clickable and that Enter key submits where supported (press Enter inside inputs).
- Expected:
  - Inputs trigger conversions on Enter and the UI updates results.

---

## 10) Accessibility & labels

- Feature: Ensure controls have labels, readable error messages, and aria attributes where applicable.
- Steps:
  1. Use a screen reader or inspect the DOM to confirm labels and `aria-live` on result areas.
- Expected:
  - Results announce changes (aria-live) and input labels are present.

---

## Fixtures

- Sample timestamp fixtures are available at `tests/fixtures/datetime-utilities/sample-timestamps.json`.
- See `tests/fixtures/datetime-utilities/README.md` for fixture details and example usage.

## Notes & Environment

- Tests should be run across Chrome-based and Firefox browsers if possible, since timezone behavior comes from the browser's Intl implementation.
- For any discrepancy in timezone offsets or DST detection, cross-check with a trusted authoritative source (e.g., `timeanddate.com` or IANA TZ database).
