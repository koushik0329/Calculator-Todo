import XCTest
@testable import Test_Nov18

class CalculatorTests: XCTestCase {
    
    var calculator: Calculator!
    
    override func setUp() {
        super.setUp()
        calculator = Calculator()
        calculator.loadViewIfNeeded()
    }
    
    override func tearDown() {
        calculator = nil
        super.tearDown()
    }
    
    // MARK: - Addition Tests
    
    func testAdditionPositiveNumbers() {
        // Test: 5 + 3 = 8
        calculator.inputOperation("5")
        calculator.inputOperation("+")
        calculator.inputOperation("3")
        calculator.inputOperation("=")

        XCTAssertEqual(calculator.resultField.text, "8")
    }
    
    func testAdditionDecimals() {
        // Test: 2.5 + 3.5 = 6
        calculator.inputOperation("2")
        calculator.inputOperation(".")
        calculator.inputOperation("5")
        calculator.inputOperation("+")
        calculator.inputOperation("3")
        calculator.inputOperation(".")
        calculator.inputOperation("5")
        calculator.inputOperation("=")
        
        XCTAssertEqual(calculator.resultField.text, "6")
    }
    
    // MARK: - Subtraction Tests
    
    func testSubtractionPositiveResult() {
        // Test: 10 - 4 = 6
        calculator.inputOperation("1")
        calculator.inputOperation("0")
        calculator.inputOperation("-")
        calculator.inputOperation("4")
        calculator.inputOperation("=")
        
        XCTAssertEqual(calculator.resultField.text, "6")
    }
  
    func testSubtractionDecimals() {
        // Test: 7.5 - 2.5 = 5
        calculator.inputOperation("7")
        calculator.inputOperation(".")
        calculator.inputOperation("5")
        calculator.inputOperation("-")
        calculator.inputOperation("2")
        calculator.inputOperation(".")
        calculator.inputOperation("5")
        calculator.inputOperation("=")
        
        XCTAssertEqual(calculator.resultField.text, "5")
    }
    
    // MARK: - Multiplication Tests
    
    func testMultiplicationPositiveNumbers() {
        // Test: 6 * 7 = 42
        calculator.inputOperation("6")
        calculator.inputOperation("*")
        calculator.inputOperation("7")
        calculator.inputOperation("=")
        
        XCTAssertEqual(calculator.resultField.text, "42")
    }

    func testMultiplicationDecimals() {
        // Test: 2.5 * 4 = 10
        calculator.inputOperation("2")
        calculator.inputOperation(".")
        calculator.inputOperation("5")
        calculator.inputOperation("*")
        calculator.inputOperation("4")
        calculator.inputOperation("=")
        
        XCTAssertEqual(calculator.resultField.text, "10")
    }
    
    // MARK: - Division Tests
    
    func testDivisionWholeNumber() {
        // Test: 20 / 4 = 5
        calculator.inputOperation("2")
        calculator.inputOperation("0")
        calculator.inputOperation("/")
        calculator.inputOperation("4")
        calculator.inputOperation("=")
        
        XCTAssertEqual(calculator.resultField.text, "5")
    }
    
    func testDivisionDecimals() {
        // Test: 7.5 / 2.5 = 3
        calculator.inputOperation("7")
        calculator.inputOperation(".")
        calculator.inputOperation("5")
        calculator.inputOperation("/")
        calculator.inputOperation("2")
        calculator.inputOperation(".")
        calculator.inputOperation("5")
        calculator.inputOperation("=")
        
        XCTAssertEqual(calculator.resultField.text, "3")
    }
    
    // MARK: - Clear and Back Tests
    
    func testClearButton() {
        // Test: Enter numbers then clear
        calculator.inputOperation("1")
        calculator.inputOperation("2")
        calculator.inputOperation("3")
        calculator.inputOperation("AC")
        
        XCTAssertEqual(calculator.resultField.text, "0")
    }
    
    func testBackButton() {
        // Test: Enter 123, result 12
        calculator.inputOperation("1")
        calculator.inputOperation("2")
        calculator.inputOperation("3")
        calculator.inputOperation("Back")
        
        XCTAssertEqual(calculator.resultField.text, "12")
    }

}

