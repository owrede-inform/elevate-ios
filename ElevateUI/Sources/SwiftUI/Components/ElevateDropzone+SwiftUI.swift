#if os(iOS)
import SwiftUI
import UniformTypeIdentifiers

/// Dropzone component for file selection
///
/// **iOS Adaptation Note**: Unlike ELEVATE web's drag-and-drop, iOS uses:
/// - **Document Picker**: Native file selection dialog (iOS standard)
/// - **Photo Picker**: For images/videos (PHPickerViewController)
/// - **Tap to select**: No drag-and-drop on touch devices
/// - **Visual feedback**: State changes on interaction
/// See docs/DIVERSIONS.md for full adaptation details.
///
/// Example:
/// ```swift
/// ElevateDropzone(
///     allowedTypes: [.image, .pdf],
///     onFilesSelected: { urls in
///         print("Selected files: \(urls)")
///     }
/// )
/// ```
@available(iOS 15, *)
public struct ElevateDropzone: View {

    @State private var showFilePicker = false
    @State private var isTargetable = false

    private let allowedTypes: [UTType]
    private let allowsMultipleSelection: Bool
    private let isInvalid: Bool
    private let message: String
    private let buttonText: String
    private let onFilesSelected: ([URL]) -> Void

    @Environment(\.isEnabled) private var isEnabled

    // MARK: - Initialization

    public init(
        allowedTypes: [UTType] = [.item],
        allowsMultipleSelection: Bool = false,
        isInvalid: Bool = false,
        message: String = "Tap to select files",
        buttonText: String = "Choose Files",
        onFilesSelected: @escaping ([URL]) -> Void
    ) {
        self.allowedTypes = allowedTypes
        self.allowsMultipleSelection = allowsMultipleSelection
        self.isInvalid = isInvalid
        self.message = message
        self.buttonText = buttonText
        self.onFilesSelected = onFilesSelected
    }

    // MARK: - Body

    public var body: some View {
        Button {
            performHaptic()
            showFilePicker = true
        } label: {
            VStack(spacing: DropzoneComponentTokens.gap_m) {
                // Upload icon
                Image(systemName: "arrow.up.doc.fill")
                    .font(.system(size: 40))
                    .foregroundColor(textColor)

                // Message
                Text(message)
                    .font(.body)
                    .foregroundColor(textColor)
                    .multilineTextAlignment(.center)

                // Button
                Text(buttonText)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, DropzoneComponentTokens.padding_inline_m)
            .padding(.vertical, DropzoneComponentTokens.padding_block_m)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: DropzoneComponentTokens.radius_m)
                    .strokeBorder(borderColor, style: StrokeStyle(lineWidth: DropzoneComponentTokens.width_m, dash: [8, 4]))
            )
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .fileImporter(
            isPresented: $showFilePicker,
            allowedContentTypes: allowedTypes,
            allowsMultipleSelection: allowsMultipleSelection
        ) { result in
            handleFileSelection(result)
        }
    }

    // MARK: - File Selection Handler

    private func handleFileSelection(_ result: Result<[URL], Error>) {
        switch result {
        case .success(let urls):
            performHaptic(.medium)
            onFilesSelected(urls)
        case .failure(let error):
            print("File selection error: \(error.localizedDescription)")
        }
    }

    // MARK: - Computed Properties

    private var backgroundColor: Color {
        if !isEnabled {
            return DropzoneComponentTokens.fill_disabled
        }
        if isInvalid {
            return DropzoneComponentTokens.fill_invalid
        }
        if isTargetable {
            return DropzoneComponentTokens.fill_targetable
        }
        return DropzoneComponentTokens.fill_default
    }

    private var borderColor: Color {
        if !isEnabled {
            return DropzoneComponentTokens.color_disabled
        }
        if isInvalid {
            return DropzoneComponentTokens.color_invalid
        }
        if isTargetable {
            return DropzoneComponentTokens.color_targetable
        }
        return DropzoneComponentTokens.color_default
    }

    private var textColor: Color {
        if !isEnabled {
            return DropzoneComponentTokens.text_color_disabled
        }
        if isInvalid {
            return DropzoneComponentTokens.text_color_invalid
        }
        if isTargetable {
            return DropzoneComponentTokens.text_color_targetable
        }
        return DropzoneComponentTokens.text_color_default
    }

    // MARK: - Haptics

    private func performHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

