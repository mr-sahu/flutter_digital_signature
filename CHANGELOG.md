# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2025-09-09
### Added
- Initial release of `flutter_digital_signature` package.
- Provides easy-to-use API to check internet connectivity status in Flutter apps.
- Supports real-time connection status changes (online/offline).
- Handles platform-specific connectivity checks (iOS, Android).
- Exposes connectivity status as Stream for reactive usage.
- Simple method to check current connection status (WiFi, Mobile, None).
- Example usage included in the documentation.

### Fixed
- Minor bug fix: Stream was not properly emitting connectivity status on some devices.
- Improved null-safety compliance.
- Improved package documentation and code comments.

### Added
- Added custom timeout option when checking connectivity.
- Added method to force refresh current connection status.
- Support for Web platform connectivity detection.
- Improved error handling for edge cases.

### Fixed
- Fix issue where connection stream did not update correctly on Android 13+.
- Documentation typo fixes.
