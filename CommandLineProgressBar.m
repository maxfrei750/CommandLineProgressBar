classdef CommandLineProgressBar < handle
    %COMMANDLINEPROGRESSBAR
    % Progressbar for the command line, which also supports parfor loops.
    
    properties(Access=public)
        message = 'Progress'
        barLength = 42;
    end
    
    properties(Access=private)
        nIncrements_total
        nIncrements_current = 0
        wasAlreadyPrinted = false
    end
    
    properties(Dependent=true)
        progress
    end
    
    methods
        function obj = CommandLineProgressBar(nIncrements_total)
            %COMMANDLINEPROGRESSBAR Construct an instance of this class
            
            % Validate input.
            validateattributes( ...
                nIncrements_total, ...
                {'numeric'}, ...
                {'real','finite','nonnan','nonsparse','nonempty','positive','integer','scalar'});
            
            % Assign property.
            obj.nIncrements_total = nIncrements_total;
        end
        
        function obj = increment(obj)
            %INCREMENT Increment the progressbar.
            obj.nIncrements_current = obj.nIncrements_current+1;
            obj.print;
        end
        
        function print(obj)
            %PRINT Print the current progress.
            if obj.barLength > 0
                nChars_complete = round((obj.barLength-2)*obj.progress);
                nChars_incomplete = obj.barLength-2-nChars_complete;
                
                barString = [ ...
                    '|' ...
                    repmat('=',1,nChars_complete) ...
                    repmat(' ',1,nChars_incomplete) ...
                    '| '
                    ];
            else
                barString = '';
            end
            
            % Print the message on the first increment. On all other
            % increments delte the old prograssbar chars.
            if obj.wasAlreadyPrinted
                fprintf(repmat('\b',1,numel(barString)+4));
            else
                fprintf('%s',obj.message)
                obj.wasAlreadyPrinted = true;
            end
            
            % Print the progressbar.
            fprintf('%s%3d%%',barString,round(obj.progress*100));
            
            % On the last increment print a linebreak.
            if obj.progress == 1
                fprintf('\n');
            end
        end
        
        %% Getters
        function value = get.progress(obj)
            value = obj.nIncrements_current/obj.nIncrements_total;
        end
        
        %% Setters
        function set.message(obj,value)
            % Validate input.
            validateattributes( ...
                value, ...
                {'char'}, ...
                {'row','vector'});
            
            % Assign property.
            obj.message = value;
        end
        
        function set.barLength(obj,value)
            % Validate input.
            validateattributes( ...
                value, ...
                {'numeric'}, ...
                {'real','finite','nonnan','nonsparse','nonempty','integer','scalar','>',2});
            
            % Assign property.
            obj.barLength = value;
        end
    end
end

