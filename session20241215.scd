∫// c: 261.626
// cs: 277.183
// d: 293.665
// ds: 311.127
// e: 329.628
// f: 349.228
// fs: 369.994
// g: 391.995
// gs: 415.305
// a: 440.000
// bf: 466.164
// b: 493.883

// 前半

// 2. パレード 3:30

(
a = Synth(\zureSc, [\amp, 0, \freq, 329.628*0.25, \hpf, 100, \lpf, 300, \detune, 1]);
d = Synth(\zureSc, [\amp, 0, \freq, 329.628*0.25, \hpf, 100, \lpf, 300, \detune, 1]);
b = Synth(\sine, [\amp, 0, \freq, 110, \reverb, 0.8, \ice, 0, \parFreq, 0, \pan2Freq, 0]);
c = Synth(\sine, [\amp, 0, \freq, 110, \reverb, 0.8, \ice, 0, \parFreq, 0, \pan2Freq, 0]);
e = Synth(\pad, [\amp, 0, \freq, 329.628*0.25]);
)

(
var vol2 = 0.0;
a.set(\amp, 0.5*vol2, \freq, 493.883*(2**(-0/12)), \detune, 0.5);
d.set(\amp, 0.8*vol2, \freq, 493.883*(2**(-0/12)), \detune, 0.1);
b.set(\amp, 0.3*vol2, \freq, 110, \parFreq, 0.2, \reverb, 1, \ice, 0.3, \pan2Freq, 0);
c.set(\amp, 0.2*vol2, \freq, 112, \parFreq, 0.7, \reverb, 1, \ice, 0.3,  \pan2Freq, 0.1);
e.set(\amp, 0.2*vol2, \freq, 329.628*0.25);
)

(
a.free;
b.free;
c.free;
d.free;
e.free;
)

// 3. 百式

f = Synth(\saw, [\amp, 0]);

f.set(\amp, 0.0, \freq, 164.814*0.25, \parFreq, 110*4, \reverb, 1, \ice, 0, \pan2Freq, 103.826*2, \bpf, 164.814*1, \vibrato, 0.5, \vrate, 8);

f.free


x = Synth(\sine, [\amp, 0]);
x.set(\amp, 0.4, \freq, 164.814*(2**(1/12)), \parFreq, 0, \pan2Freq, 0, \vibratoFreq, 2, \vibratoDepth, 0.02, \reverb, 0.4, \ice, 0);


y = Synth(\sine, [\amp, 0])
y.set(\amp, 0.4, \freq, 164.814*(2**(12/12)), \parFreq, 0, \pan2Freq, 0.1, \vibratoFreq, 5, \vibratoDepth, 0.2, \reverb, 0.8, \ice, 0);

z = Synth(\sine, [\amp, 0])
z.set(\amp, 0.4, \freq, 164.814*(2**(9/12)), \parFreq, 0, \pan2Freq, 0.1, \vibratoFreq, 5, \vibratoDepth, 0.0, \reverb, 0.7, \ice, 0);

w = Synth(\sine, [\amp, 0])
w.set(\amp, 0.4, \freq, 164.814*(2**(14/12)), \parFreq, 0, \pan2Freq, 0.1, \vibratoFreq, 5, \vibratoDepth, 0.0, \reverb, 0.4, \ice, 0);

(
x.set(\amp, 0.4, \freq, 164.814*(2**(1/12)), \parFreq, 0, \pan2Freq, 0, \vibratoFreq, 6, \vibratoDepth, 0.09, \reverb, 0.4, \ice, 0);
y.set(\amp, 0.4, \freq, 164.814*(2**(12/12)), \parFreq, 0, \pan2Freq, 0.1, \vibratoFreq, 5, \vibratoDepth, 0.2, \reverb, 0.8, \ice, 0);
z.set(\amp, 0.4, \freq, 164.814*(2**(9/12)), \parFreq, 0, \pan2Freq, 0.1, \vibratoFreq, 5, \vibratoDepth, 0.0, \reverb, 0.7, \ice, 0);
w.set(\amp, 0.4, \freq, 164.814*(2**(14/12)), \parFreq, 0, \pan2Freq, 0.1, \vibratoFreq, 5, \vibratoDepth, 0.0, \reverb, 0.4, \ice, 0);
)

