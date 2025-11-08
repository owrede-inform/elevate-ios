#if os(iOS)
import SwiftUI

/// Lightbox component with iOS Photos app gestures
///
/// **iOS Adaptation Note**: Unlike ELEVATE web's fixed lightbox, this uses:
/// - Pinch-to-zoom gesture (iOS Photos pattern)
/// - Double-tap to toggle zoom
/// - Swipe down to dismiss
/// - Share button with native iOS share sheet
/// - Horizontal paging for multiple images
/// See docs/DIVERSIONS.md for full adaptation details.
///
/// Example:
/// ```swift
/// @State private var showLightbox = false
///
/// Button("View Photo") {
///     showLightbox = true
/// }
/// .elevateLightbox(
///     isPresented: $showLightbox,
///     images: ["photo1", "photo2", "photo3"],
///     initialIndex: 0
/// )
/// ```
@available(iOS 15, *)
public struct ElevateLightbox: View {

    @Environment(\.dismiss) private var dismiss
    @State private var currentScale: CGFloat = 1.0
    @State private var finalScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var finalOffset: CGSize = .zero
    @State private var currentIndex: Int
    @State private var showShareSheet = false

    private let images: [String]
    private let onDismiss: (() -> Void)?

    // MARK: - Initialization

    public init(
        images: [String],
        initialIndex: Int = 0,
        onDismiss: (() -> Void)? = nil
    ) {
        self.images = images
        self._currentIndex = State(initialValue: initialIndex)
        self.onDismiss = onDismiss
    }

    // MARK: - Body

