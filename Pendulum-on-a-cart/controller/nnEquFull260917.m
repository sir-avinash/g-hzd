function [y1] = nnEquFull260917(x1)
%NNEQUFULL260917 neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 26-Sep-2017 13:45:25.
% 
% [y1] = nnEquFull260917(x1) takes these arguments:
%   x = 5xQ matrix, input #1
% and returns:
%   y = 1xQ matrix, output #1
% where Q is the number of samples.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [-3.31620618640166;-0.679361912923211;-6.25362987194125;-3.75314603523389;0];
x1_step1.gain = [0.301549404286311;1.4719694775015;0.159907129215753;0.266443136134904;1.02564102564103];
x1_step1.ymin = -1;

% Layer 1
b1 = [0.27264382259707443;0.13276029722259083;3.9279977020556727;-0.0093147812291491106;-0.41464880069133431;0.3261475953583986;0.21003338577817832;-1.7763159640414261;1.342961612758826;-0.39152155997791155;3.2212406270219129;0.41460746491133305;-0.066166732906006193;-8.5508549198599315;-0.88772153405841936;-4.650052833061908;-1.0614972212806746;-0.79243561146052421;-1.3747079150495158;0.15815786937444748;0.0086700116748939151;-1.038988429565415;0.51095311648942132;2.94778340115603;1.5083192972207304;-0.47639807387230237;-0.6568640349566397;0.13230150532495899;-0.43446784191541288;-4.9152984279845189;1.3245986712206377;-0.361885323533506;0.08729708500583433;-0.017479832430953222;0.66527897731091734;-8.9836015302106684;-1.2819035136089236;-1.8014088426792154;0.94120307835643136;-1.0064829290302011;1.4530905403043644;0.072833044902788302;-1.2471703375338403;0.035265412873683538;-0.22663222984530956;0.065484219139627681;-3.0700314590652185;0.032612731948998649;-0.28165116337424112;1.7865908867972875];
IW1_1 = [-0.06248686021160172 0.43924005423201651 -0.17484796661946841 -0.25018901180316083 -0.0079972821799350387;-0.76997956707037662 0.065861931174700655 -0.86126377768186568 0.12540471621638508 0.89794064688269826;-0.3812176312501413 0.73484573209174864 -0.93185775262971671 0.97669378023266618 3.3652862100582852;-0.6337851576753083 -0.0082134383099868695 -0.13793317672015035 0.18342316873696698 -0.070289221838261834;0.56205801110344011 -0.60270748063511692 1.4191649533336634 -0.95153740379321328 -0.38955245404836786;-0.026291870985685029 -0.2022938648468125 0.050042432273764162 -0.19186270370246453 0.84494762970930382;0.15603075508546685 -0.1905337778029772 -0.53830391723118265 0.57771743635981598 0.11927435760420481;0.2292624401399555 0.38239646218319701 -0.04341797552897296 0.54600369166553187 -2.3596757258882151;0.06917485625426345 0.57684396000597704 -0.2230462650056316 0.59503486929630278 0.77687260874552611;-0.21880510793225674 0.024567010276878996 -0.76976744706007871 1.2819632027865251 -0.47783723870052658;0.42512895751283347 -0.75681102772926223 0.97467896468290471 -0.99878451003900481 2.7191183077944667;-0.37306896120945571 -0.3797647695504287 -0.22878791082453537 -0.65028568637890394 0.46698612156141683;0.49635561291147395 0.52740762344042491 0.06897729311509955 0.84097049233318621 -0.91044663750827692;0.50910179654569532 -0.90529249794395217 1.1650725845739405 -1.1530502315748319 -7.8535748669573273;-0.20451389213403504 0.36924013228068486 -0.44804659294653881 0.10537631592819516 -1.2107521455986465;-0.39183911961959811 0.77676667832211488 -0.95942924903312599 1.0126115827858664 -4.597152473667375;0.085432644677099809 0.72098738941120788 0.23620961971307725 -0.090830516238548861 0.20837658047798277;-0.432721799900677 0.050530493435374177 -0.41595053962177969 -0.51513042308129264 -0.88657271493480005;-0.098871482488504539 -0.60290867879378884 -0.55616586076730168 0.17813627298570028 0.13428414121310231;0.024623006100681109 -0.25175269020587399 0.26819587281214197 -0.51902122972559872 -0.068560385877272353;0.094431130951575723 -0.81018077444247394 0.14073357679753656 -0.59480436846040874 0.08566509760033926;0.51896001882993015 0.098786701695954271 0.46479131748016478 0.16053056599818466 -1.7975980618444263;-0.32064810048597453 0.3414941049660668 -0.6119392785281107 0.57995025728938299 0.91643538001414682;0.14421559227746078 -0.3320068092345187 0.36777320481248993 -0.39927780416831404 3.2023444177861702;-0.096403652618279642 1.5059142692781666 -0.1447305352918164 0.95759491245202211 0.087065167531051924;-0.30823054164297703 -0.41806636805494052 0.44007972158822101 0.018555888189333375 0.019211181092250916;0.32158673440395635 0.45048966279435415 -0.41465972545105467 -0.0070151511862261463 -0.037636206602854633;-0.7585050561586365 0.73552570536519202 -1.7559062365625659 1.0241827983906067 0.11065670933779523;-0.10193952301867912 0.061087863066241976 0.23695044934750314 -0.29635934580955053 0.56526453452753767;0.41786174484401745 -0.79577505645483804 1.0102795436495664 -1.0464274633528641 -4.7986036663698268;0.14233857496079297 -1.4719540139923242 0.1190432077814287 -0.77513836216205789 0.08856442327260404;0.065562399707522812 -0.21306767016891817 0.08459945444177526 -0.16412253272898303 0.1682310048692682;0.0028008088074315124 0.32629137784848866 0.32932705474650509 -0.2859240016510331 -0.39026075863295606;0.49166335755707291 -0.098219751341058079 -0.079936281088087716 -0.33149077706185309 0.15878318678840422;-0.39047389233736396 0.73059729836051601 -1.1996608006514689 1.3479161560212989 0.66597771199724498;-0.50898526069087402 0.88552418813854383 -1.1373403931573229 1.1286732722315229 -8.3693336484958163;0.98204291010656197 -0.50624197015145722 1.4444335112332487 -0.67506575986221817 -0.52447238115239658;0.3267563554957808 0.41899993092046978 0.014415997586099872 0.6353755420764543 -2.1028986966129719;0.37202574342271821 0.28964820605828734 0.093389646290082132 0.99141100500389312 0.96685526068436678;0.47746558038585385 -0.7637944553070557 1.1045426161692486 -1.165834279270763 0.16943129896118359;0.046688693808452864 -0.034493459467509167 -0.35105545176458713 -0.11804843568500044 0.7238827035309352;-0.18758357638884471 0.34668760091670164 -0.81438821781642856 1.1722615950165924 0.021487996248948992;0.69465691046310629 -0.28583842488202638 0.97410913690380763 -0.43348750132079 -1.6456371971049746;-0.58106885228949678 -0.26930107978778262 -0.84627975023296131 0.14733982918913341 0.052804689246265323;-0.037320813428528971 0.62289055014234429 -0.21715490192302414 0.010464809302101055 0.11931963711838939;0.12588437114824089 -0.17128357234882582 0.62663948752383014 0.0052785066741207441 0.087817532030923434;0.22014990091272807 -0.28735877430923412 0.43836012630821658 -0.37956259370766282 -3.2098246313204077;-0.71778340893447057 -0.064287566803272675 -0.73534016618893694 0.025581457223062196 0.20268518195424057;-0.52297705138798956 -0.4017150048520764 -0.22256569077381386 -0.7140477749664913 0.41317028438504866;-0.55102581506188952 0.12566387226137843 -0.69202891260455168 0.20213164964899047 2.4678214890806243];

