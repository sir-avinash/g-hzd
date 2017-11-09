function [y1] = nnOrbitLibrary(x1)
%NNORBITLIBRARY_NONE neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 25-Jul-2017 13:19:44.
% 
% [y1] = nnOrbitLibrary_none(x1) takes these arguments:
%   x = 4xQ matrix, input #1
% and returns:
%   y = 3xQ matrix, output #1
% where Q is the number of samples.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [-2.26386609775547;-1.62340701346445;0;-2];
x1_step1.gain = [0.441722238338856;0.615988468514705;1;0.5];
x1_step1.ymin = -1;

% Layer 1
b1 = [-1.0649021808198389;0.28806657598188856;0.44780129517280165;-4.4677300409605261;0.53350171008600389;9.667988508390815;0.19089119114387593;4.0476092258891807;-6.5549276521149968;-7.5538757187153802;-0.13904247772210895;9.9302994840274081;-4.3062828733177048;-0.17612117321686932;-0.48059360195734585;-14.318829356734993;-0.31633301651006757;0.19250642193081122;1.0091095647830011;6.560605616843767;4.3806131720145496;9.5909365720676139;0.75034868531703158;-6.6837251861366171;-1.4155050514759868;10.137308594484505;4.6397183841113021;-8.3960181629323145;15.020770691971036;7.5172803036788309;-1.2743348841045641;1.2445838453635982;-0.30495565912945327;-0.31542810294797924;-1.1659881432264911;2.1273744551050044;-2.7963115186577228;-0.2645618047893662;0.80917785977467849;1.1106998655789355;0.17222209030373908;0.56142872169701441;2.1066104968152257;0.019379003158496791;4.6881981560413841;3.146168838971291;0.30480345289707828;-2.8333781879081719;-0.32458021739425447;-0.39837187980744798];
IW1_1 = [0.039156225537801216 -0.2856185262774274 0.87872038753112991 0.27088985240815905;0.0081426793315187707 0.018729250127151032 1.8122062725322963 0.33058012973092293;-0.024305779398536287 0.093202107549678503 -1.5742271405488102 -0.1509124313271091;0.095016549608463285 -0.57305718925940974 -2.6564976731295689 -0.37967563668197452;0.083611244262936452 -0.22804583241810936 -0.51657318235985084 -0.42835565035106982;-0.036497877729797262 0.20797307441170448 8.9792209226857995 -0.11882766651320739;0.016185027312611379 0.06436669291675623 0.78753954729907527 0.66089520445481431;-0.14589542202640304 -0.27564281080609432 -4.6394190058171807 0.19897672843940339;-0.0053008819437768756 0.43582514688597951 6.8419908830215936 -0.25512965137624333;-0.036634825600326798 -0.51424079851409943 7.9382293192779496 0.06868642189572767;0.089901204855977121 0.46149584488524326 -0.11846290472477819 0.60306049551437724;0.045651100947602649 -0.1774723430147282 10.153909693041879 0.052851931201350774;0.010564708912824719 0.20833845383204697 -3.6861589624698778 0.0080055870001609231;-0.039806639557398327 -0.39813439687631924 -1.0163351011898749 0.35344368267162263;-0.26583361437073072 -0.16112265087268249 0.80878301435528166 -0.11892485520611187;0.066990540178658672 1.2983293407598349 14.365503538944481 -0.64208804962486687;0.057081157143308997 0.40326095853400895 -0.31219525402151466 0.48156618491987718;0.028511888799330445 0.030760426730086613 1.0460637464949789 0.52110765147766303;-0.030104098584776869 -0.13158091110283535 0.092101535607795021 -0.63176405653646339;-0.043919117686368608 0.2153212047902992 5.3082315493746961 0.054025371624685209;0.083080704054672924 0.18057232577994134 -5.0606863211879203 -0.29728696007026695;0.049303183452905477 -0.14687401829417129 9.6718611373165881 0.049580189436917943;0.12088374690976933 -0.10014148925941399 -1.2114362027979917 -0.74153906055298136;-0.0067336382189709838 1.0052369432688888 6.1912030979118704 -0.51647721515667977;0.018275956329975095 1.0022210533668592 1.1898106572847098 0.031145667018011972;-0.077607523238712992 0.067386810850033937 10.181610658288735 -0.044361395211225577;-0.049192159103684283 0.3134115986674274 -2.0796133121244038 1.157630794117581;-0.036560403885718372 -1.137661593816401 7.6217186094311025 0.61104471348091338;0.085467076925232449 1.2172570328453742 -15.065894692333154 -0.5952015579312524;0.027549601594202715 0.70692047892122456 -7.824624664263931 -0.012790882949457563;-0.018148245558904475 -0.020084325459486928 -1.9630594844732125 -0.14105644291280159;-0.014627327057201709 0.056688690979704512 2.3634433524492295 -0.11173917551792242;-0.019919777805415598 -0.15572442387258978 -1.477966758515761 0.46602881215312558;0.0061009404639008266 -0.030522029919325438 -2.5616031558238679 -0.19751584796485042;0.012539450802859438 0.10434277273418649 -0.61444067649837852 0.57895724914314362;0.059363550792616911 0.026795466944546799 -2.7513511166132569 -0.31372032447277393;0.048572095640284911 -0.10552208113662842 -3.6618699460812807 0.12900696204481929;0.026791787065902774 -0.3959743387124332 0.48355917347369298 0.17892122744418285;0.13688083268556006 0.33851423975096745 -0.48194934366310671 0.090292218100086058;-0.090317002461707568 0.13834712853955894 1.2732309671065736 0.00053660410468248478;-0.00084472421494149856 -0.014498758553831797 1.1345282297826376 -0.42578940455176423;-0.0091714781253401656 -0.050961409706273851 -2.2994880422852502 0.10887942129752613;0.097740906267317906 0.075092546066303126 -2.3486335362596629 -0.42742034325129319;-0.028490231088828338 -0.49799369084906453 -0.66623697380631408 0.18905798928112769;0.10734940882999121 0.30794930521701358 -5.3566399302574856 -0.22892566036302275;-0.098992501118583917 0.00075492058680455066 -3.4868762613567554 0.0031968856008618139;0.0018815286218110212 0.06506673739464644 1.8426014881786039 -0.34346913341864005;-0.061518443401857907 0.062200013679719557 -2.9927632999677947 -0.14742465077790351;0.0039562305516091965 -0.60149917649514006 0.35745715135094036 0.19305234709254196;0.037446541243396907 -0.11160361035341818 1.1383380178585383 -0.26807286236385952];

