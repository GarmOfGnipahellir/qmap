package test_lexer

import "core:bytes"
import "core:strings"
import "core:testing"
import "core:unicode"
import "core:unicode/utf8"

import "../qmap"

expect_equal :: proc(t: ^testing.T, actual: $T, expected: T, loc := #caller_location) -> bool {
	return testing.expectf(
		t,
		expected == actual,
		"Actual: %v, Expected: %v",
		actual,
		expected,
		loc = loc,
	)
}

@(test)
test_next_char :: proc(t: ^testing.T) {
	data := "42\nFoo"

	lexer := qmap.new_lexer(data)

	{
		char := qmap.next_char(&lexer)
		expect_equal(t, lexer.char, char)
		expect_equal(t, lexer.char, '4')
		expect_equal(t, lexer.index, 1)
	}

	{
		char := qmap.next_char(&lexer)
		expect_equal(t, lexer.char, char)
		expect_equal(t, lexer.char, '2')
		expect_equal(t, lexer.index, 2)
	}

	{
		char := qmap.next_char(&lexer)
		expect_equal(t, lexer.char, char)
		expect_equal(t, lexer.char, '\n')
		expect_equal(t, lexer.index, 3)
	}

	{
		char := qmap.next_char(&lexer)
		expect_equal(t, lexer.char, char)
		expect_equal(t, lexer.char, 'F')
		expect_equal(t, lexer.index, 4)
	}

	{
		char := qmap.next_char(&lexer)
		expect_equal(t, lexer.char, char)
		expect_equal(t, lexer.char, 'o')
		expect_equal(t, lexer.index, 5)
	}

	{
		char := qmap.next_char(&lexer)
		expect_equal(t, lexer.char, char)
		expect_equal(t, lexer.char, 'o')
		expect_equal(t, lexer.index, 6)
	}

	{
		char := qmap.next_char(&lexer)
		expect_equal(t, lexer.char, char)
		expect_equal(t, lexer.char, qmap.EOB)
		expect_equal(t, lexer.index, 7)
	}
}

@(test)
test_next_token_comment :: proc(t: ^testing.T) {
	data := "// Foo bar"

	lexer := qmap.new_lexer(data)

	token, ok := qmap.next_token_comment(&lexer)
	expect_equal(t, token.type, qmap.TokenType.Comment)
	expect_equal(t, token.value, "// Foo bar")
}

@(test)
test_read :: proc(t: ^testing.T) {
	data := "Hello"

	lexer := qmap.Lexer {
		data = data,
	}

	{
		result, ok := qmap.read(&lexer)
		testing.expect(t, result == "H")
		testing.expect(t, ok == true)
		testing.expect(t, lexer.index == 1)
	}

	{
		result, ok := qmap.read(&lexer, 3)
		testing.expect(t, result == "ell")
		testing.expect(t, ok == true)
		testing.expect(t, lexer.index == 4)
	}

	{
		result, ok := qmap.read(&lexer, 3)
		testing.expect(t, result == "")
		testing.expect(t, ok == false)
		testing.expect(t, lexer.index == 4)
	}

	{
		result, ok := qmap.read(&lexer, 1)
		testing.expect(t, result == "o")
		testing.expect(t, ok == true)
		testing.expect(t, lexer.index == 5)
	}
}
