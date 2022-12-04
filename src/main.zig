const std = @import("std");

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try bw.flush(); // don't forget to flush!
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

fn cmpByValue(context: void, a: usize, b: usize) bool {
    return std.sort.asc(usize)(context, a, b);
}

const day1_part1_test_input = @embedFile("day1_part_1.txt");
// const day1_part1_test_input = @embedFile("day1_part_1_sample.txt");

test "aoc day 1 part 1" {
    std.debug.print("\n", .{});

    var counts = std.ArrayList(usize).init(std.testing.allocator);
    defer counts.deinit();

    var i:usize = 0;
    var j:usize = 0;

    var integer_parse_buffer = try std.testing.allocator.alloc(u8, 255);
    defer std.testing.allocator.free(integer_parse_buffer);

    var callorie_count_accumulator = std.ArrayList(usize).init(std.testing.allocator);
    defer callorie_count_accumulator.deinit(); 

    var elf_id: usize = 1;

    while(i < day1_part1_test_input.len):(i += 1) {
        if(day1_part1_test_input[i] == '\n') {
            if(j == 0) {
                var done = false;
                var count:usize = 0;
                while(done == false) {
                    var value = callorie_count_accumulator.popOrNull();
                    if(value) |v| {
                        count+=v;
                    } else {done = true;}
                }
                try counts.append(count);
                elf_id+=1;
                continue;
            }

            integer_parse_buffer[j] = 0;
            const v = std.fmt.parseInt(usize, integer_parse_buffer[0..j], 10) catch {
                break;
            };
            try callorie_count_accumulator.append(v);
            j = 0;
            continue;
        }
        integer_parse_buffer[j] = day1_part1_test_input[i];
        j+=1;
    }
    var s = counts.toOwnedSlice();
    defer(counts.allocator.free(s));
    std.sort.sort(usize, s, {}, cmpByValue);
    var highscore: usize = s[s.len-1];
    var highscore2: usize = s[s.len-2];
    var highscore3: usize = s[s.len-3];

    std.debug.print("highest calorie count: {d}+{d}+{d}={d}\n", .{highscore, highscore2, highscore3, highscore+highscore2+highscore3});
    // try std.testing.expectEqual(@as(usize, 24000), highscore);
    try std.testing.expectEqual(@as(usize, 69177), highscore);

    // try std.testing.expectEqual(@as(usize, 45000), highscore+highscore2+highscore3);
    try std.testing.expectEqual(@as(usize, 207456), highscore+highscore2+highscore3);
}

// const day2_part1_test_input = @embedFile("day2_part_1_sample.txt");
const day2_part1_test_input = @embedFile("day2_part_1.txt");

const P1 = enum(usize) {
    rock = 0x41,
    paper = 0x42,
    scissors = 0x43
};

const P2 = enum(usize) {
    // rock = 0x58,
    // paper = 0x59,
    // scissors = 0x5A
    loss = 0x58,
    draw = 0x59,
    win = 0x5A,
};

const Game = struct {
    p1: P1,
    win: P1,
    loss: P1,
    draw: P1,
    p2: P2,

    pub fn init(p1: P1, p2: P2) Game {
        var win: P1 = undefined;
        var loss: P1 = undefined;
        if(p1 == .rock) {
            win = .paper;
            loss = .scissors;
        } else if(p1 == .paper) {
            win = .scissors;
            loss = .rock;
        } else {
            win = .rock;
            loss = .paper;
        }
        return .{
            .p1 = p1,
            .p2 = p2,
            .win = win,
            .loss = loss,
            .draw = p1
        };
    }

    pub fn getscore(self: *const Game, in: P1) usize {
        _ = self;
        return switch(in) {
            .rock => 1,
            .paper => 2,
            .scissors => 3
        };
    }

    pub fn evaultate(self: *const Game) usize {
        var score:usize = 0;

        // part 1:
        // if(self.p2 == .rock) {score = 1;}
        // else if(self.p2 == .paper) {score = 2;}
        // else if(self.p2 == .scissors) {score = 3;}

        // // p2 win
        // if(self.p2 == .rock and self.p1 == .scissors) { score += 6; }
        // else if(self.p2 == .paper and self.p1 == .rock) { score += 6; }
        // else if(self.p2 == .scissors and self.p1 == .paper) { score += 6; }

        // // p2 loss
        // else if(self.p1 == .rock and self.p2 == .scissors) { score += 0; }
        // else if(self.p1 == .paper and self.p2 == .rock) { score += 0; }
        // else if(self.p1 == .scissors and self.p2 == .paper) { score += 0; }

        // draw
        // else score += 3; 

        switch(self.p2) {
            .loss => {
                score+=0;
                score += self.getscore(self.loss);
            },
            .draw => {
                score+=3;
                score += self.getscore(self.p1);
            },
            .win => {
                score+=6;
                score += self.getscore(self.win);
            }
        }

        // std.debug.print("{s} : {s} ({s}, {s}, {s}) = {d}\n", .{@tagName(self.p2), @tagName(self.p1), @tagName(self.win), @tagName(self.loss), @tagName(self.draw), score});
        return score;
    }
};

