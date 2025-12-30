import GRDB
import Testing

nonisolated private struct Player: Codable {
    var id: Int64?
    var name: String
}

extension Player: nonisolated Identifiable { }
extension Player: nonisolated FetchableRecord, TableRecord {
    nonisolated enum Columns {
        static let name = Column(CodingKeys.name)
    }
}

@Suite struct FetchableRecordTests {
    @Test func fetch_record() async throws {
        let dbQueue = try DatabaseQueue()
        let player = try await dbQueue.write { db in
            try db.create(table: "player") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("name", .text).notNull()
            }
            try db.execute(sql: """
                INSERT INTO player(name) VALUES ('Arthur')
                """)
            
            return try Player.fetchOne(db)
        }
        
        #expect(player?.name == "Arthur")
    }
    
    @Test func fetch_record_by_id() async throws {
        let dbQueue = try DatabaseQueue()
        let player = try await dbQueue.write { db in
            try db.create(table: "player") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("name", .text).notNull()
            }
            try db.execute(sql: """
                INSERT INTO player(id, name) VALUES (42, 'Arthur')
                """)
            
            return try Player.find(db, id: 42)
        }
        
        #expect(player.name == "Arthur")
    }
    
    @Test func fetch_record_by_column() async throws {
        let dbQueue = try DatabaseQueue()
        let player = try await dbQueue.write { db in
            try db.create(table: "player") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("name", .text).notNull()
            }
            try db.execute(sql: """
                INSERT INTO player(id, name) VALUES (42, 'Arthur')
                """)
            
            return try Player
                .filter { $0.name == "Arthur" }
                .fetchOne(db)
        }
        
        #expect(player?.id == 42)
    }
}
