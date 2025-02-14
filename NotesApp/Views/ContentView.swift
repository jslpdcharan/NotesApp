import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NotesViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note, viewModel: viewModel)) {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(note.title)
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(note.isCompleted ? .gray : .primary)
                                    .strikethrough(note.isCompleted, color: .gray)
                                    .accessibilityLabel("Note Title Screen")
                                    .accessibilityHint("Displays Title of the note")

                                Text(note.content)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                                    .accessibilityLabel("Note Content Screen")
                                    .accessibilityHint("Displays the one line content of the displayed note")
                            }
                            .padding(.vertical, 5)
                            
                            Spacer()
                            
                            if note.isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    
                }
                .onDelete(perform: viewModel.deleteNotes)
            }
            .navigationTitle("Notes")
            .toolbar {
                NavigationLink(destination: AddEditNoteView(viewModel: viewModel)) {
                    Image(systemName: "plus")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
