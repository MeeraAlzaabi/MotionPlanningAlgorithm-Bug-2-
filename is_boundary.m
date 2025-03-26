function is_b = is_boundary(pos, map)
    % Check if the given position is on the boundary of an obstacle
    % A position is on the boundary if it is adjacent to an obstacle.
    directions = [0,  1;   % N
                  1, -1;   % SE
                  1,  0;   % E
                 -1, -1;   % SW
                  0, -1;   % S
                 -1,  1;   % NW
                 -1,  0;   % W
                  1,  1];  % NE
    is_b = false;
    
    % Check adjacent cells
    for i = 1:size(directions, 1)
        adjacent_pos = pos + directions(i, :);
        if is_collision(adjacent_pos, map)
            is_b = true; % At least one neighbor is an obstacle
            return;
        end
    end
end