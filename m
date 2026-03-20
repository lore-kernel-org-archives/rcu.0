Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D43016EE
	for <rcu@vger.kernel.org>; Fri, 20 Mar 2026 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030830; cv=none; b=SNetOBvVsAKVTeegEqcGGjtFM7NOeBFiBIVT138qvexIxSOU7Y8iDm5s767yaYDoK/ARD9eyHu0218iw1skIUzGklaKAIiBhvvVpZTkBRpkuG2Glk7SE2U319+j6KcwzQAElxOXWngWWmfppIFxEnz98leeaSNdD2v23Wf+2JfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030830; c=relaxed/simple;
	bh=kMoX2ELC/zWDMwsxu2y/RMxWec1AjmlgLXIrLOnS8fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTL3Tiu5gRrUlorfhZEL00uPXzQYrbcVMAS0w5MmExLMIKBqoC0AUXRyaufhrK8yc93ijtRSRR+a6gvdZaJchHnTnCKeP4I76ppNYpAT7IKUDo1wNN4hacof7kiWLKC7qHpzkVLUaqnNmCmLoo5FYMl/Dcg1hOYhS45p0mqVIGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEa9elLk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEa9elLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A03DC4CEF7;
	Fri, 20 Mar 2026 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774030830;
	bh=kMoX2ELC/zWDMwsxu2y/RMxWec1AjmlgLXIrLOnS8fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EEa9elLkvqCR9O2yuC4VZ3o1kCte20xIBFcqlSnFS3XNLRuGjpmjKH3pDuTNOUd8d
	 ar8MkApfphsVLnh8Nws/SUL8PNwzPaK7VoDKBBiXv9fs+WG3RkfV4bX1/Tv2AMAdb1
	 Y1dit+hGzFi3GSTP7KstukEJ9UUoE5mm5cdbVbJVfl+HaiUn3SbLcpRkANPFjqmisa
	 16dP8PAb5yP04nCy2nVoi3rOeN+C9doNpLmNriptyykIUCpzgi0onNR+l6lgpxzvLi
	 sUPYijk7fv+6LFjf3h0gO6tkEoTj9dfMv+v4fJgSTABvT+GmnHlz30MtmfJcum1ABb
	 Vj1MI6XPFJQmg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 16475F4007A;
	Fri, 20 Mar 2026 14:20:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 20 Mar 2026 14:20:29 -0400
X-ME-Sender: <xms:7Y-9aeINsjbjzO0YYF5C-tWULoiK8JmN1_Yos6N531gL291lMNsVWw>
    <xme:7Y-9aQgK1pH3dso8qS9A6ikEj60wQ9BFvZ2irR8Lf6KiIqeMAxqgBHZF6Rwg61RHt
    wvWVFjvhIEgMxu7gZsKRSNG0jtCGaRr9qPOtHNbx6PbNUyltsI1_JM>
X-ME-Received: <xmr:7Y-9aU0VTEFF2d8keo34yDmfqazoF0PJZ4KXGj-bR4r0tKp0sLFXN3RivmtEOFtQjoZ1Vt4tW4LBkuucWF0m7dvPnAc5q5qx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elueehtefhtddtgfejvdejueehhfekteevueeuueekgeetieeggeehvdffhefhhfenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohgvlhgrghhnvghlfhesnhhvihguihgrrd
    gtohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepmhgvmhigohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghighgvrghshieslh
    hinhhuthhrohhnihigrdguvgdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhiihhtrhdutdesghhmrghilhdrtghomh
    dprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopegsohhq
    uhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehrtghusehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7Y-9aehj66x5bBRAHzP1LZhpAGdzA_eeE1ceFmvIG79AckiHMS7g_g>
    <xmx:7Y-9ad_-BvpiHVo19bO14Fq-TjUEqlaJhTVW8X2RXBKahPZPJVHFkg>
    <xmx:7Y-9aSJSNUmBTXAzv6qAsDktpcP_j4rKBpPNO5gHLZj-PE2nLucEQQ>
    <xmx:7Y-9aaz0uaeNUcTYvgsUfNdpqIymwiArQ6raSPW-puSE3dfPJ82zKg>
    <xmx:7Y-9ad2EIYmEtltkZIoGXXYpPWbAm66rG2e3HRUSiZgs9ssIVioZMmVf>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 14:20:28 -0400 (EDT)
Date: Fri, 20 Mar 2026 11:20:27 -0700
From: Boqun Feng <boqun@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <ab2P61FzyyIN2pib@tardis.local>
References: <abwyGtG7hDpd8vBN@tardis.local>
 <CAP01T75S-NMgB=s_0jqq52xRwe1cQ29DzD33eeqUZHM3cSb=oA@mail.gmail.com>
 <abxZEE4SAMkNEleq@tardis.local>
 <89763fcd-3710-49a0-91ca-cd923b47fc1e@nvidia.com>
 <abxfBZ89wIJILuom@tardis.local>
 <c391f8b9-a168-4235-aa7b-6902b4f07002@paulmck-laptop>
 <ab1u-AuqIbJakUYW@tardis.local>
 <2b3848e9-3b11-41b8-8c44-5de28d4a4433@paulmck-laptop>
 <ab18cUI_4jKA8wcA@tardis.local>
 <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>

