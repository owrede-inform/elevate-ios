#if os(iOS)
import SwiftUI

/// Select component with iOS-native Picker patterns
///
/// **iOS Adaptation Note**: Unlike ELEVATE web's hover dropdown, this uses:
/// - Small lists (<10 items): Picker with .menu style
/// - Large lists (≥10 items): Sheet with searchable List
/// - Never uses web-style hover dropdown on touch
/// See docs/DIVERSIONS.md for full adaptation details.
///
/// Example:
/// ```swift
/// @State private var selectedOption = "Option 1"
///
/// ElevateSelect(
///     selection: $selectedOption,
///     options: ["Option 1", "Option 2", "Option 3"]
/// )
/// ```
@available(iOS 15, *)
public struct ElevateSelect<T: Hashable & CustomStringConvertible>: View {

    @Binding private var selection: T
    @State private var showSheet = false

    private let options: [T]
    private let label: String
    private let isInvalid: Bool
    private let searchable: Bool

    @Environment(\.isEnabled) private var isEnabled

    // MARK: - Initialization

    public init(
        selection: Binding<T>,
        options: [T],
        label: String = "Select",
        isInvalid: Bool = false,
        searchable: Bool = false
    ) {
        self._selection = selection
        self.options = options
        self.label = label
        self.isInvalid = isInvalid
        self.searchable = searchable || options.count >= 10 // Auto-enable for large lists
    }

    // MARK: - Body

    public var body: some View {
        if options.count < 10 && !searchable {
            // iOS Adaptation: Small lists use native Menu picker
            menuStylePicker
        } else {
            // iOS Adaptation: Large lists use searchable sheet
            sheetStylePicker
        }
    }

    // MARK: - Menu Style (Small Lists)

    private var menuStylePicker: some View {
        Menu {
            Picker(selection: $selection, label: Text(label)) {
                ForEach(options, id: \.self) { option in
                    Text(option.description)
                        .tag(option)
                }
            }
            .pickerStyle(.inline)
        } label: {
            selectButton
        }
        .disabled(!isEnabled)
    }

    // MARK: - Sheet Style (Large Lists)

    private var sheetStylePicker: some View {
        Button(action: {
            showSheet = true
        }) {
            selectButton
        }
        .disabled(!isEnabled)
        .sheet(isPresented: $showSheet) {
            NavigationView {
                SelectionSheet(
                    selection: $selection,
                    options: options,
                    searchable: searchable
                )
                .navigationTitle(label)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            performHaptic()
                            showSheet = false
                        }
                    }
                }
            }
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
    }

    // MARK: - Select Button

    private var selectButton: some View {
        HStack(spacing: SelectComponentTokens.gap_m) {
            Text(selection.description)
                .foregroundColor(textColor)

            Spacer()

            Image(systemName: "chevron.down")
                .foregroundColor(chevronColor)
                .font(.system(size: 12))
        }
        .padding(.horizontal, SelectComponentTokens.padding_inline_m)
        .padding(.vertical, SelectComponentTokens.padding_block_m)
        .background(backgroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: SelectComponentTokens.border_radius_m)
                .stroke(borderColor, lineWidth: SelectComponentTokens.border_width_m)
        )
    }

    // MARK: - Computed Properties

    private var backgroundColor: Color {
        if !isEnabled { return SelectComponentTokens.fill_disabled }
        if isInvalid { return SelectComponentTokens.fill_invalid }
        // NOTE: Removed fill_hover - no hover on iOS per DIVERSIONS.md
        return SelectComponentTokens.fill_default
    }

    private var borderColor: Color {
        if !isEnabled { return SelectComponentTokens.border_color_disabled }
        if isInvalid { return SelectComponentTokens.border_color_invalid }
        // NOTE: Removed border_color_hover - no hover on iOS per DIVERSIONS.md
        return SelectComponentTokens.border_color_default
    }

    private var textColor: Color {
        if !isEnabled { return SelectComponentTokens.initialValue_color_disabled }
        return SelectComponentTokens.initialValue_color_default
    }

    private var chevronColor: Color {
        if !isEnabled { return SelectComponentTokens.chevron_color_disabled }
        return SelectComponentTokens.chevron_color_default
    }

    private func performHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

// MARK: - Selection Sheet

@available(iOS 15, *)
private struct SelectionSheet<T: Hashable & CustomStringConvertible>: View {
    @Binding var selection: T
    @State private var searchText = ""

    let options: [T]
    let searchable: Bool

    var filteredOptions: [T] {
        if searchText.isEmpty || !searchable {
            return options
        }
        return options.filter { option in
            option.description.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        List {
            ForEach(filteredOptions, id: \.self) { option in
                Button(action: {
                    selection = option
                }) {
                    HStack {
                        Text(option.description)
                            .foregroundColor(.primary)

                        Spacer()

                        if selection == option {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: searchable ? "Search" : "")
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateSelect_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer()
    }

    struct PreviewContainer: View {
        @State private var smallSelection = "Small 1"
        @State private var largeSelection = "Item 1"
        @State private var invalidSelection = "Invalid"

        let smallOptions = ["Small 1", "Small 2", "Small 3", "Small 4", "Small 5"]
        let largeOptions = (1...25).map { "Item \($0)" }

        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Select Examples")
                        .font(.title)

                    // Small list (Menu style)
                    VStack(alignment: .leading) {
                        Text("Small List (Menu)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("Uses native Menu picker for <10 items")
                            .font(.caption2)
                            .foregroundColor(.secondary)

                        ElevateSelect(
                            selection: $smallSelection,
                            options: smallOptions,
                            label: "Small List"
                        )
                    }

                    // Large list (Sheet style)
                    VStack(alignment: .leading) {
                        Text("Large List (Sheet)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("Uses searchable sheet for ≥10 items")
                            .font(.caption2)
                            .foregroundColor(.secondary)

                        ElevateSelect(
                            selection: $largeSelection,
                            options: largeOptions,
                            label: "Large List"
                        )
                    }

                    // Invalid state
                    VStack(alignment: .leading) {
                        Text("Invalid State")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        ElevateSelect(
                            selection: $invalidSelection,
                            options: ["Invalid", "Other"],
                            label: "Invalid",
                            isInvalid: true
                        )
                    }

                    // Disabled
                    VStack(alignment: .leading) {
                        Text("Disabled State")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        ElevateSelect(
                            selection: .constant("Disabled"),
                            options: ["Disabled", "Other"],
                            label: "Disabled"
                        )
                        .disabled(true)
                    }

                    // iOS Adaptation notes
                    VStack(alignment: .leading, spacing: 8) {
                        Text("iOS Adaptations:")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("✓ <10 items: Menu picker")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("✓ ≥10 items: Searchable sheet")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("✓ No hover dropdown (touch device)")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("✓ Checkmark shows selection")
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
}
#endif

#endif
