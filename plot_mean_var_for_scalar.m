%% Plot sample mean and covariances for scalar examples
if nx==1
    x_mean=(1/samples)*ones(1,samples)*x;
    x_var=(1/samples)*ones(1,samples)*x.^2;
    x_ub=x_mean+x_var.^(0.5);
    x_lb=x_mean-x_var.^(0.5);
    figure()
    plot(1:steps,x_mean)
    hold on
    pause
    plot(1:steps,x_ub)
    plot(1:steps,x_lb)
    legend('mean(x)','mean(x)+std_dev','mean(x)-std_dev')
end