On Fri, Mar 20, 2026 at 01:54:22PM -0400, Joel Fernandes wrote:
> 
> 
> On 3/20/2026 12:57 PM, Boqun Feng wrote:
> > 
> >>>> So we really do need to make some variant of call_srcu() that deals
> >>>> with this.
> >>>>
> >>>> We do have some options.  First, we could make call_srcu() deal with it
> >>>> directly, or second, we could create something like call_srcu_lockless()
> >>>> or call_srcu_nolock() or whatever that can safely be invoked from any
> >>>> context, including NMI handlers, and that invokes call_srcu() directly
> >>>> when it determines that it is safe to do so.  The advantage of the second
> >>>> approach is that it avoids incurring the overhead of checking in the
> >>>> common case.
> >>> Within the RCU scope, I prefer the second option.
> >> Works for me!
> >>
> >> Would you guys like to implement this, or would you prefer that I do so?
> >>
> > I feel I don't have cycles for it soon, I have a big backlog (including
> > making preempt_count 64bit on 64bit x86). But I will send the fix in the
> > current call_srcu() for v7.0 and work with Joel to get into Linus' tree.
> 
> Boqun, I get a splat as below with your irq_work patch on rcutorture:
> 

Thank you, I fixed that in the new version [1]. Please give it a go.

[1]: https://lore.kernel.org/rcu/20260320181400.15909-1-boqun@kernel.org/

Regards,
Boqun

> Maybe the srcu_get_delay call needs:
> 
>       raw_spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
>       delay = srcu_get_delay(ssp);
>       raw_spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
> 
> can you check?
> 
> [    0.459781] ------------[ cut here ]------------
> [    0.460401] WARNING: kernel/rcu/srcutree.c:681 at srcu_get_delay+0xb4/0xd0,
> CPU#0: swapper/0/1
> [    0.460751] Modules linked in:
> [    0.460751] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> 7.0.0-rc3-00020-gc18a9e13ce7f #96 PREEMPTLAZY
> [    0.460751] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1
> 04/01/2014
> [    0.460751] RIP: 0010:srcu_get_delay+0xb4/0xd0
> [    0.460751] Code: 00 00 00 5b 5d 48 39 d0 48 0f 47 c2 e9 45 b0 0b 01 48 89 fd
> be ff ff ff ff 48 8d bb d0 00 00 00 e8 e1 86 0a 01 85 c0 75 0d 90 <0f> 0b 90 48
> 8b 55 40 e9 57 ff ff ff 48 8b 55 40 e9 4e ff ff ff 0f
> [    0.460751] RSP: 0000:ffffb4ba80003f80 EFLAGS: 00010046
> [    0.460751] RAX: 0000000000000000 RBX: ffffffffac1604c0 RCX: 0000000000000001
> [    0.460751] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: ffffffffac160590
> [    0.460751] RBP: ffffffffac160460 R08: 0000000000000000 R09: 0000000000000000
> [    0.460751] R10: 0000000000000000 R11: ffffb4ba80003ff8 R12: 0000000000000023
> [    0.460751] R13: ffff9de181214b00 R14: 0000000000000000 R15: 0000000000000000
> [    0.460751] FS:  0000000000000000(0000) GS:ffff9de1f2799000(0000)
> knlGS:0000000000000000
> [    0.460751] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.460751] CR2: ffff9de18ddda000 CR3: 000000000c64e000 CR4: 00000000000006f0
> [    0.460751] Call Trace:
> [    0.460751]  <IRQ>
> [    0.460751]  srcu_irq_work+0x11/0x40
> [    0.460751]  irq_work_single+0x42/0x90
> [    0.460751]  irq_work_run_list+0x26/0x40
> [    0.460751]  irq_work_run+0x18/0x30
> [    0.460751]  __sysvec_irq_work+0x30/0x180
> [    0.460751]  sysvec_irq_work+0x6a/0x80
> [    0.460751]  </IRQ>
> [    0.460751]  <TASK>
> [    0.460751]  asm_sysvec_irq_work+0x1a/0x20
> [    0.460751] RIP: 0010:_raw_spin_unlock_irqrestore+0x34/0x50
> [    0.460751] Code: c7 18 53 48 89 f3 48 8b 74 24 10 e8 e6 58 f1 fe 48 89 ef e8
> 2e 92 f1 fe 80 e7 02 74 06 e8 e4 c0 00 ff fb 65 ff 0d fc 63 66 01 <74> 07 5b 5d
> c3 cc cc cc cc e8 7e 03 df fe 5b 5d e9 57 1b 00 00 0f
> [    0.460751] RSP: 0000:ffffb4ba80013d50 EFLAGS: 00000286
> [    0.460751] RAX: 0000000000001c8b RBX: 0000000000000297 RCX: 0000000000000000
> [    0.460751] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffab614c2c
> [    0.460751] RBP: ffffffffac160578 R08: 0000000000000001 R09: 0000000000000000
> [    0.460751] R10: 0000000000000001 R11: 0000000000000000 R12: fffffffffffffe74
> [    0.460751] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
> [    0.460751]  ? _raw_spin_unlock_irqrestore+0x2c/0x50
> [    0.460751]  srcu_gp_start_if_needed+0x354/0x530
> [    0.460751]  __synchronize_srcu+0xcc/0x180
> [    0.460751]  ? __pfx_wakeme_after_rcu+0x10/0x10
> [    0.460751]  ? synchronize_srcu+0x3f/0x170
> [    0.460751]  ? __pfx_rcu_init_tasks_generic+0x10/0x10
> [    0.460751]  rcu_init_tasks_generic+0x104/0x150
> [    0.460751]  do_one_initcall+0x59/0x2e0
> [    0.460751]  ? _printk+0x56/0x70
> [    0.460751]  kernel_init_freeable+0x227/0x440
> [    0.460751]  ? __pfx_kernel_init+0x10/0x10
> [    0.460751]  kernel_init+0x15/0x1c0
> [    0.460751]  ret_from_fork+0x2ac/0x330
> [    0.460751]  ? __pfx_kernel_init+0x10/0x10
> [    0.460751]  ret_from_fork_asm+0x1a/0x30
> [    0.460751]  </TASK>