// MARK: - Image Dropzone

/// Specialized dropzone for images using PHPickerViewController
///
/// **iOS Adaptation**: Uses native photo picker for better UX with photos.
@available(iOS 15, *)
public struct ElevateImageDropzone: View {

    @State private var showPhotoPicker = false

    private let allowsMultipleSelection: Bool
    private let message: String
    private let onImagesSelected: ([URL]) -> Void

    @Environment(\.isEnabled) private var isEnabled

    public init(
        allowsMultipleSelection: Bool = false,
        message: String = "Tap to select photos",
        onImagesSelected: @escaping ([URL]) -> Void
    ) {
        self.allowsMultipleSelection = allowsMultipleSelection
        self.message = message
        self.onImagesSelected = onImagesSelected
    }

    public var body: some View {
        Button {
            showPhotoPicker = true
        } label: {
            VStack(spacing: DropzoneComponentTokens.gap_m) {
                Image(systemName: "photo.on.rectangle.angled")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)

                Text(message)
                    .font(.body)
                    .foregroundColor(.primary)

                Text("Choose Photos")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, DropzoneComponentTokens.padding_inline_m)
            .padding(.vertical, DropzoneComponentTokens.padding_block_m)
            .background(DropzoneComponentTokens.fill_default)
            .overlay(
                RoundedRectangle(cornerRadius: DropzoneComponentTokens.radius_m)
                    .strokeBorder(DropzoneComponentTokens.color_default, style: StrokeStyle(lineWidth: DropzoneComponentTokens.width_m, dash: [8, 4]))
            )
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .fileImporter(
            isPresented: $showPhotoPicker,
            allowedContentTypes: [.image],
            allowsMultipleSelection: allowsMultipleSelection
        ) { result in
            switch result {
            case .success(let urls):
                onImagesSelected(urls)
            case .failure(let error):
                print("Photo selection error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateDropzone_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Dropzone Examples")
                    .font(.title)

                // Basic dropzone
                VStack(alignment: .leading) {
                    Text("Basic File Selector")
                        .font(.headline)

                    ElevateDropzone { urls in
                        print("Selected: \(urls)")
                    }
                }

                // PDF only
                VStack(alignment: .leading) {
                    Text("PDF Only")
                        .font(.headline)

                    ElevateDropzone(
                        allowedTypes: [.pdf],
                        message: "Select PDF documents"
                    ) { urls in
                        print("PDFs: \(urls)")
                    }
                }

                // Multiple selection
                VStack(alignment: .leading) {
                    Text("Multiple Selection")
                        .font(.headline)

                    ElevateDropzone(
                        allowsMultipleSelection: true,
                        message: "Select one or more files",
                        buttonText: "Choose Multiple Files"
                    ) { urls in
                        print("Multiple: \(urls)")
                    }
                }

                // Invalid state
                VStack(alignment: .leading) {
                    Text("Invalid State")
                        .font(.headline)

                    ElevateDropzone(
                        isInvalid: true,
                        message: "Please select a valid file"
                    ) { urls in
                        print("Selected: \(urls)")
                    }
                }

                // Image dropzone
                VStack(alignment: .leading) {
                    Text("Image Selector")
                        .font(.headline)

                    ElevateImageDropzone { urls in
                        print("Images: \(urls)")
                    }
                }

                // Disabled
                VStack(alignment: .leading) {
                    Text("Disabled State")
                        .font(.headline)

                    ElevateDropzone { _ in }
                        .disabled(true)
                }

                // iOS Adaptation notes
                VStack(alignment: .leading, spacing: 8) {
                    Text("iOS Adaptations:")
                        .font(.caption)
                        .fontWeight(.semibold)

                    Text("✓ Native document picker (no drag-drop)")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("✓ Photo picker for images")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("✓ Tap to select (touch device)")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("✓ Haptic feedback on selection")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            .padding()
        }
    }
}
#endif

#endif
