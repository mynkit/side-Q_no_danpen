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

// intro

Ndef(\fire).play(vol: 10, numChannels: ~numChannels, fadeTime: 1);
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

(
l = Synth(\superhammondSc, [\amp, 0.0, \freq, 277.183, \vibrato, 1.0, \vrate, 32, \lpf, 300, \reverb, 1, \pan, 0]);
m = Synth(\superhammondSc, [\amp, 0.0, \freq, 277.183, \vibrato, 1.0, \vrate, 32, \lpf, 300, \reverb, 1, \pan, -0.5]);
o = Synth(\superhammondSc, [\amp, 0.0, \freq, 277.183, \vibrato, 1.0, \vrate, 32, \lpf, 300, \reverb, 1, \pan, 0.5]);
p = Synth(\superhammondSc, [\amp, 0.0, \freq, 277.183, \vibrato, 1.0, \vrate, 32, \lpf, 300, \reverb, 1, 0]);
)

(
var vol = 0.1, n = 0;
l.set(\amp, 0.5*vol, \freq, 277.183*0.5*(2**(0+n/12)), \reverb, 0.8, \vibrato, 1, \vrate, 16, \lpf, 4000, \hpf, 100,\tremolorate, 2, \tremolodepth, 0.2, \pan, -0.1);
m.set(\amp, 0.4*vol, \freq, 277.183*0.5*(2**(4+n/12)), \reverb, 0.6, \vibrato, 1, \vrate, 32, \lpf, 4000, \hpf, 100, \tremolorate, 8, \tremolodepth, 0.1, \pan, -0.5);
o.set(\amp, 0.4*vol, \freq, 277.183*0.5*(2**(7+n/12)), \reverb, 0.7, \vibrato, 1, \vrate, 28, \lpf, 4000, \hpf, 100, \tremolorate, 20, \tremolodepth, 0.1, \pan, 0.5);
p.set(\amp, 0.5*vol, \freq, 277.183*0.5*(2**(-12+n/12)), \reverb, 0.7, \vibrato, 1, \vrate, 28, \lpf, 4000, \hpf, 100, \tremolorate, 20, \tremolodepth, 0.1, \pan, 0.1);
)

(
var vol = 0.7;
var n = 0; // 初期値
var bpm = 90; // BPM
var beatsPerMeasure = 4; // 1小節の拍数（通常は4拍）
var measuresPerCycle = 4; // 切り替えに使用する小節数
var updateParameters;

// パラメータ更新関数
updateParameters = {
    l.set(\amp, 0.5 * vol, \freq, 277.183 * 0.5 * (2 ** (0 + n / 12)), \reverb, 0.8, \vibrato, 1, \vrate, 16, \lpf, 4000, \hpf, 100, \tremolorate, 2, \tremolodepth, 0.2, \pan, -0.1);
    m.set(\amp, 0.4 * vol, \freq, 277.183 * 0.5 * (2 ** (7 + n / 12)), \reverb, 0.6, \vibrato, 1, \vrate, 32, \lpf, 4000, \hpf, 100, \tremolorate, 8, \tremolodepth, 0.1, \pan, -0.5);
    o.set(\amp, 0.4 * vol, \freq, 277.183 * 0.5 * (2 ** (4 + n / 12)), \reverb, 0.7, \vibrato, 1, \vrate, 28, \lpf, 4000, \hpf, 100, \tremolorate, 20, \tremolodepth, 0.1, \pan, 0.5);
    p.set(\amp, 0.5 * vol, \freq, 277.183 * 0.5 * (2 ** (-12 + n / 12)), \reverb, 0.7, \vibrato, 1, \vrate, 28, \lpf, 4000, \hpf, 100, \tremolorate, 20, \tremolodepth, 0.1, \pan, 0.1);
};

// TempoClockを使用してBPMに同期
TempoClock.default.tempo = bpm / 60; // BPMを秒単位に変換

// 4小節ごとにnを切り替えるタスク
~task.stop;
~task.reset;

~task = Task({
    loop {
        n = if(n == 0, { 5 }, { 0 }); // nを0と5に切り替え
        updateParameters.value; // パラメータを更新
        (beatsPerMeasure * measuresPerCycle).wait; // 4小節待機
    }
});

~task.reset;
~task.start;
)

(
~task.reset;
~task.stop;
)

(
var vol = 0.0, n = -12;
l.set(\amp, 0.5*vol, \freq, 277.183*0.5*(2**(0+n/12)), \reverb, 0.8, \vibrato, 1, \vrate, 16, \lpf, 4000, \hpf, 100,\tremolorate, 2, \tremolodepth, 0.2, \pan, -0.1);
m.set(\amp, 0.4*vol, \freq, 277.183*0.5*(2**(7+n/12)), \reverb, 0.6, \vibrato, 1, \vrate, 32, \lpf, 4000, \hpf, 100, \tremolorate, 8, \tremolodepth, 0.1, \pan, -0.5);
o.set(\amp, 0.4*vol, \freq, 277.183*0.5*(2**(4+n/12)), \reverb, 0.7, \vibrato, 1, \vrate, 28, \lpf, 4000, \hpf, 100, \tremolorate, 20, \tremolodepth, 0.1, \pan, 0.5);
p.set(\amp, 0.5*vol, \freq, 277.183*0.5*(2**(-12+n/12)), \reverb, 0.7, \vibrato, 1, \vrate, 28, \lpf, 4000, \hpf, 100, \tremolorate, 20, \tremolodepth, 0.1, \pan, 0.1);
)


(
l.free;
m.free;
o.free;
p.free;
)


// architected noise





// 怪穏

x = Synth(\sine, [\amp, 0])

x.set(\amp, 1,\freq, 329.628*0.25, \reverb, 0.9, \pan2Freq, 0.0, \parFreq, 0*3, \ice, 0.3, \vibratoDepth, 1, \vibratoFreq, 10)


y = Synth(\sine, [\amp, 0])

y.set(\amp, 0.8,\freq, 493.883*0.5, \reverb, 0.9, \pan2Freq, 0.0, \parFreq, 0*0, \ice, 0.0, \vibratoDepth, 0.4, \vibratoFreq, 4)

y.set(\amp, 0.8,\freq, 329.628*0.75, \reverb, 0.9, \pan2Freq, 1.5, \parFreq, 0*3, \ice, 0.2, \vibratoDepth, 0.4, \vibratoFreq, 4)


(
x.free;
y.free;
)

(
a = Synth(\zureSc, [\amp, 0, \freq, 329.628*0.25, \hpf, 100, \lpf, 300, \detune, 1]);
b = Synth(\zureSc, [\amp, 0, \freq, 261.626*0.5, \hpf, 100, \lpf, 300, \detune, 0.1]);
c = Synth(\zureSc, [\amp, 0, \freq, 493.883*1, \hpf, 100, \lpf, 300, \detune, 0.03]);
)

(
a.set(\amp, 1,  \freq, 329.628*(2**(-12/12)), \detune, 0.15);
b.set(\amp, 1, \freq, 261.626*(2**(-12/12)), \detune, 0.2);
c.set(\amp, 1, \freq, 493.883*(2**(-12/12)), \detune, 0.13);
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
s.set(\amp, 5,\freq, 164*0.25,\bpf, 164*0.5, \reverb, 0.9, \pan2Freq, 103*2.0, \parFreq, 110*2.0, \ice, 0.0, \vibratoDepth, 1, \vibratoFreq, 10)


s.set(\amp, 0)




