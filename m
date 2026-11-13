Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585185;
	b=pZSCVC49tA5V9elGXsD8osylXaVKaO+aVDu4DfdIN4/Yzg8DDT7f24gWdG1gitZDomtL
	 FSSQv1u4JjOJYnQAdeLxMBV44LKmoEMdiT44yTK7/hQpuou2hZrFaeA7CGYLexhuD3XNt
	 Q/BYfhHG6btph13Ma9b6PvYBig1I3BNaoKIbz46l7CoMccEATN+UZhe8aXtccJTAR5rWu
	 BZ9qhAVFcxm5JieTos+7WwIMyZ/vqg5kqPaj/FfVJojTXeX0Z0uv9FmkXb1Q1ScnA4EKs
	 MGHvmr4mTJI2/ZvSrGR6SaQKQ8W2arB8zu4XnkCMvpkvcqXtfznLAL4yAtKk2pYfT3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585185;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=lPBrGEpxfeP7+RLyhevc3uBzt+GD4i3aOMdb5mw30PI=;
	b=S/w8VvhF+SpTBewpZgs1wV/aoUwvzhuYKjVG03CANeVa4tiaI7pMTfRjYRFKivNgfgyd
	 5IdKSzq/wNUD8xTzy+BG5xJdLBzB9VgEveiyygZ75hnoEhUkU6UR/o1UStQCNdOGbibYf
	 GHl2AXz5HjO1GM39kpby3Qet1OiG3sONR/5KNbPx93jovpj84CbqUzAlEj4ujexP0WOHU
	 Zt0a266awpqVaQ2u7kB57T1AlScOR53F+LGpAtZf+luMhPiHCKJEFkdqTUo+KRzTPVjpS
	 +xs/ghlpJnNYYzeSmnjRUWBRmoAJiS49J3Aq4ZEUQgj9tEA7Rqd0ggFwQrwpRF5X+hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=4IUh16L0;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5AhhZpnL;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5A606A323;
	Fri, 13 Nov 2026 15:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59B5A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=4IUh16L0;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5AhhZpnL
Date: Fri, 13 Nov 2026 16:53:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794585183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPBrGEpxfeP7+RLyhevc3uBzt+GD4i3aOMdb5mw30PI=;
	b=4IUh16L0+T4jJDUfeeP1FSADGyvB5RgyV6jGX1mSu3E7SwRbEqdy2XhLG8tZsSVWY07LDN
	zsQRJkpMvoHjyo/u8DQ20va0UVy6qXQb5wp8woVnxf7Z+uPOqMJb9zSR6RGkQ5uBbx2MIL
	gUaSCBuK4Jb7tbn84ZjlIr+evL5Jvgg6ftohMy59UWwCF7hT2sHj+cz/j65MH0Xxkadqkv
	faOsSw5hmC6ystIQXp/UceCLT3ll95qc+kUzYJMkp/j4HYXplRZRXj6Nq3ZhpWBhbAPhCl
	VidzsObwtecSSBfmRyS1ty7sOlBJyEGpMYOM4C74LFnMklW4RM+U7WqlDLcoPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794585183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPBrGEpxfeP7+RLyhevc3uBzt+GD4i3aOMdb5mw30PI=;
	b=5AhhZpnLVslG5PKTWBqXp396wPeODEOzc+qtMYsDAfat1cOIH+mqrXn2weZwuGQ+vA4ytb
	SForDyVsyX6YmoBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 1/7] rcutorture: Rewrite RCU priority-boost test
 around a CPU-hungry reader
Message-ID: <20261113155301.Rs-PyiuR@linutronix.de>
References: <20261111213826.2035045-1-joelagnelf@nvidia.com>
 <20261111213826.2035045-2-joelagnelf@nvidia.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261111213826.2035045-2-joelagnelf@nvidia.com>

On 2026-11-11 16:38:19 [-0500], Joel Fernandes wrote:
> The old boost test relies on RT throttling being disabled and on grace
> periods taking too long, which is fragile.  Instead, each interval one
> CPU runs a normal-priority reader that spins inside an RCU read-side
> critical section until it has consumed test_boost_reader_ms of CPU time
> (measured via sum_exec_runtime, so time spent preempted does not count),
> while a SCHED_FIFO hog on the same CPU tries to starve it.  With RT
> throttling enabled, an unboosted reader gets only about 5% of the CPU,
> far less than it needs within test_boost_duration.  If the reader
> finishes, boosting worked, otherwise it failed.

What I see from tracing is:

| rcu_torture_boo-2066    [001] d..2.   237.448002: sched_switch: prev_comm=
=3Drcu_torture_boo prev_pid=3D2066 prev_prio=3D120 prev_state=3DR+ =3D=3D> =
next_comm=3Drcu_torture_boo next_pid=3D93 next_prio=3D98

preempted as SCHED_OTHER

|          rcub/0-16      [003] d..3.   237.460085: sched_pi_setprio: comm=
=3Drcu_torture_boo pid=3D2066 oldprio=3D120 newprio=3D97

boosted shortly after