% Layer 2
b2 = 0.021376794490333761;
LW2_1 = [-0.95923039801117149 1.7435795645123231 6.3692894997290717 1.7369678637060202 2.6802669268701296 2.3880402558430216 0.56810231120461552 -2.5048421440052508 -1.3630748800009067 0.42111567731743804 -4.120132458435962 1.087749815384536 1.5492490612660332 1.7472046840565143 -1.0801868506968739 -1.7550387669371836 -1.6697524389362663 1.2895987030665657 1.4187994020089481 1.0072495269242201 -3.9472066256043465 1.3366116792215095 -4.1863938787385786 2.3163958345511708 0.77609557273136265 -1.2370502620444819 1.2881809761384579 1.7604800405981824 -1.075373997869963 2.0826476568948551 -0.80202744489377154 1.0547461221511014 -0.98338603177168293 1.2766209045717192 1.9589062848045227 -1.0828740804764645 -0.91429696521666659 1.8022898674848451 0.75757662170874251 1.458182232293542 1.5858973477801459 -2.2906729763075417 -2.7871892506674496 0.8595040716055653 -0.91563992344425083 2.5394205663993379 3.409745354162697 -1.9904712347956437 1.6306856825664726 -1.6784778845815393];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = 0.0148486944337356;
y1_step1.xoffset = -67.3459881919342;

% ===== SIMULATION ========

% Dimensions
Q = size(x1,2); % samples

% Input 1
xp1 = mapminmax_apply(x1,x1_step1);

% Layer 1
a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*xp1);

% Layer 2
a2 = repmat(b2,1,Q) + LW2_1*a1;

% Output 1
y1 = mapminmax_reverse(a2,y1_step1);
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings)
  y = bsxfun(@minus,x,settings.xoffset);
  y = bsxfun(@times,y,settings.gain);
  y = bsxfun(@plus,y,settings.ymin);
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n,~)
  a = 2 ./ (1 + exp(-2*n)) - 1;
end

% Map Minimum and Maximum Output Reverse-Processing Function
function x = mapminmax_reverse(y,settings)
  x = bsxfun(@minus,y,settings.ymin);
  x = bsxfun(@rdivide,x,settings.gain);
  x = bsxfun(@plus,x,settings.xoffset);
end
