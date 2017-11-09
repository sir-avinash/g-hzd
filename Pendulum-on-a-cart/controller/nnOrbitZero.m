function [y1] = nnOrbitZero(x1)
%NNORBITZERO_RAW270717 neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 27-Jul-2017 10:51:53.
% 
% [y1] = nnOrbitZero_raw270717(x1) takes these arguments:
%   x = 4xQ matrix, input #1
% and returns:
%   y = 3xQ matrix, output #1
% where Q is the number of samples.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.keep = [1 2 3];
x1_step2.xoffset = [-1.69590442012002;-2;0];
x1_step2.gain = [0.589655872191919;0.5;2.00501253132832];
x1_step2.ymin = -1;

% Layer 1
b1 = [0.047797359505367218;-0.97250640913706898;-10.608574048985282;0.14795434845126543;-7.3620443801394613;1.2179115273410728;1.1748611714025232;0.10404664095979775;0.56087201980570189;-0.65971621416552129;-1.1898632025576257;-3.2648890656925595;-0.052043350363283017;-1.9068690770439976;-1.2111185809594922;1.4428357160821654;1.1754797556886498;-0.22389513425292409;1.8327194576234049;-1.875876652058748;-5.1410503434028305;0.67703562848451482;5.4549754459615443;-0.044846274960843813;-1.2675549183957298;0.73246612139575007;0.17043924008802816;-0.14345610761944361;0.80476125703007706;1.8204984713498662;-6.3536023437925815;-0.20697601277596872;1.9546852901689422;7.3779707058186865;-0.64194246314948178;-0.31598771115480706;-0.67826537395231301;0.1506790613722914;-3.467596230594705;-2.2734062187573776;2.1591638061006946;-0.55860227921045769;-0.44141587904445728;-3.7344691435963089;-0.044594164952576898;-0.083018656495794055;-0.58318837016819891;0.14313584517816202;-8.2102517224845197;0.82525009491804702];
IW1_1 = [0.12691386024644991 0.33394653464069818 1.7577896177528636;0.04628501526191478 -0.035879345144469464 -1.7850874637418339;0.58395044596619317 0.71655019036351697 8.5204062655941755;0.18367983325615575 -1.3399071383317949 -0.27423435022585718;0.044322794136339889 0.12049050818178132 -6.6887800380111795;0.54409977735643167 0.83908268790555296 -0.50281670156730507;-0.18590509598513943 -0.28728336835963575 -2.1402445922828504;-0.61533749825310025 -1.0502462311025786 1.6409474566584656;-0.82172104667395041 -0.76790604206572199 -0.73566437669811335;0.47544844732883101 0.77249007512172196 0.26801034522627726;0.028039456454719537 0.08236376465352209 2.0725683731150584;-0.11671754998216727 -0.2984794394788064 -3.0947495272196197;-0.24250595475154327 -0.47067254874419601 -1.4528671851816115;-0.065323598016882881 -0.17394770110043828 -2.3560105393146422;-0.43688641678324491 -0.61257870994812902 0.84773546889596907;0.097313227683870213 0.15994152644027207 -2.1606053468998736;0.53710681556462636 0.53106908548726217 -0.06924753961584422;0.65233777832529638 1.0689131406708734 1.282131963618286;0.13670027632210321 0.00041933986971893242 -1.2917992693330815;0.28906989301107999 0.34981981924243871 1.9597349075633452;-0.80866808728464101 -0.37358021799550095 2.8601668038058645;0.19139403804327609 0.45020446507483119 1.0240087466866721;0.3489606685551358 0.32342281419106733 -4.3195475421214651;0.51224955319025267 0.90374767683560109 -1.3034351552281813;-0.083375549754592618 -0.12469812402975533 1.9278653893441726;-0.15895635864630708 -0.21244489324856666 -1.103524459972069;-0.094043038676596205 -0.87644877253422759 -0.26874800635881241;-0.17109990893280738 -0.39922833349174491 1.2047691024495011;-0.38689300957600042 -0.70489423030538267 1.0507970564991953;0.14366410835568635 0.40299543813291322 1.1611963657272952;-0.41724281512992517 -0.43741934238170627 5.5372979198756775;0.26047745507784814 0.48930930886589419 -0.87354137728888226;-0.052508883651545955 -0.10121969134395435 2.3859766165306446;0.037469538708574009 0.099911485752812404 6.7047118879380463;0.52730335328617206 0.82011330884348554 1.8224523702498732;0.66459390405886876 1.0733895366296531 1.1782455792824216;-0.49514936722601494 -0.75722254444564929 1.6358814925541871;0.45963903223187547 0.74329223610455364 -0.042108095413713159;0.12964616363260675 0.32170494956877216 -3.3637863990977181;0.93522110312332918 0.98068347094222497 1.8437871047357388;-0.88616558231205667 -0.91205577009042949 -1.6686731537467097;0.41670073081889542 0.64122312258490366 1.8687074872732738;0.091229983711197921 -0.082224917539051978 0.38008666324214563;0.086478473517422341 0.19263925116775144 3.063971815641628;0.70368775535635586 1.0073279149406527 -1.6493612959315334;0.27325543324748447 0.82875902979894633 0.31333638607303671;-0.42862492168509925 -0.65913191624216294 1.5849887116650223;0.22578940273387557 -1.3796516259385829 -0.28664626342552202;-0.47217790589497938 -0.63625193527796575 6.5344578672349733;0.11764274169661988 0.31210926424926255 1.8431129711057841];

