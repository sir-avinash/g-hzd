function [y1] = nnEquZero17-07-26(x1)
%NNEQUZERO17-07-26 neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 26-Jul-2017 15:45:02.
% 
% [y1] = nnEquZero17-07-26(x1) takes these arguments:
%   x = 4xQ matrix, input #1
% and returns:
%   y = 3xQ matrix, output #1
% where Q is the number of samples.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.keep = [1 2 3];
x1_step2.xoffset = [-1.69803432305843;-2;0];
x1_step2.gain = [0.588916246521354;0.5;2.05128205128205];
x1_step2.ymin = -1;

% Layer 1
b1 = [-1.715125562273202;-1.16913544275585;0.26436456754947585;-0.31574940790610762;-0.72948169323296508;-1.1735792889607566;8.3579833711322635;-0.8562569029385062;-0.018178239939620568;-5.418960082029459;-6.6575907434067769;-1.6706799543597319;-2.9328361847220927;0.30201780860669319;1.7966984599270264;-1.8652283389500433;-2.1803549416332144;-0.43621029794538879;0.26679138436166944;0.89302864811685945;0.61310535603251393;-6.3822914372503385;1.5062363581336995;-0.54318599178211568;-6.0568513315207664;5.0286761675274469;-0.23562318422096976;-0.42997553676070743;3.1749727274301605;0.10820421010193079;0.71978072745736366;0.95308212256288916;-0.68219016195473037;1.4007939423908462;1.0395260650890388;-0.14729008536401622;6.6300891905089818;5.6832920300636296;6.7513623866653747;0.32241285727242064;0.27822494829268407;-0.21026628710252657;-1.0247093990170937;-1.0675528326131589;0.36486968532170272;1.7342242031400508;-0.29735594364523416;0.27040469281805102;10.954135575824843;0.83113325929904602];
IW1_1 = [-0.22168126381664774 -0.2714847371057954 1.8582728697159003;0.35657255783076669 0.4834448293024059 2.101696198950008;-0.012950077413531201 -0.17344037092866421 0.21989858152512021;0.30270818170250152 0.17605123150954624 0.38163573679188301;0.13416799913224697 -0.26585745537013844 -0.42015013327745937;-0.36277712601092382 -0.68885224580982096 -0.93637534418102764;0.080484269533381322 0.22124092508336513 8.6400497691747038;-0.19439873701782015 0.082645447164693894 1.2752843107456571;0.1149020300022095 0.27868028041701443 1.2461182402323177;0.20338527698392955 0.51492340165701556 -4.4646165157030762;-0.068688671604814261 -0.17450716986972917 -6.4500572499344075;-0.47343746308158535 -0.4373834422439114 1.5763639065723738;0.041729115643742577 0.11137708583132809 -3.5494877375245188;0.69415784181085227 1.1539687499346774 -0.78916696184528345;-0.20116371701565527 -0.25702335451207597 -1.9789285756115695;-0.36864783407125251 -0.38244746948754149 1.9326848731633439;0.49079578141809266 0.64048639331927737 1.6708458584207653;-0.37886007958786755 -0.21157180107857307 0.30614282028968998;0.7004953390821872 1.1811672907175108 -0.91358943064216602;-0.51125957972805058 -0.72899856745395064 -0.81355322335870961;0.59993896319403073 1.0206373286851589 1.0326455897895639;-0.15129239825653476 -0.38952972682174092 -5.5620456374106562;-0.075200407683425383 -0.1412172501977603 2.4772426409034289;0.37770682050759186 0.73377041343803706 -1.4363027197982492;-0.17667732900638863 -0.2187244830788703 5.5140024628223863;-0.071249427496810985 -0.17595983207361857 5.0952690784885499;-0.21209841851018527 -0.26872731520670828 0.19329712625510034;0.41875242819444319 0.65263105115274145 -0.14615919350389994;0.032327507967338118 0.050118565739927304 3.7676185111470741;0.13979901093656302 0.58998434848826498 0.6887529582118912;0.17845120305310366 0.3534032001453094 1.4879251581308703;0.2010461336204479 0.2913676462872471 -1.7722238873142306;0.56121660591999156 1.0608022109952946 2.0499696006159422;-0.50181187862310372 -0.65052279188798889 -0.048770831629568467;-0.18679807897575557 -0.28717485447355556 -2.0013940565301884;0.33574952627846311 0.67284647150024646 -0.89209650263750839;-0.57011227797306507 -0.7001415008570675 -4.8799797972183372;-0.07355498470971461 -0.043680247536802573 -5.1552583647285717;0.48046466517045167 0.5543324131422489 -5.067128886853606;-0.017876409594644795 0.48366922154008946 -0.086921982732711622;0.3623735258357661 0.60883138711541551 0.36301184361534811;-0.032626935280370827 -0.22223993849553456 -1.6612281214259135;-0.38377572037516489 -0.5588069191080608 2.0188232493478657;0.18937821653645781 -0.022830055626573937 1.603765906847979;0.74244589372779091 0.46089579078961301 -0.97437651150518712;0.055474975422910126 0.12779109000676805 2.3088384783590827;0.10925675489211009 -0.11648134980376613 0.5348245747539242;-0.31103342597428929 -0.60074176545279867 1.2370660203922828;-0.092339890234932206 -0.22884685407238584 10.604106516660602;0.16722054128198344 -0.49708723598166449 -0.90429580695298439];

