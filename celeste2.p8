pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

#include main.lua
#include gamestate.lua
#include input.lua
#include object.lua
#include objects.lua
#include player.lua
#include px9_decomp.lua

__gfx__
00000000626666660011110001111110011111000011110000000000000000000000000000000022000000006666666600000000422222220000000000000000
00000000626666660111111011144411111111100111111000000000000000000000000000000220000000000311113000000000422222220000000000000000
00700700626666661114441111474471144441101174471100000000000000000000000000002200000000000031130000000000422222220000000000000000
0007700022222222114744710144444017447410714444170000000000000000000000000002200000000077000bb00000000000422222220000000000000000
00077000666662660144444000aaaa000444441007aaaa700eeeeeeeeee00000000000000099400000000777000bb00066666666200000000000000000000000
007007006666626600aaaa000022220000aaaa7000222200e111ee11e111000000770000094447700007777700b11b0000033000400000000000000000000000
000000006666626600222200070000700022220000222200e1ccee7ce7cc00000777770004447770007777770b1111b0000bb000400000000000000000000000
000000002222222200700700000000000000700007700770e1cceeccee77c0007777777044777777777777776666666666666666400000000000000000000000
57777777777777777777777599999999000600000b300b00e1cceeeceeccc0000440000000000000000000000000000000000000000000000000000000022000
77777777777777777777777791111119006660000033b000eeeeeeeeeeee22220444400000000000000000000000000000000000000000000000000000022000
77777777777777777777777791411419000500000288882088888888888897970442240000000000000000000000000000000000000000000000000000024000
77777771177777711777777791441119000500000898888088888888888897970442244000000000000000000000000000000000000000000000000000044000
777777122177771221777777911441190044400008888980eeeeeeeeeeee11110442244400000000077000000000000000000000000000000000000000044000
71777122221111222217771791414419009990000888888020002220002222220444444420000000777700000000000000000000000000000000000000044000
72111222222222222221112791111119004440000289882001610201615551000477744422000000777777000000000000000000000000000000000000044000
72222222222222222222222799999999009990000028820001110001110111007777774422200777777777700000000000000000000000000000000000042000
72222222222222222222222757777775000000000000066622222222222222225555555555555555555555555777777777777777777777750008800056666650
77222222222222222222227777777777000000000007777722222221122222225555555555555550055555557771111177711111777111170081180066666661
77222222222222222222227777777777000000000000066622222211112222225555555555555500005555557777111117771111177711170811118066666661
77722222222222222222277777177177007000700000000022222111111222225555555555555000000555557177711111777111117771178117711866666661
777222222222222222222777772112770070007000000666222211111111222255555555555500000000555571c777ccccc777ccccc777178117711856666651
772222222222222222222277772222770676067600077777222111111111122255555555555000000000055571cc777ccccc777ccccc77770811118055555551
77222222222222222222227777722777067606760000066622111111111111225555555555000000000000557111177711111777111117770081180015555551
72222222222222222222222757777775067606760000000021111111111111125555555550000000000000055777777777777777777777750008800001111110
722222222222222222222227577777777777777777777775211111111111111211111111500000000000000557777775777ccc17777ccc170077770056666650
7222222222222222222222277777777777777777777777772211111111111122111111115500000000000055777711177777cc177777cc170777677066666661
72222722222222222222222777777777777777777777777722211111111112221111111155500000000005557177711771777c1771777c177777777766666661
72222222222222222222222777777771177777711777777722221111111122221111111155550000000055557117771771c7771771c777177777767766666661
772222222222222222272277777777122177771221777777222221111112222211111111555550000005555571cc777771cc777771cc77777767777756666651
777222222277772222222777717771222211112222177717222222111122222211111111555555000055555571ccc77771ccc77771ccc7777777777755555551
777772222777777222277777721112222222222222211127222222211222222211111111555555500555555571cccc7771cccc77711111770777677015555551
577777777777777777777775577777777777777777777775222222222222222211111111555555555555555571cccc1771cccc17577777750077770001111110
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
fff73f7a7ef7408a8281a823c17a88e93419485698f6c18f9fef6d52cac6b6b9fdf7595793e8fffb7b3ad97efff06eaf29becff54e5fffeedfcf0b34f9c64efb
ef1fbcf39ff5f6ff4ff1fcf8bf3ef8f7effd9f1e78f528c1297cf3cffc793fdf36e067c1ff8c3df5278fffb399fdc51ef7597cff7254e93e7afb2fb5d1dcaef7
5b38f56e42fe27c3ff52e80323327ff6cd89b5adff59b077e17c6e9ce9f72f0197c7f285e0ffb88ca9f1ffcc3b7e12557d16ffde7df73d4ef12b9f93202c0381
03f77296a78fdff70bcff10fe1b67b4694ce9ff5cff3eff1ff39f614296eff2f37affb967f4c71fff9c070f48783c7fd11b50236f7df2fb4cf3d6bd2f787c309
a22fefc696693dcf1fbfc394ffdffd8cbc27862e1e8421b11fc1e09361ebef1bde7b5f1f57b43c16619f0cd1b758febd0cf59810ff79ffbc3ff70cfe0540400d
e85651d0478ba43731182a3f3542aeddb2be1e9e57527dae393fad1fed7e3f509bb2b3e4f30748ab07def87e79bc7cb6ef1f487297d1f35d929f1e8172f4f72e
a585f7a7f99cf59f32f7df172f49dee19acb36991935610f88666714e42bfde9030ff50d5efbe7214f0f5445ee31078f1ffcf3ffcc2fb6c54e81e919e622709f
e87424f707c79f6fc7ff2c1af3bc4e0197627193c1eb57fbd1ec21d46c53e8c3906207d68ef4f3f1ba4c170f6efc32ef4efef2bd3997c17cefb341c5b3ef274b
325e1f4fa058c1c59924294ed3c11bc4c14878723e1f3ff85e09f12a2bdc1e1fbefd7c7f8c3bde3e112cfb84e7217f80e06f86812190809c8d6ba14ef63950bc
fd4ad76f3408c5c5c7e7fbc14a997274f7197c90195e1769ba2c1ef709d3e832d4dff0670f074fecff0276642b346bcf6f7d1e59c5ddfbbf3fa4eac61766fb6d
3f5e7a10ffffff0fbe3ff72024b1f02e45541caecb37d5215e21621a6013dd132ab65eb972169ffb1772bf4e6a4cefffb1f346bb61d9362ffff93c77c1fc17d7
bc9efff3f29c37cafab6e2169b1efffc689f12bf3e9f5ea421764efffd688cc52ff87ce0ef79b7e79be717ef4376321bf98c29ecf478c56f70196e79cf49ee12
cbefa73b53fb5b62f7deac62dd21e88be96c99ebffd119429d29de9d21968cbe9fd28763297afded569481f47f784cc27b326f80293e1e794942639b09546b80
29da9a854294e859a72c3911b4e79c067ad6a45298f11dad3e95ff3f90bf8f4c4d84294e51b461584aa58fc52b54ec1e1242f7ef7bcde411ebc27607cfaff68a
f9f0e8e5f3df39a5a9ec2612cd9fbd39ae80e479c7e8c46b4e70e8dfafb72bf3ff70ff70dff509d2f76614cebcbe80679d2f341f5629ffe57df0bf1eff17c9b1
95f73f888c794ef296cdbdfaff4e80f2ff0b42750c5be369ff10e163111919b1b9e995243f78f12ef72bcfefbc31e127cc9dc3be3d479c01ba4e0ff305390b8f
94efa429f3293ff989cfee8ac5e2bf5df5b4c35b333148842fb4ec83e3fb40bfbf9fdf8c22ffe5cf59c47741dd05bf77fef2976fc122753616dd1dc9e8e29cc5
5000fc9e528bc24e0ff79cff3cfd7cff5e7af9f7ec317c8ba98e3cf43b44e9d3d72129f9cea36f7c1f8ef0170ffb932fcff622f7def8d32f872e9dc7e88adff6
e8d2bffdcf5bbeff0f46fff9b710ff094ff9f10e7a369f2ff9fdf70e719aef726f74ef732f3b01ef0888f3f71e8c3eadefb8cff8c393fcc4d19aadf0936f77ef
71ef4abfef83abf7ff735b5df3df1ff71ff78ff18cf99b6ce8cbff843fb8f36224093d31e4bf93b2f3d197e794ef70f3ff41fc8b68bcff40ff07bf7f71d0ffff
ff0ff797eff012f04cdf42b8dce02ce495d21944af09032bdea37dd0f58f2cf81eb0f8cfffb062ce3e769325873702fff756e9d705cf26f7b32cfff719f0ea8c
21f77e3dc92cfff713cb97fb748d8f72678cc7fff774ff8cdfe3278cfecfffb1df52f3cf0f38cf19f324244e5efff70f78eff04fffff362fb8ffffe9f7cfff12
f39cf51dfdef395e7c38f92b7f9383e78df9f5e71fbe8fff738cf73df3ef8b9d57d3f4df1f7ce842cb2f19c171f8bffff35e1b838f1ff2ea0f0778fff3397d76
ff7980e06cfffd7e71efff6b7efff621ef70c36ffff66ffefce73b37bde78cf3efff65eabeecf0ebcde74efff4eefef7f7e5efeddcfff5ee9acef69629fff3b9
cf6ff04406ffff639f9f5e739fffb99de5ef3bf58fff78b567c6375e0ff8fd3cfff144e29cc79fc276efff366e8cfee0fbef15ffdf5bfffb91f7d1cff6278fff
f61f3777cff0c1e9175ef4f3ce88ffff63e6c39bdfd99489dfffda3cd9de1fbd5487825938ffff61e599fe719f322fff7a000000000000000000000000000000
__gff__
0003000000000101010101000000000003030300000001010101010000000001030303030800030301010107070700030303030303030303010101070707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
01030306245342452024510245102451024510245002450030500305002b5002b5002950029500245002450030500305002b5002b5002950029500245002450030500305002b5002b50029500295002450024500
0104020317770187711877018770154001540015400164001740018400194001a4001b4001d4001e4001f4001f4001f4001c40018400164000000000000000000000000000000000000000000000000000000000
010b05080017000160001500014000132001220012200122000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010605081817300154001400013000122001220012200122000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010300002f6702f6302f6202f6202f6102f6102f6102f6102f6152f61500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010400021837020370000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01040002183701f370000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010200000c6200c050110411303130624306150c04000031244502b4513a4503a4502b0241f021320213202329030290402a0512a0502c0512c0500c63400000186531e0501f0411f0401e0311d0211c01100000
010700000c05318653246440061200612000000000000000301532b1402e13035130241342b1242e1143511500673186230c621006150065324620186212461524340246433233131321303112b3110000000000
010b000030830308252b8202b8152982029815248202481530820308152b8202b8152982029815248202481530820308152b8102b8152981029815248102481530820308152b8102b81529810298152481024815
010b0000080400802513045130251a0451a0251f0451f025080400802513045130251a0451a0251f0451f025080400802513045130251a0451a0251f0451f025080400802513045130251a0451a0251f0451f025
010b00000c0400c02513045130251a0451a0251f0451f0250c0400c02513045130251a0451a0251f0451f0250c0400c02513045130251a0451a0251f0451f0250c0400c02513045130251a0451a0251f0451f025
010b00000a0400a02513045130251a0451a0251f0451f0250a0400a02513045130251a0451a0251f0451f0250a0400a02513045130251a0451a0251f0451f0250a0400a02513045130251a0451a0251f0451f025
010b0000060400602513045130251a0451a0251f0451f025060400602513045130251a0451a0251f0451f025070400702513045130251a0451a0251f0451f025070400702513045130251a0451a0251f0451f025
01040000306532405330653306103061018615376003760000654000003065424800248002480000000000003c6140c6312465113065260741a0510e0410205425031190210d03424021180110c014180110c011
010b0000247402473500000000002b7402b73500000000002b7402b73500000000002b7402b73500000240002b9402b7302b7222b7122c740007002e7402e7302e7202e71530750000002e7402e7352c7402c735
010b00002b9402b7302b7302b7222b7122b7122c7402b740297402973029730297202971029712297120000027740277302773027720277122771229740277402674026730267202671226712267120000000000
010c000013033070001f023210213c0112480024800000003e0143d0213c0213a0213b0213a0213901138011370113601135011340113301132011300111f02100614006110c62118631246310c6210061100615
010b0000247402473024722247152b7402b73500000000002b7402b73500000000002b7402b73500000000002b7402b7302b7222b7152c740000002e9402e7302e7422e73530740307352e7402e7352c7402c735
010b0000090400902513040130251a0401a0251f0401f0250804008025120401202519040190251e0401e0250704007025110401102518040180251d0401d0250604006025140401402518040180251d0401d025
010b00002b9402b7302b7302b7222b7122b7122c7402b7302974029730297302972229712297122b7402973027740277302772027722277122771229740277302674026730267302672226712267122671026710
010b000014b5014a2014a2014a5014a2014a2014a5014a2014a5014a2014a2014a5014a2014a2014b5020a2014b5014a2014a2014a5014a2014a2014a5014a2014a5014a2014a2014a5014a2014a2016a5016a20
010b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000018c0018c000000024a3018a21
010b000018b5018a2018a2018a5018a2018a2018a5018a2018a5018a2018a2018a5018a2018a2018b5024a2018b5018a2018a2018a5018a2018a2018a5018a2018a5018a2018a2018a5018a2018a201aa5018a20
010b000016b5016a2016a2016a5016a2016a2016a5016a2016a5016a2016a2016a5016a2016a2016b5022a2016b5016a2016a2016a5016a2016a2016a5016a2016a5016a2016a2016a5016a2016a2018a5016a20
010b000012b5012a2012a2012a5012a2012a2012a5012a2012b5012a2012a2012a5012a2012a201ea501ea2007b50000000000000000000000000007b50000000000000000000000000018c4018c1024a3018a21
010b000014b5014a2014a2014a5014a2014a2014a5014a2014c4014c1014a2014a5014a2014a2014b5020a2014b5014a2014a2014a5014a2014a2014a5014a2014c4014c1014a2014a5014a2014a2016a5016a20
010b000018b5018a2018a2018a5018a2018a2018a5018a2018c4018c1018a2018a5018a2018a2018b5024a2018b5018a2018a2018a5018a2018a2018a5018a2018c4018c1018a2018a5018a2018a201ac3018a20
010b000016b5016a2016a2016a5016a2016a2016a5016a2016c4016c1016a2016a5016a2016a2016b5022a2016b5016a2016a2016a5016a2016a2016a5016a2016c4016c1016a2016a5016a2016a2018a5016a20
010b00000000030810308152b8102b8152981029815248102481530810308152b8102b8152981029815248102481530810308152b8102b8152981029815248102481530810308152b8102b815298102981524810
010b000022130221202211222112291302912500000000002912029115000000000029110291150000000000291302912527135001002912500100291302b1302b1202b112291302912527135001002612500000
010b0000241302412024112241122b1302b12500100001002b1202b11500100001002b1102b11500100001002b1302b12529135001002b125001002b1302c1302c1202c1122b1302b12529135001002712500000
010b0000050400502513045130251a0451a0251f0451f025050400502513045130251a0451a0251f0451f025050400502513045130251a0451a0251f0451f025050400502513045130251a0451a0251f0451f025
010b000011b5011a2011a2011a5011a2011a2011a5011a2011c4011c1011a2011a5011a2011a2011b501da2011b5011a2011a2011a5011a2011a2011a5011a2011c4011c1011a2011a5011a2011a2011a5013a20
010b000026130261202611226112291302912500000000002912029115000000000029110291150000000000291302912527135001002912500100291302b1302b1202b112291302912527135001002612500000
010b0000241302412024112241122b1302b12500100001002b1202b11500100001002b1102b11500100001002b1102b11529100001002b1102b1152b1002c1002b1102b1152b1002b1002b1102c1112e7212f731
010b00000b0400b02513045130251a0451a0251f0451f0250b0400b02513045130251a0451a0251f0451f0252b0242b01500000000002b0242b01500000000002b0342b02500000000002b0442b0352b00000000
010b000017b5017a2017a2017a5017a2017a2017a5017a2017c4017c1017a2017a5017a2017a2017b5023a2013b5013a4013a4213a3207a2107a1207a1207a120000000000000000000018b5018a4016b5016a40
010b0000307503074500000000003075030745000000000030750307450000000000307503074030732307253275032740327323272533755000003295032740327323272530750000002e7502e7453074500000
010b00003275032745000000000032740327350000000000327403273032722327153375033745357303572533950337403373033722337123371532950327303273232742337503274030750307403073230725
010b00002c7502c7402c7322c7322c7222c7222e7502e7402e7322e7222e7122e715307503074030732307422f7502f7402f7322f7322f7222f72230750307403073230722307123071532750327403273232725
010b00002a7502b7412b7402b7302b7322b7222b7222b7122b7122b7122b7122b715297402b7302c7302b7502b7402b7402b7322b7222b7122b7122b7150000000000000000000000000297002b7002c7002b700
010b00002f7502f7402f7402f7322f7322f7423075030740307403073230732307423275032740327323273533750337403373033722337123371235750337403275032740327303272232722327123271232715
010b0000083550000013d200000013d1000000083550000013d200000013d1000000083550000013d20000000a3550000013e200000013e10000000a3550000013e200000013e10000000a3550000013e2000000
010b00000b3550000013e200000013e10000000b3550000013e200000013e10000000b3550000013e20000000c340133251b3150c340133251b3150a340133251b3150a340133251b3150a340133201b3121b315
010b0000083550000013d200000013d1000000083550000013d200000013d1000000083550000013d2000000073550000013e2000e0013e1000000073550000013e200000013e1000000073550000013e2000000
010b0000063550000013e200000013e1000000063550000013e200000013e1000000063550000013e2000000073550000013e2000e0013e1000000073550000013e200000013e1000000073550000013e2000000
010b000014b5014a4014a3014a5014c4014a4014b4014a3014b5014a5014a4014a3014c4014a3020a350000016b5016a500000016b5016c400000016b5016a4016a3016a2216a2216a1216c4016a5016b5022a40
010b000017b5017a4017a3017a5017c4017a4017b4017a3017b5017a5017a4017a3013c4013a301fa350000018b5018a500000018b5018c400000016b5016a4016a3016a2216a2216a1216c4016a5018b5022a40
010b000014b5014a4014a3014a5014c4014a4014b4014a3014b5014a5014a4014a3014c4014a3020a350000013b5013a500000013b5013c400000013b5013a4013a3013a2213a2213a1213c4013a5013b501fa40
010b000012b501ea4012a3012a5012c4012a4012b4012a3012b5012a501ea4012a3012c4012a3012a350000013b501fa50000001fb5013c400000013b501fa401fa301fa221fa221fa1213c401fa5013b502ba40
010200002b0241f021320213202300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 091d4344
00 091d1656
01 090a1555
00 090b1757
00 090c1858
00 090d194e
00 1a0a0f51
00 1b0b1057
00 1c0c1258
00 16131444
00 21201e44
00 1b0b1f44
00 1c0c2244
00 25242344
00 2f2b2644
00 302c2744
00 312d2844
00 322e2944
00 2f2b2644
00 302c2744
00 312d2844
02 322e2a44
00 091d4344
00 091d4344
01 090a4344
00 090b4344
00 090c4344
00 090d4e44
00 090a0f44
00 090b1044
00 090c1244
00 41131444
00 09201d44
00 090b1d44
00 090c1d44
02 090d1d44

