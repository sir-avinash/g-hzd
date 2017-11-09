function [y1] = nnOrbits(x1)
%NNORBITLIBRARY neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 24-Jul-2017 13:56:12.
% 
% [y1] = nnOrbitLibrary(x1) takes these arguments:
%   x = 4xQ matrix, input #1
% and returns:
%   y = 3xQ matrix, output #1
% where Q is the number of samples.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [-3.15540798357829;-2.83028458461259;0;-2];
x1_step1.gain = [0.316916229281382;0.353321360486751;1.02564102564103;0.5];
x1_step1.ymin = -1;

% Layer 1
b1 = [0.25935558232946643;0.4432659917843812;-0.33829477748766684;2.0904344972729336;-3.0075103669640613;0.47241269063592672;-2.4104972793852943;-1.1490001214173082;0.59286929167232671;8.7971827564302281;-1.2381846189197747;-1.8875602848387281;1.3080030870150963;6.6962640313303341;-1.387916311968596;0.51128200550920655;-0.92042063473544544;0.42752266123150073;7.9666068667388368;0.82266666675788769;-3.216488752297225;0.74740389630322102;-1.7245214760996537;7.8860074669867082;-0.79536975939944521;0.3281637080227226;2.1951888015049694;-0.044521416169432157;-8.9677259716600961;1.1730826563933485;2.7379753881494322;-0.75667970316091038;3.0452187730352049;-0.52944533190173548;0.092848848431359737;0.2324216082369514;3.0235407256020244;1.7290322840921721;-0.81109109069239005;-0.6438354095479748;3.2338631880339697;-1.4211529571525405;-0.77388453793099776;-0.29952654329267808;0.021465376040525917;1.3360814660639104;-4.0886422125044293;0.84937912809100102;3.6862021457258405;0.53458158626519392];
IW1_1 = [-0.022910069322871124 0.019956427995652278 -2.2029254161283771 -0.68973531965151569;-0.16476429102354695 -0.35371496523472473 -0.87845194877868338 0.36452573261850935;-0.13575797220528624 -0.2754807149528628 -0.82319175716249393 -0.4433857769866657;-0.049342338916065633 -0.18471938886426553 1.9337882497095491 0.33938682885182825;0.089719165962853675 0.22117832676721427 -3.324119682898186 -0.09068533982932131;-0.10390562997591808 -0.19373977212243931 1.2012222310044181 0.11589923306866445;0.22538458909345915 0.40289057948621504 1.7796591414704599 -0.41031784198823484;0.10414993205018788 0.14477723843716897 1.2044503555189501 0.12541526958906118;0.12327207553224483 0.24946296974140184 1.0816039979029974 0.28247097541029098;-0.078329408255228578 -0.18699467077873819 9.2487734004219 0.048200329963093397;0.021161298783145856 -0.0044248209627991454 1.254824261479246 0.43885885492523091;0.23579201298940222 0.35504232907387101 2.3210836050880639 -0.38827700188480541;0.22047086085913689 0.44115003068283726 -0.96460149466245315 -0.13542269076833743;-0.38502447367700443 -0.57017609235468314 -5.0097558741246617 0.23340369414696491;0.097294029321124256 0.18698763404384847 1.5572251033823021 -0.19489076072175385;0.055517193088363406 0.070469547988338127 -1.6681571410685148 0.58037770813031941;-0.21150282365362127 -0.42506267072222825 1.4650095845647604 0.59083358506615491;0.050284149289888107 0.10249389393554659 1.4181332730714895 0.31872222183117721;0.073160754081247586 0.18115892982195908 8.1539321278629124 -0.061935849699907251;0.018926552405332177 0.019395199618588231 -1.975035997373989 0.79761401026278933;-0.38690119619469487 -0.67005860636653758 2.6843932211226469 0.45342413080258831;-0.034051466899094301 -0.0739708250290739 1.8707671775087049 0.21521719109371504;0.023554825131132044 -0.0046509442041417449 -1.8453576461293113 -0.16737557858264243;-0.071580433180554598 -0.17204481369559008 8.1076146052151916 0.046702545935550954;0.16082252794229118 0.2449492860087987 1.4488857333837435 -0.10631502130033214;-0.033090832584338335 0.047988131051179009 -2.4835923735849601 -0.35346106516617842;0.059705826640195206 0.1436747632986842 1.8920124392666542 0.26574915937843424;-0.1358586896836646 -0.2625502588363785 0.2942177618492493 0.21091493432592845;-0.072318620298327141 -0.1833551255530779 -9.4032659554958187 0.060513694537062512;0.21914660510299294 0.47425201482533003 0.95407752062458251 -0.21575577100870927;0.06847143810746259 0.15595535750326425 2.3254114787831277 -0.24159343576068198;0.017668250174157168 0.035269297028419355 -1.9053904255180045 -0.41379021521301024;-0.10046793309393107 -0.11899358719574475 -2.292494911542458 0.092126586819770304;0.11635744479706425 0.27258288166873429 1.5723395512757874 -0.4551985472841712;0.055528160724205168 0.099359556284844247 -1.3522984159590634 0.31008373330493821;-0.129858199194297 -0.25104670493344311 0.78716546899164552 -0.21925747654342717;0.10859308680336022 0.24286443753621273 2.9512558727315223 0.051800771839352965;0.13865084544862849 0.24798463569734014 -2.017513468612488 -0.16429182852556778;0.02548288261022378 0.023058198302995443 -1.7723954061007017 0.40357498485080207;-0.10233153721393276 -0.19896497375980943 1.4373120103852739 0.26345892385413433;0.10529561902623272 0.23179258937496999 3.4552146586597989 -0.071648967799621266;-0.25008760343799452 -0.53062334597170902 0.39083123805592856 0.069307181662611281;-0.087879243850990121 -0.18291278055444743 0.72096399262721744 0.27968612284122291;-0.096367029047850106 -0.18512652183878781 -0.12864820514143324 -0.15887903736592304;-0.16240157589811788 -0.3676018934277413 -0.83309961689468004 0.22522707114710905;0.18960665208462105 0.35403464060127199 -0.92797538605996233 0.34314508813090805;-0.26048911293902371 -0.43859038750566243 2.8705018169453607 0.064042170888372732;-0.020306249815216941 -0.029585330650450502 1.8063122220155901 -0.24638470957063749;0.32104180406952881 0.53253373247589975 -3.3897990492724661 -0.29282240923147357;-0.085490888482149988 -0.17195074433272484 1.1319236415603557 -0.30096346554888365];

