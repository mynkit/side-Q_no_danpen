(
Server.killAll;
// ~dirt.free;
)

s.dumpOSC(0);

SuperDirtMod.reset

Server.allBootedServers

FreqScope.new(300,205);


// 出力先デバイスの確認
ServerOptions.inDevices;

ServerOptions.outDevices;

(
Server.default.options.inDevice_("BlackHole 2ch");
Server.default.options.outDevice_("MacBook Proのス");
// Server.default.options.outDevice_("BlackHole 2ch");
// Server.default.options.outDevice_("M2");
Server.default.options.outDevice_("M4");

~numChannels = 2;

Server.default.waitForBoot{
	~dirt.stop;
	~dirt = SuperDirt(~numChannels, Server.default);
	// load samples
	~dirt.loadSoundFiles(thisProcess.nowExecutingPath.dirname ++ "/samples/*");
	Server.default.sync;
	// ~dirt.loadSoundFiles;
	// Server.default.sync;
	SynthDef("pinknoise", {
		arg amp=1, lpf=4510, hpf=800;
		var out=0;
		p=PinkNoise.ar(1!2);
		p=HPF.ar(p, hpf);
		p=LPF.ar(p, lpf);
		Out.ar(out, p*0.7*amp);
	}, [1]).add;
	SynthDef("forest", {
		arg amp=1, lpf=3000, hpf=1500;
		var a, out=0, groundNoise=0;
		a=PinkNoise.ar(1!2);
		50.do{
			a=BBandStop.ar(a,LFNoise1.kr(0.01.rand).range(10,2500),Rand(0.9,1))
		};
		a=LPF.ar(a,lpf);
		a=HPF.ar(a,hpf-(groundNoise*(hpf-100)));
		Out.ar(out, amp * a * 5);
	}, [1]).add;
	SynthDef(\pad, {
		| out=0, amp=1, freq=440, tremolo=0, parFreq=0|
		var gate = 1;
		var freqs = { freq * LFNoise2.kr(freq:1,mul:0.01,add:1) }!24;
		var gen = LFSaw.ar(freq:freqs) * 0.1;
		var fmod = 1;
		//var fmod = LFCub.kr(freq:1/12).range(1, LFNoise2.kr(freq:1).range(6,7)); // sharper sound
		var rqmod = LFNoise2.kr(freq:1/8).range(0.1,1.0);
		// var modspeed = 1/s;
		var modspeed = tremolo*1100;
		var snd = RLPF.ar(in:gen, freq:SinOsc.kr(modspeed).range(freqs*0.8, freqs*1.2) * fmod, rq:rqmod);
		snd = snd*LFPar.kr(parFreq*110);
		// snd = snd*LFPulse.kr(parFreq, width: 0.7);
		Out.ar(bus:out, channelsArray:Splay.ar(snd*amp));
	}, [0, 0.2, 0.1]).add;
	SynthDef("rain2", {
		arg amp=1;
		var out=0;
		p=PinkNoise.ar(1!2);
		p=HPF.ar(p, 1600);
		p=LPF.ar(p, 4390);
		Out.ar(out, p*0.05*amp);
	}, [1]).add;
	SynthDef("river", {
		arg amp=1;
		var out=0;
		p=PinkNoise.ar(1!2);
		p=HPF.ar(p, 475);
		p=LPF.ar(p, 2500);
		Out.ar(out, p*0.05*amp);
	}, [1]).add;
	SynthDef("sine", {
		arg freq = 440, amp = 0.2, parFreq=0, pan2Freq=0, pan=0,
		vibratoFreq=3, vibratoDepth=0, actave=1, reverb=0, ice=0, distort=0;
		var sig, out=0, chain, in, z, y, oct, left, right, mod;
		sig = SinOsc.ar(actave*freq*(1+((LFPar.ar(vibratoFreq)+1)*(vibratoDepth/50))), 0, amp);
		// distort
		mod = CrossoverDistortion.ar(sig, amp: 0.2, smooth: 0.01);
		mod = mod + (0.1 * distort * DynKlank.ar(`[[60,61,240,3000 + SinOsc.ar(62,mul: 100)],nil,[0.1, 0.1, 0.05, 0.01]], sig));
		mod = (mod.cubed * 8).softclip * 0.5;
		sig = SelectX.ar(distort, [sig, mod]);
		// tremoro
		sig = if(
			parFreq>0.1,
			sig*LFPar.ar(parFreq),
			if(
				LFPar.ar(parFreq)>0,
				sig*(LFPar.ar(parFreq) + (1-(LFPar.ar(parFreq))*((1-(parFreq*10))))),
				sig*(LFPar.ar(parFreq) + (-1-(LFPar.ar(parFreq))*((1-(parFreq*10))))),
			)
		);
		// panning
		sig = if(
			pan2Freq>0.1,
			Pan2.ar(sig, LFPar.ar(pan2Freq)),
			Pan2.ar(sig, LFPar.ar(pan2Freq)*pan2Freq*10)
		);
		// reverb
		z = DelayN.ar(sig, 0.048);
		y = Mix.ar(Array.fill(7,{ CombL.ar(z, 0.1, 1, 15) }));
		32.do({ y = AllpassN.ar(y, 0.050, [0.050.rand, 0.050.rand], 1) });
		oct = 1.0 * LeakDC.ar( abs(y) );
		y = SelectX.ar(ice, [y, ice * oct, DC.ar(0)]);
		sig = sig + (0.2*y*reverb);
		sig = sig * 0.1;
		Out.ar(out, sig);
	}, [0.1, 0.2, 1, 1, 1, 1, 1, 1, 10, 10, 10]).add;

	SynthDef("sine2", {
		arg freq = 440, amp = 0.2, parFreq=0, pan2Freq=0, pan=0,
		vibratoFreq=3, vibratoDepth=0, actave=1, reverb=0, ice=0, distort=0;
		var sig, out=0, chain, in, z, y, oct, left, right, mod;
		sig = SinOsc.ar(actave*freq*(1+((LFPar.ar(vibratoFreq)+1)*(vibratoDepth/50))), 0, amp);
		// distort
		mod = CrossoverDistortion.ar(sig, amp: 0.2, smooth: 0.01);
		mod = mod + (0.1 * distort * DynKlank.ar(`[[60,61,240,3000 + SinOsc.ar(62,mul: 100)],nil,[0.1, 0.1, 0.05, 0.01]], sig));
		mod = (mod.cubed * 8).softclip * 0.5;
		sig = SelectX.ar(distort, [sig, mod]);
		// tremoro
		sig = if(
			parFreq>0.1,
			sig*LFPar.ar(parFreq),
			if(
				LFPar.ar(parFreq)>0,
				sig*(LFPar.ar(parFreq) + (1-(LFPar.ar(parFreq))*((1-(parFreq*10))))),
				sig*(LFPar.ar(parFreq) + (-1-(LFPar.ar(parFreq))*((1-(parFreq*10))))),
			)
		);
		// panning
		sig = if(
			pan2Freq>0.1,
			Pan2.ar(sig, LFPar.ar(pan2Freq)),
			Pan2.ar(sig, LFPar.ar(pan2Freq)*pan2Freq*10)
		);
		// reverb
		z = DelayN.ar(sig, 0.048);
		y = Mix.ar(Array.fill(7,{ CombL.ar(z, 0.1, 1, 15) }));
		32.do({ y = AllpassN.ar(y, 0.050, [0.050.rand, 0.050.rand], 1) });
		oct = 1.0 * LeakDC.ar( abs(y) );
		y = SelectX.ar(ice, [y, ice * oct, DC.ar(0)]);
		sig = sig + (0.2*y*reverb);
		sig = sig * 0.1;
		Out.ar(out, sig);
	}, [0.2, 0.2, 1, 1, 1, 1, 1, 1, 10, 10, 10]).add;

	SynthDef("saw", {
		arg freq = 440, amp = 0.2, parFreq=0, pan2Freq=0, pan=0,
		vibratoFreq=3, vibratoDepth=0, actave=1, reverb=0, ice=0, bpf=440;
		var sig, out=0, chain, in, z, y, oct, left, right, mod;
		sig = SawDPW.ar(actave*freq*(1+((LFPar.ar(vibratoFreq)+1)*(vibratoDepth/50))), 0, amp);
		// tremoro
		sig = if(
			parFreq>0.1,
			sig*LFPar.ar(parFreq),
			if(
				LFPar.ar(parFreq)>0,
				sig*(LFPar.ar(parFreq) + (1-(LFPar.ar(parFreq))*((1-(parFreq*10))))),
				sig*(LFPar.ar(parFreq) + (-1-(LFPar.ar(parFreq))*((1-(parFreq*10))))),
			)
		);
		// panning
		sig = if(
			pan2Freq>0.1,
			Pan2.ar(sig, LFPar.ar(pan2Freq)),
			Pan2.ar(sig, LFPar.ar(pan2Freq)*pan2Freq*10)
		);
		// reverb
		z = DelayN.ar(sig, 0.048);
		y = Mix.ar(Array.fill(7,{ CombL.ar(z, 0.1, 1, 15) }));
		32.do({ y = AllpassN.ar(y, 0.050, [0.050.rand, 0.050.rand], 1) });
		oct = 1.0 * LeakDC.ar( abs(y) );
		y = SelectX.ar(ice, [y, ice * oct, DC.ar(0)]);
		sig = sig + (0.2*y*reverb);
		sig = sig * 0.1;
		// sig = LPF.ar(sig, lpf);
		sig = BPF.ar(sig, bpf);
		Out.ar(out, sig);
	}, [0.3, 10, 1, 1, 1, 1, 1, 1, 10, 10, 10]).add;

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

	~dirt.start(57120, 0 ! 15);
}
)