% Layer 2
b2 = [0.44901086442724308;-0.35397791547130342;2.7094519039833576];
LW2_1 = [0.97373313033522235 -0.32390688426837777 5.5866911754730886 -0.35980033382424986 2.6309568263714707 0.99722445731941933 2.9049714126530994 0.62274623415386099 -0.070646124339813376 0.38253671726718141 1.8172656053975591 -2.6164417415938308 2.2723401542805926 -1.4520458295613814 -0.75956778511010437 2.540923244368404 -0.62572137405374872 0.82033377585720002 1.8013970485652411 -2.2402302039725255 1.1744945476019286 -1.6355737949695761 8.7369335944179127 1.7278912241132671 4.8048964451337541 -3.1570247067144517 0.50076602601555098 0.071468359849093874 -1.070761738609638 -3.1337410895374438 2.6373176599582675 -3.4884600469944136 -1.1197736179906412 2.6346853699902919 1.2691168210800547 -0.78517619639120972 -2.0224634285464864 0.40317834203096831 1.6117336552094823 -1.0856449538984807 -1.513899499362785 -2.0593585386894446 -1.521925957653959 3.6493305932419391 0.14069536036408931 0.41015546833240979 2.6282588202517942 0.26800036890156448 -3.81763869482725 0.54137590209875031;-0.60905288962024684 -0.26129760868487151 1.0907618408006352 0.057754486649568219 -0.1623302313259187 -0.57930008918750375 -3.1586216762334143 -0.7157363584183194 0.0038604365098501257 -0.21540284320388137 -3.1606246287822035 1.2660578073662538 -1.6109995925838916 1.847383348832123 0.32544295265454948 -2.3510695723348554 0.32127813300814145 -0.17803214084110697 -0.039669461311509564 0.99416879130026126 0.17952634331522668 1.3137850853901938 -1.05863978143402 -0.88164967042207876 -2.3708413420087897 2.9002883499233483 -0.21114926452993535 0.11138733124739027 0.27405867998598976 1.5215157248463158 -0.30084759475886558 1.5024691021670238 1.5215167233506661 -0.17284497594167911 -1.2559683565639417 0.27758752694781053 0.54314434693607749 -0.078771295186492327 -0.75807461966979039 0.0393782615063136 0.14100396945861407 1.9470116245683433 0.43409316395584413 0.11502037916749135 -0.22781551902992869 -0.11243727131086663 -1.1478332420644399 -0.03297731770132132 -1.2428819559933777 -0.69055830154918429;-0.090626130725582038 1.4260290707727683 5.8906770881482435 -0.17850912108066197 -2.1161887178771148 -1.342792614469754 -0.36216910918991518 -0.43657538273776397 -0.061472630117138126 -1.1479869359532595 -2.8915242773327252 -0.43789663637232906 -0.81745187635813066 -5.3230890235801596 -2.3311763015884597 -0.15067891784183066 -0.61622348821149731 -1.3145459105478654 -0.99433666011036959 -2.8115560110316138 0.54828351974085732 -1.4308664781830169 5.1052240135178844 -1.3807256485479593 4.5308497205661311 -0.1785071111099843 0.88041429517320891 2.0523985108444815 0.77909609101437804 -2.3885711381465664 1.2864632826307836 5.7426815302862302 -4.237888868533533 -2.0072889790505313 -1.3485869944080586 1.3155772402012316 0.15642687370037922 -0.8474651597200713 -0.19473183799255592 0.91389927183871811 0.82998895391533012 1.2950261822132736 -0.40338495044278083 3.5893657462755257 0.06797829510549562 1.0858173351062279 -0.35913919771474795 0.085499051064152898 -4.5380602815879678 2.216757102810913];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = [0.0514097468891074;2.3082151012342;0.668645916432596];
y1_step1.xoffset = [-19.4515643532935;-0.433235186558349;-1.49555987021541];

% ===== SIMULATION ========

% Dimensions
Q = size(x1,2); % samples

% Input 1
xp1 = removeconstantrows_apply(x1,x1_step1);
xp1 = mapminmax_apply(xp1,x1_step2);

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

% Remove Constants Input Processing Function
function y = removeconstantrows_apply(x,settings)
  y = x(settings.keep,:);
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
