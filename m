Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433C034CFDF
	for <rcu@vger.kernel.org>; Fri, 20 Mar 2026 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774040045; cv=none; b=i6hld5COJsaojsQO1YiBf5SOC+ReT2fShyMZYT0qEdI4oDoOU0k928+w24GEL/mlLdamN/1gKzuGXWhaQfSXui3oOzph1JPd8RF68xKxsV3RJlXaGR7m3rdVk90dpoZ/EU36QPEns50+hOnsEVDU16otUYIAQr0yT+E/WyEa8fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774040045; c=relaxed/simple;
	bh=gRVOFegaxn51Tt9lYq62XbZzAjL7sjicd+sG+wqplsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJRhtXwY7Eg4RQGperKpvh4bn0UlrlACDgAe+3PWxa1cdxZTAPiJPkyRfGQIkWblZPHmKzLktSV2L4VlUzfmr0BmPIFHfN6imI7C0wwkJl9S1N3TQZfnQjBoj4CP1OGK+unT34Y0NH2BjTHj/bQqlYS7wwkVB+6oQ3AkTORWihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nx+uBrL3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nx+uBrL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7436CC4AF09;
	Fri, 20 Mar 2026 20:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774040045;
	bh=gRVOFegaxn51Tt9lYq62XbZzAjL7sjicd+sG+wqplsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nx+uBrL3WhMCGonXfI1zO1Dhm+alypVn0vVQz00MoBfQbaJJ12tysfTuqekMVbCF7
	 EDXXTSHeqgh0jbzLMTHH1sECXuTGwF0rUltAPlI/My6elejXUZjsO0axY5/nyEbdqS
	 EviTordBN5auWsS6TviUKnWo8+OvH2vMMX4XiQI/3E0Wq2fx7wyJ6AJ7BO/qJBhX/Y
	 l9tsa/jQizX+mNBLWPCWLQZ9uiRxOqp6XfrzV352B/53imwR12lNSbYYpZTkkrIg5b
	 8gDqI09Q4nVJZN5rWKcuiNggoOrG6QCRPN/8LD+GBB5BkxsMlq3BgqEVlPFowKR6Iz
	 PM+Tu5Bn7q8cg==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5D7C8F4006D;
	Fri, 20 Mar 2026 16:54:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 20 Mar 2026 16:54:03 -0400
X-ME-Sender: <xms:67O9abavU8rezNzex8u4XhnylJv0bCOuP4rpuUyUNywUEdY-X58NjA>
    <xme:67O9aTygrfZsvyD8Xf3_2yYDxLmKUjkHWzCTRWIa7vcLmf9Al6uug5rXNji_VoE-V
    aNoxR5F4EyHbPleZiPxyun6JZgNDM1ugmQ_GS_BCyNuXdTY8A1viQ>
X-ME-Received: <xmr:67O9aWdfMpXUsnb2OPIa0ppAEYO5rMa-XzBQv8rkbN088QwMO2Vjm6YQksGJ3wfUHlhRK3_5YimJQ3NqHhTuxx7sPo1CRDAI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elueehtefhtddtgfejvdejueehhfekteevueeuueekgeetieeggeehvdffhefhhfenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrrhhighhhihesnhhvihguihgrrdgtohhmpd
    hrtghpthhtohepjhhovghlrghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgtphhtthho
    pehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvghmgihorhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhhonhhigidr
    uggvpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehnvggvrhgrjhdrihhithhruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhr
    vgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:67O9aRKnVUlSIvPOHOAvkHa-FclqpbUnukom07Mop8HPOxW0lwiGSQ>
    <xmx:67O9aX1U16x8CFMW9o9ys_RFikoiZlQLHLea0sAH-7wBUSPKs8mN2Q>
    <xmx:67O9aSYRVQSFf3NWagslGM00bnQ1dcyZZXoUWFjeXTBFe6-vFPiCLg>
    <xmx:67O9aZgTnsJ24gW4RcIf6E4CESHKgvux3H-fZQ66ofn5m7VcLlsTyg>
    <xmx:67O9aZ-mTQxaHU7Rl23cLAhVRih3t5gG3PGSb4fLKvE4kO6n75lB31gH>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 16:54:02 -0400 (EDT)
