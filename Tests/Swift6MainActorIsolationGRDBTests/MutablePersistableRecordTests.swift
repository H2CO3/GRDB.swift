import GRDB
import Testing

nonisolated private struct Player: Codable {
    var id: Int64?
    var name: String
}

extension Player: nonisolated Identifiable { }
extension Player: MutablePersistableRecord {
    nonisolated mutating func didInsert(_ inserted: InsertionSuccess) {
        id = inserted.rowID
    }
}

@Suite struct MutablePersistableRecordTests {
    @Test func insert_record() async throws {
        let dbQueue = try DatabaseQueue()
        try await dbQueue.write { db in
            try db.create(table: "player") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("name", .text).notNull()
            }
            
            var player = Player(name: "Arthur")
            try player.insert(db)
            #expect(player.id == 1)
            
            let playerCount = try Player.fetchCount(db)
            #expect(playerCount == 1)
        }
    }
}
