import GRDB

private struct Player: TableRecord { }

private func fetchCount(_ writer: any DatabaseWriter) async throws -> Int {
    // Converting non-sendable function value to
    // '@Sendable (DatabaseBase<some SQLiteAPI>) throws -> Int' may introduce data races.
    try await writer.read(Player.fetchCount)
}