(
var vol = 0.0;
x.set(\amp, 0.4*vol, \freq, 164.814*(2**(-24/12)), \parFreq, 0, \pan2Freq, 10, \vibratoFreq, 3, \vibratoDepth, 0.2, \reverb, 0.4, \ice, 0);
y.set(\amp, 0.7*vol, \freq, 164.814*(2**(0/12)), \parFreq, 20, \pan2Freq, 0.1, \vibratoFreq, 5, \vibratoDepth, 0.2, \reverb, 0.8, \ice, 0);
z.set(\amp, 0.7*vol, \freq, 164.814*(2**(2/12)), \parFreq, 0, \pan2Freq, 110, \vibratoFreq, 5, \vibratoDepth, 0.0, \reverb, 0.7, \ice, 0);
w.set(\amp, 0.7*vol, \freq, 164.814*(2**(7/12)), \parFreq, 0, \pan2Freq, 50, \vibratoFreq, 5, \vibratoDepth, 0.0, \reverb, 0.4, \ice, 0);
)

(
x.free;
y.free;
z.free;
w.free;
)

// 後半

// 4. 草達磨と残雪 12:20
// 中盤まではDJのみ
// 「だけど、その夢の中の少年は〜目を覚ましているのだそうなのです。」でDJ終わり
// 次の「クズ　キリ」から



// 5. Type-β 3:20


// 6. 火星の植物 5:28

s = Synth(\saw, [\amp, 0])
s.set(\amp, 0,\freq, 164*0.25,\bpf, 164*0.5, \reverb, 0.9, \pan2Freq, 103*2.0, \parFreq, 110*2.0, \ice, 0.0, \vibratoDepth, 1, \vibratoFreq, 10)


(
a = Synth(\zureSc, [\amp, 0, \freq, 329.628*0.25, \hpf, 100, \lpf, 300, \detune, 1]);
b = Synth(\zureSc, [\amp, 0, \freq, 261.626*0.5, \hpf, 100, \lpf, 300, \detune, 0.1]);
c = Synth(\zureSc, [\amp, 0, \freq, 493.883*1, \hpf, 100, \lpf, 300, \detune, 0.03]);
)

(
a.set(\amp, 0.0,  \freq, 329.628*(2**(-12/12)), \detune, 0.15);
b.set(\amp, 0.0, \freq, 261.626*(2**(-12/12)), \detune, 0.2);
c.set(\amp, 0.0, \freq, 493.883*(2**(0/12)), \detune, 0.13);
)
(
a.free;
b.free;
c.free;
)



(
a = Synth(\zureSc, [\amp, 0, \freq, 329.628*0.25, \hpf, 100, \lpf, 300, \detune, 1]);
b = Synth(\zureSc, [\amp, 0, \freq, 261.626*0.5, \hpf, 100, \lpf, 300, \detune, 0.1]);
c = Synth(\zureSc, [\amp, 0, \freq, 493.883*1, \hpf, 100, \lpf, 300, \detune, 0.03]);
)

(
var vol = 0.4;
a.set(\amp, 2*vol, \freq, 329.628*0.25, \hpf, 50, \lpf, 300);
b.set(\amp, 2*vol, \freq, 261.626*0.125, \hpf, 100, \lpf, 300);
c.set(\amp, 2*vol, \hpf, 100, \lpf, 300, \freq, 0.25*493.883*(2**(0/12)), \detune, 0.1)
)


s = Synth(\saw, [\amp, 0])
s.set(\amp, 1,\freq, 164*0.25,\bpf, 164*0.5, \reverb, 0.9, \pan2Freq, 103*2.0, \parFreq, 110*2.0, \ice, 0.0, \vibratoDepth, 1, \vibratoFreq, 10)

x = Synth(\sine, [\amp, 0])
x.set(\amp, 0.4, \freq, 164*(2**(1/12)), \parFreq, 0, \pan2Freq, 0, \vibratoFreq, 3, \vibratoDepth, 0, \reverb, 0, \ice, 0)
x.set(\amp, 0.3,\freq, 164*(2**(5/12)), \reverb, 0.9, \pan2Freq, 0.2, \parFreq, 110*3, \ice, 0.4, \vibratoDepth, 1.5, \vibratoFreq, 10)
