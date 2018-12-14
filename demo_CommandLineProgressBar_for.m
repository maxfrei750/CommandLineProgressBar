%% Setup progress bar.
N = 30;
progressBar = CommandLineProgressBar(N);

% Optional settings.
progressBar.message = 'Status';
progressBar.barLength = 42;

%% Loop
for idx = 1:N
    % Work
    pause(rand());
    
    % Update progressbar.
    progressBar.increment;
end

