function X = NonlinearTriangulation(K, C1, R1, C2, R2, x1, x2, X0)

opts = optimoptions(@lsqnonlin, 'Algorithm', 'levenberg-marquardt',...
                                'TolX', 1e-64,...
                                'TolFun', 1e-64,...
                                'MaxFunEvals', 1e64,...
                                'MaxIter', 1e64,...
                                'Display', 'iter');

P1 = K*R1*[eye(3) -C1];
P2 = K*R2*[eye(3) -C2];

%% Your code goes here. You can use any functions defined below.
[X,~] = lsqnonlin(@error,X0,[],[],opts,x1,x2,P1,P2);

    function err = error(X, x1, x2, P1, P2)
        X_aug = [X ones(size(X,1),1)];
        x_p1 = bsxfun(@rdivide,(P1(1:2,:)*X_aug'),(P1(3,:)*X_aug'))';
        x_p2 = bsxfun(@rdivide,(P2(1:2,:)*X_aug'),(P2(3,:)*X_aug'))';
        err = sum(sum((x1-x_p1).^2)) + sum(sum((x2-x_p2).^2));
    end
end