Date: Fri, 20 Mar 2026 13:54:01 -0700
From: Boqun Feng <boqun@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH] rcu: Use an intermediate irq_work to start process_srcu()
Message-ID: <ab2z6XRzTajNADK2@tardis.local>
References: <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>
 <20260320181400.15909-1-boqun@kernel.org>
 <ab2yd35rm6OgZUmb@gpd4>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab2yd35rm6OgZUmb@gpd4>

On Fri, Mar 20, 2026 at 09:47:51PM +0100, Andrea Righi wrote:
> Hi Boqun,
> 
> On Fri, Mar 20, 2026 at 11:14:00AM -0700, Boqun Feng wrote:
> > Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> > of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> > happen basically everywhere (including where a scheduler lock is held),
> > call_srcu() now needs to avoid acquiring scheduler lock because
> > otherwise it could cause deadlock [1]. Fix this by following what the
> > previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> > the work to start process_srcu().
> > 
> > [boqun: Apply Joel's feedback]
> > 
> > Reported-by: Andrea Righi <arighi@nvidia.com>
> > Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> > Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> > Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
> > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > Signed-off-by: Boqun Feng <boqun@kernel.org>
> > ---
> > @Zqiang, I put your name as Suggested-by because you proposed the same
> > idea, let me know if you rather not have it.
> > 
> > @Joel, I did two updates (including your test feedback, other one is
> > call irq_work_sync() when we clean the srcu_struct), please give it a
> > try.
> 
> I'm getting this at boot with this patch applied (testing directly from
> Joel's branch rcu/dev):
> 
> [    0.639477] DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())

My bad, this is missing:

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 73aef361a524..e08aaacad695 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1993,13 +1993,14 @@ static void srcu_irq_work(struct irq_work *work)
        struct srcu_struct *ssp;
        struct srcu_usage *sup;
        unsigned long delay;
+       unsigned long flags;

        sup = container_of(work, struct srcu_usage, irq_work);
        ssp = sup->srcu_ssp;

-       raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
+       raw_spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
        delay = srcu_get_delay(ssp);
-       raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
+       raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);

        queue_delayed_work(rcu_gp_wq, &sup->work, !!delay);
 }

Regards,
Boqun

