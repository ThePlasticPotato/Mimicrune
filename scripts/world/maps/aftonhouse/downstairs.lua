return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 36,
  height = 24,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 8,
  nextobjectid = 62,
  properties = {
    ["has_tile_sounds"] = true,
    ["inside"] = true,
    ["light"] = true,
    ["step_sound"] = ""
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
      height = 24,
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
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0,
        1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 1, 1, 1, 16, 16, 16, 16, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0,
        1, 1, 1, 1, 1, 9, 9, 9, 9, 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9, 9, 9, 1, 1, 1, 1, 0,
        1, 1, 9, 9, 1, 9, 9, 9, 9, 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9, 9, 9, 1, 1, 1, 1, 0,
        1, 1, 9, 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0,
        0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0,
        0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 9, 9, 1, 1, 1, 1, 1, 1, 0, 0, 0,
        0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 9, 9, 1, 1, 1, 1, 1, 1, 0, 0, 0,
        0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0,
        0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0,
        0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0,
        0, 0, 0, 1, 1, 1, 10, 10, 10, 1, 10, 10, 1, 1, 16, 16, 16, 16, 16, 16, 16, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0,
        0, 0, 0, 1, 1, 1, 10, 10, 10, 1, 10, 10, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0,
        0, 0, 0, 1, 1, 9, 9, 1, 1, 1, 1, 1, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 1, 1, 1, 1, 10, 10, 10, 1, 1, 1, 1, 0, 0, 0,
        0, 0, 0, 1, 1, 9, 9, 1, 1, 1, 1, 1, 1, 1, 16, 16, 16, 16, 16, 16, 16, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0,
        0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0,
        0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0
      }
    },
    {
      type = "imagelayer",
      image = "../../../../assets/sprites/rooms/aftonhouse_downstairs.png",
      id = 3,
      name = "aftonhouse_downstairs",
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
      id = 6,
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
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 326,
          y = 556.545,
          width = 44.1818,
          height = 245.091,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 218.182,
          y = 508.909,
          width = 41.6364,
          height = 293.273,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 141.818,
          y = 880.182,
          width = 1121.45,
          height = 35.4545,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1110,
          y = 438.364,
          width = 247.818,
          height = 298.121,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1344.07,
          y = 140.481,
          width = 247.818,
          height = 298.121,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 24.3333,
          y = 438,
          width = 899.333,
          height = 300,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "",
          type = "",
          shape = "rectangle",
          x = -2,
          y = -43.3333,
          width = 65.6667,
          height = 417.333,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 62,
          y = -54,
          width = 637,
          height = 53,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 332,
          y = -17.3333,
          width = 1074.67,
          height = 256.667,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "",
          type = "",
          shape = "rectangle",
          x = 978,
          y = 218.75,
          width = 127.75,
          height = 31.375,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "",
          type = "",
          shape = "rectangle",
          x = 620.091,
          y = 221.636,
          width = 57.5455,
          height = 23.9091,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 856.091,
          y = 218.273,
          width = 57.6364,
          height = 27.3636,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "",
          type = "",
          shape = "rectangle",
          x = 561.818,
          y = 230.364,
          width = 30.3636,
          height = 24.5455,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1162.13,
          y = 216.625,
          width = 43.25,
          height = 31,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 430.909,
          y = 705.818,
          width = 34.7273,
          height = 49.0909,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "",
          type = "",
          shape = "rectangle",
          x = 511.091,
          y = 710.545,
          width = 86.7273,
          height = 58.9091,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 27,
          name = "",
          type = "",
          shape = "rectangle",
          x = 626.743,
          y = 732.409,
          width = 136.333,
          height = 37,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "",
          type = "",
          shape = "rectangle",
          x = 803.636,
          y = 707.545,
          width = 86.7273,
          height = 58.9091,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 29,
          name = "",
          type = "",
          shape = "polygon",
          x = 141.5,
          y = 881,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 81, y = -81.5 },
            { x = 79, y = -239 },
            { x = -30, y = -137.5 }
          },
          properties = {}
        },
        {
          id = 30,
          name = "",
          type = "",
          shape = "polygon",
          x = 1111,
          y = 736,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 148.5, y = 149 },
            { x = 145.5, y = -133.5 }
          },
          properties = {}
        },
        {
          id = 31,
          name = "",
          type = "",
          shape = "polygon",
          x = 1344.5,
          y = 384.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -157, y = -155.5 },
            { x = -1, y = -244 }
          },
          properties = {}
        },
        {
          id = 32,
          name = "",
          type = "",
          shape = "polygon",
          x = 333,
          y = 238.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -76.5, y = -75 },
            { x = -76.5, y = -255.5 },
            { x = -1, y = -256.5 }
          },
          properties = {}
        },
        {
          id = 33,
          name = "",
          type = "",
          shape = "polygon",
          x = 64,
          y = 374.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 1.5, y = 10 },
            { x = 50.5, y = 60 },
            { x = 105, y = 65.5 },
            { x = 11.5, y = 80 },
            { x = -31.5, y = 3.5 },
            { x = -14.5, y = -16.5 }
          },
          properties = {}
        },
        {
          id = 40,
          name = "",
          type = "",
          shape = "polygon",
          x = 370.182,
          y = 801.636,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 63.4545, y = -63.6364 },
            { x = 0.181818, y = -63.6364 }
          },
          properties = {}
        },
        {
          id = 61,
          name = "",
          type = "",
          shape = "polygon",
          x = 259.625,
          y = 796.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 28.5, y = -27 },
            { x = 28.625, y = -71.375 },
            { x = -7.75, y = -69.875 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
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
          id = 5,
          name = "entry_stairs",
          type = "",
          shape = "point",
          x = 285.818,
          y = 831.03,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 48,
          name = "entry_kitchen",
          type = "",
          shape = "point",
          x = 160,
          y = 120,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 49,
          name = "entry",
          type = "",
          shape = "point",
          x = 767.333,
          y = 294.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 50,
          name = "entry_office",
          type = "",
          shape = "point",
          x = 1200.67,
          y = 322,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 51,
          name = "entry_garage",
          type = "",
          shape = "point",
          x = 230,
          y = 854.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "objects",
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
          name = "aftonhouse/couch",
          type = "",
          shape = "rectangle",
          x = 554,
          y = 826,
          width = 282,
          height = 54,
          rotation = 0,
          visible = true,
          properties = {
            ["sprite"] = "props/aftonhouse/aftonhouse_upstairs_couch"
          }
        },
        {
          id = 2,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 986,
          y = 124.667,
          width = 112.333,
          height = 125.667,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* It's a closet. Might be the fourth they added..."
          }
        },
        {
          id = 3,
          name = "aftonhouse/door",
          type = "",
          shape = "rectangle",
          x = 1251.33,
          y = 232.667,
          width = 28.6667,
          height = 86.3333,
          rotation = 0,
          visible = true,
          properties = {
            ["lock"] = true,
            ["lock_text"] = "* Dad's office. It's locked.",
            ["target_dir"] = "right",
            ["target_map"] = "aftonhouse/office",
            ["target_marker"] = "entry"
          }
        },
        {
          id = 4,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 280.424,
          y = 737,
          width = 46.1212,
          height = 42.2424,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "down",
            ["map"] = "aftonhouse/upstairs",
            ["marker"] = "entry_stairs",
            ["stairs"] = true
          }
        },
        {
          id = 35,
          name = "interactable",
          type = "",
          shape = "point",
          x = 469.333,
          y = 227.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* It's raining out there."
          }
        },
        {
          id = 36,
          name = "aftonhouse/frontdoor",
          type = "",
          shape = "rectangle",
          x = 703.333,
          y = 132,
          width = 128.667,
          height = 107.333,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 37,
          name = "interactable",
          type = "",
          shape = "point",
          x = 649.333,
          y = 234,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* A fern. You aren't too frond of this one."
          }
        },
        {
          id = 38,
          name = "interactable",
          type = "",
          shape = "point",
          x = 1181.33,
          y = 245.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* A shrub. It's best to leaf it be."
          }
        },
        {
          id = 39,
          name = "interactable",
          type = "",
          shape = "point",
          x = 446.667,
          y = 752.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* A sprout. The thought that one day, this may grow into a boring houseplant...",
            ["text2"] = "* What? Were you expecting more?"
          }
        },
        {
          id = 41,
          name = "interactable",
          type = "",
          shape = "point",
          x = 738,
          y = 742.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* Vidya games."
          }
        },
        {
          id = 42,
          name = "interactable",
          type = "",
          shape = "point",
          x = 645.333,
          y = 742,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* The remote for the TV. It's out of batteries..."
          }
        },
        {
          id = 43,
          name = "interactable",
          type = "",
          shape = "point",
          x = 845.333,
          y = 753.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* Elizabeth's favorite spot.\n* Seems like she forgot her pillow."
          }
        },
        {
          id = 44,
          name = "interactable",
          type = "",
          shape = "point",
          x = 1130.5,
          y = 771.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* A painting. It leaves you at a loss for words..."
          }
        },
        {
          id = 45,
          name = "aftonhouse/door",
          type = "",
          shape = "point",
          x = 182.667,
          y = 844.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["lock"] = true,
            ["lock_text"] = "* This goes to the garage. It's locked.",
            ["target_dir"] = "left",
            ["target_map"] = "aftonhouse/garage",
            ["target_marker"] = "entry_downstairs"
          }
        },
        {
          id = 46,
          name = "interactable",
          type = "",
          shape = "point",
          x = 282.5,
          y = 185.75,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* It's a painting, but sans anything interesting to note."
          }
        },
        {
          id = 47,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 64.2727,
          y = 0.212133,
          width = 192.788,
          height = 42.2424,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "up",
            ["map"] = "aftonhouse/kitchen",
            ["marker"] = "entry_downstairs",
            ["stairs"] = false
          }
        },
        {
          id = 52,
          name = "interactable",
          type = "",
          shape = "point",
          x = 576.667,
          y = 256,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* A coat hanger.\n* It lacks any coats to be hung..."
          }
        },
        {
          id = 60,
          name = "interactable",
          type = "",
          shape = "point",
          x = 885.5,
          y = 231,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["text"] = "* It's raining out there."
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
      name = "objects_above",
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
          id = 59,
          name = "aftonhouse/arch",
          type = "",
          shape = "point",
          x = 924,
          y = 426,
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
