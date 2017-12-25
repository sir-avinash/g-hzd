function HAlpha = interpolateRoughGround4(hAlphaSet,h1Set,h1, h0Set, h0,l1Set,l1, l0Set, l0)
	
	if length(h1Set) > 1
		minAbs = abs(h1Set - h1);
		[~, AIdx] = sort(minAbs);
		AIdx = AIdx(1:2);
		HAlpha_Set1 = (hAlphaSet(:,:,AIdx(1),:,:,:)*(h1Set(AIdx(2))-h1) +...
			hAlphaSet(:,:,AIdx(2),:,:,:)*(h1-h1Set(AIdx(1))))/(h1Set(AIdx(2))-h1Set(AIdx(1)));
	else
		HAlpha_Set1 = hAlphaSet;
	end
	
    if length(h0Set) > 1
        minAbs = abs(h0Set - h0);
        [~, AIdx] = sort(minAbs);
        AIdx = AIdx(1:2);
        HAlpha_Set2 = (HAlpha_Set1(:,:,:,AIdx(1),:,:)*(h0Set(AIdx(2))-h0) +...
            HAlpha_Set1(:,:,:,AIdx(2),:,:)*(h0-h0Set(AIdx(1))))/(h0Set(AIdx(2))-h0Set(AIdx(1)));
    else
        HAlpha_Set2 = HAlpha_Set1;
    end
    
    if length(l1Set) > 1
        minAbs = abs(l1Set - l1);
        [~, AIdx] = sort(minAbs);
        AIdx = AIdx(1:2);
        HAlpha_Set3 = (HAlpha_Set2(:,:,:,:,AIdx(1),:)*(l1Set(AIdx(2))-l1) +...
            HAlpha_Set2(:,:,:,:,AIdx(2),:)*(l1-l1Set(AIdx(1))))/(l1Set(AIdx(2))-l1Set(AIdx(1)));
    else
        HAlpha_Set3 = HAlpha_Set2;
    end 
    
    if length(l0Set) > 1
        minAbs = abs(l0Set - l0);
        [~, AIdx] = sort(minAbs);
        AIdx = AIdx(1:2);
        HAlpha_Set4 = (HAlpha_Set3(:,:,:,:,:,AIdx(1))*(l0Set(AIdx(2))-l0) +...
            HAlpha_Set3(:,:,:,:,:,AIdx(2))*(l0-l0Set(AIdx(1))))/(l0Set(AIdx(2))-l0Set(AIdx(1)));
    else
        HAlpha_Set4 = HAlpha_Set3;
    end
    
    HAlpha=HAlpha_Set4;