// c: 261.626
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


// 2. パレード 3:30

(
a = Synth(\zureSc, [\amp, 0, \freq, 329.628*0.25, \hpf, 100, \lpf, 300, \detune, 1]);
d = Synth(\zureSc, [\amp, 0, \freq, 329.628*0.25, \hpf, 100, \lpf, 300, \detune, 1]);
b = Synth(\sine, [\amp, 0, \freq, 110, \reverb, 0.8, \ice, 0, \parFreq, 0, \pan2Freq, 0]);
c = Synth(\sine, [\amp, 0, \freq, 110, \reverb, 0.8, \ice, 0, \parFreq, 0, \pan2Freq, 0]);
e = Synth(\pad, [\amp, 0, \freq, 329.628*0.25]);
)

(
var vol2 = 2;
a.set(\amp, 1*vol2, \freq, 493.883*(2**(-36/12)), \detune, 0.5);
d.set(\amp, 0.6*vol2, \freq, 493.883*(2**(-24/12)), \detune, 0.1);
b.set(\amp, 0.9*vol2, \freq, 110, \parFreq, 0.2, \reverb, 1, \ice, 0.3, \pan2Freq, 0);
c.set(\amp, 0.9*vol2, \freq, 112, \parFreq, 0.7, \reverb, 1, \ice, 0.3,  \pan2Freq, 0.1);
e.set(\amp, 0.8);
)

(
a.free;
b.free;
c.free;
d.free;
e.free;
)



