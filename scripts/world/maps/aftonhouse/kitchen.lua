return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 36,
  height = 26,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 9,
  nextobjectid = 78,
  properties = {
    ["has_tile_sounds"] = true,
    ["inside"] = true,
    ["light"] = true,
    ["node_size"] = 40,
    ["step_sound"] = "board"
  },
  tilesets = {
    {
      name = "debug",
      firstgid = 1,
      filename = "../../tilesets/debug.tsx",
      exportfilename = "../../tilesets/debug.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 36,
      height = 26,
      id = 1,
      name = "stepsounds",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 11, 11, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 10, 9, 0, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 0, 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 10, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0, 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 16, 16, 16, 16, 16, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 16, 16, 16, 16, 16, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 16, 16, 16, 16, 16, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0,
        0, 0, 0, 0, 10, 0, 0, 16, 16, 16, 16, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0,
        0, 0, 0, 0, 10, 0, 0, 16, 16, 16, 16, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 10, 0, 0, 0, 0, 16, 16, 16, 0, 10, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "imagelayer",
      image = "../../../../assets/sprites/rooms/aftonhouse_kitchen.png",
      id = 2,
      name = "aftonhouse_kitchen",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = false,
      repeaty = false,
      properties = {}
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "collision",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 37,
          name = "",
          type = "",
          shape = "polygon",
          x = 280,
          y = 646,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = -3.27273, y = 12.3636 },
            { x = 93.6364, y = 94.9091 },
            { x = 100, y = 114 },
            { x = 50, y = 134 },
            { x = 30, y = 124 },
            { x = -45.25, y = 53.25 },
            { x = -45, y = 27 },
            { x = -32.5, y = 11.25 }
          },
          properties = {}
        },
        {
          id = 38,
          name = "",
          type = "",
          shape = "rectangle",
          x = 220.125,
          y = 537.375,
          width = 71.75,
          height = 71,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 39,
          name = "",
          type = "",
          shape = "rectangle",
          x = -69.3333,
          y = 808,
          width = 613.333,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 40,
          name = "",
          type = "",
          shape = "rectangle",
          x = 736,
          y = 808,
          width = 714.667,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 41,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 154,
          height = 840,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 42,
          name = "",
          type = "",
          shape = "rectangle",
          x = -178.4,
          y = -38,
          width = 1876.8,
          height = 276,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 43,
          name = "",
          type = "",
          shape = "rectangle",
          x = 375.667,
          y = 170,
          width = 579.917,
          height = 84,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 50,
          name = "",
          type = "",
          shape = "rectangle",
          x = 368,
          y = 380.333,
          width = 312,
          height = 19.9167,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 51,
          name = "",
          type = "",
          shape = "rectangle",
          x = 794,
          y = 381.333,
          width = 86,
          height = 18.9167,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 52,
          name = "",
          type = "",
          shape = "rectangle",
          x = 929.688,
          y = 184.75,
          width = 42.3125,
          height = 111.5,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 54,
          name = "",
          type = "",
          shape = "polygon",
          x = 880,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 20, y = 0 },
            { x = 90, y = -70 },
            { x = 89.8849, y = -86.1389 },
            { x = 91.7941, y = -86.1822 },
            { x = 91.9318, y = -108 },
            { x = 50.0227, y = -103.386 },
            { x = -0.181818, y = -18.6591 }
          },
          properties = {}
        },
        {
          id = 55,
          name = "",
          type = "",
          shape = "polygon",
          x = 320,
          y = 210,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -180, y = 180 },
            { x = -180, y = -10 }
          },
          properties = {}
        },
        {
          id = 56,
          name = "",
          type = "",
          shape = "polygon",
          x = 150,
          y = 700,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 70, y = 70 },
            { x = 180, y = 120 },
            { x = 0, y = 110 }
          },
          properties = {}
        },
        {
          id = 58,
          name = "",
          type = "",
          shape = "polygon",
          x = 1230,
          y = 810,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 100, y = -100 },
            { x = 100, y = -290 },
            { x = 50, y = -340 },
            { x = 10, y = -380 },
            { x = -50, y = -500 },
            { x = -130, y = -580 },
            { x = 65.3333, y = -593.667 },
            { x = 188, y = -378.333 },
            { x = 191, y = 7.33333 }
          },
          properties = {}
        },
        {
          id = 60,
          name = "",
          type = "",
          shape = "polygon",
          x = 310,
          y = 600,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 20, y = 30 },
            { x = 60, y = 30 },
            { x = 100, y = 30 },
            { x = 121.875, y = 0.125 },
            { x = 80, y = -20 },
            { x = 40, y = -20 }
          },
          properties = {}
        },
        {
          id = 61,
          name = "",
          type = "",
          shape = "rectangle",
          x = 898.091,
          y = 580,
          width = 314.159,
          height = 105.273,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 75,
          name = "",
          type = "",
          shape = "rectangle",
          x = 374.667,
          y = 773,
          width = 18.6667,
          height = 17.3333,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 76,
          name = "",
          type = "",
          shape = "rectangle",
          x = 231,
          y = 622.333,
          width = 20.3333,
          height = 20.3333,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 77,
          name = "",
          type = "",
          shape = "rectangle",
          x = 174.667,
          y = 349.333,
          width = 20,
          height = 37,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "objects_lower",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 25,
          name = "aftonhouse/chair",
          type = "",
          shape = "point",
          x = 976,
          y = 570,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "down"
          }
        },
        {
          id = 26,
          name = "aftonhouse/chair",
          type = "",
          shape = "point",
          x = 1056,
          y = 570,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "down"
          }
        },
        {
          id = 27,
          name = "aftonhouse/chair",
          type = "",
          shape = "point",
          x = 1136,
          y = 570,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "down"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "objects_party",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 2,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 1000,
          width = 240,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "down",
            ["map"] = "aftonhouse/downstairs",
            ["marker"] = "entry_kitchen",
            ["stairs"] = false
          }
        },
        {
          id = 3,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 840,
          width = 240,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "aftonhouse.afton_intro",
            ["once"] = true,
            ["set_flag"] = "breakfast_scene_incomplete"
          }
        },
        {
          id = 4,
          name = "sprite",
          type = "",
          shape = "point",
          x = 160,
          y = 330,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["texture"] = "props/aftonhouse/aftonhouse_kitchen_leg_pot"
          }
        },
        {
          id = 5,
          name = "sprite",
          type = "",
          shape = "point",
          x = 540,
          y = 68,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["texture"] = "props/aftonhouse/aftonhouse_kitchen_window_pot"
          }
        },
        {
          id = 6,
          name = "sprite",
          type = "",
          shape = "point",
          x = 674,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["texture"] = "props/aftonhouse/aftonhouse_kitchen_cabinet"
          }
        },
        {
          id = 7,
          name = "sprite",
          type = "",
          shape = "point",
          x = 368,
          y = 342,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["texture"] = "props/aftonhouse/aftonhouse_kitchen_counter_1"
          }
        },
        {
          id = 8,
          name = "sprite",
          type = "",
          shape = "point",
          x = 794,
          y = 294,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["texture"] = "props/aftonhouse/aftonhouse_kitchen_counter_2"
          }
        },
        {
          id = 9,
          name = "sprite",
          type = "",
          shape = "point",
          x = 412,
          y = 348,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["texture"] = "props/aftonhouse/aftonhouse_kitchen_chips"
          }
        },
        {
          id = 10,
          name = "sprite",
          type = "",
          shape = "point",
          x = 898,
          y = 570,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["texture"] = "props/aftonhouse/aftonhouse_kitchen_table"
          }
        },
        {
          id = 11,
          name = "sprite",
          type = "",
          shape = "point",
          x = 1216,
          y = 422,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["texture"] = "props/aftonhouse/aftonhouse_kitchen_stache_pot"
          }
        },
        {
          id = 12,
          name = "sprite",
          type = "",
          shape = "point",
          x = 218,
          y = 616,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["texture"] = "props/aftonhouse/aftonhouse_kitchen_what_pot"
          }
        },
        {
          id = 13,
          name = "sprite",
          type = "",
          shape = "point",
          x = 358,
          y = 758,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["texture"] = "props/aftonhouse/aftonhouse_kitchen_violet_pot"
          }
        },
        {
          id = 14,
          name = "sprite",
          type = "",
          shape = "point",
          x = 310,
          y = 570,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["texture"] = "props/aftonhouse/aftonhouse_kitchen_coffeetable"
          }
        },
        {
          id = 16,
          name = "sprite",
          type = "",
          shape = "point",
          x = 214,
          y = 522,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["texture"] = "props/aftonhouse/aftonhouse_kitchen_couch_2"
          }
        },
        {
          id = 17,
          name = "sprite",
          type = "",
          shape = "point",
          x = 234,
          y = 636,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["texture"] = "props/aftonhouse/aftonhouse_kitchen_couch_1"
          }
        },
        {
          id = 28,
          name = "interactable",
          type = "",
          shape = "point",
          x = 410,
          y = 610,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* The latest edition of \"Friend Inside Weekly\"."
          }
        },
        {
          id = 29,
          name = "interactable",
          type = "",
          shape = "point",
          x = 350.667,
          y = 608.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* It's a cup o' joe. Who IS this joe, anyways...?"
          }
        },
        {
          id = 44,
          name = "interactable",
          type = "",
          shape = "point",
          x = 185.5,
          y = 377.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* It can try to decieve you with its stance, but you are not fooled...",
            ["text2"] = "* That is a normal plant pot with white plastic legs strapped on."
          }
        },
        {
          id = 45,
          name = "interactable",
          type = "",
          shape = "point",
          x = 428,
          y = 370.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* A bag of chips. A quick snack to make you feel chipper."
          }
        },
        {
          id = 46,
          name = "interactable",
          type = "",
          shape = "point",
          x = 330,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* A fridge. It's stocked full of food..."
          }
        },
        {
          id = 47,
          name = "interactable",
          type = "",
          shape = "point",
          x = 480,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "aftonhouse.sinkven"
          }
        },
        {
          id = 49,
          name = "interactable",
          type = "",
          shape = "point",
          x = 880,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* An oven. Not to be confused with an of out the hot food in out the..."
          }
        },
        {
          id = 59,
          name = "interactable",
          type = "",
          shape = "point",
          x = 1038,
          y = 239.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* The pantry's secrets are not for you to behold."
          }
        },
        {
          id = 68,
          name = "aftonhouse/chair",
          type = "",
          shape = "point",
          x = 976,
          y = 722,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "up",
            ["update_layer"] = false
          }
        },
        {
          id = 69,
          name = "aftonhouse/chair",
          type = "",
          shape = "point",
          x = 1056,
          y = 722,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "up",
            ["update_layer"] = false
          }
        },
        {
          id = 70,
          name = "aftonhouse/chair",
          type = "",
          shape = "point",
          x = 1136,
          y = 722,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "up",
            ["update_layer"] = false
          }
        },
        {
          id = 72,
          name = "interactable",
          type = "",
          shape = "point",
          x = 383,
          y = 787.25,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* A violet. The Afton's signature color."
          }
        },
        {
          id = 73,
          name = "interactable",
          type = "",
          shape = "point",
          x = 242,
          y = 636.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* What in the ANGEL's name is that supposed to be."
          }
        },
        {
          id = 74,
          name = "interactable",
          type = "",
          shape = "point",
          x = 1243.75,
          y = 449.75,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* A plant. It reminds you of the plumber your dad hired last week..."
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
      name = "objects_upper",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
      name = "markers",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 1,
          name = "entry_downstairs",
          type = "",
          shape = "point",
          x = 640,
          y = 960,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
