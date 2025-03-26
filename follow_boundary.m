function next_pos = follow_boundary(current_pos, previous_pos, map)
    % Directions to move: [N, E, S, W]
    directions = [0, 1; 1, 0; 0, -1; -1, 0];
    for i = 1:size(directions, 1)
        test_pos = current_pos + directions(i, :);
        if is_boundary(test_pos, map) && ~is_collision(test_pos, map) && ~isequal(test_pos, previous_pos)
            next_pos = test_pos;
            return;
        end
    end
    next_pos = current_pos; % Stay in place if no valid move
end
