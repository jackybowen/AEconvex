function dy = rigid(t,y)
dy = zeros(2,1);    % a column vector

alpha=1;
beta=1;
epsilon=0.3;
% delta=2*(-pi/4+epsilon);

delta=1.8;

cc=1+y(1)^2+y(2)^2;

dy(1)=-2/cc+4*y(1)^2/cc^2-8*y(1)*cos(delta)/cc^2;
dy(2)=4*y(1)*y(2)/cc^2-8*y(2)*cos(delta)/(cc*(y(1)^2+y(2)^2)^(1/2));
