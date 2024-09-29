%% ODRC
%Rossler system using the forth Runge-Kutta method
function chaos = rossler(T, ds)

    step = T * ds;

    x = zeros(step, 0);
    y = zeros(step, 0);
    z = zeros(step, 0);
    
    %Initial value
    x(1) = 0.1;
    y(1) = 0;
    z(1) = 0;
    
    h = 0.001;

    step = T * ds;
    
    for t = 1:(step-1)
        xd1 = h * dx(x(t), y(t), z(t));
        yd1 = h * dy(x(t), y(t), z(t));
        zd1 = h * dz(x(t), y(t), z(t));
        
        xd2 = h * dx((x(t) + 0.5 * xd1), (y(t) + 0.5 * yd1), (z(t) + 0.5 * zd1));
        yd2 = h * dy((x(t) + 0.5 * xd1), (y(t) + 0.5 * yd1), (z(t) + 0.5 * zd1));
        zd2 = h * dz((x(t) + 0.5 * xd1), (y(t) + 0.5 * yd1), (z(t) + 0.5 * zd1));
        
        xd3 = h * dx((x(t) + 0.5 * xd2), (y(t) + 0.5 * yd2), (z(t) + 0.5 * zd2));
        yd3 = h * dy((x(t) + 0.5 * xd2), (y(t) + 0.5 * yd2), (z(t) + 0.5 * zd2));
        zd3 = h * dz((x(t) + 0.5 * xd2), (y(t) + 0.5 * yd2), (z(t) + 0.5 * zd2));
        
        xd4 = h * dx((x(t) + xd3), (y(t) + yd3), (z(t) + zd3));
        yd4 = h * dy((x(t) + xd3), (y(t) + yd3), (z(t) + zd3));
        zd4 = h * dz((x(t) + xd3), (y(t) + yd3), (z(t) * zd3));
        
        x(t+1) = x(t) + (xd1 + 2 * xd2 + 2 * xd3 + xd4) / 6;
        y(t+1) = y(t) + (yd1 + 2 * yd2 + 2 * yd3 + yd4) / 6;
        z(t+1) = z(t) + (zd1 + 2 * zd2 + 2 * zd3 + zd4) / 6;
        
        if x(t) > 50
            break;
        end
    end

    % downsampling
    x_ds = downsample(x, ds);
    y_ds = downsample(y, ds);
    z_ds = downsample(z, ds);

    chaos = [x_ds; y_ds; z_ds];

    % 3 dimensional plot
    %plot3(x, y, z);
end

function dxdt = dx(x, y, z)
    dxdt = - y - z;
end

function dydt = dy(x, y, z)
    a = 0.2;
    dydt = x + a * y;
end

function dzdt = dz(x, y, z)
    b = 0.2;
    c = 5.7;
    dzdt = b + x * z - c * z;
end