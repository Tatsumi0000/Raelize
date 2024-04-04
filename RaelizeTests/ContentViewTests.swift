import Testing

@testable import Raelize
@testable import RaelizeInputMethodKit

struct ContentViewTests {

    private let example = true

    @Test func sample() {
        #expect(self.example == true)
    }
}
