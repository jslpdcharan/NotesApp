import Foundation

// Notes JSON Structure 
struct Note: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var content: String
    var isCompleted: Bool = false
}