(
SynthDef("softSawWave", {
	arg amp=1, sustain=1, pan=0, freq=110, accelerate=0, lpf=5000, out=0;
	var sound, env;
	freq = freq * Line.kr(1, 1+accelerate, max(0.5, sustain));
	sound = Saw.ar(freq).dup!2 * 0.5;
	sound = LPF.ar(sound, Line.kr(lpf, lpf*0.01, sustain));
	sound=NumChannels.ar([sound*(1-pan)/2, sound*(1+pan)/2], 2);
	env = EnvGen.ar(Env.linen(0.1, 0, 0.6, 1, -3), timeScale:sustain, doneAction:2);
	Out.ar(out, sound*env*amp);
}).add;
)


(
a = Synth(\superhammondSc, [\amp, 0.8, \freq, 110, \vibrato, 1, \vrate, 32]);
b = Synth(\superhammondSc, [\amp, 0.8, \freq, 123.471, \vibrato, 1, \vrate, 32]);
c = Synth(\superhammondSc, [\amp, 0.8, \freq, 82.407, \vibrato, 1, \vrate, 32]);
)

(
a.set(\vibrato, 1);
b.set(\vibrato, 1);
c.set(\vibrato, 1);
)

(
a.set(\vibrato, 1.8);
b.set(\vibrato, 1.8);
c.set(\vibrato, 1.8);
)

