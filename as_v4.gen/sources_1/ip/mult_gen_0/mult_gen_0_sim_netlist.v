// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Wed Dec 24 23:23:31 2025
// Host        : LAPTOP-RU9TJ31G running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/vivado_project/as_v4/as_v4.gen/sources_1/ip/mult_gen_0/mult_gen_0_sim_netlist.v
// Design      : mult_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult_gen_0,mult_gen_v12_0_23,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_23,Vivado 2025.1" *) 
(* NotValidForBitStream *)
module mult_gen_0
   (CLK,
    A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_mode = "slave clk_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_mode = "slave a_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_mode = "slave b_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_mode = "master p_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [31:0]P;

  wire [15:0]A;
  wire [15:0]B;
  wire CLK;
  wire [31:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [47:0]NLW_U0_PCASC_EXT_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "16" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "2" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "31" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  mult_gen_0_mult_gen_v12_0_23 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .PCASC_EXT(NLW_U0_PCASC_EXT_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2025.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
a8oy5VKhI9r6ZPDsrDu70hiHV6+ii4ww2JaV5MUqlt96iDVy6O5zHUCC5McNgSuoSwwCPdCh3NfR
NZtBCQSLG0WwcosxcrJiFr1T2gfnuZ9DZ8tsCPFlUYSkK9TqrpuhK1VynSR2mJDUl5kbI+XeznL9
/CbZbbtSog8A2vpipn8=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
o311wzstkCi2Xm0gL322QWGmUhRTX44GhP9CVjsruJH5GZBvfa3cm86OmVjiGEpHioogBxsR0NDd
XR9RNFQCg7MrCcuUCqcDwg3nc06Zvy69ApHslAaAJfq3je7ho9JqFhs1hHvtjlbaglmDuWWFWGQc
Bgysjzhh3ru5Ii7iHoGjO0IlMu9zs+L/elCRBBBn1w0+QTXbhYQ46WB9RyOj/PGV0imZWjRTabjV
fhxz4+rcJEAXvKASzSR0NIh+s0wrMWXaFVAQI3k1kuIp+s8OlrsfDAMBLTI/Cq9tgDOVZU8mMZTO
iWoFmmk8pGf1aV+oDOp+FzQGxy+Qcq6K0Bj61A==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
YJ83ZUBaPDw2/wturr4+wRIqi4laFrwEhGoGQ5BRbuqYVi2X6+ISa2PNsgxB3ARgzDg8nfQNPtTM
PxT2Tg54UyByzAtZtMXN0v5YjxO/vjUFuk5fcskLYRi1zY2CvQYEJAaqfZndV/hvS52LyaMEfkFC
qkLPntD4nsxuEOWR60U=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bf70+ZpglOMDV70X+xuN4nRPXfVUkSD67DJnuxYBU6BsEPWcIsKXYgb9RI/ipBHJIcS5yMR5ay4y
ZGUkpXF+VPjaNXTMFQtZ1K5mRMAV+JArWtTEriEcaLERTsJDeyd1Z4zDdjYpzxG6Z/Zz/ztR6NaS
DXPNkKDCuWXgoJuaTg85GgRlSZApN/Vz7Nv1VpBlKW8RaeWWPsl6V/rBQd0p3r8ABmazkNszJyh/
a/Su2bs7i+4OC4ukaxri7kHCPF84cPWArUBZQMvbfhPrio7YX4Dez8ldc4zmFSAwboVFno/moixD
/ffMy9k08hZ5r0inf4IqvyUqwJCF9Becd6RX7g==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
t0Ly2SOPXG6TCNJmq3H1TpmFnVRhv9HxO3kBWy9oUObB5mmxIMwH4PVecLk2fGShC4taYGDp/0aY
0si1i/ejKKGrqyyGb/N6vx1JLs41Bu7iCTta1xo+4dbj/F2PireXic+68Jto7/kB5nZuUUbPr+t1
XUmV4vv6ttLMYChOaIau7ny0aK2gEX5WVUPZ16h17dlWdlRPDvH+mgudXa6P8dmQnJxg31t6wIjC
zSzt7OAwLFjEUTLsI1YB1ruB9BhEm0/OF/srCIQRKr1tQ/WOFTsRZEf6dblVTmJHun0E1Z1Vh+cF
2Up7FSrGzExIyH2zWQJovu4NqQpUZ5Vjf9Fjqw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2025.1-2029.x", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
hJSML2FqcV98cUylkT1L5mHMuOLICQ4g+hlj2HavieYMseOK/g7SxNWmH7qEphzStwrOZQFMzDtD
1Vj1aF0JKpb4PBKJJzHZno9WZDpafcG5qIrY28RJ+CR8mZXTbgQVr2MxRUw7gbya4Hp6xeZAdEnq
6fFaKMN9dWeYzikVZe+5yRYREhZz9d8qnsnvvnvQHkeJETtLiM6B4Sr0hgsHS8c9+Aa7ia2UmIhh
zBvRSlghkTCQ5cJLnL8xgPU6BPDNj9ZjMUofD1+hKfZfIaKZrWraiXgKs9SjrJAfs+GEIY9yXPoD
WVQVvdkFdjNY66o/EOnV7dqw6ONHGFRgE2/DTA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
LYickIpiuxmseA8hr32NIz+PQH5YL3u7uoihU3kCjGsvwbbVRibk3qUmfOq9SbEshOFLrK5X0BTq
8GfHccDg1r/f3v2KGiQuvPe2+ATRd7TaeIr0e/tveJAg6wBQ5MMLCYc0cZ0iux1JaECuVSbCj0bd
pZxf8m1J/Bcgco+JI3qHNqh0uRXRY6K3uyDmOIL2cpgPbx191SyuIKtL9L3ray4QFZfxPmHYJWSj
BZPwXShcJFZX29uWHQFhfzvxV2bqiS0Nz4zhd2ABCLFr2iQ5ZhbpmzpNVMPrA8V1idxVj0eEmgpq
PorgSpLZ/EmMRvNPhUhTla7L8gkjJn8CQJ+NEw==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
fAQn311nBu08DuuB0R4ieuk9vtdguq7CpXeo0sHmor7YAb3d1vkwMpX+W9baRf19NFZZ7e1SAP1F
fTmg3llJ2sBIV6fyHdZ+hSOU4b0ZFJQWKlOSIAJtqJAGSLmmMXWkAoMKMaaUvXp2GF6wsgiWkjl1
JNAnVYRBQ8AHqRW6PrnluqSpRtTejfk/sB+RZukTSfKQltkUKOb0022ozakCkpGSeEUd3hnycn9q
ThFWMHNg/eW1lHKgfXIVBIujW6b7LN1+g9UMt0VZ2fPXl3AYmeJ1HOHU0W7sXDxYQMAQQNKzjExn
3sIWEqqopjcUfDNIvU30CG3dLKU+N3FHqB7RlxbhCZL1ezwKR9dz51hLS6rYQgRkgJhrgSbvfuJ4
UVN77y+HZA6DSo1GSnNJAR1nbioPV9OQ9bcgYhPW6VywV9ol9pdoa4gyoiVBScD2I/eiM6CB3I+8
wDaR5NT2PbMvxoco4gWfY0YlwoAXHCVrIW6pnXb+5TOex4mxMUQ0x/en

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
IEjnv73YQXRAkCIEYUr9W/mAjZNVmIpdev/N/sb1oZY2hb/ju2aA2Z20+M+pkJl+6nOQbGe1MYuz
zxVqt33HW4VglAaDUONi3dVlB8u02Hsxvnh5/OHQcEFY9x/e5ztwxK1eRXZPm/d+0zVyJ6gwoMoE
06tLSQsLFc6lLMYdT8GLPcx12l+fRnCavi4TdwVXmRz9JXNyxkRl4etYfDiQ6b/xjYRs7Pt2thIv
5aToHduM1mSg3cyHnHLWsqaAsHsWdGnunKoMwG+3GkevK+9ja7sQp29foyEKH1c/9PuZYtaWE5bi
LlP8eh0QsevIeaAiRzyZ9OP/MoUkwRABhD+xMg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UD8GrSfmICSJ1lNXY+pPzOHUnx3TQOAxMB9U29uGc6H9NB5gnp8cO29pHZK74mATlCW0nJQarmiX
S3isy2zGtfy59l9GotJHsnwYJV6lmXKLw5K/RuvPlgIDlmh+Nlv8d91OmOQCBKKZTqH9004P7eVX
DVx/GN7xQPkrPBH61QqH9NLrj83xdr8+7AVHNAx40vRqNTCoKIp3dNX7WLu/2dPPi6c/WhMo22lv
efTeM4tFElsgjIFjIibSY4uF6wFamWljzCEL6UVWyMPwldGELitCYgZeHKFDjxC9TvBhzfE1q5Eq
glo/0KlCLsigiPyAhTCiKvxftfz+CksVkaeZfQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
h96XoyciCvz7a4XWTvv+YGkr0w4RAzd7A+zidHXAmAT4WKxC2cAmwZ3sK6PcDssPJK4TM5ccz16y
mP0si6/vfKq9brstNhibi9bAU7g/fpqrUdd5IWtcP85S1fWwjqpKNsNvlD/1yga395E0JGtTomHu
/SAgmnZLgp/AifzqmbO6RDMIT1wDJFWJY7gidPkT/jCiit2g4Orf+XBF1yysQUBlolMhA5ug1uMw
yhUnPqnaH0DrOX0sJh2AuzdB7FRRKTz0Ow0SwQn9sgRXNJlGEclyyut7Qlu3cuOxwKy+bP4i6DFV
t9yU8XYvX7EbKAA+xgspCIwc3jhQ5DnWQeaFPQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 5728)
`pragma protect data_block
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
5FLC/zow4huk7UU//ODcLOdP+L71YTLtBoqlOg==
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2025.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
a8oy5VKhI9r6ZPDsrDu70hiHV6+ii4ww2JaV5MUqlt96iDVy6O5zHUCC5McNgSuoSwwCPdCh3NfR
NZtBCQSLG0WwcosxcrJiFr1T2gfnuZ9DZ8tsCPFlUYSkK9TqrpuhK1VynSR2mJDUl5kbI+XeznL9
/CbZbbtSog8A2vpipn8=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
o311wzstkCi2Xm0gL322QWGmUhRTX44GhP9CVjsruJH5GZBvfa3cm86OmVjiGEpHioogBxsR0NDd
XR9RNFQCg7MrCcuUCqcDwg3nc06Zvy69ApHslAaAJfq3je7ho9JqFhs1hHvtjlbaglmDuWWFWGQc
Bgysjzhh3ru5Ii7iHoGjO0IlMu9zs+L/elCRBBBn1w0+QTXbhYQ46WB9RyOj/PGV0imZWjRTabjV
fhxz4+rcJEAXvKASzSR0NIh+s0wrMWXaFVAQI3k1kuIp+s8OlrsfDAMBLTI/Cq9tgDOVZU8mMZTO
iWoFmmk8pGf1aV+oDOp+FzQGxy+Qcq6K0Bj61A==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
YJ83ZUBaPDw2/wturr4+wRIqi4laFrwEhGoGQ5BRbuqYVi2X6+ISa2PNsgxB3ARgzDg8nfQNPtTM
PxT2Tg54UyByzAtZtMXN0v5YjxO/vjUFuk5fcskLYRi1zY2CvQYEJAaqfZndV/hvS52LyaMEfkFC
qkLPntD4nsxuEOWR60U=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bf70+ZpglOMDV70X+xuN4nRPXfVUkSD67DJnuxYBU6BsEPWcIsKXYgb9RI/ipBHJIcS5yMR5ay4y
ZGUkpXF+VPjaNXTMFQtZ1K5mRMAV+JArWtTEriEcaLERTsJDeyd1Z4zDdjYpzxG6Z/Zz/ztR6NaS
DXPNkKDCuWXgoJuaTg85GgRlSZApN/Vz7Nv1VpBlKW8RaeWWPsl6V/rBQd0p3r8ABmazkNszJyh/
a/Su2bs7i+4OC4ukaxri7kHCPF84cPWArUBZQMvbfhPrio7YX4Dez8ldc4zmFSAwboVFno/moixD
/ffMy9k08hZ5r0inf4IqvyUqwJCF9Becd6RX7g==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
t0Ly2SOPXG6TCNJmq3H1TpmFnVRhv9HxO3kBWy9oUObB5mmxIMwH4PVecLk2fGShC4taYGDp/0aY
0si1i/ejKKGrqyyGb/N6vx1JLs41Bu7iCTta1xo+4dbj/F2PireXic+68Jto7/kB5nZuUUbPr+t1
XUmV4vv6ttLMYChOaIau7ny0aK2gEX5WVUPZ16h17dlWdlRPDvH+mgudXa6P8dmQnJxg31t6wIjC
zSzt7OAwLFjEUTLsI1YB1ruB9BhEm0/OF/srCIQRKr1tQ/WOFTsRZEf6dblVTmJHun0E1Z1Vh+cF
2Up7FSrGzExIyH2zWQJovu4NqQpUZ5Vjf9Fjqw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2025.1-2029.x", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
hJSML2FqcV98cUylkT1L5mHMuOLICQ4g+hlj2HavieYMseOK/g7SxNWmH7qEphzStwrOZQFMzDtD
1Vj1aF0JKpb4PBKJJzHZno9WZDpafcG5qIrY28RJ+CR8mZXTbgQVr2MxRUw7gbya4Hp6xeZAdEnq
6fFaKMN9dWeYzikVZe+5yRYREhZz9d8qnsnvvnvQHkeJETtLiM6B4Sr0hgsHS8c9+Aa7ia2UmIhh
zBvRSlghkTCQ5cJLnL8xgPU6BPDNj9ZjMUofD1+hKfZfIaKZrWraiXgKs9SjrJAfs+GEIY9yXPoD
WVQVvdkFdjNY66o/EOnV7dqw6ONHGFRgE2/DTA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
LYickIpiuxmseA8hr32NIz+PQH5YL3u7uoihU3kCjGsvwbbVRibk3qUmfOq9SbEshOFLrK5X0BTq
8GfHccDg1r/f3v2KGiQuvPe2+ATRd7TaeIr0e/tveJAg6wBQ5MMLCYc0cZ0iux1JaECuVSbCj0bd
pZxf8m1J/Bcgco+JI3qHNqh0uRXRY6K3uyDmOIL2cpgPbx191SyuIKtL9L3ray4QFZfxPmHYJWSj
BZPwXShcJFZX29uWHQFhfzvxV2bqiS0Nz4zhd2ABCLFr2iQ5ZhbpmzpNVMPrA8V1idxVj0eEmgpq
PorgSpLZ/EmMRvNPhUhTla7L8gkjJn8CQJ+NEw==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
fAQn311nBu08DuuB0R4ieuk9vtdguq7CpXeo0sHmor7YAb3d1vkwMpX+W9baRf19NFZZ7e1SAP1F
fTmg3llJ2sBIV6fyHdZ+hSOU4b0ZFJQWKlOSIAJtqJAGSLmmMXWkAoMKMaaUvXp2GF6wsgiWkjl1
JNAnVYRBQ8AHqRW6PrnluqSpRtTejfk/sB+RZukTSfKQltkUKOb0022ozakCkpGSeEUd3hnycn9q
ThFWMHNg/eW1lHKgfXIVBIujW6b7LN1+g9UMt0VZ2fPXl3AYmeJ1HOHU0W7sXDxYQMAQQNKzjExn
3sIWEqqopjcUfDNIvU30CG3dLKU+N3FHqB7RlxbhCZL1ezwKR9dz51hLS6rYQgRkgJhrgSbvfuJ4
UVN77y+HZA6DSo1GSnNJAR1nbioPV9OQ9bcgYhPW6VywV9ol9pdoa4gyoiVBScD2I/eiM6CB3I+8
wDaR5NT2PbMvxoco4gWfY0YlwoAXHCVrIW6pnXb+5TOex4mxMUQ0x/en

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
IEjnv73YQXRAkCIEYUr9W/mAjZNVmIpdev/N/sb1oZY2hb/ju2aA2Z20+M+pkJl+6nOQbGe1MYuz
zxVqt33HW4VglAaDUONi3dVlB8u02Hsxvnh5/OHQcEFY9x/e5ztwxK1eRXZPm/d+0zVyJ6gwoMoE
06tLSQsLFc6lLMYdT8GLPcx12l+fRnCavi4TdwVXmRz9JXNyxkRl4etYfDiQ6b/xjYRs7Pt2thIv
5aToHduM1mSg3cyHnHLWsqaAsHsWdGnunKoMwG+3GkevK+9ja7sQp29foyEKH1c/9PuZYtaWE5bi
LlP8eh0QsevIeaAiRzyZ9OP/MoUkwRABhD+xMg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UD8GrSfmICSJ1lNXY+pPzOHUnx3TQOAxMB9U29uGc6H9NB5gnp8cO29pHZK74mATlCW0nJQarmiX
S3isy2zGtfy59l9GotJHsnwYJV6lmXKLw5K/RuvPlgIDlmh+Nlv8d91OmOQCBKKZTqH9004P7eVX
DVx/GN7xQPkrPBH61QqH9NLrj83xdr8+7AVHNAx40vRqNTCoKIp3dNX7WLu/2dPPi6c/WhMo22lv
efTeM4tFElsgjIFjIibSY4uF6wFamWljzCEL6UVWyMPwldGELitCYgZeHKFDjxC9TvBhzfE1q5Eq
glo/0KlCLsigiPyAhTCiKvxftfz+CksVkaeZfQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
h96XoyciCvz7a4XWTvv+YGkr0w4RAzd7A+zidHXAmAT4WKxC2cAmwZ3sK6PcDssPJK4TM5ccz16y
mP0si6/vfKq9brstNhibi9bAU7g/fpqrUdd5IWtcP85S1fWwjqpKNsNvlD/1yga395E0JGtTomHu
/SAgmnZLgp/AifzqmbO6RDMIT1wDJFWJY7gidPkT/jCiit2g4Orf+XBF1yysQUBlolMhA5ug1uMw
yhUnPqnaH0DrOX0sJh2AuzdB7FRRKTz0Ow0SwQn9sgRXNJlGEclyyut7Qlu3cuOxwKy+bP4i6DFV
t9yU8XYvX7EbKAA+xgspCIwc3jhQ5DnWQeaFPQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 9056)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
