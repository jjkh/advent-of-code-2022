const std = @import("std");

const print = std.debug.print;
const parseInt = std.fmt.parseInt;

const test_input = @embedFile("day1_test.txt");
const real_input = @embedFile("day1.txt");

fn greaterThan(_: void, a: u64, b: u64) std.math.Order {
    return std.math.order(b, a);
}
const ElfQueue = std.PriorityQueue(u64, void, greaterThan);

pub fn main() !void {
    const input = real_input;

    var elf_queue = ElfQueue.init(std.heap.page_allocator, {});
    defer elf_queue.deinit();

    var current_elf: u64 = 0;
    var lines = std.mem.split(u8, input, "\r\n");
    while (lines.next()) |line| {
        if (line.len == 0) {
            try elf_queue.add(current_elf);
            current_elf = 0;
            continue;
        }
        
        current_elf += try parseInt(u64, line, 10);
    }

    print("part 1: {}\n", .{ elf_queue.peek() });
    print("part 2: {}\n", .{ elf_queue.remove() + elf_queue.remove() + elf_queue.remove() });
}