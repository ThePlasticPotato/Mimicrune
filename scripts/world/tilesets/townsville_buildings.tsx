<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.11" tiledversion="1.11.2" name="townsville_buildings" tilewidth="624" tileheight="464" tilecount="10" columns="0">
 <editorsettings>
  <export target="townsville_buildings.lua" format="lua"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0">
  <image source="../../../assets/sprites/props/diner.png" width="606" height="402"/>
 </tile>
 <tile id="1">
  <image source="../../../assets/sprites/props/townsville_apartment_a.png" width="400" height="400"/>
 </tile>
 <tile id="2">
  <image source="../../../assets/sprites/props/italianfood.png" width="258" height="438"/>
 </tile>
 <tile id="3">
  <image source="../../../assets/sprites/props/fountainbase.png" width="624" height="464"/>
 </tile>
 <tile id="4">
  <image source="../../../assets/sprites/props/buildings/type_a/cap_left.png" width="40" height="370"/>
 </tile>
 <tile id="5">
  <image source="../../../assets/sprites/props/buildings/type_a/cap_right.png" width="40" height="370"/>
 </tile>
 <tile id="6">
  <image source="../../../assets/sprites/props/buildings/type_a/dwg.png" width="280" height="370"/>
 </tile>
 <tile id="7">
  <image source="../../../assets/sprites/props/buildings/type_a/gdg.png" width="280" height="370"/>
 </tile>
 <tile id="8">
  <image source="../../../assets/sprites/props/buildings/type_a/ggd.png" width="280" height="370"/>
 </tile>
 <tile id="9">
  <image source="../../../assets/sprites/props/buildings/type_a/wdw.png" width="280" height="370"/>
 </tile>
 <wangsets>
  <wangset name="Buildings" type="edge" tile="-1">
   <wangcolor name="Type A" color="#ff0000" tile="-1" probability="1"/>
   <wangtile tileid="4" wangid="0,0,1,0,0,0,0,0"/>
   <wangtile tileid="5" wangid="0,0,0,0,0,0,1,0"/>
   <wangtile tileid="6" wangid="0,0,1,0,0,0,1,0"/>
   <wangtile tileid="7" wangid="0,0,1,0,0,0,1,0"/>
   <wangtile tileid="8" wangid="0,0,1,0,0,0,1,0"/>
   <wangtile tileid="9" wangid="0,0,1,0,0,0,1,0"/>
  </wangset>
 </wangsets>
</tileset>
