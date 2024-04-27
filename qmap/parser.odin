package qmap

/*
import "core:unicode"
import "core:unicode/utf8"

Parser :: struct {
	data:        ^[]u8,
	byte_offset: int,
	rune_offset: int,
	line:        int, // current line number
	bol:         int, // rune offset to beginning of line
}

make_parser :: proc(data: ^[]u8) -> Parser {
	p: Parser
	p.data = data
	return p
}

peek_rn :: proc(using p: ^Parser) -> (rune, int, bool) {
	found_rn, size := utf8.decode_rune(data[byte_offset:])
	if size == 0 {
		return 0, 0, false
	}
	return found_rn, size, true
}

read_rn :: proc(using p: ^Parser) -> (rune, bool) {
	found_rn, size, ok := peek_rn(p)
	byte_offset += size
	return found_rn, ok
}

char :: proc(a: rune) -> proc(_: []u8) -> ([]u8, rune, bool) {
	unimplemented()
}

peek :: proc(p: proc(_: ^[]u8) -> (^[]u8, $T, bool)) -> proc(_: ^[]u8) -> (^[]u8, T, bool) {
	unimplemented()
}
*/
