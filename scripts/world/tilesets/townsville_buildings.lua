return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  name = "townsville_buildings",
  class = "",
  tilewidth = 624,
  tileheight = 464,
  spacing = 0,
  margin = 0,
  columns = 0,
  objectalignment = "unspecified",
  tilerendersize = "tile",
  fillmode = "stretch",
  tileoffset = {
    x = 0,
    y = 0
  },
  grid = {
    orientation = "orthogonal",
    width = 1,
    height = 1
  },
  properties = {},
  wangsets = {
    {
      name = "Buildings",
      class = "",
      tile = -1,
      wangsettype = "edge",
      properties = {},
      colors = {
        {
          color = { 255, 0, 0 },
          name = "Type A",
          class = "",
          probability = 1,
          tile = -1,
          properties = {}
        }
      },
      wangtiles = {
        {
          wangid = { 0, 0, 1, 0, 0, 0, 0, 0 },
          tileid = 4
        },
        {
          wangid = { 0, 0, 0, 0, 0, 0, 1, 0 },
          tileid = 5
        },
        {
          wangid = { 0, 0, 1, 0, 0, 0, 1, 0 },
          tileid = 6
        },
        {
          wangid = { 0, 0, 1, 0, 0, 0, 1, 0 },
          tileid = 7
        },
        {
          wangid = { 0, 0, 1, 0, 0, 0, 1, 0 },
          tileid = 8
        },
        {
          wangid = { 0, 0, 1, 0, 0, 0, 1, 0 },
          tileid = 9
        }
      }
    }
  },
  tilecount = 10,
  tiles = {
    {
      id = 0,
      image = "../../../assets/sprites/props/diner.png",
      width = 606,
      height = 402
    },
    {
      id = 1,
      image = "../../../assets/sprites/props/townsville_apartment_a.png",
      width = 400,
      height = 400
    },
    {
      id = 2,
      image = "../../../assets/sprites/props/italianfood.png",
      width = 258,
      height = 438
    },
    {
      id = 3,
      image = "../../../assets/sprites/props/fountainbase.png",
      width = 624,
      height = 464
    },
    {
      id = 4,
      image = "../../../assets/sprites/props/buildings/type_a/cap_left.png",
      width = 40,
      height = 370
    },
    {
      id = 5,
      image = "../../../assets/sprites/props/buildings/type_a/cap_right.png",
      width = 40,
      height = 370
    },
    {
      id = 6,
      image = "../../../assets/sprites/props/buildings/type_a/dwg.png",
      width = 280,
      height = 370
    },
    {
      id = 7,
      image = "../../../assets/sprites/props/buildings/type_a/gdg.png",
      width = 280,
      height = 370
    },
    {
      id = 8,
      image = "../../../assets/sprites/props/buildings/type_a/ggd.png",
      width = 280,
      height = 370
    },
    {
      id = 9,
      image = "../../../assets/sprites/props/buildings/type_a/wdw.png",
      width = 280,
      height = 370
    }
  }
}
