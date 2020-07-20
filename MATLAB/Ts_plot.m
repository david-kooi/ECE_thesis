clear all;
clc;
close all;

self_data = load("self_data.mat").data;
self_t    = self_data.t;
self_j    = self_data.j;
self_Ts   = self_data.Ts_arr;


de_ben_data = load("de_ben_data.mat").data;
de_ben_t    = de_ben_data.t;
de_ben_j    = de_ben_data.j;
de_ben_Ts   = de_ben_data.Ts_arr;
 
standard_data = load("standard_data.mat").data;
stan_t        = standard_data.t;
stan_j        = standard_data.j;
stan_Ts       = standard_data.Ts_arr;


modF{1} = 'w';

modJ{1} = 'r';
modJ{2} = 'Marker';
modJ{3} = '*';


plotHarc(self_t,self_j,self_Ts,[1,self_j(end)], modF, modJ);
hold on;

modF{1} = 'w';

modJ{1} = 'g';
modJ{2} = 'Marker';
modJ{3} = '*';

plotHarc(de_ben_t,de_ben_j,de_ben_Ts, [1,de_ben_j(end)], modF, modJ);
hold on;


modF{1} = 'w';

modJ{1} = 'b';
modJ{2} = 'Marker';
modJ{3} = '*';

plotHarc(stan_t,stan_j,stan_Ts, [1,stan_j(end)], modF, modJ );

