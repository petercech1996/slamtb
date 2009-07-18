function [q,Qv] = v2q(v)

% V2Q Rotaiton vector to quaternion conversion.
%   [Q,Qv] = V2Q(V) returns the quaternion Q correscponding to the rotation
%   encoded in rotation vector V, and the associated Jacobian Qv = dQ/dV.
%
%   See also QUATERNION, R2Q, Q2E, Q2V.

%   Copyright 2008-2009 Joan Sola @ LAAS-CNRS.

if nargout == 1
    
    [a,u] = v2au(v);
    q = au2q(a,u);

else
    a = sqrt(dot(v,v));

    if isnumeric(a) && a < 1e-6
        
        % Use small signal approximation:
        q = [1-norm(v)^2/8
            v(:)/2];
        
        Qv = [-1/4*v(:)'
            0.5*eye(3)];

    else

        [a,u,Av,Uv] = v2au(v);
        [q,Qa,Qu] = au2q(a,u);
        Qv = Qa*Av + Qu*Uv;

    end
end


return

%%
syms r s t real
v = [r;s;t];
[q,Qv] = v2q(v)

simplify(Qv - jacobian(q,v))



% ========== End of function - Start GPL license ==========


%   # START GPL LICENSE

%---------------------------------------------------------------------
%
%   This file is part of SLAMTB, a SLAM toolbox for Matlab.
%
%   SLAMTB is free software: you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation, either version 3 of the License, or
%   (at your option) any later version.
%
%   SLAMTB is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
%
%   You should have received a copy of the GNU General Public License
%   along with SLAMTB.  If not, see <http://www.gnu.org/licenses/>.
%
%---------------------------------------------------------------------

%   SLAMTB is Copyright 2007,2008,2009 
%   by Joan Sola, David Marquez and Jean Marie Codol @ LAAS-CNRS.
%   See on top of this file for its particular copyright.

%   # END GPL LICENSE

