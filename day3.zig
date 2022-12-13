const std = @import("std");

const print = std.debug.print;
const parseInt = std.fmt.parseInt;

const test_input = @embedFile("day3_test.txt");
const real_input = @embedFile("day3.txt");

fn itemPriority(item: u8) u8 {
    return switch (item) {
        'a'...'z' => (item - 'a') + 1,
        'A'...'Z' => (item - 'A') + 27,
        else => unreachable,
    };
}

pub fn main() !void {
    const input = real_input;

    var part1_priority_total: u64 = 0;
    var part2_priority_total: u64 = 0;

    var lines = std.mem.tokenize(u8, input, "\r\n");
    var line_count: u32 = 0;
    var rucksacks: [3][]const u8 = undefined;
    while (lines.next()) |line| : (line_count += 1) {
        const first_compartment = line[0 .. line.len / 2];
        const second_compartment = line[line.len / 2 ..];
        // print("{s}:{s}\n", .{ first_compartment, second_compartment });
        for (first_compartment) |item| {
            if (std.mem.indexOfScalar(u8, second_compartment, item) != null) {
                // print("  found dupe '{c}'\n", .{item});
                part1_priority_total += itemPriority(item);
                break;
            }
        }

        rucksacks[line_count % 3] = line;
        if (line_count % 3 == 2) {
            for (rucksacks[0]) |item| {
                if (std.mem.indexOfScalar(u8, rucksacks[1], item) != null and std.mem.indexOfScalar(u8, rucksacks[2], item) != null) {
                    // print("  found badge '{c}'\n", .{item});
                    part2_priority_total += itemPriority(item);
                    break;
                }
            }
        }
    }

    print("part 1: {}\n", .{part1_priority_total});
    print("part 2: {}\n", .{part2_priority_total});
}
