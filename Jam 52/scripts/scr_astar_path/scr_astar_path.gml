function scr_astar_path(startX, startY, endX, endY) {
    // Ensure arguments are numbers
    if (!is_real(startX) || !is_real(startY) || !is_real(endX) || !is_real(endY)) {
        show_debug_message("Invalid arguments provided to scr_astar_path");
        return ds_list_create(); // Return an empty path if arguments are invalid
    }

    var open_list = ds_priority_create();
    var closed_list = ds_map_create();
    var came_from = ds_map_create();

    var start = string(startX) + "," + string(startY);
    var goal = string(endX) + "," + string(endY);

    show_debug_message("Pathfinding from " + start + " to " + goal);

    ds_priority_add(open_list, start, 0);
    ds_map_add(closed_list, start, false);

    var g_scores = ds_map_create();
    var f_scores = ds_map_create();

    ds_map_add(g_scores, start, 0);
    ds_map_add(f_scores, start, point_distance(startX, startY, endX, endY));

    while (ds_priority_size(open_list) > 0) {
        var current = ds_priority_find_min(open_list);
        var currentX = real(string_copy(current, 1, string_pos(",", current) - 1));
        var currentY = real(string_copy(current, string_pos(",", current) + 1, string_length(current)));

        if (current == goal) {
            var path = ds_list_create();
            while (ds_map_exists(came_from, current)) {
                ds_list_add(path, current);
                current = ds_map_find_value(came_from, current);
            }
            ds_priority_destroy(open_list);
            ds_map_destroy(closed_list);
            ds_map_destroy(came_from);
            ds_map_destroy(g_scores);
            ds_map_destroy(f_scores);
            ds_list_reverse(path);
            show_debug_message("Path found");
            return path;
        }

        ds_priority_delete_min(open_list);
        ds_map_replace(closed_list, current, true);

        for (var dx = -1; dx <= 1; dx++) {
            for (var dy = -1; dy <= 1; dy++) {
                if (dx == 0 && dy == 0) continue;

                var neighborX = currentX + dx;
                var neighborY = currentY + dy;
                var neighbor = string(neighborX) + "," + string(neighborY);
                var tentative_g_score = ds_map_find_value(g_scores, current) + point_distance(currentX, currentY, neighborX, neighborY);

                if (wall_collision(neighborX, neighborY)) {
                    tentative_g_score += point_distance(currentX, currentY, neighborX, neighborY); // Half speed through walls
                }

                if (ds_map_exists(closed_list, neighbor) && ds_map_find_value(closed_list, neighbor) == true) continue;

                if (!ds_priority_find_priority(open_list, neighbor) || tentative_g_score < ds_map_find_value(g_scores, neighbor)) {
                    ds_map_add(came_from, neighbor, current);
                    ds_map_add(g_scores, neighbor, tentative_g_score);
                    ds_map_add(f_scores, neighbor, tentative_g_score + point_distance(neighborX, neighborY, endX, endY));

                    if (!ds_priority_find_priority(open_list, neighbor)) {
                        ds_priority_add(open_list, neighbor, ds_map_find_value(f_scores, neighbor));
                    } else {
                        ds_priority_change_priority(open_list, neighbor, ds_map_find_value(f_scores, neighbor));
                    }
                }
            }
        }
    }

    ds_priority_destroy(open_list);
    ds_map_destroy(closed_list);
    ds_map_destroy(came_from);
    ds_map_destroy(g_scores);
    ds_map_destroy(f_scores);

    show_debug_message("No path found");
    return ds_list_create(); // Return an empty path if no path is found
}
