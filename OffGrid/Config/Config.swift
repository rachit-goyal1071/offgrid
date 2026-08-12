import Supabase
import Foundation

final class Config {
    
    static let shared = Config()
    private init() {}
    
    let client = SupabaseClient(
        supabaseURL: URL(string: SUPABASE_URL)!, supabaseKey: SUPABASE_KEY
    )
}