(
SynthDef(\superhammondSc, {|out, amp=1, freq, vibrato=0.5, vrate=7,
	voice=0, perc=0, percf=2, accelerate=0, speed=1, hpf=700, tremolorate = 0.2, tremolodepth = 0.2|
	var freqs, amps, sound, click, env, ampscale, attrel, tremolowave, decay=0;
	// attrel = (sustain/2).clip(0,0.005);
	// freq = freq * DirtFreqScale.kr(speed, accelerate, sustain);
	freqs = [0.5, 1.4988, 1, 2, 2.9976, 4, 5.0409, 5.9953, 8] * freq;
	freqs = 2**(freqs < 63) * freqs; // fold up bottom register
	freqs = freqs / (2**(freqs > 6000)); // fold down high harmonics
	freqs = freqs / (2**(freqs > 6000)); // do it again for the really high notes
	amps = SelectX.kr(voice, #[
		[1, 4, 5, 4, 3, 1, 0, 0, 0], // 0: bass violin 16'
		[0, 0, 8, 0, 4, 0, 0, 0, 0], // 1: tibia 8'
		[0, 7, 8, 1, 2, 0, 0, 0, 0], // 2: bassoon 8'
		[0, 0, 7, 8, 8, 8, 8, 7, 2], // 3: french trumpet 8'
		[4, 0, 5, 5, 4, 5, 3, 3, 6], // 4: string ensemble
		[8, 8, 5, 3, 2, 4, 5, 8, 8], // 5: Blues
		[8, 8, 8, 0 ,0, 0, 0, 0, 3], // 6: Jazz 1
		[8, 8, 8, 8, 8, 8, 8, 8, 8], // 7: Full Shout
		[8, 0, 0, 0, 0, 0, 8, 8, 8], // 8: Bro' Jack
		[0, 0, 8, 8, 0, 0, 0, 0, 0]  // 9: Jazz 2
	]);
	amps = amps - [0, 0, 0, 0, 0, 0, 0.5, 1, 1.5]; // damp brilliance a bit
	amps = 2**(amps-8);
	click = WhiteNoise.ar(1) * XLine.ar(1,1e-6, 0.1);
	sound = 0.5 * Mix.ar( SinOsc.ar(freqs*(2*click+1), (2pi ! 9).rand, amps/amps.sum) );
	sound = perc * 0.5 * SinOsc.ar(freq*percf, 2pi.rand) * XLine.ar(1,1e-6,2*decay+1) + sound;
	sound = sound + BAllPass.ar(sound, 1000*LFTri.kr(vrate,0,vibrato/2,1));
	sound = HPF.ar(sound, hpf);
	sound = FreeVerb.ar(sound, 0.33, 0.5);
	tremolodepth = tremolodepth.clip(0, 1) * 0.5;
	tremolowave = (1 - tremolodepth) + SinOsc.ar(tremolorate, 0.5pi, tremolodepth);
	sound = sound * tremolowave;
	Out.ar(out, amp*sound!2);
}, [0, 0, 0, 2, 2]).add;
)


