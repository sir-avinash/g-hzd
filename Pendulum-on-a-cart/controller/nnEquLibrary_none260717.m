function [y1] = nnEquLibrary_none260717(x1)
%NNEQULIBRARY_NONE260717 neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 26-Jul-2017 23:47:36.
% 
% [y1] = nnEquLibrary_none260717(x1) takes these arguments:
%   x = 4xQ matrix, input #1
% and returns:
%   y = 3xQ matrix, output #1
% where Q is the number of samples.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.keep = [1 2 3];
x1_step2.xoffset = [-1.31767408011108;-0.973330746534651;0];
x1_step2.gain = [0.758913008227115;1.02739999076398;2.00501253132832];
x1_step2.ymin = -1;

% Layer 1
b1 = [-0.82300151921392639;-0.15637974888737538;-0.38184592680038321;6.9029082199944591;0.43698350036740147;-2.231180454547308;1.6682318770971558;1.3162408938233561;-0.025241591050208973;0.54989383332899211;-1.2302582599492391;-0.41379486129052134;-0.63389870419923899;-4.2569213482815602;4.1541292022545866;0.49101434360780888;6.5601725083920668;0.31097460436347374;0.23086891387096417;6.6431723765069464;-0.79474305308068183;2.643401288777159;1.1657998390010826;-1.2630765354255302;2.5203349285136851;2.7426988397607026;-0.86821742977719252;1.0082531862648936;0.18115727794612849;10.397587343138296;-10.768343085480044;-0.38880999622645335;-1.4411268154035657;-0.29325977985762963;-0.36518314482368314;0.62356544756524401;-0.96777182990717481;-1.1655390050948349;-1.4396893006250588;1.2389268086444034;7.2213998801433199;0.79592215062131655;0.072369515204916954;0.23043512584943668;3.7242774631157225;0.18555276622814784;-2.6242733731883785;0.066503841251954202;1.1049851180104198;-0.52155761421282776];
IW1_1 = [-0.33772048096189272 -0.34525446526074272 1.1366668541086158;-0.35683220725685666 0.19649464291414009 -0.096519584177747766;-0.40251219891451029 0.15695126799757039 0.85831138029418386;-0.488367316914396 -0.83372211473561886 -6.4733630770049757;-0.33641108288969218 -0.84327682100279666 -1.2125585032720372;0.019292226730640426 0.18180071579582974 -1.437333678718222;-0.1995833413099373 0.36205217014222318 1.2296869018629477;-0.39806958451898283 -0.82004269784833361 -1.8701872915736293;-0.21705572682049526 -0.45479453766728201 -0.28975226213767735;0.23448467589883781 -1.1867043945177385 -0.892469406331862;-0.15675878374126803 -0.32335296007490444 1.7459201643955324;0.2746220785565856 -1.0723271886258257 -0.063316751765029919;-0.25661384299060497 -0.036019816359501418 1.7359047900107523;0.60018104341258438 0.10166831385082191 -2.2978779054601817;-0.18055014519810469 0.30242414211176988 2.9141460153405498;-0.17417146156370861 0.0036029399546587695 0.88883797631424266;-0.19385957640839546 -0.33246901069610302 -7.0124353656137108;0.23038045372147936 0.34470193733345195 -0.90993234770827469;-0.61717049548115499 -0.5822014246446896 -0.97214578493910053;0.10504140023064604 0.17646751990730081 -7.0805953763638003;-0.014768907208016612 -0.71683843497972077 0.23670476754237613;-0.11697122451203196 0.018419258766766908 2.6773487033440531;-0.021214823520304137 -0.18041295395372656 1.1661106864722182;-0.26855579568517707 0.26936766858924277 0.68917345742691405;-0.20661463141001565 -0.018397305323359439 2.0863930823472923;0.12823766527152966 -0.067963249736752634 2.3821975997559468;0.36996691798128739 0.79922581606829135 0.90288685607036456;0.33075547061557964 0.27059459645488715 1.2038309787801997;-0.54866149092617034 -1.0092091467378057 -0.34848067433033636;-0.5067363070216595 -0.87353062606393328 -10.39573775821216;-0.46280931807192721 -0.77767005305333337 10.744553545683397;0.33500258263449578 -1.0956775184107281 0.09653091147722101;0.084588752826968233 -0.084706591755879135 1.893238880614134;-0.69301138593913025 -0.71800856323966267 -0.71172546932701741;0.61211572060654462 0.63281721432588212 1.6672604488564231;-0.40525586120944801 0.15434269218690128 0.64702797202876905;0.37878937573641208 0.27426693173198141 2.0852028150694331;0.603142002547853 0.46045972315068234 -0.094601841646384396;0.11297055398086032 0.44749016380392631 2.0744942943782054;0.43106604001441418 0.58942103972208681 0.71765185415919908;0.45926540450788933 0.76824060694911134 -6.6882461037167564;0.62105281138441437 0.35052015501907569 0.73334483436361642;0.6990929594421218 0.80594078406157998 0.43875506301659328;0.49815504250527537 0.4858430890354315 1.2641063539994679;0.28837531047268805 -0.18546126271609942 2.553385660000608;0.5312600357354692 1.071230920611999 -0.13186403772620464;-0.10903826550917277 -0.10393775084667875 -2.6024938399629707;0.19910025260166705 -0.32566364325710606 0.52387960468700967;0.46646263171042679 1.0628823178755815 -0.48840043012910761;-0.33917961366514732 0.69357199952458515 -0.32847653194977044];