| rcu_torture_boo-93      [001] d..2.   237.460108: sched_switch: prev_comm=
=3Drcu_torture_boo prev_pid=3D93 prev_prio=3D98 prev_state=3DR+ =3D=3D> nex=
t_comm=3Drcu_torture_boo next_pid=3D2066 next_prio=3D97
| rcu_torture_boo-2066    [001] d.h1.   237.463994: sched_stat_runtime: com=
m=3Drcu_torture_boo pid=3D2066 runtime=3D3908069 [ns]
| rcu_torture_boo-2066    [001] d.h1.   237.467985: sched_stat_runtime: com=
m=3Drcu_torture_boo pid=3D2066 runtime=3D3991212 [ns]
| rcu_torture_boo-2066    [001] d.h1.   237.471995: sched_stat_runtime: com=
m=3Drcu_torture_boo pid=3D2066 runtime=3D4009726 [ns]

back on CPU and not pushed away.
|  rcu_torture_boo-2066    [001] dN.2.   238.397969: sched_stat_runtime: co=
mm=3Drcu_torture_boo pid=3D2066 runtime=3D5311 [ns]
|  rcu_torture_boo-2066    [001] d..2.   238.397975: sched_switch: prev_com=
m=3Drcu_torture_boo prev_pid=3D2066 prev_prio=3D97 prev_state=3DR+ =3D=3D> =
next_comm=3Dkworker/1:3 next_pid=3D1386 next_prio=3D120
|     kworker/1:1H-745     [001] d..2.   238.398067: sched_switch: prev_com=
m=3Dkworker/1:1H prev_pid=3D745 prev_prio=3D100 prev_state=3DI =3D=3D> next=
_comm=3Drcu_torture_boo next_pid=3D2066 next_prio=3D97
|  rcu_torture_boo-2066    [001] d.s3.   238.398122: sched_waking: comm=3Dk=
worker/1:3 pid=3D1386 prio=3D120 target_cpu=3D001
|  rcu_torture_boo-2066    [001] d.s4.   238.398124: sched_stat_runtime: co=
mm=3Drcu_torture_boo pid=3D2066 runtime=3D63431 [ns]
|  rcu_torture_boo-2066    [001] dNs4.   238.398128: sched_wakeup: comm=3Dk=
worker/1:3 pid=3D1386 prio=3D120 target_cpu=3D001
|  rcu_torture_boo-2066    [001] d..2.   238.398130: sched_switch: prev_com=
m=3Drcu_torture_boo prev_pid=3D2066 prev_prio=3D97 prev_state=3DR+ =3D=3D> =
next_comm=3Dkworker/1:3 next_pid=3D1386 next_prio=3D120
|      kworker/1:3-1386    [001] d..2.   238.398137: sched_switch: prev_com=
m=3Dkworker/1:3 prev_pid=3D1386 prev_prio=3D120 prev_state=3DI =3D=3D> next=
_comm=3Drcu_torture_boo next_pid=3D2066 next_prio=3D97
|  rcu_torture_boo-2066    [001] d.h1.   238.399986: sched_stat_runtime: co=
mm=3Drcu_torture_boo pid=3D2066 runtime=3D1851337 [ns]
|  rcu_torture_boo-2066    [001] d.h1.   238.400081: sched_stat_runtime: co=
mm=3Drcu_torture_boo pid=3D2066 runtime=3D94860 [ns]

The fair_server preempts now and then.
|  rcu_torture_boo-2066    [001] d.h1.   239.455988: sched_stat_runtime: co=
mm=3Drcu_torture_boo pid=3D2066 runtime=3D4002590 [ns]
|  rcu_torture_boo-2066    [001] d..3.   239.455999: sched_waking: comm=3Dr=
cu_preempt pid=3D15 prio=3D97 target_cpu=3D000
|  rcu_torture_boo-2066    [001] d..3.   239.456012: sched_waking: comm=3Dr=
cu_exp_gp_kthr pid=3D18 prio=3D120 target_cpu=3D002
|  rcu_torture_boo-2066    [001] d..3.   239.456023: sched_pi_setprio: comm=
=3Drcu_torture_boo pid=3D2066 oldprio=3D97 newprio=3D120
|  rcu_torture_boo-2066    [001] d..3.   239.456024: sched_stat_runtime: co=
mm=3Drcu_torture_boo pid=3D2066 runtime=3D35773 [ns]
|  rcu_torture_boo-2066    [001] d..2.   239.456032: sched_switch: prev_com=
m=3Drcu_torture_boo prev_pid=3D2066 prev_prio=3D120 prev_state=3DR+ =3D=3D>=
 next_comm=3Drcu_torture_boo next_pid=3D93 next_prio=3D98

Leaving the RCU section and getting de-boosted.

This looks good.

=E2=80=A6

> Success testing: with the series applied and no other changes, run
> TREE01 TREE02 TREE03 TREE08 TREE09 BUSTED-BOOST for 10 minutes each.
> Every scenario ended "SUCCESS" with rtbf (boost failures) of 0 in 59 to
> 83 boost intervals.  (BUSTED-BOOST can no longer fail by construction
> because CONFIG_RCU_BOOST is now enabled automatically for preemptible
> RCU.)

I didn't run the individual tests but checked in my rcu-tree setup that
boosting works as it should and that it complains once it does not. And
the throttling of the RT tasks has no visible impact.

Sebastian
