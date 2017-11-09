function HAlpha = interpolateRoughGround(hAlphaSet,dxSet,dx, hSet, h)
	
	if length(dxSet)>1
		minAbs = abs(dxSet - dx);
		[~, AIdx] = sort(minAbs);
		AIdx = AIdx(1:2);
		HAlpha_hSet = (hAlphaSet(:,:,AIdx(1),:)*(dxSet(AIdx(2))-dx) +...
			hAlphaSet(:,:,AIdx(2),:)*(dx-dxSet(AIdx(1))))/(dxSet(AIdx(2))-dxSet(AIdx(1)));
	else
		HAlpha_hSet = hAlphaSet;
	end
	
	if length(hSet)>1
		minAbs = abs(hSet - h);
		[~, AIdx] = sort(minAbs);
		AIdx = AIdx(1:2);
		HAlpha = (HAlpha_hSet(:,:,:,AIdx(1))*(hSet(AIdx(2))-h) +...
			HAlpha_hSet(:,:,:,AIdx(2))*(h-hSet(AIdx(1))))/(hSet(AIdx(2))-hSet(AIdx(1)));
	else
		HAlpha = HAlpha_hSet;
	end