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
