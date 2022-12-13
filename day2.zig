const std = @import("std");

const print = std.debug.print;
const parseInt = std.fmt.parseInt;

const test_input = @embedFile("day2_test.txt");
const real_input = @embedFile("day2.txt");

const Move = enum(u4) {
    rock = 1,
    paper = 2,
    scissors = 3,

    pub fn beats(move: Move) Move {
        return switch (move) {
            .rock => .scissors,
            .paper => .rock,
            .scissors => .paper,
        };
    }

    pub fn beaten_by(move: Move) Move {
        return switch (move) {
            .rock => .paper,
            .paper => .scissors,
            .scissors => .rock,
        };
    }
};

fn moveFromMoveChar(char: u8) !Move {
    return switch (char) {
        'A', 'X' => .rock,
        'B', 'Y' => .paper,
        'C', 'Z' => .scissors,
        else => return error.InvalidChar,
    };
}

fn moveFromResultChar(opponent_move: Move, char: u8) !Move {
    return switch (char) {
        'X' => opponent_move.beats(),
        'Y' => opponent_move,
        'Z' => opponent_move.beaten_by(),
        else => return error.InvalidChar,
    };
}

fn roundScore(player_move: Move, opponent_move: Move) u32 {
    if (player_move.beaten_by() == opponent_move) {
        return 0 + @enumToInt(player_move);
    } else if (player_move == opponent_move) {
        return 3 + @enumToInt(player_move);
    } else {
        return 6 + @enumToInt(player_move);
    }
}

pub fn main() !void {
    const input = real_input;

    var total_part1_score: u64 = 0;
    var total_part2_score: u64 = 0;
    var lines = std.mem.tokenize(u8, input, "\r\n");
    while (lines.next()) |line| {
        const opponent_move = try moveFromMoveChar(line[0]);
        const part1_player_move = try moveFromMoveChar(line[2]);
        const part2_player_move = try moveFromResultChar(opponent_move, line[2]);

        total_part1_score += roundScore(part1_player_move, opponent_move);
        total_part2_score += roundScore(part2_player_move, opponent_move);
    }

    print("part 1: {}\n", .{total_part1_score});
    print("part 2: {}\n", .{total_part2_score});
}
