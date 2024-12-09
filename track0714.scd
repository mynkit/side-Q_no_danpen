// sketch1

(
SynthDef(\zureSc, {|out, amp=1, pan, accelerate, freq, decay=0, detune=1,lpf=8000,hpf=50 |
	var basefreq = freq;
	var sound = VarSaw.ar(basefreq, 0, 1);
	var sound2 = VarSaw.ar(basefreq*(detune/100+1), 0, 1);
	var sound3 = VarSaw.ar(basefreq*(-1*detune/100+1), 0, 1);
	sound = sound - DelayN.ar(sound2,0.2)
	+ DelayN.ar(sound3,0.2);
	sound = LPF.ar(sound, lpf);
	sound = HPF.ar(sound, hpf);
	Out.ar(out, sound!2*0.05*amp);
}, [0, 1, 0, 0, 0, 0.2]).add;
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
s.set(\amp, 2.5,\freq, 164*0.25,\bpf, 164*0.5, \reverb, 0.9, \pan2Freq, 103*2.0, \parFreq, 110*2.0, \ice, 0.0, \vibratoDepth, 1, \vibratoFreq, 10)

x = Synth(\sine, [\amp, 0])
x.set(\amp, 0.4, \freq, 164*(2**(1/12)), \parFreq, 0, \pan2Freq, 0, \vibratoFreq, 3, \vibratoDepth, 0, \reverb, 0, \ice, 0)
x.set(\amp, 0.3,\freq, 164*(2**(5/12)), \reverb, 0.9, \pan2Freq, 0.2, \parFreq, 110*3, \ice, 0.4, \vibratoDepth, 1.5, \vibratoFreq, 10)


// sketch2

(
a.set(\amp, 0);
b.set(\amp, 0);
c.set(\amp, 0);
s.set(\amp, 0);
x.set(\amp, 0.7, \freq, 164.814*(2**(1/12)), \parFreq, 0, \pan2Freq, 0, \vibratoFreq, 3, \vibratoDepth, 0.2, \reverb, 0.4, \ice, 0);
)

(
a.free;
b.free;
c.free;
s.free;
)

y = Synth(\sine, [\amp, 0])
y.set(\amp, 0.7, \freq, 164.814*(2**(12/12)), \parFreq, 0, \pan2Freq, 0.1, \vibratoFreq, 5, \vibratoDepth, 0.2, \reverb, 0.8, \ice, 0);

z = Synth(\sine, [\amp, 0])
z.set(\amp, 0.7, \freq, 164.814*(2**(9/12)), \parFreq, 0, \pan2Freq, 0.1, \vibratoFreq, 5, \vibratoDepth, 0.0, \reverb, 0.7, \ice, 0);

w = Synth(\sine, [\amp, 0])
w.set(\amp, 0.7, \freq, 164.814*(2**(14/12)), \parFreq, 0, \pan2Freq, 0.1, \vibratoFreq, 5, \vibratoDepth, 0.0, \reverb, 0.4, \ice, 0);

(
x.set(\amp, 0.7, \freq, 164.814*(2**(12/12)), \parFreq, 0, \pan2Freq, 0, \vibratoFreq, 3, \vibratoDepth, 0.2, \reverb, 0.4, \ice, 0);
y.set(\amp, 0.7, \freq, 164.814*(2**(11/12)), \parFreq, 0, \pan2Freq, 0.1, \vibratoFreq, 5, \vibratoDepth, 0.2, \reverb, 0.8, \ice, 0);
z.set(\amp, 0.7, \freq, 164.814*(2**(5/12)), \parFreq, 0, \pan2Freq, 0.1, \vibratoFreq, 5, \vibratoDepth, 0.0, \reverb, 0.7, \ice, 0);
w.set(\amp, 0.7, \freq, 164.814*(2**(14/12)), \parFreq, 0, \pan2Freq, 0.1, \vibratoFreq, 5, \vibratoDepth, 0.0, \reverb, 0.4, \ice, 0);
)

(
var vol = 0.7;
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






