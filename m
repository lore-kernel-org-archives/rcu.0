Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE421BE40;
	Tue, 28 Jan 2025 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738089822; cv=none; b=u5f0P59I+Lv5/SQ2e6kVTTGZtwSFvruz6FqGrvfzKh2qJlFSC/2KpoHSO4ifx6Haj3/AYHeDy5aDcDL+FqsHEtZf9jKvcmGQwdURQipr4bvBlYFUTPZ7keazsbTt5TuuQGTS0kkhIKdRmwdn2TX09Cm20MAGQ8WKaZnP/nEwJA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738089822; c=relaxed/simple;
	bh=EJ1CMY45MZFk9TcVYt1WoN4Ts+wXKnEaJI1F+/MbEeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuDBL3+MuqGphqIYKYFQ8Xc/WDUCYSc27SYLloYwXLSOE8ug64GwbPcci8gq4XV13Dxt0VOS+BkU+iJo49hwZvLVSfRk6CTSqXRKaGY3XkR1YPMR5BFQDBa5RgF3tlhngv7F7/6PPWj8QS1GDzPyWCsqMLCZAzK2hRs2b3VY5/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBuANZlb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBuANZlb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3BAC4CEE2;
	Tue, 28 Jan 2025 18:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738089822;
	bh=EJ1CMY45MZFk9TcVYt1WoN4Ts+wXKnEaJI1F+/MbEeY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mBuANZlb6etvkgvC7aTTTS9n3RuxmUoCfbK/Fc8GtYVZIXjjvXIpKb+NA5q8jU/BY
	 6oGHpqX8u9iKqP2UCMP/2QePMLtMfumGGcLP2NSNxBPUPv/OwhOcx9jQnaFQBlH/pq
	 o54Gqmfb/4DlMIW2ZKRnpesq64V83i9MyOiv/aQvkR4sZal52spXCNW75JfPNmvKtF
	 XeYs5+j/eD89PY1NXG9Y3WUxpLGjZPTSxeGqXlkQesU+fBqAuPmCHIBV6W2SPXwvuS
	 LTtgC0nz0/RgIVH1OqxyKGW+a0lz8DCVt3G8gYP1qbfV4ckxvfM9XvBo/EcdPaWkw5
	 RP58NA64IfeBg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2718FCE1160; Tue, 28 Jan 2025 10:43:39 -0800 (PST)
Date: Tue, 28 Jan 2025 10:43:39 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/4] torture: Remove CONFIG_NR_CPUS configuration
Message-ID: <50fe6944-383e-48bf-979b-f146260ec74a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <Z5epgkyeyAvTVOQg@pc636>
 <fd09724c-dcd9-4f41-b33c-20f6258da6b0@paulmck-laptop>
 <Z5fB4xTWD7PWmVXq@pc636>
 <77d09c35-b970-4103-9be2-11c05d7fe124@paulmck-laptop>
 <Z5fdaj2HnhpagC-A@pc636>
 <Z5fueD7u1tXQv-jI@pc636>
 <321dd3a8-4d0e-4115-af3d-27f38171cb18@paulmck-laptop>
 <Z5jK3juSZcDYc7bA@pc636>
 <48ce1bcc-15e9-4e05-9b00-2b0903b122a9@paulmck-laptop>
 <Z5jrCqL-PFitmGkK@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5jrCqL-PFitmGkK@pc636>

