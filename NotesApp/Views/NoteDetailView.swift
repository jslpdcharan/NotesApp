import SwiftUI

struct NoteDetailView: View {
    var note: Note
    @ObservedObject var viewModel: NotesViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Note Details")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.primary)
            
            Text(note.title)
                .font(.title2)
                .bold()
                .strikethrough(note.isCompleted, color: .gray)
                .foregroundColor(note.isCompleted ? .gray : .primary)

            
            Divider()
                .background(Color.gray.secondary)
            
            Text(note.content)
                .font(.body)
                .foregroundColor(.primary) // Ensures visibility in all modes

            
            Spacer()
            
            Button(action: {
                viewModel.toggleCompletion(id: note.id)
            }) {
                HStack {
                    Image(systemName: note.isCompleted ? "xmark.circle.fill" : "checkmark.circle.fill")
                        .foregroundColor(.white) // Icon color
                    Text(note.isCompleted ? "Mark as Incomplete" : "Mark as Completed")
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(note.isCompleted ? Color.orange : Color.green)
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.5), radius: 5, x: 2, y: 2)
            }
            .padding(.bottom, 10)
        }
        .padding()
        .toolbar {
            NavigationLink(destination: AddEditNoteView(viewModel: viewModel, note: note)) {
                Image(systemName: "square.and.pencil")
                    .padding(4)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.blue, lineWidth: 1)
                    )
            }
        }
    }
}

