import SwiftUI

struct AddEditNoteView: View {
    @ObservedObject var viewModel: NotesViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String
    @State private var content: String
    @State private var showError: Bool = false
    
    
    var note: Note?
    
    init(viewModel: NotesViewModel, note: Note? = nil) {
        self.viewModel = viewModel
        self.note = note
        _title = State(initialValue: note?.title ?? "")
        _content = State(initialValue: note?.content ?? "")
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextEditor(text: $content)
                    .frame(height: 200)
            }
            .navigationTitle(note == nil ? "Add Note" : "Edit Note")
            .toolbar {
                Button("Save") {
                    if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        showError = true // Show error if title is empty
                    }
                    else{
                        if let note = note {
                            viewModel.updateNote(id: note.id, title: title, content: content)
                        } else {
                            viewModel.addNote(title: title, content: content)
                        }
                        dismiss()
                    }
                }
            }
            .foregroundColor(.primary)
            if showError {
                Text("Title cannot be empty")
                    .foregroundColor(.red)
                    .padding(.top, 5)
            }
        }
    }
}
