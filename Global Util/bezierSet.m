function HAlpha = bezierSet(hAlphaSet,dxSet,dx)

minAbs = abs(dxSet - dx);
[~, AIdx] = sort(minAbs);
AIdx = AIdx(1:2);
HAlpha = (hAlphaSet(:,:,AIdx(1))*(dxSet(AIdx(2))-dx) + hAlphaSet(:,:,AIdx(2))*(dx-dxSet(AIdx(1))))/(dxSet(AIdx(2))-dxSet(AIdx(1)));
