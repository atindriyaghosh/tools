# Common Patterns

This document is the canonical source for reusable code patterns and best practices for tools.

**Cross-references**:
- For file upload patterns, validation, and download handling: @./FILE_UPLOAD_PATTERNS.md
- For naming conventions (variables, functions, CSS classes): @./NAMING_CONVENTIONS.md
- For standard features and structure: @./TOOL_TEMPLATE.md

## Back Navigation

Include at top and bottom of each tool page (styled automatically by `common-styles.css`):
```html
<p style="margin-bottom: 1rem;"><a href="index.html" class="back-link">← Back to Tools</a></p>
```

This is the canonical HTML pattern for back navigation.

## File Upload & Download Patterns

See @./FILE_UPLOAD_PATTERNS.md for:
- PDF byte handling (CRITICAL for avoiding "detached ArrayBuffer" errors)
- File download best practices
- Memory management for blob URLs
- Common pitfalls and how to avoid them

## State Management Pattern

For tools with complex state (forms, multi-step workflows, undo/redo):

```javascript
// Single source of truth - one state object
const state = {
    data: {},
    selectedItems: [],
    mode: 'view',  // or 'edit', 'fill', etc.
    history: { past: [], future: [] }
};

// All state updates go through this function
function updateState(updates) {
    Object.assign(state, updates);
    render();  // Trigger re-render after state changes
}

// Deep cloning for history (undo/redo)
function saveToHistory() {
    const snapshot = JSON.parse(JSON.stringify(state));
    state.history.past.push(snapshot);
    state.history.future = [];  // Clear redo stack
}

function undo() {
    if (state.history.past.length === 0) return;
    const current = JSON.parse(JSON.stringify(state));
    state.history.future.push(current);
    Object.assign(state, state.history.past.pop());
    render();
}
```

**Benefits:**
- Predictable state changes
- Easy to debug (state is centralized)
- Easier to implement undo/redo
- Clear data flow

## Keyboard Shortcut Pattern

Handle keyboard shortcuts without interfering with form inputs:

```javascript
document.addEventListener('keydown', (e) => {
    // Don't trigger shortcuts when typing in inputs/textareas
    const isTyping = ['INPUT', 'TEXTAREA'].includes(e.target.tagName);
    if (isTyping) return;

    // Check for Cmd/Ctrl key combos
    const isMeta = e.metaKey || e.ctrlKey;

    if (isMeta && e.key === 'z') {
        e.preventDefault();
        e.shiftKey ? redo() : undo();
    } else if (isMeta && e.key === 'c') {
        e.preventDefault();
        copySelected();
    } else if (isMeta && e.key === 'v') {
        e.preventDefault();
        paste();
    } else if (e.key === 'Delete' || e.key === 'Backspace') {
        e.preventDefault();
        deleteSelected();
    } else if (e.key === 'Escape') {
        e.preventDefault();
        deselectAll();
    }
});

// Add helpful labels in UI
// <button title="Ctrl+Z or Cmd+Z">Undo</button>
```

**Best Practices:**
- ✓ Prevent default browser behavior with `e.preventDefault()`
- ✓ Skip shortcuts when user is typing (in inputs/textareas)
- ✓ Show keyboard shortcuts in button titles/labels
- ✓ Use standard shortcuts: Ctrl+Z (undo), Ctrl+C (copy), etc.
- ✗ Don't override browser defaults like Ctrl+S (save), Ctrl+F (find)

## Modal/Dialog Pattern

For confirmations, prompts, or complex interactions:

```javascript
function showModal(title, message, options = {}) {
    const modal = document.createElement('article');
    modal.id = 'modal-' + Math.random().toString(36).slice(2);
    modal.style.position = 'fixed';
    modal.style.top = '50%';
    modal.style.left = '50%';
    modal.style.transform = 'translate(-50%, -50%)';
    modal.style.zIndex = '1000';
    modal.style.maxWidth = '500px';
    modal.style.padding = '2rem';

    let html = `<h2>${title}</h2><p>${message}</p>`;

    if (options.type === 'confirm') {
        html += `
            <div style="display: flex; gap: 1rem; margin-top: 1rem;">
                <button id="modal-cancel">Cancel</button>
                <button id="modal-confirm" style="background: #6b8dd6;">Confirm</button>
            </div>
        `;
    } else if (options.type === 'input') {
        html += `
            <input type="text" id="modal-input" placeholder="${options.placeholder || ''}" />
            <div style="display: flex; gap: 1rem; margin-top: 1rem;">
                <button id="modal-cancel">Cancel</button>
                <button id="modal-confirm" style="background: #6b8dd6;">OK</button>
            </div>
        `;
    }

    modal.innerHTML = html;
    document.body.appendChild(modal);

    return new Promise((resolve) => {
        document.getElementById('modal-cancel')?.addEventListener('click', () => {
            modal.remove();
            resolve(null);
        });

        document.getElementById('modal-confirm')?.addEventListener('click', () => {
            const value = options.type === 'input'
                ? document.getElementById('modal-input').value
                : true;
            modal.remove();
            resolve(value);
        });

        // Close on Escape key
        const handleEscape = (e) => {
            if (e.key === 'Escape') {
                modal.remove();
                document.removeEventListener('keydown', handleEscape);
                resolve(null);
            }
        };
        document.addEventListener('keydown', handleEscape);
    });
}

// Usage:
const result = await showModal('Delete?', 'Are you sure you want to delete this item?', { type: 'confirm' });
if (result) deleteItem();
```

**Best Practices:**
- ✓ Use `position: fixed` to overlay modals on top of content
- ✓ Add high `z-index` to ensure visibility
- ✓ Support Escape key to close (standard UX pattern)
- ✓ Return Promise for async workflows
- ✓ Prevent background scrolling (optional: `document.body.style.overflow = 'hidden'`)