% Layer 2
b2 = [0.22163030894829749;-0.37068866824386315;-0.61299777419927548];
LW2_1 = [-3.3582692089579891 1.2634197043889541 0.24350523901692614 0.60903144616954963 0.20068008601615936 0.9955032007386071 -1.6416985007341298 0.91349599359161193 -3.0642546719988628 -1.4940158537835253 -9.8962257051163043 -2.3811330768031818 2.7016841533759832 -0.81001110497941053 1.5643678683337021 4.2045715417247314 2.4940539183122885 0.18907993944584553 0.76814587986146898 -0.65079515706820423 -0.25248866513133122 4.4718347271821619 -0.37938845711220942 0.35003830428138233 1.2359961566680562 -3.9911595832929359 0.23702154308202206 -0.9164386320889748 2.8816235847184188 -0.26620813465161092 0.16929561260818982 -4.3777002530723355 0.10961722693618545 1.2517126181280902 2.9431559250468715 0.016058686801028295 -6.1720217061326528 1.4886057483209141 5.8370923879607606 0.059579578933488149 2.129544297687608 -0.95336028998803346 -0.95243998645309802 -0.40848656221028623 0.067840759524633143 1.125818437625536 -0.57882927989427047 0.96081389120869676 -2.0471555558201118 0.1786072352991753;2.4135300133136242 -0.84711487138470976 -0.073156861358251224 -0.32589452259522411 0.25689350123952959 0.38659045977806628 -0.1660428249045334 0.22873615903478253 1.5607203880716025 -0.082570962836906014 -0.0091807968688216116 0.0080851725070120017 -1.4486412905338251 0.10243586640041046 0.93232528049738539 -0.99111841491718233 -0.32237424945306747 0.44996484936973619 -0.18482096708439757 -0.12882525608415324 -0.085208895804050583 0.10679029652349263 0.13631476178807683 -0.56214683640246588 0.66131709798881533 0.51577393778233649 0.240416307872312 -0.051936341606871071 -1.4384619806719503 0.12579355818509946 -0.014044455338977727 2.9017539629103792 -0.045845737948956779 -0.078891118167020158 -1.710750767478963 0.58512018639079821 -0.52244229381598051 0.58966731698710062 1.2170061158171921 -0.17766748153215725 0.79843574548888008 0.23359601649865111 0.55068746544044733 0.96075663603367001 0.099078018980933311 -0.31121726563416713 -0.33094961642417137 -1.1109834899830169 -0.01116636157616344 0.34455877891125458;1.1094519148302457 -0.20867060523731912 0.14518987667311709 -0.4176568957886917 1.1013424554059379 0.50263327906449318 0.16290047553758363 0.068750882569240904 0.3345365831024103 -0.41389417628481839 0.93819184159728863 -3.5358732082280433 1.9787389310109682 0.56877083077326229 4.1704234170188128 4.7569385477604493 1.4710486050061307 0.71833341373754911 -0.52875157803443584 -0.98034173178484973 0.038005558707503079 0.69629940239077004 -1.9830687239700286 0.56312522238787077 2.3667879903422064 0.30174078056482906 0.35063413890903572 -0.22978728068156795 0.87668522930121795 -0.10232213910387108 1.20974612691614 0.18843477632926114 -0.18054464630873465 1.1770773404782553 0.62634399769521931 -0.63359784528929308 -4.915947414776948 2.5008945162720644 5.6622857607593451 0.61263104987152972 0.61214757370914441 0.57029014734475858 0.82070058164237181 0.83805068708041686 0.1365442977793469 3.2485159321879586 -0.20010295204341211 -0.2104208140245421 0.33654732262557707 0.27644944325671778];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = [0.05714490782958;2.30317514330608;0.663758799806519];
y1_step1.xoffset = [-17.4993719997282;-0.434183220024056;-1.50657136341016];

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
