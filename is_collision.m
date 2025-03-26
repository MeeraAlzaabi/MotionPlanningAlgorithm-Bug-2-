function collision = is_collision(pos, map)
    pos = round(pos);
    [rows, cols] = size(map);
    if pos(1) < 1 || pos(1) > cols || pos(2) < 1 || pos(2) > rows
        collision = true;
    else
        collision = map(pos(1), pos(2)) == 1;
    end
end