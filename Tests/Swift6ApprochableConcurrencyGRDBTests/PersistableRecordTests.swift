import GRDB
import Testing

private struct Player {
    var id: Int64
    var name: String
}

extension Player: Codable, Identifiable { }
extension Player: PersistableRecord { }

@Suite struct PersistableRecordTests {
    @Test func insert_record() async throws {
        let dbQueue = try DatabaseQueue()
        try await dbQueue.write { db in
            try db.create(table: "player") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("name", .text).notNull()
            }
            
            try Player(id: 1, name: "Arthur").insert(db)
            let playerCount = try Player.fetchCount(db)
            #expect(playerCount == 1)
        }
    }
}
