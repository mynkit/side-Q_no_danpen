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

// fire

Ndef(\fire).play(vol: 300, numChannels: ~numChannels, fadeTime: 1);
Ndef(\fire).stop;
Ndef(\fire).clear;

(
Ndef(\fire,{|amp = 2.0, freq = 0.25, numharm=90, lpf = 700, hpf = 200|
	j=DelayL.ar(n=Ndef(\fire);n.ar,2,LFNoise0.kr(3.5*_!4)+1)+HPF.ar(LPF.ar(Blip.ar(freq, numharm),lpf), hpf);
	amp*LeakDC.ar(j+j.mean*0.15).sin
});
)

Ndef(\fire).set(\amp, 2.0, \freq, 0.25, \numharm, 90, \lpf, 700, \hpf, 200);
Ndef(\fire).set(\amp, 0);

//

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
a.set(\amp, 2);
b.set(\amp, 2);
c.set(\amp, 1, \freq, 493.883*(1**(1/12)));
)
(
a.free;
b.free;
c.free;
)



//

s = Synth(\saw, [\amp, 0])

s.set(\amp, 5,\freq, 110*0.5,\bpf, 110*0.9, \reverb, 0.9, \pan2Freq, 250*4.0, \parFreq, 130*3.0, \ice, 0.0, \vibratoDepth, 1, \vibratoFreq, 10)

s.free

f = Synth(\saw, [\amp, 0]);

f.set(\amp, 5, \freq, 164.814*0.25, \parFreq, 110*4, \reverb, 1, \ice, 0, \pan2Freq, 103.826*2, \bpf, 164.814*1, \vibrato, 0.5, \vrate, 8);

f.free


//

x = Synth(\sine, [\amp, 0])

x.set(\amp, 0.9,\freq, 164*1, \reverb, 0.9, \pan2Freq, 103*0, \parFreq, 110*3, \ice, 0.3, \vibratoDepth, 1.5, \vibratoFreq, 10)


y = Synth(\sine, [\amp, 0])

y.set(\amp, 0.8,\freq, 220*0.25, \reverb, 0.5, \pan2Freq, 220, \parFreq, 330, \ice, 0.4, \vibratoDepth, 1, \vibratoFreq, 10)


(
a = Synth(\pad, [\amp, 0.0, \freq, 164.814*(2**(4/12))]);
b = Synth(\pad, [\amp, 0.0, \freq, 164.814*(2**(11/12))]);
c = Synth(\pad, [\amp, 0.0, \freq, 164.814*(2**(0/12))]);
d = Synth(\pad, [\amp, 0.0, \freq, 164.814*(2**(7/12))]);
e = Synth(\pad, [\amp, 0.0, \freq, 164.814*(2**(9/12))]);
)

(
var vol = 1;
var up = -5;
a.set(\amp, vol, \parFreq, 1, \freq, 164.814*(2**((4+up)/12)));
b.set(\amp, vol, \parFreq, 0, \freq, 164.814*(2**((5+up)/12)));
c.set(\amp, vol, \parFreq, 0.1, \freq, 164.814*(2**((0+up)/12)));
d.set(\amp, vol, \parFreq, 0, \freq, 164.814*(2**((7+up)/12)));
e.set(\amp, vol, \parFreq, 0.1, \freq, 164.814*(2**((9+up)/12)));
)

(
a.free;
b.free;
c.free;
d.free;
e.free;
)