test "aoc day 2 part 1" {
    std.debug.print("\n", .{});
    var game: std.ArrayList(Game) = std.ArrayList(Game).init(std.testing.allocator);
    defer game.deinit();

    var tmp_buffer: []u8 = try std.testing.allocator.alloc(u8, 2);
    defer std.testing.allocator.free(tmp_buffer);

    var i: usize = 0;
    var j: usize = 0;

    // fill up the game states
    while(i < day2_part1_test_input.len):(i += 1) {
        if(day2_part1_test_input[i] == ' ') {continue;}
        if(day2_part1_test_input[i] == '\n') {
            try game.append(Game.init(
                    @intToEnum(P1, tmp_buffer[0]), 
                    @intToEnum(P2, tmp_buffer[1])
                )
            );
            j = 0;
            continue;
        }
        tmp_buffer[j] = day2_part1_test_input[i];
        j+=1;
    }

    var scores:usize = 0;
    var s = game.toOwnedSlice();
    defer game.allocator.free(s);
    for(s) | round | {
        var round_score:usize = round.evaultate();
        scores+=round_score;
    }
    std.debug.print("score={d} numrounds={d}\n", .{scores, s.len});
}

const day3_part1_test_input = @embedFile("day3_part_1.txt");
// const day3_part1_test_input = @embedFile("day3_part_1_sample.txt");

pub fn priority(common: usize) usize {
    std.debug.assert(common > 65);
    if(common > 96) return common - 96;
    return (common - 64) + 26;
}

pub const find_common_error = error {
    none
};

pub fn find_common(sacks: [3][]const u8) find_common_error!usize {
    for(sacks[0]) |first_char| {
        for(sacks[1]) |second_char| {
            if(second_char == first_char) {
                for(sacks[2]) |third_char| {
                    if(third_char == second_char) return third_char;
                }
            }
        }
    }
    return find_common_error.none;
}

test "aoc day 3 part 1" {
    std.debug.print("\n", .{});

    var i: usize = 0;
    var line_length: usize = 0;
    var line_count: usize = 0;

    var sacks = std.ArrayList([]const u8).init(std.testing.allocator);
    defer sacks.deinit();

    var groups = std.ArrayList([3][]const u8).init(std.testing.allocator);
    defer groups.deinit();

    while(i < day3_part1_test_input.len):(i += 1) {
        if(day3_part1_test_input[i] == '\n') {
            var start = i-line_length;
            var end = start + line_length;

            var all = day3_part1_test_input[start..end];
            try sacks.append(all);
            line_count+=1;
            if((line_count % 3) == 0) {
                try groups.append(.{sacks.items[line_count-3], sacks.items[line_count-2], sacks.items[line_count-1]});
            }
            line_length = 0;
            continue;
        }

        line_length+=1;
    }
    var s = groups.toOwnedSlice();
    defer std.testing.allocator.free(s);
    var count: usize = 0;
    for(s) |group| {
        const common = try find_common(group);
        count += priority(common);
    }

    std.debug.print("common count = {d}\n", .{count});
}

const day4_part1_test_input = @embedFile("day4_part_1.txt");
// const day4_part1_test_input = @embedFile("day4_part_1_sample.txt");

