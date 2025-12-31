import GRDB
import Testing

nonisolated private class NonSendable {
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
}

@Suite struct NonSendableTests {
    @Test func non_sendable_type_in_synchronous_database_access() throws {
        let dbQueue = try DatabaseQueue()
        let input = NonSendable(value: 0)
        let output = try dbQueue.read { _ in
            input
        }
        #expect(input === output)
    }
    
    @Test func non_sendable_type_sent_to_databaseReader_read() async throws {
        let dbQueue = try DatabaseQueue()
        let nonSendable = NonSendable(value: 0)
        let value = try await dbQueue.read { _ in
            nonSendable.value
        }
        #expect(value == 0)
    }
    
    @Test func non_sendable_type_sent_to_databaseReader_unsafeRead() async throws {
        let dbQueue = try DatabaseQueue()
        let nonSendable = NonSendable(value: 0)
        let value = try await dbQueue.unsafeRead { _ in
            nonSendable.value
        }
        #expect(value == 0)
    }
    
    @Test func non_sendable_type_sent_to_databaseWriter_barrierWriteWithoutTransaction() async throws {
        let dbQueue = try DatabaseQueue()
        let nonSendable = NonSendable(value: 0)
        let value = try await dbQueue.barrierWriteWithoutTransaction { _ in
            nonSendable.value
        }
        #expect(value == 0)
    }
    
    @Test func non_sendable_type_sent_to_databaseWriter_write() async throws {
        let dbQueue = try DatabaseQueue()
        let nonSendable = NonSendable(value: 0)
        let value = try await dbQueue.write { _ in
            nonSendable.value
        }
        #expect(value == 0)
    }
    
    @Test func non_sendable_type_sent_to_databaseWriter_writeWithoutTransaction() async throws {
        let dbQueue = try DatabaseQueue()
        let nonSendable = NonSendable(value: 0)
        let value = try await dbQueue.writeWithoutTransaction { _ in
            nonSendable.value
        }
        #expect(value == 0)
    }
}