(
SynthDef("bassSynth", {
	arg out, sustain=1, decay=0, pan, freq, vibrato=0.5, vrate=7, voice=0, perc=0, percf=2, accelerate=0, slide=0, sustainpedal=0.5;
	var freqs, amps, sound, click, env, ampscale, attrel, fglide, bendSustain;
	bendSustain = sustainpedal;
	attrel = (sustain/2).clip(0,0.005);
	env = EnvGen.ar(Env.linen(0.003, 0, 0.6, 1, 6), timeScale:sustain, doneAction:2);
	fglide = EnvGen.ar(Env.perc(0.05, 0.3, 1, \lin), timeScale:bendSustain) * (-1*slide/4) + 1;
	freq = freq * fglide * Line.kr(1, 1+accelerate, bendSustain);
	freqs = [0.5, 1.4988, 1, 2, 2.9976, 4, 5.0409, 5.9953, 8, 1.001] * freq;
	freqs = 2**(freqs < 63) * freqs; // fold up bottom register
	freqs = freqs / (2**(freqs > 6000)); // fold down high harmonics
	freqs = freqs / (2**(freqs > 6000)); // do it again for the really high notes
	amps = SelectX.kr(voice, #[
		[1, 4, 5, 4, 3, 1, 0, 0, 0], // 0: bass violin 16'
	]);
	amps = amps - [0, 0, 0, 0, 0, 0, 0.5, 1, 1.5]; // damp brilliance a bit
	amps = 2**(amps-8);
	click = WhiteNoise.ar(1) * XLine.ar(1,1e-6, 0.1);
	sound = 0.5 * Mix.ar( SinOsc.ar(freqs, (2pi ! 9).rand, amps/amps.sum) );
	// sound = perc * 0.5 * SinOsc.ar(freq*percf, 2pi.rand) * XLine.ar(1,1e-6,2*decay+1) + sound;
	// sound = sound + BAllPass.ar(sound, 1000*LFTri.kr(vrate,0,vibrato/2,1));
	// panning
	// sound = Pan2.ar(sound, FSinOsc.kr(1.43));
	Out.ar(out, sound*env);
}).add;
)


// 動く装置
(
f = {arg value, fromMin, fromMax, toMin, toMax;((value - fromMin) * (toMax - toMin) / (fromMax - fromMin)) + toMin;};
Routine({
	loop {
		var rand = rrand(0.0, 1.0);
		var freq = 800;
		var sustain = f.value(rand, 0, 1, 0.1, 0.08) * f.value(freq, 1000, 5000, 0.6, 0.5);
		var accelerate = 0;
		var pan = 0;
		var amp = f.value(rand*rand, 0, 1, 0.06, 1);
		amp = amp * f.value(rrand(0.0, 1.0)*rrand(0.0, 1.0), 0, 1, 0, 1);
		Synth("simpleSineWave", ["amp", amp*0.1, "freq", freq, "sustain", sustain, "pan", pan, "accelerate", accelerate, "lpf", 5000]);
		0.03.yield;
	}
}).play;
)