pub const SectionRange = struct {
    start_id: usize,
    end_id: usize,
    pub fn init(start: usize, end: usize) SectionRange {
        return .{.start_id = start, .end_id = end};
    }
    pub fn overlap(a: *const SectionRange, b: *const SectionRange) bool {
        if(a.start_id <= b.start_id and a.end_id >= b.end_id) return true;
        if(b.start_id <= a.start_id and b.end_id >= a.end_id) return true;
        return false;
    }
    pub fn count_overlap(a: *const SectionRange, b: *const SectionRange) usize {
        var i:usize = a.start_id;
        var count:usize = 0;
        while(i <= a.end_id):(i+=1) {
            if(i >= b.start_id and i <= b.end_id) {
                std.debug.print("{d} >= {d} and {d} <= {d}", .{i, b.start_id, i, b.end_id});
                count += 1;
            }
        }
        std.debug.print("counting overlap for {d}-{d},{d}-{d}={d}\n", .{a.start_id, a.end_id, b.start_id, b.end_id, count});
        return count;
    }
};
test "aoc day4 test" {
    std.debug.print("\n", .{});

    var count:usize = undefined;
    count = SectionRange.count_overlap(&.{.start_id = 5, .end_id = 7}, &.{.start_id = 7, .end_id = 9});
    try std.testing.expectEqual(@as(usize, 1), count);

    count = SectionRange.count_overlap(&.{.start_id = 2, .end_id = 8}, &.{.start_id = 3, .end_id = 7});
    try std.testing.expectEqual(@as(usize, 5), count);

    count = SectionRange.count_overlap(&.{.start_id = 6, .end_id = 6}, &.{.start_id = 4, .end_id = 6});
    try std.testing.expectEqual(@as(usize, 1), count);

    count = SectionRange.count_overlap(&.{.start_id = 2, .end_id = 6}, &.{.start_id = 4, .end_id = 8});
    try std.testing.expectEqual(@as(usize, 3), count);
}

test "aoc day 4 part 1" {
    std.debug.print("\n", .{});

    var i: usize = 0;
    var part: enum {first, second} = .first;

    var current_id_start: usize = 0;
    
    var first_id_start: usize = undefined;
    var first_id_end: usize = undefined;

    var second_id_start: usize = undefined;
    var second_id_end: usize = undefined;

    var third_id_start: usize = undefined;
    var third_id_end: usize = undefined;

    var fourth_id_start: usize = undefined;
    var fourth_id_end: usize = undefined;

    var sections = std.ArrayList([2]SectionRange).init(std.testing.allocator);
    defer sections.deinit();

    while(i < day4_part1_test_input.len):(i += 1) {
        if(day4_part1_test_input[i] == '-') {
            if(part == .first) {
                first_id_start = current_id_start;
                first_id_end = i;
            } else if(part == .second) {
                third_id_start = current_id_start;
                third_id_end = i;
            } else unreachable;
            current_id_start = i+1;
            continue;
        }
        if(day4_part1_test_input[i] == ',') {
            second_id_start = current_id_start;
            second_id_end = i;
            current_id_start = i+1;
            part = .second;
            continue;
        }
        if(day4_part1_test_input[i] == '\n') {
            fourth_id_start = current_id_start;
            fourth_id_end = i;
            part = .first;
            current_id_start = i + 1;
            const start_one = try std.fmt.parseInt(usize, day4_part1_test_input[first_id_start..first_id_end], 10);
            const end_one = try std.fmt.parseInt(usize, day4_part1_test_input[second_id_start..second_id_end], 10);
            const start_two = try std.fmt.parseInt(usize, day4_part1_test_input[third_id_start..third_id_end], 10);
            const end_two = try std.fmt.parseInt(usize, day4_part1_test_input[fourth_id_start..fourth_id_end], 10);
            try sections.append(.{
                SectionRange.init(start_one, end_one),
                SectionRange.init(start_two, end_two)
            });
            continue;
        }
    }

    var s = sections.toOwnedSlice();
    defer std.testing.allocator.free(s);
    var overlap_count: usize = 0;
    var overlap_pair_count: usize = 0;
    for(s) |ranges| {
        if(SectionRange.overlap(&ranges[0], &ranges[1])) overlap_count+=1;
        if(SectionRange.count_overlap(&ranges[0], &ranges[1]) > 0) overlap_pair_count +=1;
    }
    std.debug.print("overlap_count={d} overlap_pair_count={d}\n", .{overlap_count, overlap_pair_count});
}
