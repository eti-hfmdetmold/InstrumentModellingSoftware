classdef PointSourceClass
    properties
        Q {mustBeNumeric} = 1e-3 % standard value
        f {mustBeNumeric} = 340 % standard value
        D {mustBeNumeric} = 0 % acoustic distance from oscillator in m
        Z {mustBeNumeric} = 0 % Z distance from origin in m
        X {mustBeNumeric} = 0 % X distance from origin in m
        Y {mustBeNumeric} = 0 % Y distance from origin in m
        rho0 {mustBeNumeric} = 1.2041
        pref {mustBeNumeric} = 2e-5
        c {mustBeNumeric} = 340
    end
    methods
        function obj = PointSourceClass(Q,f,D,Z,Y,X)
            if nargin == 1
                obj.Q = Q;
            elseif nargin == 2
                obj.Q = Q;
                obj.f = f;
            elseif nargin == 3
                obj.Q = Q;
                obj.f = f;
                obj.D = D;
            elseif nargin == 4
                obj.Q = Q;
                obj.f = f;
                obj.D = D;
                obj.Z = Z;
            elseif nargin == 5
                obj.Q = Q;
                obj.f = f;
                obj.D = D;
                obj.Z = Z;
                obj.Y = Y;
            elseif nargin == 6
                obj.Q = Q;
                obj.f = f;
                obj.D = D;
                obj.Z = Z;
                obj.Y = Y;
                obj.X = X;
            end
        end
        function p = pressure(obj,z,y,x) % calculates complex pressure at observation point z,y,x from point source at Z,Y,X 
            deltaPhi = obj.D*obj.f*2*pi/obj.c; % phase difference between oscillator and radiator
            deltaR = sqrt((x-obj.X).^2+(y-obj.Y).^2+(z-obj.Z).^2); % Euclidean distance between radiator and observation point
            p = j.*2*pi*obj.f.*obj.rho0.*[obj.Q]./(4.*pi.*deltaR).*exp(j.*(-2*pi*obj.f/obj.c.*deltaR-deltaPhi));
        end
        function v = velocity(obj,z,y,x) % calculates complex velocity at observation point z,y,x from point source at Z,Y,X 
            deltaPhi = obj.D*obj.f*2*pi/obj.c; % phase difference between oscillator and radiator
            deltaR = sqrt((x-obj.X).^2+(y-obj.Y).^2+(z-obj.Z).^2); % Euclidean distance between radiator and observation point
            v = j.*2*pi*obj.f./(4.*pi.*obj.c.*deltaR).*[obj.Q].*(1 + obj.c./(j.*2.*pi.*obj.f.*deltaR)).*exp(j.*(-2*pi*obj.f/obj.c.*deltaR-deltaPhi));
        end
        function Lp = SPL(obj,z,y,x) % calculates sound pressure level at observation point z,y,x from point source at Z,Y,X 
            deltaPhi = obj.D.*obj.f.*2.*pi./obj.c; % phase difference between oscillator and radiator
            deltaR = sqrt((x-obj.X).^2+(y-obj.Y).^2+(z-obj.Z).^2); % Euclidean distance between radiator and observation point
            Lp = 20.*log10(abs(-j.*2.*pi.*obj.f.*obj.rho0.*[obj.Q]./(4.*pi.*deltaR).*exp(j.*(-2.*pi.*obj.f./obj.c.*deltaR-deltaPhi))) ./ obj.pref);
        end
    end
end