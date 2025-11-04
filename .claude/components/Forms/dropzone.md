# Dropzone Component

## Overview
DropzoneComponent provides an accessible area for dragging and dropping files and/or folders with optional action buttons to open the native file and folder pickers.

**Category:** Forms
**Tag Name:** `elvt-dropzone`
**Since:** 0.0.29
**Status:** Complete

## Dependencies
- `elvt-button`
- `elvt-divider`
- `elvt-stack`

## Properties

### disabled
- **Type:** `boolean`
- **Attribute:** `disabled`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** If set to `true`, the user can't interact with the component

### size
- **Type:** `Size` (`'s' | 'm' | 'l'`)
- **Attribute:** `size`
- **Reflects:** `true`
- **Default:** `'m'`
- **Description:** Size of the Dropzone Component

### allowFiles
- **Type:** `DropzoneAllowFilesMode` (`'none' | 'single' | 'multiple'`)
- **Attribute:** `allow-files`
- **Reflects:** `true`
- **Default:** `'multiple'`
- **Description:** Whether, and in what quantity, file selection is allowed

### allowDirectories
- **Type:** `boolean`
- **Attribute:** `allow-directories`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Whether selection of directories is allowed

### direction
- **Type:** `Direction` (`'row' | 'column'`)
- **Attribute:** `direction`
- **Reflects:** `true`
- **Default:** `'column'`
- **Description:** Direction of the dropzone elements

### enableFileFilter
- **Type:** `boolean`
- **Attribute:** `enable-file-filter`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Whether only a set of file types given by `allowedFileTypes` is accepted

### allowedFileTypes
- **Type:** `string[]`
- **Attribute:** `allowed-file-types`
- **Reflects:** `true`
- **Default:** `[]`
- **Description:** File types that are allowed for selection. Accepts MIME types (e.g., `image/*`, `text/plain`) or file extensions (e.g., `.pdf`, `.jpg`)

## Slots

### Default Slot
Default slot for the instructional text, replace the prompt message.

## Events

### elvt-file-drop
- **Type:** `FileDropEvent`
- **Description:** Files received as a FileSystemTree. Contains dropped or selected files/folders

## CSS Parts

### ground
Root visual container with state classes: `targetable`, `dragover`, `invalid`, `disabled`

### prompt
Container for the instructional text

### divider
Divider component separating prompt from actions

## Internationalization (i18n)

### DropzoneIntl
Provides customizable text strings:
- **prompt(filesAllowed, foldersAllowed):** Prompt text 'Drop ...'
- **selectFilesLabel:** Button label for "Select files"
- **selectFileLabel:** Button label for "Select file"
- **selectFolderLabel:** Button label for "Select folder"
- **dividerLabel:** Label for the divider (default: "or")

## File Filtering

### Accepted Format Examples
- MIME types: `image/*`, `video/*`, `text/plain`, `application/pdf`
- File extensions: `.pdf`, `.jpg`, `.png`, `.doc`
- Multiple types: `['image/*', '.pdf', 'text/plain']`

### Filtering Behavior
- When `enableFileFilter` is `true`, only files matching `allowedFileTypes` are accepted
- Files with unknown MIME types (empty type) are accepted to allow directories
- Invalid items visually mark the dropzone as invalid
- Filter applies to both drag-and-drop and file picker selection

## Drag and Drop States

### Visual States
- **targetable:** Valid files are being dragged over the page
- **dragover:** Files are being dragged over the dropzone
- **invalid:** Invalid files are being dragged over the dropzone
- **disabled:** Component is disabled

### State Classes
Applied to the `ground` CSS part based on current interaction state.

## Usage Notes
- Supports both drag-and-drop and button-triggered file selection
- File picker respects `allowedFileTypes` filter
- Folder picker uses `webkitdirectory` attribute
- Returns `FileSystemTree` structure for hierarchical file handling
- Automatically filters results based on `allowFiles`, `allowDirectories`, and `enableFileFilter`
- Uses modern `CloseWatcher` API when available
- Divider tone changes to danger when invalid files are detected
- When nothing is allowed (`allowFiles: 'none'` and `allowDirectories: false`), component is disabled