> [    0.639479] WARNING: kernel/locking/lockdep.c:4404 at lockdep_hardirqs_on_prepare+0x15e/0x1a0, CPU#0: swapper/0/1
> [    0.639507] Modules linked in:
> [    0.639507] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-rc3-virtme #5 PREEMPT(full)
> [    0.639507] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [    0.639507] RIP: 0010:lockdep_hardirqs_on_prepare+0x165/0x1a0
> [    0.639507] Code: cc 90 e8 0e b1 4e 00 85 c0 74 0a 8b 35 54 08 43 02 85 f6 74 31 90 5b c3 cc cc cc cc 48 8d 3d d2 3c 44 02 48 c7 c6 b9 58 c5 b2 <67> 48 0f b9 3a eb ac 48 8d 3d cd 3c 44 02 48 c7 c6 37 55 c5 b2 67
> [    0.639507] RSP: 0018:ffffd26700003f58 EFLAGS: 00010046
> [    0.639507] RAX: 0000000000000001 RBX: ffffffffb35719f8 RCX: 0000000000000001
> [    0.639507] RDX: 0000000000000000 RSI: ffffffffb2c558b9 RDI: ffffffffb36bf810
> [    0.639507] RBP: ffffffffb35718e0 R08: 0000000000000001 R09: 0000000000000000
> [    0.639507] R10: 0000000000000001 R11: 000000007cb360a8 R12: 0000000000000000
> [    0.639507] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [    0.639507] FS:  0000000000000000(0000) GS:ffff8a7e076f6000(0000) knlGS:0000000000000000
> [    0.639507] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.639507] CR2: ffff8a7dbffff000 CR3: 0000000023452000 CR4: 0000000000750ef0
> [    0.639507] PKRU: 55555554
> [    0.639507] Call Trace:
> [    0.639507]  <IRQ>
> [    0.639507]  trace_hardirqs_on+0x18/0x100
> [    0.639507]  _raw_spin_unlock_irq+0x28/0x50
> [    0.639507]  srcu_irq_work+0x63/0x90
> [    0.639507]  irq_work_single+0x69/0x90
> [    0.639507]  irq_work_run_list+0x26/0x40
> [    0.639507]  irq_work_run+0x18/0x30
> [    0.639507]  __sysvec_irq_work+0x35/0x1b0
> [    0.639507]  ? irq_exit_rcu+0xe/0x20
> [    0.639507]  sysvec_irq_work+0x6e/0x80
> [    0.639507]  </IRQ>
> [    0.639507]  <TASK>
> [    0.639507]  asm_sysvec_irq_work+0x1a/0x20
> [    0.639507] RIP: 0010:_raw_spin_unlock_irqrestore+0x36/0x70
> [    0.639507] Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 b1 3d 26 ff 48 89 df e8 d9 a1 26 ff f7 c5 00 02 00 00 75 17 9c 58 f6 c4 02 75 2b <65> ff 0d 33 62 f0 01 74 16 5b 5d c3 cc cc cc cc e8 f5 83 35 ff 9c
> [    0.639507] RSP: 0018:ffffd26700013d48 EFLAGS: 00000246
> [    0.639507] RAX: 0000000000000092 RBX: ffffffffb35719f8 RCX: ffffffffb2017e0b
> [    0.639507] RDX: ffff8a7d80338000 RSI: 0000000000000000 RDI: ffffffffb2017e0b
> [    0.639507] RBP: 0000000000000282 R08: 0000000000000000 R09: 0000000000000001
> [    0.639507] R10: 0000000000000001 R11: 000000007cb360a8 R12: ffff8a7dbb628a40
> [    0.639507] R13: 0000000000000000 R14: ffffffffb3571940 R15: 0000000000000001
> [    0.639507]  ? _raw_spin_unlock_irqrestore+0x4b/0x70
> [    0.639507]  ? _raw_spin_unlock_irqrestore+0x4b/0x70
> [    0.639507]  srcu_gp_start_if_needed+0x37a/0x520
> [    0.639507]  ? __pfx_rcu_init_tasks_generic+0x10/0x10
> [    0.639507]  __synchronize_srcu+0xf6/0x1b0
> [    0.639507]  ? __pfx_wakeme_after_rcu+0x10/0x10
> [    0.639507]  ? __pfx_rcu_init_tasks_generic+0x10/0x10
> [    0.639507]  rcu_init_tasks_generic+0xfe/0x120
> [    0.639507]  do_one_initcall+0x6f/0x300
> [    0.639507]  kernel_init_freeable+0x24b/0x2b0
> [    0.639507]  ? __pfx_kernel_init+0x10/0x10
> [    0.639507]  kernel_init+0x1a/0x130
> [    0.639507]  ret_from_fork+0x2bd/0x370
> [    0.639507]  ? __pfx_kernel_init+0x10/0x10
> [    0.639507]  ret_from_fork_asm+0x1a/0x30
> [    0.639507]  </TASK>
> [    0.639507] irq event stamp: 6418
> [    0.639507] hardirqs last  enabled at (6417): [<ffffffffb2017e0b>] _raw_spin_unlock_irqrestore+0x4b/0x70
> [    0.639507] hardirqs last disabled at (6418): [<ffffffffb20013fe>] sysvec_irq_work+0xe/0x80
> [    0.639507] softirqs last  enabled at (6406): [<ffffffffb11ce7b6>] __irq_exit_rcu+0x96/0xc0
> [    0.639507] softirqs last disabled at (6401): [<ffffffffb11ce7b6>] __irq_exit_rcu+0x96/0xc0
> [    0.639507] ---[ end trace 0000000000000000 ]---
> 
> Thanks,
> -Andrea
