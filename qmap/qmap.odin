package qmap

import "core:fmt"
import "core:log"
import "core:os"
import "core:unicode"
import "core:unicode/utf8"

read_file :: proc(path: string) {
	bytes, ok := os.read_entire_file(path)
	if !ok {
		log.error("Couldn't read file:", path)
		return
	}
	data := string(bytes)
	defer delete(data)

	// l := make_lexer(data)

	// t := lexer_next(&l)
	// fmt.println(t)
	// fmt.println(string(t.value))

	// t = lexer_next(&l)
	// fmt.println(t)
	// fmt.println(string(t.value))
}

EOB :: '\x00'

Pos :: struct {
	index: int,
	line:  int,
	col:   int,
}

TokenType :: enum {
	Invalid,
	Comment,
}

Token :: struct {
	using pos: Pos,
	type:      TokenType,
	value:     string,
}

Lexer :: struct {
	using pos: Pos,
	data:      string,
	char:      rune,
}

new_lexer :: proc(data: string) -> Lexer {
	lexer := Lexer {
		data = data,
	}
	next_char(&lexer)
	lexer.index = 0
	return lexer
}

next_char :: proc(using lexer: ^Lexer) -> rune {
	char = index < len(data) ? rune(data[index]) : EOB

	index += 1
	col += 1

	return char
}

next_token_comment :: proc(using lexer: ^Lexer) -> (Token, bool) {
	token := Token {
		pos = pos,
	}
	ok := false

	if char == '/' && next_char(lexer) == '/' {
		token.type = .Comment

		for {
			next := next_char(lexer)
			if next == '\n' {
				break
			} else if next == EOB {
				index -= 1
				break
			}
		}

		token.value = data[token.index:index]
		ok = true
	}

	return token, ok
}

next_token :: proc(using lexer: ^Lexer) -> Token {
	if token, ok := next_token_comment(lexer); ok {
		return token
	}

	return Token{pos = pos}
}

seek :: proc(using lexer: ^Lexer, n: int = 1) -> bool {
	if n <= 0 do return true

	if len(data) < index + n {
		return false
	}

	index += n
	return true
}

peek :: proc(using lexer: ^Lexer, n: int = 1) -> (result: string, ok: bool) {
	if n <= 0 do return "", true

	if len(data) < index + n {
		return "", false
	}

	result = data[index:index + n]
	return result, true
}

read :: proc(using lexer: ^Lexer, n: int = 1) -> (result: string, ok: bool) {
	if result, ok := peek(lexer, n); ok {
		seek(lexer, n)
		return result, true
	}
	return "", false
}
