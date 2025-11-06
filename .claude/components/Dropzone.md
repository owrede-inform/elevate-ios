# Dropzone Component - iOS Adaptations

## ELEVATE Web Pattern
File drop area with drag-over states

## iOS Adaptation
- ✅ iOS file picker integration
- ✅ PhotosPicker for images
- ✅ DocumentPicker for files
- ✅ Drag and drop on iPad (limited)
- ✅ Visual feedback during selection
- ✅ File type filtering

## Reasoning
iOS doesn't have web-style drag and drop. Native pickers provide file access.

## Implementation Notes
Uses DropzoneComponentTokens
PhotosPicker for photos
DocumentPicker for documents
iPad supports limited drag/drop
File access requires permissions

## Code Example
```swift
@State private var selectedFile: URL?

ElevateDropzone(
    acceptedTypes: [.image, .pdf],
    onFilesSelected: { urls in
        selectedFile = urls.first
    }
)
```

## Related Components
Input, Field, Button