(
SynthDef("simpleSawWaveCut", {
	arg amp=1, sustain=1, pan=0, freq=110, accelerate=0, lpf=5000, out=0;
	var sound, env;
	freq = freq * Line.kr(1, 1+accelerate, max(0.5, sustain));
	sound = Saw.ar(freq).dup!2 * 0.5;
	sound = LPF.ar(sound, lpf);
	sound=NumChannels.ar([sound*(1-pan)/2, sound*(1+pan)/2], 2);
	env = EnvGen.ar(Env.linen(0.01, 0.8, 0.01, 1, 0), timeScale:sustain, doneAction:2);
	Out.ar(out, sound*env*amp);
}).add;
)

(
SynthDef("simpleSawWaveRev", {
	arg amp=1, sustain=1, pan=0, freq=110, accelerate=0, lpf=5000, out=0;
	var sound, env;
	freq = freq * Line.kr(1, 1+accelerate, max(0.5, sustain));
	sound = Saw.ar(freq).dup!2 * 0.5;
	sound = LPF.ar(sound, lpf);
	sound=NumChannels.ar([sound*(1-pan)/2, sound*(1+pan)/2], 2);
	env = EnvGen.ar(Env.linen(0.6, 0, 0.01, 1, 1), timeScale:sustain, doneAction:2);
	Out.ar(out, sound*env*amp);
}).add;
)

Env.linen(0.6, 0, 0.01, 1, 3).plot

(
SynthDef(\zureSc, {|out, amp=1, sustain=1, pan, accelerate, freq, decay=0, slide=1, detune=1 |
	// var env = EnvGen.ar(Env.linen(0.0001, 0, 0.6, 1, -3), timeScale:sustain, doneAction:2);
	// var env = EnvGen.ar(Env.linen(0, 0, 0.6, 1, -2), timeScale:sustain, doneAction:2);
	var basefreq = freq * Line.kr(1, 1+accelerate, sustain);
	var sound = VarSaw.ar(basefreq, 0, Line.ar(0,0.5,sustain*20/slide));
	var sound2 = VarSaw.ar(basefreq*(detune/100+1), 0, Line.ar(0,0.5,sustain*20/slide));
	var sound3 = VarSaw.ar(basefreq*(-1*detune/100+1), 0, Line.ar(0,0.5,sustain*20/slide));
	var lpfEnv = 800 + EnvGen.ar(Env.linen(0, 0, 0.5, 1000, -30), timeScale:sustain);
	sound = sound - DelayN.ar(sound2,0.2, Line.ar(0,1,5*sustain/slide)/basefreq)
	+ DelayN.ar(sound3,0.2, Line.ar(0,1,20*sustain/slide)/basefreq);
	// sound = LPF.ar(sound, 800);
	Out.ar(out, sound!2*0.05*amp);
}, [0, 1, 0, 0, 0, 0.2]).add;
)

(
a = Synth(\zureSc, [\amp, 0, \freq, 110, \vibrato, 2, \vrate, 32]);
b = Synth(\zureSc, [\amp, 0, \freq, 123.471, \vibrato, 2, \vrate, 53]);
c = Synth(\zureSc, [\amp, 0, \freq, 82.407, \vibrato, 2, \vrate, 64]);
)

(
a.set(\amp, 1);
b.set(\amp, 1);
c.set(\amp, 1);
)

(
SynthDef("simpleSawWaveSc", {
	arg amp=1, sustain=1, pan=0, freq=110, accelerate=0, lpf=5000, out=0;
	var sound;
	freq = freq * Line.kr(1, 1+accelerate, max(0.5, sustain));
	sound = Saw.ar(freq).dup!2 * 0.5;
	sound = LPF.ar(sound, lpf);
	sound=NumChannels.ar([sound*(1-pan)/2, sound*(1+pan)/2], 2);
	Out.ar(out, sound*amp);
}).add;
)



(
a = Synth(\saw, [\amp, 0, \freq, 110, \vibrato, 1, \vrate, 32, \lpf, 1000]);
b = Synth(\saw, [\amp, 0, \freq, 220, \vibrato, 1, \vrate, 32, \lpf, 1000]);
c = Synth(\saw, [\amp, 0, \freq, 330, \vibrato, 1, \vrate, 32, \lpf, 1000]);
d = Synth(\saw, [\amp, 0, \freq, 55, \vibrato, 1, \vrate, 32, \lpf, 1000]);
e = Synth(\saw, [\amp, 0, \freq, 165, \vibrato, 1, \vrate, 32, \lpf, 1000]);
)

