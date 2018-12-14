%% Setup progress bar.
N = 30;
pb = CommandLineProgressBar(N);

% Optional settings.
pb.message = 'Status';
pb.barLength = 42;

%% Loop
for idx = 1:N
    % Work
    pause(rand());
    
    % Update progressbar.
    pb.increment;
end

