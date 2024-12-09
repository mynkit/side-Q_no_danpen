x = Synth(\sine, [\amp, 0])

x.set(\amp, 0,\freq, 329.628*0.25, \reverb, 0.9, \pan2Freq, 0.0, \parFreq, 0*3, \ice, 0.3, \vibratoDepth, 1, \vibratoFreq, 10)


y = Synth(\sine, [\amp, 0])

y.set(\amp, 0.1,\freq, 493.883*0.5, \reverb, 0.9, \pan2Freq, 0.0, \parFreq, 0*0, \ice, 0.0, \vibratoDepth, 0.4, \vibratoFreq, 4)

y.set(\amp, 0.1,\freq, 329.628*0.75, \reverb, 0.9, \pan2Freq, 1.5, \parFreq, 0*3, \ice, 0.4, \vibratoDepth, 0.4, \vibratoFreq, 4)


(
a = Synth(\zureSc, [\amp, 0, \freq, 329.628*0.25, \hpf, 100, \lpf, 300, \detune, 1]);
b = Synth(\zureSc, [\amp, 0, \freq, 261.626*0.5, \hpf, 100, \lpf, 300, \detune, 0.1]);
c = Synth(\zureSc, [\amp, 0, \freq, 493.883*1, \hpf, 100, \lpf, 300, \detune, 0.03]);
)

(
a.set(\amp, 1,  \freq, 329.628*(2**(-12/12)), \detune, 0.15);
b.set(\amp, 1, \freq, 261.626*(2**(-12/12)), \detune, 0.2);
c.set(\amp, 1.5, \freq, 493.883*(2**(-0/12)), \detune, 0.13);
)
(
a.free;
b.free;
c.free;
)




z = Synth(\sine, [\amp, 0])

z.set(\amp, 0.0,\freq, 164*1, \reverb, 0.0, \pan2Freq, 103*0, \parFreq, 110*0, \ice, 0.0, \vibratoDepth, 0, \vibratoFreq, 10)

z.set(\amp, 0.9,\freq, 164*1, \reverb, 0.9, \pan2Freq, 103*1, \parFreq, 110*3, \ice, 0.0, \vibratoDepth, 1.5, \vibratoFreq, 10)

s = Synth(\saw, [\amp, 0])
s.set(\amp, 3,\freq, 164*0.25,\bpf, 164*0.5, \reverb, 0.9, \pan2Freq, 103*2.0, \parFreq, 110*2.0, \ice, 0.0, \vibratoDepth, 1, \vibratoFreq, 10)

