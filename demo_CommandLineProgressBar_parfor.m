%% Setup parallel pool.
setupparallelpool
dq = parallel.pool.DataQueue;

%% Setup progress bar.
N = 30;
pb = CommandLineProgressBar(N);

% Optional settings.
pb.message = 'Status';
pb.barLength = 42;

%% Loop
afterEach(dq, @(varargin) increment(pb));
parfor idx = 1:N
    % Work
    pause(rand());
    
    % Update progressbar.
    send(dq,idx);
end
