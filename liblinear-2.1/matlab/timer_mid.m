function [ prev_tick] = timer_mid( prev_tick, interval_time ,start, chunks, i )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%% timer_mid.m
% 	Part of timer code, requires timer_start
if toc(prev_tick) > interval_time
    time_spent = toc(start);
    time_left  = (time_spent / i)*(chunks-i);

    days    = floor(time_left) / (24*60*60);
    hours   = floor(mod(time_left,24*60*60)/(60*60));
    minutes = floor(mod(time_left,60*60)/60);
    seconds = floor(mod(time_left,60));
    fprintf('\t%.0f/%.0f\t %.0fd %.0fh %.0fm %.0fs remaining.\n',i,chunks,days,hours,minutes,seconds);
    prev_tick = tic;
end

end

