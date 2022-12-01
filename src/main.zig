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

    // elf => calorie count
    // var acc = std.AutoHashMap(usize, usize).init(std.testing.allocator);

    var acc = std.ArrayList(usize).init(std.testing.allocator);
    defer acc.deinit();

    var i:usize = 0;
    var j:usize = 0;
    var tmp_buffer = try std.testing.allocator.alloc(u8, 255);
    defer std.testing.allocator.free(tmp_buffer);

    var tmp_acc = std.ArrayList(usize).init(std.testing.allocator);
    defer tmp_acc.deinit(); 

    var elf_id: usize = 1;

    while(i < day1_part1_test_input.len):(i += 1) {
        if(day1_part1_test_input[i] == '\n') {
            if(j == 0) {
                var done = false;
                var count:usize = 0;
                while(done == false) {
                    var value = tmp_acc.popOrNull();
                    if(value) |v| {
                        count+=v;
                    } else {done = true;}
                }
                // try acc.put(elf_id, count);
                try acc.append(count);
                elf_id+=1;
                // tmp_acc.clearAndFree();
                continue;
            }

            tmp_buffer[j] = 0;
            // std.debug.print("{any}", .{tmp_buffer[0..j]});
            const v = std.fmt.parseInt(usize, tmp_buffer[0..j], 10) catch {
                break;
            };
            try tmp_acc.append(v);
            // std.debug.print("{d}\n", .{v});
            j = 0;
            continue;
        }
        tmp_buffer[j] = day1_part1_test_input[i];
        j+=1;
    }
    var s = acc.toOwnedSlice();
    defer(acc.allocator.free(s));
    std.sort.sort(usize, s, {}, cmpByValue);
    var highscore: usize = s[s.len-1];
    var highscore2: usize = s[s.len-2];
    var highscore3: usize = s[s.len-3];
    // std.sort.sort(Data, x, {}, cmpByData);

    // var iter = acc.iterator();
    // while (iter.next()) |entry| {
    //     if(entry.value_ptr.* > highscore) highscore = entry.value_ptr.*;
    // }
    std.debug.print("highest calorie count: {d}+{d}+{d}={d}\n", .{highscore, highscore2, highscore3, highscore+highscore2+highscore3});
    // try std.testing.expectEqual(@as(usize, 24000), highscore);
    try std.testing.expectEqual(@as(usize, 69177), highscore);

    // try std.testing.expectEqual(@as(usize, 45000), highscore+highscore2+highscore3);
    try std.testing.expectEqual(@as(usize, 207456), highscore+highscore2+highscore3);
}
