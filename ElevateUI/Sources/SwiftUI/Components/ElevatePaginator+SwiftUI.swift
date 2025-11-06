#if os(iOS)
import SwiftUI

/// ELEVATE Paginator Component
///
/// Navigation control for paginated content with page size selection.
/// Supports offset and page display modes.
///
/// **Web Component:** `<elvt-paginator>`
/// **API Reference:** `.claude/components/Navigation/paginator.md`
@available(iOS 15, *)
public struct ElevatePaginator: View {

    // MARK: - Properties

    /// Total number of items
    @Binding private var length: Int

    /// Current page index (0-based)
    @Binding private var pageIndex: Int

    /// Number of items per page
    @Binding private var pageSize: Int

    /// Available page size options
    private let pageSizeOptions: [Int]

    /// Display mode
    private let mode: PaginatorMode

    /// Whether to show first/last buttons
    private let showFirstLastButtons: Bool

    /// Whether to hide page size selector
    private let hidePageSize: Bool

    /// Whether to hide range status
    private let hideRangeStatus: Bool

    /// The size of controls
    private let size: PaginatorSize

    /// Action when page changes
    private let onPageChange: ((Int, Int) -> Void)?

    // MARK: - Computed Properties

    private var totalPages: Int {
        guard pageSize > 0 else { return 0 }
        return max(1, Int(ceil(Double(length) / Double(pageSize))))
    }

    private var rangeStart: Int {
        min(pageIndex * pageSize + 1, length)
    }

    private var rangeEnd: Int {
        min((pageIndex + 1) * pageSize, length)
    }

    private var isFirstPage: Bool {
        pageIndex <= 0
    }

    private var isLastPage: Bool {
        pageIndex >= totalPages - 1
    }

    // MARK: - Initializer

    /// Creates a paginator
    ///
    /// - Parameters:
    ///   - length: Total number of items
    ///   - pageIndex: Current page index (0-based)
    ///   - pageSize: Items per page
    ///   - pageSizeOptions: Available page sizes (default: [10, 25, 50, 100])
    ///   - mode: Display mode (default: .offset)
    ///   - showFirstLastButtons: Show first/last buttons (default: false)
    ///   - hidePageSize: Hide page size selector (default: false)
    ///   - hideRangeStatus: Hide range display (default: false)
    ///   - size: Control size (default: .medium)
    ///   - onPageChange: Called when page changes (default: nil)
    public init(
        length: Binding<Int>,
        pageIndex: Binding<Int>,
        pageSize: Binding<Int>,
        pageSizeOptions: [Int] = [10, 25, 50, 100],
        mode: PaginatorMode = .offset,
        showFirstLastButtons: Bool = false,
        hidePageSize: Bool = false,
        hideRangeStatus: Bool = false,
        size: PaginatorSize = .medium,
        onPageChange: ((Int, Int) -> Void)? = nil
    ) {
        self._length = length
        self._pageIndex = pageIndex
        self._pageSize = pageSize
        self.pageSizeOptions = pageSizeOptions
        self.mode = mode
        self.showFirstLastButtons = showFirstLastButtons
        self.hidePageSize = hidePageSize
        self.hideRangeStatus = hideRangeStatus
        self.size = size
        self.onPageChange = onPageChange
    }

    // MARK: - Body