% Layer 2
b2 = [2.4785164969144646;0.073086799440833988;1.8541664766691657];
LW2_1 = [1.4371135915420796 -4.6342012726593316 0.52998729739818229 1.2323428475202112 -1.0542879238572234 -1.8039461890509587 -1.7966763807661574 -0.9011643315164557 5.9998571603072568 -5.8577063193571268 0.24418131563448722 -2.0682155548549752 -0.83423821384546826 -1.248421254660818 -0.51179419949560101 3.1965466421048103 -0.57926213849029207 3.9313545076048131 2.0521097777860384 3.1192418674828373 -3.2478749840991141 3.4426177200614099 0.33135770349946048 -6.3620228668551819 -0.3521480793501035 -0.58185408130621286 -0.7222417437597346 6.5201955959092004 3.3555814640708252 -2.7205356007001469 4.9875549764557467 4.4958584663520504 1.4926017853669844 -1.3391075317955567 2.6488846986156362 -3.771337854019658 -1.021198802533801 -0.79761499155515014 -1.5219674652443409 -1.6340198044508443 -1.8788105846460987 -1.5347540858877056 3.4618900348056356 1.511783346307161 3.1848623354203149 3.1373613691854865 3.5953118608885819 -0.34799375450680475 0.4439784621135372 -1.9914407354676946;-1.0031517604000479 3.6339441097628704 -0.0057887064299012962 0.20431363187175894 0.66580442457911149 -1.0638819669117177 0.3023749319629972 2.141786162392274 -1.5893461262963315 1.5315551126988818 0.48859967464324633 -1.3481512629481847 -2.5554091038004176 0.16569800795886389 0.1485390300002104 -0.45927086304864839 -0.67855092529343486 -1.4089470965672997 -0.42610850577743492 -1.8222664851359605 2.1220820869788133 1.2640978414868762 0.087803424113270065 1.5569011367523633 0.4760907205226439 0.49605931101524686 1.1107163760139869 -0.52548906037864584 -0.2269404506089574 1.1275842837587664 -3.4327724141614655 -2.4801178611182344 -0.63246032241989913 0.92344628210254032 0.034813557279036053 2.8248402122519569 0.20108337012961303 -0.80227221426629514 0.96279265224425803 0.15717724388825041 -0.44837929420225431 0.71320559921924831 -2.2826715663235921 -1.036842402371265 -2.1047606523149778 -4.1831782950439198 -2.229360016852568 1.4985164126464687 0.056592380537580311 2.1891025010462175;1.51915951849103 -1.0382309301834169 3.3731818740402444 -2.1199449986608925 -0.044231971587391873 5.7107573909183511 0.51563413513803458 1.9367287059452782 0.44957361712526767 -0.59591590352907575 -1.0672096055557532 5.3364828796014567 6.6070492530330691 -0.84863594287152333 0.16964361710039785 0.63550511033608592 2.3322338650451959 -0.36528606390215634 -0.33854998912432138 -4.8952587049351477 0.54543055316968292 -6.5283741534834823 -0.18704170601377357 0.029590309189021349 -0.37227816071873077 -0.80659082817660022 -0.4280002737290432 -0.9832727892034151 0.45863554867949236 -0.053015320190212982 -2.5662473394225853 -2.8629041575771406 2.15979707576389 0.081022551816052932 -1.8120019496811095 0.87637314415990231 1.7698959461287387 2.0987060383318572 0.5980191782341745 2.6951451745501966 4.0868407614970916 -0.90011176842379204 -1.8561274898454594 0.77861452168521805 -1.3434646581464698 -1.0451983059313286 0.92189090953894282 -3.0312977362263118 -0.64334242512849915 -0.59866243080680659];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = [0.0676833787374776;2.34121949228358;0.657661569666595];
y1_step1.xoffset = [-14.7746761265965;-0.427127829447814;-1.52053890043622];

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
