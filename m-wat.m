function displayStuff(a, v)
stop=false; 

figure 
h = animatedline; 
ax = gca; 
ax.YGrid = 'on'; 
ax.YLim = [-0.1 5]; 
title('Soil sensor voltage vs time (live)'); 
ylabel('Time [HH:MM:SS]'); 
xlabel('Voltage [volt]'); 

startTime = datetime('now'); 

while ~stop
    v = readVoltage(a,'A0')
    
    t =  datetime('now') - startTime;     % Add points to animation
    addpoints(h,datenum(t),v)     % Update axes
    ax.XLim = datenum([t-seconds(15) t]);
    datetick('x','keeplimits')
    drawnow
    
    
    if v > 3
        writeDigitalPin(a,'D2',1);
    elseif v > 2.9
        
        writeDigitalPin(a,'D2',1);
    else
        
        writeDigitalPin(a,'D2',0);
        
    end
    
    stop=readDigitalPin(a,'D6');
end
end