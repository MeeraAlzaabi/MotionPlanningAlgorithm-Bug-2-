function is_on_line = is_point_on_line_equation(pos, start, goal)
    
    x=pos(1); y=pos(2);
    x1=start(1); y1=start(2);
    x2=goal(1); y2=goal(2);

    if x1 == x2
        % Vertical line
        is_on_line = abs(x - x1) < 1;
    else
        % Line equation
        m = (y2 - y1) / (x2 - x1);
        c = y1 - m * x1;
        is_on_line = abs(y - (m * x + c)) < 1;
    end
end