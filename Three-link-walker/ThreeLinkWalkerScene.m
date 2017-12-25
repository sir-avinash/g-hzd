%TLWSCENE Creates a simple 2D Three Link Walker scene object.
%
% Description:
%   Creates a simple 2D Three Link Walker object using the Scene superclass.
%

classdef ThreeLinkWalkerSystem < Scene
    
    properties 
        axes@matlab.graphics.axis.Axes
        ground@StripedLine_poly
        torso@RoundedSquare
        lLegA1@RoundedSquare
        lLegA2@RoundedSquare
        lLegB1@RoundedSquare
        lLegB2@RoundedSquare
        rLegA1@RoundedSquare
        rLegA2@RoundedSquare
        rLegB1@RoundedSquare
        rLegB2@RoundedSquare
        lActA@RoundedSquare
        lActB@RoundedSquare
        rActA@RoundedSquare
        rActB@RoundedSquare

        response@Response
    end %properties
    
end %classdef