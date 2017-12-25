clc; clear all; close all;
ls=      [10; 15; 20; 25; 30; 40; 50; 60; 70; 80; 85; 90; 95;100];
CBF_gait=[80; 92; 99;100;100;100;100;100;100;100;100; 99; 92; 80];
CBF_ls56=[ 0;  0;  3;  6; 12; 38; 99; 99; 38; 12;  6;  3;  0;  0];
gait    =[ 0;  1;  1;  1;  1;  1;  6;  6;  1;  1;  1;  1;  1;  0];

figure;
plot(ls,gait,'g-*',ls,CBF_ls56,'b-o',ls,CBF_gait,'r-s');
xlabel('Step length (m)');
ylabel(['Percentage of successful tests']);
h=legend('Gait Library','CBF','CBF & Gait Library');
set(h,'Location','northoutside','Orientation','horizontal')
axis tight;
savename='multiple_tests';

pos=[0 0 9.69/2 2.5];
set(gcf, 'PaperPosition', pos); 
set(gcf, 'PaperSize', pos(3:4));
saveas(gcf, savename, 'pdf')