    public var body: some View {
        HStack(spacing: tokenGap) {
            // Page size selector
            if !hidePageSize && !pageSizeOptions.isEmpty {
                HStack(spacing: 4) {
                    Text("Items per page:")
                        .font(labelFont)
                        .foregroundColor(PaginatorComponentTokens.text_color)

                    Menu {
                        ForEach(pageSizeOptions, id: \.self) { size in
                            Button("\(size)") {
                                changePageSize(size)
                            }
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Text("\(pageSize)")
                                .font(labelFont)
                            Image(systemName: "chevron.down")
                                .font(.caption)
                        }
                        .foregroundColor(PaginatorComponentTokens.text_color)
                    }
                }
            }

            Spacer()

            // Range/Page status
            if !hideRangeStatus {
                Text(statusText)
                    .font(labelFont)
                    .foregroundColor(PaginatorComponentTokens.text_color)
                    .padding(.leading, tokenRangePadding)
            }

            // Navigation buttons
            HStack(spacing: 4) {
                // First page button
                if showFirstLastButtons {
                    Button(action: goToFirstPage) {
                        Image(systemName: "chevron.left.to.line")
                            .font(iconFont)
                    }
                    .disabled(isFirstPage)
                    .accessibilityLabel("First page")
                }

                // Previous page button
                Button(action: goToPreviousPage) {
                    Image(systemName: "chevron.left")
                        .font(iconFont)
                }
                .disabled(isFirstPage)
                .accessibilityLabel("Previous page")

                // Next page button
                Button(action: goToNextPage) {
                    Image(systemName: "chevron.right")
                        .font(iconFont)
                }
                .disabled(isLastPage)
                .accessibilityLabel("Next page")

                // Last page button
                if showFirstLastButtons {
                    Button(action: goToLastPage) {
                        Image(systemName: "chevron.right.to.line")
                            .font(iconFont)
                    }
                    .disabled(isLastPage)
                    .accessibilityLabel("Last page")
                }
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .accessibilityElement(children: .contain)
    }

    // MARK: - Helpers

    private var statusText: String {
        guard length > 0 else { return "0 of 0" }

        switch mode {
        case .offset:
            return "\(rangeStart) - \(rangeEnd) of \(length)"
        case .page:
            return "Page \(pageIndex + 1) of \(totalPages)"
        }
    }

    private func goToFirstPage() {
        changePage(0)
    }

    private func goToPreviousPage() {
        changePage(max(0, pageIndex - 1))
    }

    private func goToNextPage() {
        changePage(min(totalPages - 1, pageIndex + 1))
    }

    private func goToLastPage() {
        changePage(totalPages - 1)
    }

    private func changePage(_ newPage: Int) {
        let clampedPage = max(0, min(totalPages - 1, newPage))
        pageIndex = clampedPage
        onPageChange?(pageIndex, pageSize)
    }

    private func changePageSize(_ newSize: Int) {
        pageSize = newSize
        pageIndex = 0 // Reset to first page
        onPageChange?(pageIndex, pageSize)
    }

    // MARK: - Token Accessors

    private var tokenGap: CGFloat {
        switch size {
        case .small: return PaginatorComponentTokens.gap_s
        case .medium: return PaginatorComponentTokens.gap_m
        case .large: return PaginatorComponentTokens.gap_l
        }
    }

    private var tokenRangePadding: CGFloat {
        switch size {
        case .small: return PaginatorComponentTokens.range_padding_inline_start_s
        case .medium: return PaginatorComponentTokens.range_padding_inline_start_m
        case .large: return PaginatorComponentTokens.range_padding_inline_start_l
        }
    }

    private var labelFont: Font {
        switch size {
        case .small: return ElevateTypography.bodySmall
        case .medium: return ElevateTypography.bodyMedium
        case .large: return ElevateTypography.bodyLarge
        }
    }

    private var iconFont: Font {
        switch size {
        case .small: return .system(size: 14)
        case .medium: return .system(size: 16)
        case .large: return .system(size: 18)
        }
    }
}

// MARK: - Paginator Mode

@available(iOS 15, *)
public enum PaginatorMode {
    case offset  // Shows "1 - 25 of 100"
    case page    // Shows "Page 1 of 4"
}

// MARK: - Paginator Size

@available(iOS 15, *)
public enum PaginatorSize {
    case small
    case medium
    case large
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevatePaginator_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 32) {
            // Basic Paginator
            VStack(alignment: .leading, spacing: 16) {
                Text("Basic Paginator").font(.headline)

                StatefulPaginatorPreview(
                    length: 100,
                    pageSize: 10
                )
            }

            Divider()

            // With First/Last Buttons
            VStack(alignment: .leading, spacing: 16) {
                Text("With First/Last Buttons").font(.headline)

                StatefulPaginatorPreview(
                    length: 200,
                    pageSize: 25,
                    showFirstLastButtons: true
                )
            }

            Divider()

            // Page Mode
            VStack(alignment: .leading, spacing: 16) {
                Text("Page Mode").font(.headline)

                StatefulPaginatorPreview(
                    length: 150,
                    pageSize: 20,
                    mode: .page
                )
            }

            Divider()

            // Size Variants
            VStack(alignment: .leading, spacing: 16) {
                Text("Size Variants").font(.headline)

                VStack(spacing: 12) {
                    StatefulPaginatorPreview(
                        length: 100,
                        pageSize: 10,
                        size: .small
                    )

                    StatefulPaginatorPreview(
                        length: 100,
                        pageSize: 10,
                        size: .medium
                    )

                    StatefulPaginatorPreview(
                        length: 100,
                        pageSize: 10,
                        size: .large
                    )
                }
            }

            Divider()

            // Hidden Options
            VStack(alignment: .leading, spacing: 16) {
                Text("Hidden Options").font(.headline)

                StatefulPaginatorPreview(
                    length: 100,
                    pageSize: 10,
                    hidePageSize: true
                )

                StatefulPaginatorPreview(
                    length: 100,
                    pageSize: 10,
                    hideRangeStatus: true
                )
            }
        }
        .padding()
    }

    struct StatefulPaginatorPreview: View {
        @State private var length: Int
        @State private var pageIndex: Int = 0
        @State private var pageSize: Int

        let mode: PaginatorMode
        let showFirstLastButtons: Bool
        let hidePageSize: Bool
        let hideRangeStatus: Bool
        let size: PaginatorSize

        init(
            length: Int,
            pageSize: Int,
            mode: PaginatorMode = .offset,
            showFirstLastButtons: Bool = false,
            hidePageSize: Bool = false,
            hideRangeStatus: Bool = false,
            size: PaginatorSize = .medium
        ) {
            self._length = State(initialValue: length)
            self._pageSize = State(initialValue: pageSize)
            self.mode = mode
            self.showFirstLastButtons = showFirstLastButtons
            self.hidePageSize = hidePageSize
            self.hideRangeStatus = hideRangeStatus
            self.size = size
        }

        var body: some View {
            VStack {
                ElevatePaginator(
                    length: $length,
                    pageIndex: $pageIndex,
                    pageSize: $pageSize,
                    mode: mode,
                    showFirstLastButtons: showFirstLastButtons,
                    hidePageSize: hidePageSize,
                    hideRangeStatus: hideRangeStatus,
                    size: size
                ) { index, size in
                    print("Page changed to \(index + 1), size: \(size)")
                }

                // Sample content list
                List {
                    ForEach(currentPageItems, id: \.self) { item in
                        Text("Item \(item)")
                    }
                }
                .frame(height: 200)
            }
            .background(Color.gray.opacity(0.1))
        }

        private var currentPageItems: [Int] {
            let start = pageIndex * pageSize + 1
            let end = min((pageIndex + 1) * pageSize, length)
            return Array(start...end)
        }
    }
}
#endif

#endif
