extension ValueReducers {
    /// A `ValueReducer` that perform database fetches.
    public struct Fetch<API: SQLiteAPI, Value: Sendable>: ValueReducer {
        public struct _Fetcher: _ValueReducerFetcher {
            let _fetch: @Sendable (DatabaseBase<API>) throws -> Value
            
            public func fetch(_ db: DatabaseBase<API>) throws -> Value {
                assert(db.isInsideTransaction, "Fetching in a non-isolated way is illegal")
                return try _fetch(db)
            }
        }
        
        private let _fetch: @Sendable (DatabaseBase<API>) throws -> Value
        
        /// Creates a reducer which passes raw fetched values through.
        init(fetch: @escaping @Sendable (DatabaseBase<API>) throws -> Value) {
            self._fetch = fetch
        }
        
        public func _makeFetcher() -> _Fetcher {
            _Fetcher(_fetch: _fetch)
        }
        
        public func _value(_ fetched: Value) -> Value? {
            fetched
        }
    }
}