(
var masterVol = 5;
a.set(\amp, 0.2*masterVol, \freq, 110, \parFreq, 0.22, \reverb, 0.8, \pan2Freq, 0.03, \bpf, 110);
b.set(\amp, 0.25*masterVol, \freq, 220, \parFreq, 0.13, \reverb, 0.8, \pan2Freq, 0.07, \bpf, 220*4);
c.set(\amp, 0.3*masterVol, \freq, 165, \parFreq, 0.1, \reverb, 0.8, \pan2Freq, 0.05, \bpf, 165*3);
d.set(\amp, 1*masterVol, \freq, 55, \parFreq, 0.5, \reverb, 0.8, \pan2Freq, 0, \bpf, 55);
e.set(\amp, 0.1*masterVol, \freq, 275, \parFreq, 0.08, \reverb, 0.8, \pan2Freq, 0.03, \bpf, 275*2);
)



// tsub

(
var masterVol = 1;
a.set(\amp, 0.2*masterVol, \freq, 164.814, \parFreq, 0.22, \reverb, 0.8, \pan2Freq, 0.03, \bpf, 164.814);
b.set(\amp, 0.25*masterVol, \freq, 164.814*2, \parFreq, 0.13, \reverb, 0.8, \pan2Freq, 0.17, \bpf, 164.814*4);
c.set(\amp, 0.2*masterVol, \freq, 164.814*1.5, \parFreq, 0.1, \reverb, 0.8, \pan2Freq, 0.13, \bpf, 164.814*1.5*3);
d.set(\amp, 1*masterVol, \freq, 164.814*0.5, \parFreq, 0.5, \reverb, 0.8, \pan2Freq, 0, \bpf, 164.814*0.5);
e.set(\amp, 0.2*masterVol, \freq, 164.814*2.5, \parFreq, 0.08, \reverb, 0.8, \pan2Freq, 0.1, \bpf, 164.814*2.5*2);
)


// ホーミー


a = Synth(\saw, [\amp, 0]);

a.set(\amp, 5, \freq, 164.814*0.25, \parFreq, 110*4, \reverb, 1, \ice, 0, \pan2Freq, 103.826*2, \bpf, 164.814*1, \vibrato, 0.5, \vrate, 32);








s = Synth(\saw, [\amp, 0])

s.set(\amp, 10,\freq, 164*0.25,\bpf, 164*0.5, \reverb, 0.9, \pan2Freq, 103*2.0, \parFreq, 110*2.0, \ice, 0.0, \vibrato, 0.3, \vrate, 32)


s.set(\amp, 10,\freq, 164*0.25,\bpf, 164*0.5, \reverb, 1, \pan2Freq, 103*2.0, \parFreq, 110*4.0, \ice, 1, \vibrato, 0.5, \vrate, 32)


(
SynthDef(\padDirt, {
	| out = 0, amp = 1, freq = 440, gate=1, sustain=1, modspeed=1|
	var freqs = { freq * LFNoise2.kr(freq:1,mul:0.01,add:1) }!24;
	var gen = LFSaw.ar(freq:freqs) * 0.1;
	var fmod = 1;
	//var fmod = LFCub.kr(freq:1/12).range(1, LFNoise2.kr(freq:1).range(6,7)); // sharper sound
	var rqmod = LFNoise2.kr(freq:1/8).range(0.1,1.0);
	// modspeed = 1/sustain;
	// var modspeed = 1/(Rand(0.4,10));
	// var modspeed = 110; // tremolo sound
	// var modspeed = 1000*LFNoise2.ar(freq:40); // wobble sound (works best with sharper sounding pad)
	var snd = RLPF.ar(in:gen, freq:SinOsc.kr(modspeed).range(freqs*0.8, freqs*1.2) * fmod, rq:rqmod);
	var env = EnvGen.ar(Env.linen(0.1, 0, 0.6, 1, -3), timeScale:sustain, doneAction:2);
	Out.ar(bus:out, channelsArray:Splay.ar(snd*amp*env));
}).add;
)
