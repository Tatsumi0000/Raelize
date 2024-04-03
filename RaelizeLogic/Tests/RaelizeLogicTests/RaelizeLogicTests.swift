import Testing

@testable import RaelizeLogic

struct RaelizeLogicTests {

    private let someBoolValue = true

    @Test func boolの値がtrueであること() {
        #expect(self.someBoolValue == true)
    }
}
