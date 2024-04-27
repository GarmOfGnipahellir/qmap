package qmap

/*
import "core:unicode"
import "core:unicode/utf8"

TokenType :: enum {
	EOF,
	Comment,
}

Pos :: struct {
	line:   int,
	col:    int,
	offset: int,
}

Token :: struct {
	type:  TokenType,
	value: []byte,
	pos:   Pos,
}

Lexer :: struct {
	data:        []byte,
	rn:          rune, // current rune
	rune_offset: int,
	byte_offset: int,
	line:        int, // current line number
	bol:         int, // rune offset to beginning of line
}

lexer_init :: proc(using l: ^Lexer, d: []byte) {
	l.data = d
	lexer_read(l)
	l.rune_offset = 0
	l.line = 1
}

make_lexer :: proc(data: []byte) -> Lexer {
	l: Lexer
	lexer_init(&l, data)
	return l
}

lexer_next :: proc(using l: ^Lexer) -> Token {
	lexer_skip_space(l)

	t: Token
	t.pos = lexer_pos(l)

	switch {
	case rn == 0:
		t.type = .EOF
	case rn == '/':
		next_rn, _ := lexer_peek(l)
		if next_rn == '/' {
			lexer_read(l)
			lexer_skip_space(l)
			t.type = .Comment
			s, _ := lexer_read_until(l, '\n')
			t.value = data[s:byte_offset - 1]
		}
	}

	return t
}

lexer_peek :: proc(using l: ^Lexer) -> (rune, int) {
	read_rn, size := utf8.decode_rune(data[byte_offset:])
	if size == 0 {
		return 0, 0
	}
	return read_rn, size
}

lexer_read :: proc(using l: ^Lexer) {
	read_rn, size := lexer_peek(l)

	byte_offset += size
	rune_offset += 1
	rn = read_rn

	lexer_check_newline(l)
}

lexer_check_newline :: proc(using l: ^Lexer) {
	if rn != '\n' {
		return
	}

	line += 1
	bol = rune_offset + 1
}

lexer_skip_space :: proc(using l: ^Lexer) {
	if unicode.is_space(rn) {
		lexer_read(l)
	}
}

lexer_pos :: proc(using l: ^Lexer) -> Pos {
	return Pos{line = line, col = rune_offset - bol, offset = rune_offset}
}

lexer_read_until :: proc(using l: ^Lexer, check: ..rune) -> (int, bool) {
	start_byte_offset := byte_offset - 1
	for rn != 0 {
		lexer_read(l)

		if rn == '\r' || rn == '\n' {
			return start_byte_offset, false
		}

		for c in check {
			if c == rn {
				return start_byte_offset, true
			}
		}
	}
	return start_byte_offset, false
}
*/