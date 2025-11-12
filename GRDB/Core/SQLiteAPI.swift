public protocol SQLiteAPI {
    static var SQLITE_NULL: CInt { get }
    static var SQLITE_OK: CInt { get }
    
    static func sqlite3_bind_double(_: OpaquePointer?, _: CInt, _: CDouble) -> CInt
    static func sqlite3_bind_int64(_: OpaquePointer?, _: CInt, _: Int64) -> CInt
    static func sqlite3_bind_null(_: OpaquePointer?, _: CInt) -> CInt
    static func sqlite3_bind_text(_: OpaquePointer?, _: CInt, _: UnsafePointer<CChar>?, _: CInt, _: (@convention(c) (UnsafeMutableRawPointer?) -> Void)?) -> CInt
    
    static func sqlite3_column_double(_: OpaquePointer?, _ iCol: CInt) -> Double
    static func sqlite3_column_int64(_: OpaquePointer?, _ iCol: CInt) -> Int64
    static func sqlite3_column_text(_: OpaquePointer?, _ iCol: CInt) -> UnsafePointer<CChar>?
    static func sqlite3_column_type(_: OpaquePointer?, _ iCol: CInt) -> CInt
    
    @discardableResult static func sqlite3_commit_hook(_: OpaquePointer?, _: (@convention(c) (UnsafeMutableRawPointer?) -> Int32)?, _: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer?
    @discardableResult static func sqlite3_rollback_hook(_: OpaquePointer?, _: (@convention(c) (UnsafeMutableRawPointer?) -> Void)?, _: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer?
    @discardableResult static func sqlite3_update_hook(_: OpaquePointer?, _: (@convention(c) (UnsafeMutableRawPointer?, Int32, UnsafePointer<CChar>?, UnsafePointer<CChar>?, Int64) -> Void)?, _: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer?
}

public typealias sqlite3_destructor_type = @convention(c) (UnsafeMutableRawPointer?) -> Void