% Layer 2
b2 = [1.1627631472900251;-0.12547112212415473;0.0088890511378198825];
LW2_1 = [-1.0216575863862745 0.92336200375210131 -0.61381837206931356 -9.1432932327328444 0.87935677912942944 1.5390654770559817 0.45818650692438412 2.5811907497829885 0.44622650079637188 -0.066219053264830588 3.9454226218542754 -0.70568922795267464 0.59177085550510611 2.2196346139129774 1.3310812905556413 1.271954054923339 3.794219773234361 -3.5583373017629678 -1.8445370250559352 -3.5620388386549351 1.5327433638760479 1.8620560068033225 3.3752300350826134 -0.93568290937301268 -4.1775531323129282 2.0718274746634218 3.1609512274269425 -3.1539154110763179 -0.55840803131608496 3.2646241568867116 2.8453304497330172 0.59573286953570936 -4.6300492805010256 -0.94801794905582193 -1.1983746134860651 -0.80792650433574731 -0.80475274422681187 0.26631740525676273 2.362238359646994 0.82922167747547171 8.9524264136338925 0.57469025833196907 -0.65987287799586158 -2.4145771639959719 1.0307539360561044 0.57552717169221146 1.8504629321049948 -0.29081551218235613 1.5953276874605558 -0.45586993432851552;0.70987515776008825 0.1272705450331422 -0.11339727360053382 -0.20229275815477607 -0.21689828742243658 -1.2170257201503765 -0.43255238495488502 -1.4758342423288753 0.48209477009464752 -0.07936221865878923 -1.7897703382296886 -0.30618901001155679 -0.60595807916934896 0.11270022664650602 -1.9443014975227149 0.65274664523403769 0.11799674532259258 2.866757289654855 0.88648053814819261 -0.11446315319994711 -0.80631779850833463 -0.035773462067180219 -1.9861214546746842 1.0174721353765064 1.6522655043415573 -0.86843005694077802 -1.2369137116094775 1.2431098152740054 0.12208868331582787 0.01600666908011087 0.10347140539637623 0.26819105037914026 2.9495998938035153 0.40719528891311996 0.79095768200769434 -0.07856531798081326 0.77227432513662608 -0.21467831653238098 -2.074815467051967 -0.28799208418847227 0.43486570929912582 -0.010401863628050253 0.25317864389108102 1.4616832445019345 1.4816651200165729 -0.22853441973004812 -0.0017150227120081227 -0.14594741776216327 -0.81033995066750542 -0.061141676027446176;0.84383231240558987 0.16002071743128882 0.5645331888762033 -3.4087096591401589 0.35443472096405731 1.6957699863212352 0.8644766256407217 0.049971912811700006 -0.038586821621329162 -0.003609624922924284 2.3096708033275442 -0.061589078223639487 -1.3936612008018199 -1.4925323911126811 2.9235815881375053 -4.4070747306643394 1.6106488618141586 -1.1024395044845925 0.73419854331465828 -1.5116965699163891 -0.33853818244121908 -1.7241806136864957 0.11435734111484473 0.73120700253287652 -0.4556000545601171 0.030349653273895504 0.3904653290577289 2.0334697971813513 -0.140651576245022 1.2097960627015747 1.1405217943055628 0.017927569491089573 -1.7499090811875093 0.020060571463529995 0.41728522940096668 0.68172631615257051 0.4093799359831678 -0.87481787358901952 -0.68784868735984439 -0.37236695549809723 3.6339869110073098 -0.6155073008274411 -0.25297691924764149 0.97379610799414651 -3.4295556207875419 0.02006970173148211 -2.3151839671479064 0.68489123813285235 0.016188634820576853 0.17655026068280166];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = [0.118835081737138;3.41972280704531;0.841744123522567];
y1_step1.xoffset = [-8.41502345420179;-0.292421361737215;-1.18800948180684];

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