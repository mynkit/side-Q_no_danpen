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


i = Synth(\pad, [\amp, 0.0, \freq, 164.814*(2**(4/12))]);


i.set(\amp, 0.4, \parFreq, 2, \freq, 5*163*(2**((-3)/12)));

i.free



(
s = Synth(\saw, [\amp, 0]);
p = Synth(\saw, [\amp, 0]);
q = Synth(\saw, [\amp, 0]);
)

(
var vol = 3;
s.set(\amp, 1.0*vol, \pan2Freq, 0, \parFreq, 300, \freq, 35*1, \vibratoDepth, 0.1, \vibratoFreq, 2, \reverb, 1, \ice, 1, \bpf, 35*2*2.5);
p.set(\amp, 1.0*vol, \pan2Freq, 0, \parFreq, 110, \freq, 35*1.75, \vibratoDepth, 0.1, \vibratoFreq, 21, \reverb, 1, \ice, 1, \bpf, 35*1.75*1);
q.set(\amp, 1.0*vol, \pan2Freq, 0, \parFreq, 10, \freq, 35*1.5, \vibratoDepth, 0.7, \vibratoFreq, 21, \reverb, 1, \ice, 1, \bpf, 35*1.5*1);
)

(
s.free;
p.free;
q.free;
)


(
k = Synth(\saw, [\amp, 0, \freq, 110, \vibrato, 1, \vrate, 32, \lpf, 1000]);
l = Synth(\saw, [\amp, 0, \freq, 220, \vibrato, 1, \vrate, 32, \lpf, 1000]);
m = Synth(\saw, [\amp, 0, \freq, 330, \vibrato, 1, \vrate, 32, \lpf, 1000]);
n = Synth(\saw, [\amp, 0, \freq, 55, \vibrato, 1, \vrate, 32, \lpf, 1000]);
o = Synth(\saw, [\amp, 0, \freq, 165, \vibrato, 1, \vrate, 32, \lpf, 1000]);
)

(
var masterVol = 4;
k.set(\amp, 0.2*masterVol, \freq, 330, \parFreq, 0.22, \reverb, 1, \pan2Freq, 0.03, \bpf, 220);
l.set(\amp, 0.25*masterVol, \freq, 220, \parFreq, 0.13, \reverb, 1, \pan2Freq, 0.07, \bpf, 220*1);
m.set(\amp, 0.3*masterVol, \freq, 329.628/2, \parFreq, 0.1, \reverb, 1, \pan2Freq, 0.05, \bpf, 329.628*0.5);
n.set(\amp, 0.3*masterVol, \freq, 277.183/2, \parFreq, 1.34, \reverb, 1, \pan2Freq, 0.1, \bpf, 277.183*0.5);
o.set(\amp, 0.3*masterVol, \freq, 415.305/2, \parFreq, 0.08, \reverb, 1, \pan2Freq, 0.03, \bpf, 415.305*0.5);
)

(
var masterVol = 4;
k.set(\amp, 0.2*masterVol, \freq, 330, \parFreq, 0.22, \reverb, 1, \pan2Freq, 0.03, \bpf, 220);
l.set(\amp, 0.25*masterVol, \freq, 220, \parFreq, 0.13, \reverb, 1, \pan2Freq, 0.07, \bpf, 220*1);
m.set(\amp, 0.3*masterVol, \freq, 329.628/2, \parFreq, 0.1, \reverb, 1, \pan2Freq, 0.05, \bpf, 329.628*0.5);
n.set(\amp, 0.3*masterVol, \freq, 277.183/2, \parFreq, 0.34, \reverb, 1, \pan2Freq, 0.1, \bpf, 277.183*0.5);
o.set(\amp, 0.3*masterVol, \freq, 415.305/2, \parFreq, 0.08, \reverb, 1, \pan2Freq, 0.03, \bpf, 415.305*0.5);
)