    public var body: some View {
        ZStack {
            // Backdrop
            LightboxComponentTokens.backdrop_color
                .ignoresSafeArea()

            // Image viewer with gestures
            TabView(selection: $currentIndex) {
                ForEach(images.indices, id: \.self) { index in
                    ZoomableImage(
                        imageName: images[index],
                        scale: $currentScale,
                        finalScale: $finalScale,
                        offset: $offset,
                        finalOffset: $finalOffset,
                        onDismiss: handleDismiss
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))

            // Toolbar overlay
            VStack {
                HStack {
                    // Close button
                    Button {
                        performHaptic(.light)
                        handleDismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(ElevateAliases.Feedback.Strong.text_inverted)
                            .shadow(radius: 2)
                    }

                    Spacer()

                    // Share button
                    Button {
                        performHaptic(.light)
                        showShareSheet = true
                    } label: {
                        Image(systemName: "square.and.arrow.up.circle.fill")
                            .font(.title2)
                            .foregroundColor(ElevateAliases.Feedback.Strong.text_inverted)
                            .shadow(radius: 2)
                    }
                }
                .padding()

                Spacer()

                // Image counter
                Text("\(currentIndex + 1) / \(images.count)")
                    .font(.caption)
                    .foregroundColor(ElevateAliases.Feedback.Strong.text_inverted)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(LightboxComponentTokens.backdrop_color)
                    .cornerRadius(16)
                    .padding(.bottom, 8)
            }
            .opacity(currentScale > 1.0 ? 0 : 1) // Hide toolbar when zoomed
        }
        .statusBar(hidden: true)
        .sheet(isPresented: $showShareSheet) {
            if let image = UIImage(named: images[currentIndex]) {
                ShareSheet(items: [image])
            }
        }
    }

    // MARK: - Actions

    private func handleDismiss() {
        onDismiss?()
        dismiss()
    }

    private func performHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

// MARK: - Zoomable Image

@available(iOS 15, *)
private struct ZoomableImage: View {
    let imageName: String
    @Binding var scale: CGFloat
    @Binding var finalScale: CGFloat
    @Binding var offset: CGSize
    @Binding var finalOffset: CGSize
    let onDismiss: () -> Void

    @State private var dragOffset: CGSize = .zero

    var body: some View {
        GeometryReader { geometry in
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .scaleEffect(max(scale * finalScale, 1.0))
                .offset(x: offset.width + finalOffset.width, y: offset.height + finalOffset.height + dragOffset.height)
                .gesture(
                    // Pinch-to-zoom gesture (iOS Photos pattern)
                    MagnificationGesture()
                        .onChanged { value in
                            scale = value
                        }
                        .onEnded { value in
                            finalScale *= scale
                            scale = 1.0

                            // Limit max zoom
                            if finalScale > 4.0 {
                                finalScale = 4.0
                            }

                            // Reset zoom if zoomed out too far
                            if finalScale < 1.0 {
                                withAnimation(.spring(response: 0.3)) {
                                    finalScale = 1.0
                                    finalOffset = .zero
                                }
                            }
                        }
                )
                .simultaneousGesture(
                    // Double-tap to toggle zoom (iOS Photos pattern)
                    TapGesture(count: 2)
                        .onEnded {
                            performHaptic(.medium)
                            withAnimation(.spring(response: 0.3)) {
                                if finalScale > 1.0 {
                                    // Zoom out to original size
                                    finalScale = 1.0
                                    finalOffset = .zero
                                } else {
                                    // Zoom in to 2x
                                    finalScale = 2.0
                                }
                            }
                        }
                )
                .simultaneousGesture(
                    // Pan gesture for moving zoomed image
                    DragGesture()
                        .onChanged { value in
                            if finalScale > 1.0 {
                                // Pan when zoomed in
                                offset = value.translation
                            } else {
                                // Swipe down to dismiss when not zoomed
                                if value.translation.height > 0 {
                                    dragOffset = value.translation
                                }
                            }
                        }
                        .onEnded { value in
                            if finalScale > 1.0 {
                                // Save pan offset when zoomed
                                finalOffset.width += offset.width
                                finalOffset.height += offset.height
                                offset = .zero
                            } else {
                                // Dismiss if swiped down far enough
                                if value.translation.height > 100 {
                                    performHaptic(.medium)
                                    onDismiss()
                                } else {
                                    // Bounce back
                                    withAnimation(.spring(response: 0.3)) {
                                        dragOffset = .zero
                                    }
                                }
                            }
                        }
                )
        }
    }

    private func performHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

// MARK: - Share Sheet

@available(iOS 15, *)
private struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

// MARK: - View Extension

@available(iOS 15, *)
extension View {
    /// Present a lightbox with iOS Photos app gestures
    ///
    /// **iOS Adaptation**: Full-screen image viewer with native gestures:
    /// - Pinch to zoom
    /// - Double-tap to toggle zoom
    /// - Swipe down to dismiss
    /// - Share button with iOS share sheet
    /// - Horizontal paging for multiple images
    ///
    /// Example:
    /// ```swift
    /// Image("photo")
    ///     .elevateLightbox(
    ///         isPresented: $showLightbox,
    ///         images: ["photo1", "photo2"],
    ///         initialIndex: 0
    ///     )
    /// ```
    public func elevateLightbox(
        isPresented: Binding<Bool>,
        images: [String],
        initialIndex: Int = 0,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        self.fullScreenCover(isPresented: isPresented) {
            ElevateLightbox(
                images: images,
                initialIndex: initialIndex,
                onDismiss: onDismiss
            )
        }
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateLightbox_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer()
    }

    struct PreviewContainer: View {
        @State private var showLightbox = false

        var body: some View {
            VStack(spacing: 20) {
                Text("Lightbox Examples")
                    .font(.title)

                // Single image preview
                Button("View Single Image") {
                    showLightbox = true
                }
                .buttonStyle(.borderedProminent)

                // Image grid
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                    ForEach(0..<6) { index in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue.opacity(0.3))
                            .aspectRatio(1, contentMode: .fit)
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.title)
                                    .foregroundColor(.white)
                            )
                            .onTapGesture {
                                showLightbox = true
                            }
                    }
                }
                .padding()

                Spacer()

                // iOS Adaptation notes
                VStack(alignment: .leading, spacing: 8) {
                    Text("iOS Adaptations:")
                        .font(.caption)
                        .fontWeight(.semibold)

                    Text("✓ Pinch to zoom (iOS Photos pattern)")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("✓ Double-tap to toggle zoom")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("✓ Swipe down to dismiss")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("✓ Share button with native share sheet")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("✓ Horizontal paging for multiple images")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("✓ Full-screen with hidden status bar")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding()
            }
            .elevateLightbox(
                isPresented: $showLightbox,
                images: ["photo.fill", "photo.fill", "photo.fill"], // Placeholder images
                initialIndex: 0
            )
        }
    }
}
#endif

#endif
