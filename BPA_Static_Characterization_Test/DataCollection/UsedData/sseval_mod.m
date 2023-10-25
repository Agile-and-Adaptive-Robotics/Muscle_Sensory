%% Compute sum of squared error 

function sse_mod = sseval_mod(pressure,force,a1,a2,a3,a4,a5,a6)

sse_mod = sum ((pressure - model).^2));