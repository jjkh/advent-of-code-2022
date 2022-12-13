const std = @import("std");

const print = std.debug.print;
const parseInt = std.fmt.parseInt;

const test_input = @embedFile("day4_test.txt");
const real_input = @embedFile("day4.txt");

const Range = struct {
    start: u32,
    end: u32,

    pub fn contains(a: Range, b: Range) bool {
        return (b.start >= a.start and b.end <= a.end);
    }
    pub fn overlaps(a: Range, b: Range) bool {
        return (a.start <= b.end and a.start >= b.start) or (b.start <= a.end and b.start >= a.start);
    }
};

pub fn main() !void {
    const input = real_input;

    var fully_contained: u32 = 0;
    var overlapping: u32 = 0;

    var lines = std.mem.tokenize(u8, input, "\r\n");
    while (lines.next()) |line| {
        var numbers = std.mem.tokenize(u8, line, ",-");
        const first_range = Range{
            .start = try parseInt(u32, numbers.next().?, 10),
            .end = try parseInt(u32, numbers.next().?, 10),
        };
        const second_range = Range{
            .start = try parseInt(u32, numbers.next().?, 10),
            .end = try parseInt(u32, numbers.next().?, 10),
        };
        if (first_range.contains(second_range) or second_range.contains(first_range))
            fully_contained += 1;

        if (first_range.overlaps(second_range))
            overlapping += 1;
    }

    print("part 1: {}\n", .{fully_contained});
    print("part 2: {}\n", .{overlapping});
}
