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

                                Text(note.content)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary) // Light gray for subtle text
                                    .lineLimit(1)
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
                        .foregroundColor(.blue) // Blue icon for better visibility
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
