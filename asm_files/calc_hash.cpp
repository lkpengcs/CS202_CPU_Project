#include <stdio.h>

int ROTR(int x, int n) {
    int r = x >> n;
    int t = (sizeof(x) << 3) - n;
    r |= x << t;
    return r;
}

int SHFR(int x, int n) {
    int r = x >> n;
    return r;
}

int CHX(int x, int y, int z) {
    int r = x & y;
    int t = ~x & z;
    r ^= t;
    return r;
}

int MAJ(int x, int y, int z) {
    int r = x & y;
    int t = x & z;
    r ^= t;
    t = y & z;
    r ^= t;
    return r;
}

int ztransform(const char* msg, int* h){
    int k[64];
    k[0] = 1116352408;
    k[1] = 1899447441;
    k[2] = 3049323471;
    k[3] = 3921009573;
    k[4] = 961987163;
    k[5] = 1508970993;
    k[6] = 2453635748;
    k[7] = 2870763221;
    k[8] = 3624381080;
    k[9] = 310598401;
    k[10] = 607225278;
    k[11] = 1426881987;
    k[12] = 1925078388;
    k[13] = 2162078206;
    k[14] = 2614888103;
    k[15] = 3248222580;
    k[16] = 3835390401;
    k[17] = 4022224774;
    k[18] = 264347078;
    k[19] = 604807628;
    k[20] = 770255983;
    k[21] = 1249150122;
    k[22] = 1555081692;
    k[23] = 1996064986;
    k[24] = 2554220882;
    k[25] = 2821834349;
    k[26] = 2952996808;
    k[27] = 3210313671;
    k[28] = 3336571891;
    k[29] = 3584528711;
    k[30] = 113926993;
    k[31] = 338241895;
    k[32] = 666307205;
    k[33] = 773529912;
    k[34] = 1294757372;
    k[35] = 1396182291;
    k[36] = 1695183700;
    k[37] = 1986661051;
    k[38] = 2177026350;
    k[39] = 2456956037;
    k[40] = 2730485921;
    k[41] = 2820302411;
    k[42] = 3259730800;
    k[43] = 3345764771;
    k[44] = 3516065817;
    k[45] = 3600352804;
    k[46] = 4094571909;
    k[47] = 275423344;
    k[48] = 430227734;
    k[49] = 506948616;
    k[50] = 659060556;
    k[51] = 883997877;
    k[52] = 958139571;
    k[53] = 1322822218;
    k[54] = 1537002063;
    k[55] = 1747873779;
    k[56] = 1955562222;
    k[57] = 2024104815;
    k[58] = 2227730452;
    k[59] = 2361852424;
    k[60] = 2428436474;
    k[61] = 2756734187;
    k[62] = 3204031479;
    k[63] = 3329325298;
    int w[64];
    int a0, b1, c2, d3, e4, f5, g6, h7;
    int t1, t2;
    int i = 0;
    int j = 0;
    for (i = 0; i < 16; i++) {
        w[i] = msg[j] << 24;
        w[i] |= msg[j + 1] << 16;
        w[i] |= msg[j + 2] << 8;
        w[i] |= msg[j + 3];
        j += 4;
    }
    for (i = 16; i < 64; i++) {
        w[i] = (ROTR(w[i - 2], 17) ^ ROTR(w[i - 2], 19) ^ SHFR(w[i - 2], 10));
        w[i] += w[i - 7];
        w[i] += (ROTR((w[i - 15]), 7) ^ ROTR((w[i - 15]), 18) ^ SHFR((w[i - 15]), 3));
        w[i] += w[i - 16];
    }


    a0 = h[0];
    b1 = h[1];
    c2 = h[2];
    d3 = h[3];
    e4 = h[4];
    f5 = h[5];
    g6 = h[6];
    h7 = h[7];

    for (i = 0; i < 64; i++) {
        t1 = h7 + (ROTR(e4, 6) ^ ROTR(e4, 11) ^ ROTR(e4, 25)) + CHX(e4, f5, g6) + k[i] + w[i];
        t2 =(ROTR(a0, 2) ^ ROTR(a0, 13) ^ ROTR(a0, 22)) + MAJ(a0, b1, c2);
        h7 = g6;
        g6 = f5;
        f5 = e4;
        e4 = d3 + t1;
        d3 = c2;
        c2 = b1;
        b1 = a0;
        a0 = t1 + t2;
    }
    h[0] += a0;
    h[1] += b1;
    h[2] += c2;
    h[3] += d3;
    h[4] += e4;
    h[5] += f5;
    h[6] += g6;
    h[7] += h7;
    return 0;
}


int main(){
    const char* str = "2834876DCFB05CB167A5C24953EB";
    char* src = (char*)str;
    int len = 0;
    while (str[len]) {
        len++;
    }
    char* tmp = (char*)src;
    char  cover_data[64];
    for (int i = 0; i < 64; i++) {
        cover_data[i] = 0;
    }
    int cover_size = 0;
    int i = 0;
    int n = 0;
    int m = 0;
    int h[8];
    h[0] = 0x6a09e667;
    h[1] = 0xbb67ae85;
    h[2] = 0x3c6ef372;
    h[3] = 0xa54ff53a;
    h[4] = 0x510e527f;
    h[5] = 0x9b05688c;
    h[6] = 0x1f83d9ab;
    h[7] = 0x5be0cd19;
    n = len >> 6;
    m = len & 64;
    if (m < 56) {
        cover_size = 64;
    }
    else {
        cover_size = 128;
    }
    for (int i = 0; i < m; i++) {
        int ind = (n << 6) + i;
        cover_data[i] = tmp[ind];
    }
    cover_data[m] = 0x80;
    int mul = len * 8;
    cover_data[cover_size - 4] = (mul & 0xff000000) >> 24;
    cover_data[cover_size - 3] = (mul & 0x00ff0000) >> 16;
    cover_data[cover_size - 2] = (mul & 0x0000ff00) >> 8;
    cover_data[cover_size - 1] = mul & 0x000000ff;
    for (i = 0; i < n; i++) {
        ztransform(tmp, h);
        tmp += 64;
    }
    tmp = cover_data;
    n = cover_size >> 6;
    for (i = 0; i < n; i++) {
        ztransform(tmp, h);
        tmp += 64;
    }
    printf("%08x", h[0]);
    return 0;
}