On Tue, Jan 28, 2025 at 03:34:50PM +0100, Uladzislau Rezki wrote:
> On Tue, Jan 28, 2025 at 04:41:16AM -0800, Paul E. McKenney wrote:
> > On Tue, Jan 28, 2025 at 01:17:34PM +0100, Uladzislau Rezki wrote:
> > > > > > with 4 CPUs inside VM :)
> > > > > > 
> > > > > And when running 16 instances with 4 CPUs each i can reproduce the
> > > > > splat which has been reported:
> > > > > 
> > > > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --configs \
> > > > >   '16*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1' \
> > > > >   --kconfig "CONFIG_NR_CPUS=4"
> > > > > 
> > > > > <snip>
> > > > > ...
> > > > > [    0.595251] ------------[ cut here ]------------
> > > > > [    0.595867] A full grace period is not passed yet: 0
> > > > > [    0.595875] WARNING: CPU: 1 PID: 16 at kernel/rcu/tree.c:1617 rcu_sr_normal_complete+0xa9/0xc0
> > > > > [    0.598248] Modules linked in:
> > > > > [    0.598649] CPU: 1 UID: 0 PID: 16 Comm: rcu_preempt Not tainted 6.13.0-02530-g8950af6a11ff #261
> > > > > [    0.599248] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > > > [    0.600248] RIP: 0010:rcu_sr_normal_complete+0xa9/0xc0
> > > > > [    0.600913] Code: 48 29 c2 48 8d 04 0a ba 03 00 00 00 48 39 c2 79 0c 48 83 e8 04 48 c1 e8 02 48 8d 70 02 48 c7 c7 20 e9 33 b5 e8 d8 03 f4 ff 90 <0f> 0b 90 90 48 8d 7b 10 5b e9 f9 38 fb ff 66 0f 1f 84 00 00 00 00
> > > > > [    0.603249] RSP: 0018:ffffadad0008be60 EFLAGS: 00010282
> > > > > [    0.603925] RAX: 0000000000000000 RBX: ffffadad00013d10 RCX: 00000000ffffdfff
> > > > > [    0.605247] RDX: 0000000000000000 RSI: ffffadad0008bd10 RDI: 0000000000000001
> > > > > [    0.606247] RBP: 0000000000000000 R08: 0000000000009ffb R09: 00000000ffffdfff
> > > > > [    0.607248] R10: 00000000ffffdfff R11: ffffffffb56789a0 R12: 0000000000000005
> > > > > [    0.608247] R13: 0000000000031a40 R14: fffffffffffffb74 R15: 0000000000000000
> > > > > [    0.609250] FS:  0000000000000000(0000) GS:ffff9081f5c80000(0000) knlGS:0000000000000000
> > > > > [    0.610249] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > [    0.611248] CR2: 0000000000000000 CR3: 00000002f024a000 CR4: 00000000000006f0
> > > > > [    0.612249] Call Trace:
> > > > > [    0.612574]  <TASK>
> > > > > [    0.612854]  ? __warn+0x8c/0x190
> > > > > [    0.613248]  ? rcu_sr_normal_complete+0xa9/0xc0
> > > > > [    0.613840]  ? report_bug+0x164/0x190
> > > > > [    0.614248]  ? handle_bug+0x54/0x90
> > > > > [    0.614705]  ? exc_invalid_op+0x17/0x70
> > > > > [    0.615248]  ? asm_exc_invalid_op+0x1a/0x20
> > > > > [    0.615797]  ? rcu_sr_normal_complete+0xa9/0xc0
> > > > > [    0.616248]  rcu_gp_cleanup+0x403/0x5a0
> > > > > [    0.616248]  ? __pfx_rcu_gp_kthread+0x10/0x10
> > > > > [    0.616818]  rcu_gp_kthread+0x136/0x1c0
> > > > > [    0.617249]  kthread+0xec/0x1f0
> > > > > [    0.617664]  ? __pfx_kthread+0x10/0x10
> > > > > [    0.618156]  ret_from_fork+0x2f/0x50
> > > > > [    0.618728]  ? __pfx_kthread+0x10/0x10
> > > > > [    0.619216]  ret_from_fork_asm+0x1a/0x30
> > > > > [    0.620251]  </TASK>
> > > > > ...
> > > > > <snip>
> > > > > 
> > > > > Linus tip-tree, HEAD is c4b9570cfb63501638db720f3bee9f6dfd044b82
> > > > 
> > > > Very good!  And of course, the next question is "does going to _full()
> > > > make the problem go away?"  ;-)
> > > > 
> > > Yes does its job if i apply:
> > > 
> > > https://lore.kernel.org/rcu/00900afe-ac4e-4362-a3f9-d65f2c9dcd9a@paulmck-laptop/T/#m5d9263f3825d3170c044beedbae741717702d4aa
> > > 
> > > after that i am not able to reproduce the warning anymore. Tested over
> > > night. Without it, i can reproduce it pretty easy :)
> > 
> > Thank you, and good to hear!!!
> > 
> > May I add your Tested-by to that patch?
> > 
> Sure.
> 
> Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thank you!  I will apply this on my next rebase.

> One question, we discussed that it is worth to print seq-delta
> in case of warning. Whereas a newly patch does do it and just
> emits a plain text.
> 
> I can send a separate patch or modify this one?

A separate patch would be best.

If it helps, one possible set of functions to model this on is
rcutorture_format_gp_seqs() on the "dev" branch of -rcu:

9357e5aecb63 ("rcutorture: Include grace-period sequence numbers in failure/close-call")

This has the needed #ifdefs and the different implementations for Tree
and Tiny RCU.

							Thanx, Paul
