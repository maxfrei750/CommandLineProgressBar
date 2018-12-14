%% Setup parallel pool.
setupparallelpool
dataQueue = parallel.pool.DataQueue;

%% Setup progress bar.
N = 30;
progressBar = CommandLineProgressBar(N);

% Optional settings.
progressBar.message = 'Status';
progressBar.barLength = 42;

%% Loop
afterEach(dataQueue, @(varargin) increment(progressBar));
parfor idx = 1:N
    % Work
    pause(rand());
    
    % Update progressbar.
    send(dataQueue,idx);
end
