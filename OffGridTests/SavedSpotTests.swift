import XCTest
@testable import OffGrid

@MainActor
class SavedSpotTests: XCTestCase {
    
    var savedIds: Set<UUID> = [
        UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
        UUID(uuidString: "00000000-0000-0000-0000-000000000003")!,
        UUID(uuidString: "00000000-0000-0000-0000-000000000005")!
    ]
    
    
    func testLoad() async {
        let vm: SavedSpotViewModel = SavedSpotViewModel(
            spotRepository: FakeSpotRepository(),
            savedRepository: FakeSavedSpotRepository( set: savedIds)
        )
        
        await vm.load()
        XCTAssertEqual(vm.state, .loaded([
            Spot.samples[0], Spot.samples[2],
        ]))
    }
    
    func testPartial_unsave() async {
        let vm: SavedSpotViewModel = SavedSpotViewModel(
            spotRepository: FakeSpotRepository(),
            savedRepository: FakeSavedSpotRepository(set: savedIds)
        )
        
        await vm.unsave(id: Spot.samples[0].id)
        XCTAssertEqual(vm.state, .loaded([
            Spot.samples[2],
        ]))
    }
    
    func testLoad_empty() async {
        let vm: SavedSpotViewModel = SavedSpotViewModel(
            spotRepository: FakeSpotRepository(),
            savedRepository: FakeSavedSpotRepository(set: savedIds)
        )
        
        await vm.unsave(id: Spot.samples[0].id)
        await vm.unsave(id: Spot.samples[2].id)
        XCTAssertEqual(vm.state, .empty)
    }
    
    func testLoad_error() async {
        let vm: SavedSpotViewModel = SavedSpotViewModel(
            spotRepository: FakeSpotRepository(shouldThrow: true),
            savedRepository: FakeSavedSpotRepository(set: [])
        )
        await vm.load()
        XCTAssertEqual(vm.state, .failed)
    }
    
    
}
