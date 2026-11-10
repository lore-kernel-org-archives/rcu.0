Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336512;
	b=zTy5CYqB7keOeLjFzfZW6TnTNfwS3d45E+w1MAyV5ixozM2BYPaezx2jRS+nryuXk5va
	 S2MiovlzzQBPJOh3KC0WG/+un9OGa53qeCsdULvRVVoNK3fwcMpjkHOGUXF1Go7sEjY8a
	 FbFNs0mF5lt4FEsBu5mnf4tR2VMzoP37zb/xsCCAGDcBElEazQNNMqhAGq6eMXAOzmh08
	 5YkX/DCf+oz9pJb79Bceq+GWwW9pAiLeHMdcBqePpO4hhOGyJtA27W6oG0PHeC516kQ0m
	 tV5YjBy/Q2pudGeeOMEUT0vWKhbwSheCTNS7pEgmd02fwCatSl0hSuxafAC2l9ZTehg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336512;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=bCemIeKvHjQDH1MHT65rkJ+916M7KPAv7Dui2YnOhxQ=;
	b=Q7LKD0Jhz5siu0bixxbwp+sCw744GBDYDJbLaq9hme/Ly6ocIKt2ddXjqKsh0QOklLWk
	 x2B+5sAzGORExGRHHGTwyCnpunqBVWGTQ3XtheV6g7UIL6l6T5PivayHt4KBVfzob7k2b
	 LMc5AKDjL6f0WHc5XnuSfM+jbCy+Q8NWErkYt99Pabxi9CcwbRtR7SK1Aa9e11EZL+LoP
	 4b7GG5W27HT9/Ddx2LTJjSntt/C0JqaFoMExpEVxK6ZxmJE4be5cu2t67JPunuWplv9Dn
	 7E8vYTHCyrQfKqt4WGUbkNJekIxJUb0ujVdM/JM3X5+m4GsAlVjuNLaHO9WK7XG6W8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eiy3OA/S";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD01A606A327;
	Tue, 10 Nov 2026 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eiy3OA/S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923181F0089F;
	Tue, 10 Nov 2026 18:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336511;
	bh=bCemIeKvHjQDH1MHT65rkJ+916M7KPAv7Dui2YnOhxQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=eiy3OA/S89ESrHaXhC7LI4eeQYA9e0zr6+Fv/6JLcF5NaXFz+bnYGEzcAsdbgXHVq
	 Zd0/HOKxMZhL12oxxfugizrDgTpJdDi43ZN1v8mc7Z9z6OJ1WKDcVz4FZhj2onMNl1
	 pw68dGW6rriy3Y2aatjJZeOrBM4FDgERH28HDYL7vFpjnSpyzQkekIyy745gGmZvDH
	 5xRdsrh94WdLmnGr0TlEGtKuJEk/+C9yuWGT8vM0WpTq0TedfDSHHS8Ip1i/FlHsMV
	 gfL8TVMtuBlGkeULoHhEHOR5N7EvO1WAr09N+7CuCtRVPE+BEMIdsvyDIAizOcroak
	 EgvCUg9bBgKWA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 35029CE0AD8; Tue, 10 Nov 2026 10:48:31 -0800 (PST)
Date: Tue, 10 Nov 2026 10:48:31 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrea Righi <arighi@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] rcutorture: Don't try to disable to RT throttling.
Message-ID: <e58e48c3-ac62-40cd-b5d3-2de87db12496@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261105165113.82N-rPMG@linutronix.de>
 <2fbdb03e-1af8-489c-819a-7e3c7b0ed1be@paulmck-laptop>
 <5970553A-3833-43F1-A013-21757664FB8F@nvidia.com>
 <auzXjQfYXs_gzx1y@gpd4>
 <c81d8243-c130-44d8-bef6-e678ecb088ac@paulmck-laptop>
 <20261106140401.90MH_6qt@linutronix.de>
 <5f5ffa5b-9fa5-4359-87fc-7558f37ff0eb@paulmck-laptop>
 <20261110080942.QxKXirzI@linutronix.de>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110080942.QxKXirzI@linutronix.de>

