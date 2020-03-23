%Tab 6, resetting all value to their initial values
function ResetTab6Values(app)

%Figure 1 settings
app.T6EFT1.Value='3';%Point size
app.T6EFT2.Value='0,0,0';%Point color
app.T6EFT3.Value='11';%Font size
app.T6EFT4.Value='1.2';%Font title multiplier
app.T6CB2.Value=false;%show axes
app.T6BG6_Intrinsic.Value=true;%Title type
app.T6CB4.Value=true;%show scale bar
app.T6EFT5.Value='15,15,18';%scale bar position
app.T6EFT6.Value='15';%Scale bar size
app.T6EFT8.Value='12';%Scale bar text font
app.T6EFT7.Value='1.8,2.5,0';%Scale bar text position

%Figure 2 settings
app.T6EFT9.Value='8';%Skeleton-point size
app.T6EFT10.Value='3';%Original-point size
app.T6EFT11.Value='11';%Font size
app.T6EFT12.Value='1.2';%Font title multiplier
app.T6CB5.Value=true;%Show skeleton points
app.T6CB6.Value=false;%Show original points
app.T6CB10.Value=true;%Original points in black color
app.T6CB9.Value=true;%Show scale bar
app.T6CB7.Value=false;%Show axes
app.T6EFT13.Value='15,15,18';%Scale bar position
app.T6EFT14.Value='15';%scale bar size
app.T6EFT15.Value='12';%Scale bar text font
app.T6EFT16.Value='1.8,2.5,0';%Scale bar text position
app.T6BG2_Intrinsic.Value=true;%Title type

%Figure 3 settings
app.T6EFT9_2.Value='8';%Skeleton-point size
app.T6EFT10_2.Value='5';%Original-point size
app.T6EFT11_2.Value='11';%Font size
app.T6EFT12_2.Value='1.2';%Font title multiplier
app.T6CB5_2.Value=false;%
app.T6CB6_2.Value=true;%
app.T6CB10_2.Value=false;%
app.T6CB9_2.Value=true;%
app.T6CB7_2.Value=false;%
app.T6BG3_Intrinsic.Value=true;%
app.T6EFT13_2.Value='15,15,18';%Scale bar position
app.T6EFT14_2.Value='15';%Sclae bar size
app.T6EFT15_2.Value='12';%Scale bar text font
app.T6EFT16_2.Value='1.8,2.5,0';%Scale bar text position

%Make a video
app.T6EF1.Value=1;%From plot#
app.T6EF2.Value=5;%to plot #
app.T6EF3.Value=-8;%Left margin
app.T6EF4.Value=24;%Right margin
app.T6EF5.Value=26;%Top margin
app.T6EF6.Value=-11;%Bottom margin
app.T6EF7.Value=5;%Frame rate
app.T6EF8.Value=100;%Video quality
app.T6EFT26.Value='2';%Number of cycles
app.T6EFT28.Value='0,0,0';%Background color
app.T6BG6_Rotation.Value=true;%Video type
app.T6EFT27Label.Text={'Rotation step';'size (degree)'};
app.T6EFT27.Value='2';%Slice center movement
app.T6DD1_2.Value='x-axis';
app.T6DD1_2.Visible=false;
app.T6DD1_2Label.Visible=false;
app.T6DD2_2.Value='z-axis';
app.T6DD3_2.Value='Azimuth';

%Figure 4 settings
app.T6CB11.Value=true;%Show dislocations
app.T6CB12.Value=true;%Show clusters
app.T6CB13.Value=true;%Show other objects
app.T6EFT17_1.Value='6';%Dislocation point size
app.T6EFT17_2.Value='6';%Cluster point size
app.T6EFT17_3.Value='6';%Other-object point size
app.T6EFT18_1.Value='1,0,0';%Dislocation point color
app.T6EFT18_2.Value='0,0,1';%Cluster point color
app.T6EFT18_3.Value='0,1,0';%Other-object point color
app.T6EFT21.Value='1.2';%Font title multiplier
app.T6EFT20.Value='11';%Font size
app.T6CB15.Value=true;%Show title
app.T6CB14.Value=false;%Show axes
app.T6BG4_Intrinsic.Value=true;%
app.T6CB16.Value=true;%Show scale bar
app.T6EFT22.Value='15,15,18';%Scale bar position
app.T6EFT23.Value='15';%Scale bar size
app.T6EFT24.Value='12';%Sclae bar text font
app.T6EFT25.Value='1.8,2.5,0';%Scale bar text position

%Figure 5 settings
app.T6EFT9_3.Value='8';%Skeleton-point size
app.T6EFT10_3.Value='5';%Original-point size
app.T6EFT11_3.Value='11';%Font size
app.T6EFT12_3.Value='1.2';%Font title multiplier
app.T6CB5_3.Value=false;%Show skeleton points
app.T6CB6_3.Value=true;%Show original points
app.T6CB10_3.Value=false;%Original points in black color
app.T6CB9_3.Value=true;%Show scale bar
app.T6CB7_3.Value=false;%Show axes
app.T6BG5_Intrinsic.Value=true;%Title type
app.T6EFT13_3.Value='15,15,18';%Scale bar position
app.T6EFT14_3.Value='15';%Scale bar size
app.T6EFT15_3.Value='12';%Scale bar text font
app.T6EFT16_3.Value='1.8,2.5,0';%Scale bar text position

end