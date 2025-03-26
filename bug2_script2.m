clc; clear; close all;

% Define the 2D grid map (1 for obstacle, 0 for free space)
map = zeros(100, 100);
map(20:40, 20:25) = 1; % Add a reactangular obstacle
map(30:50, 35:40) = 1; % Add a reactangular obstacle
map(40:60, 50:55) = 1; % Add a reactangular obstacle
map(50:70, 65:70) = 1; % Add a reactangular obstacle
map(60:80, 80:85) = 1; % Add a reactangular obstacle
tol = 0.1;

% Start and Goal positions
start = [2, 2];
goal = [70, 90];

% Plot the environment
figure; hold on; grid on;
axis([0, size(map, 2), 0, size(map, 1)]);
imagesc(map'); colormap(gray);
plot(start(1), start(2), 'go', 'MarkerSize', 10, 'LineWidth', 2); % Start
plot(goal(1), goal(2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);   % Goal
plot([start(1), goal(1)], [start(2), goal(2)], 'g--', 'LineWidth', 2);

% Initialize variables
current_pos = start;
path = current_pos;
reached_goal = false;
max_iterations = 1000; % Limit iterations to avoid infinite loops
iteration = 0;
hit_point = [];
leave_point = [];
boundary_following = false;
previous_pos = start;

% Main Bug2 Algorithm loop
while ~reached_goal && iteration < max_iterations
    iteration = iteration + 1;
    
    if ~boundary_following
        % Calculate direction to the goal (m-line movement)
        goal_vector = goal - current_pos;
        goal_direction = goal_vector / norm(goal_vector);
        next_pos = current_pos + goal_direction;

        % Check for goal reached
        if isequal(round(next_pos), goal)
            reached_goal = true;
            break;
        end

        % Check for collision
        if is_collision(next_pos, map)
            hit_point = current_pos;
            boundary_following = true; % Switch to boundary following
        end
    end

    if boundary_following
        % Follow the boundary
        next_pos = follow_boundary(current_pos, previous_pos, map);
        
        % Check if goal is reached
        if norm(next_pos - goal) < tol
            reached_goal = true;
            break;
        end

        % Check if m-line is encountered
        m_line_condition = is_point_on_line_equation(next_pos, start, goal);
        if m_line_condition
            leave_point = next_pos;
            boundary_following = false; % Exit boundary following
        end
    end

    % Update current position and path
    previous_pos = current_pos;
    current_pos = next_pos;
    path = [path; current_pos];

    % Plot current position
    plot(current_pos(1), current_pos(2), 'b.', 'MarkerSize', 15);
    pause(0.1);
end

% Plot final path
plot(path(:, 1), path(:, 2), 'r-', 'LineWidth', 1.5);
if reached_goal
    title('Bug2 Algorithm: Goal Reached!');
else
    title('Bug2 Algorithm: Goal Not Reached!');
end