% Layer 2
b2 = [0.26263117560556548;-1.7954645973673491;-0.50332805829337524];
LW2_1 = [-0.30072294634974922 -1.4213493703482627 -0.50545409948880649 -0.38294101491699412 0.22530025630819364 2.7796764110221863 1.6682511761759471 -2.3373668847097933 -0.078086063964121516 2.4299561946470978 1.6548611947382588 0.6024542308062798 4.2373552092307811 -2.8218307317718074 -6.7527480948753338 0.62028998938867952 -0.19586994196681845 -0.99454195038320237 4.981266820924616 -0.33840072964836726 -0.67427375556605251 -3.7594664449476456 0.44049287235162232 -4.4756151556751274 1.1973469708927795 0.29635006955594911 3.2177437796611192 -3.2420452404497397 2.4955362017353804 -0.8914418420909046 -3.0969055631855191 -1.8715279143061774 -0.81753831138803734 -1.0483267517790065 -1.4627379793478557 -2.4110872895212427 -3.0003531273596149 -4.1299969469459166 2.2263756575424876 4.0599234632322512 2.5716806451498444 2.0778748890596264 -3.4281092600133305 2.6952850028806004 1.9436797737233411 0.42620172222911307 -3.5383059080207002 3.852596313006587 -1.5470646818630223 1.8295939747830836;0.14449509515453263 1.1731780985562066 -0.18186680066177957 0.1060820189973696 -0.45518484750149862 1.1390807090082873 -2.0554776964680816 -1.3614980537589829 0.46074260543862422 -0.60770850171180002 -0.35955837956142739 -0.026995283511749943 -2.7179269120769041 0.31434188932162771 4.4130647151469349 -0.30752558843644562 0.051510841636368522 1.1404218323763762 -1.7283182514651005 0.18634470119421728 1.0200850603447029 1.0717642028703429 -0.24981915653937703 1.2466064315050389 0.50655681971491406 0.090984418126086208 -2.6162646299215102 0.81699465722211917 -0.8122126266830707 0.41008610438345927 2.2540285771287336 1.1778519138557508 -1.8990170481567867 0.8915381740222863 0.76957980667883252 -1.0930981019855874 2.3812043000351086 2.5054464891180461 -1.0435647108202466 -2.2132979417298095 -2.1444439978765755 -1.3283490839893743 1.471130754032939 1.3778253708194461 -1.3790549737469997 0.42605810963029483 -2.6418101107311425 -1.8530419689834312 0.42523347928129013 -1.1572811653964428;-0.12139639548739851 1.383406061466238 0.67837943739867912 1.3264713152742367 1.8595090593080512 -0.14345504685404967 0.60179552636280376 2.4911149889471549 3.5763670436722017 -1.9495391908157775 -0.30492667806306845 0.31113509900715247 -1.5868019493016445 -6.2723678159063354 -1.9421019636344423 1.9488620345462662 -0.2732337384733633 -3.4138461801542936 -2.4245468909114209 -0.34384357567990742 -2.9181208867442163 -0.90281966602954644 -1.6765684198288657 2.6789967975197801 -0.90765253442176574 0.24666951721814673 -1.1192723331507946 -0.76129644740211799 -1.6900103692132997 -0.52290056076547231 -1.5706538184216774 -1.2525850179928366 5.8567627064101702 1.879449462149551 -4.8412827923087125 -0.51622282833749455 0.24494221043236114 -1.5502907167318016 -0.70024637647307619 -1.4711447427289843 1.7870477113316077 -0.91171350785921113 2.2970446422229989 3.8315969602173698 -0.24961286465666987 1.6113078744236615 -5.0595902362413607 0.14337433233640792 -3.6338706664818652 -3.4758268441099069];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = [0.0634675943463986;1.92079559261938;0.657408453082692];
y1_step1.xoffset = [-15.7560722176126;-0.520617604414797;-1.52112434105592];

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