On Tue, Nov 10, 2026 at 09:09:42AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-11-09 16:45:47 [-0800], Paul E. McKenney wrote:
> > On Fri, Nov 06, 2026 at 03:04:01PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2026-11-05 12:03:11 [-0800], Paul E. McKenney wrote:
> > > > > For rcutorture, I don't think there's a ready-made kernel interface,
> > > > > maybe we could add a sched helper that performs the same operation as
> > > > > the debugfs knobs?
> > > > 
> > > > I would very much appreciate that.  ;-)
> > > 
> > > This maybe? Since it is built-in only, there is no need to restore the
> > > old state, is there?
> > 
> > Hearing no objections, I will start testing this.  I am applying both of
> > your patches from this email thread, but please let me know if something
> > else would work better.
> 
> I have kept the first one and added a proper body for the second. I
> intend to repost it later today if nothing goes wrong.
> 
> > I would expect that this command would result in rcutorture complaining
> > about priority-boost failures because SRCU does not support priority
> > boosting.
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 15 --configs SRCU-P --bootargs "rcutorture.test_boost=2" --trust-make
> > 
> > But please correct me if I missed a turn in here somewhere.
> 
> SRCU doesn't do boosting so yes.
> I just stared at rcu_torture_boost() and I probably miss bits. I would
> expect this thread to run at SCHED_OTHER and then run at 100% for a
> period of time within a RCU-read section. Once the RCU machinery decides
> to start a GP and force a quiescent state it would instruct rcub/ to
> boost the tasks which stayed in their RCU read section (I *think* to be
> in RCU-section is enough because the idea was once to get task back on
> CPU which were scheduled out while in their RCU read section).
> Once this happens, the task should be with SCHED_FIFO priority and could
> leave the RCU section, un-boosting itself and passing the test.
> I don't see RCU-read locks but this might be done differently. I see
> multiple sched_set_fifo_low(current) but this shouldn't change. (Your
> priority shouldn't change (becomes lower) if your higher priority is
> due to priority-boosting.)
> 
> Your rcu_torture_boost() runs at FIFO-1. So if it does what I described
> but at FIFO-1 and rcub runs at FIFO-2 then it should still work.
> Throttling should just make it go slower.

Unfortunately, my overnight run of TREE03, which does do RCU priority
boosting and has for some years, fails with the splat shown at the end
of this email.  Things go rapidly downhill from there.

For reference, I used this command on a 16-hardware-thread x86
laptop:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 9h --configs TREE03 --bootargs "rcutorture.test_boost=2" --trust-make

The "rcutorture.test_boost=2" is redundant but I was lazy.

> > And yes, in the built-in case we normally don't care about restoring
> > state.  The usual situation is that the system (usually a guest OS)
> > is brought down at the end of the test anyway, in contrast to running
> > rcutorture non-builtin, that is, using modprobe and rmmod.
> 
> this makes things easier.

Don't worry, it won't happen again.  ;-)

							Thanx, Paul

> Sebastian

------------------------------------------------------------------------

[   35.163107] Oops: divide error: 0000 [#1] SMP PTI
[   35.164020] CPU: 12 UID: 0 PID: 111 Comm: cpuhp/12 Not tainted 7.4.0-rc1-00055-g667ceeb1c083 #35 PREEMPT(full) 
[   35.165977] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[   35.167589] RIP: 0010:dl_server_apply_params+0x2fa/0x470
[   35.168677] Code: 00 c1 e0 0a 4c 63 f8 e9 67 fe ff ff 48 8b 43 30 4c 8b 45 50 48 8b 35 55 c9 be 01 48 8b 7d 18 49 29 c0 99 48 21 f7 4c 89 45 50 <f7> 7c 24 2c 81 e7 ff ff 00 00 75 1e 4c 03 04 24 4c 89 45 50 48 8b
[   35.172289] RSP: 0000:ffffa7fd80427d90 EFLAGS: 00010046
[   35.173300] RAX: 0000000000000000 RBX: ffff88c71f52b3a0 RCX: 0000000000000000
[   35.174762] RDX: 0000000000000000 RSI: 000000000000afdd RDI: 0000000000000000
[   35.176165] RBP: ffffffff8840c5c0 R08: 0000000000000000 R09: 0000000000000001
[   35.177664] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000fffffff0
[   35.179115] R13: 000000003b9aca00 R14: 000000000000000c R15: 0000000000000000
[   35.180663] FS:  0000000000000000(0000) GS:ffff88c797138000(0000) knlGS:0000000000000000
[   35.182408] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.183625] CR2: 0000000000000000 CR3: 0000000009430000 CR4: 00000000000006f0
[   35.185179] Call Trace:
[   35.185741]  <TASK>
[   35.186131]  dl_server_fair_disable+0x67/0xa0
[   35.186972]  ? __pfx_rcutorture_booster_init+0x10/0x10
[   35.187993]  rcutorture_booster_init+0x9c/0x1c0
[   35.188828]  cpuhp_invoke_callback+0x2d8/0x480
[   35.189656]  ? __pfx_io_wq_cpu_online+0x10/0x10
[   35.190578]  cpuhp_thread_fun+0x89/0x140
[   35.191415]  smpboot_thread_fn+0xa1/0x260
[   35.192164]  ? __pfx_smpboot_thread_fn+0x10/0x10
[   35.192968]  kthread+0xe7/0x120
[   35.193542]  ? __pfx_kthread+0x10/0x10
[   35.194218]  ret_from_fork+0x1bd/0x220
[   35.194901]  ? __pfx_kthread+0x10/0x10
[   35.195623]  ret_from_fork_asm+0x1a/0x30
[   35.196304]  </TASK>
[   35.196730] Modules linked in:
[   35.197286] ---[ end trace 0000000000000000 ]---
