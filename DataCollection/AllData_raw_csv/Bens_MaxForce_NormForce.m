norm_force = -0.5887 + 0.3917*Pressure + exp(-6.691*Erel-0.8048) + Pressure*(exp(-(1.113*Erel).^2 -0.2881));
max_force = pressure*(0.4864*atan(0.03306*(restinglength - 0.0075)*pressure))