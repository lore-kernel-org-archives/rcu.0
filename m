Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09C19DF62;
	Tue, 28 Jan 2025 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738023241; cv=none; b=mkGON6SYgPnyXbYAILWAuegMjYa65qX8vYdJFfyvzwVCGLpRRu3Z1+7XoraKVhF77qYM1wXIViQR0XGiI1TpfW+Z4Gr4Ib7yKBk2YMKIPH13zSce30Z6OxSLtej7EyBo+pKmN1sx4oe/XF5dU0GDknErAGmKxVA0fAsBbmQrcz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738023241; c=relaxed/simple;
	bh=iI5AcTUaqfV1INIe2vDqawKzc/B4v9WrE5XHh9ABbJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qa0A8B412+7cNWtCMAvZq3Scn/jIOVww0hOrUETvpflaw6kYDBYEWHQyi+xWQlXfpN/n1zW2AbT9J6QPQERFNXyIy2QTrlDwJQaR92WT+JjclGHuDrbD3tz/65XBT4FXBWhkB761cZ4ltQTmV890cs4ZE0ikI9QCqmqgN8yyB2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB2Zhe68; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB2Zhe68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB09C4CED2;
	Tue, 28 Jan 2025 00:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738023241;
	bh=iI5AcTUaqfV1INIe2vDqawKzc/B4v9WrE5XHh9ABbJg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=VB2Zhe68hbsqk/DEci4lGm4Xl4VscJz3ySCEE08xQBDv8a4NGZY9ZJoC6zkgEBJmr
	 BQaaBLZFepFXeXi9FLCSL7IhP2rADsG9EpvFPuPme8c9VO9OYEX4HzWx/ax1a6HqM+
	 IjmuxrHo7F1ZdCiAUoodzDtO49EDYW8QZ+QV9tdaFqBQmUmuyd41S9Sww24GMduxQL
	 kQC68t/MOJJs5mKCigQaY+GJ94Vw3XcO8bIWvMCtRjORwm66mVZ42nRO79fsROvVNg
	 ogdx+/ldb7FGIp6z04Nx9ipFGvk6TrQGFrICXl5TEaQvSOfiqZA743uS0kuTpwVUTi
	 ThgFjYxUKrUxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C3FE3CE0B6D; Mon, 27 Jan 2025 16:14:00 -0800 (PST)
Date: Mon, 27 Jan 2025 16:14:00 -0800
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
Message-ID: <321dd3a8-4d0e-4115-af3d-27f38171cb18@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <Z5PSeEn_ceFuqbnz@pc636>
 <06b6c9f2-c668-4c7d-8555-69a23cc8b4e7@paulmck-laptop>
 <Z5eJ13aWwMDK00U1@pc636>
 <c0280436-2239-41d8-b118-1e6792995778@paulmck-laptop>
 <Z5epgkyeyAvTVOQg@pc636>
 <fd09724c-dcd9-4f41-b33c-20f6258da6b0@paulmck-laptop>
 <Z5fB4xTWD7PWmVXq@pc636>
 <77d09c35-b970-4103-9be2-11c05d7fe124@paulmck-laptop>
 <Z5fdaj2HnhpagC-A@pc636>
 <Z5fueD7u1tXQv-jI@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5fueD7u1tXQv-jI@pc636>

On Mon, Jan 27, 2025 at 09:37:12PM +0100, Uladzislau Rezki wrote:
> > > > > > > > > > > > need more CPUs for TREE05.
> > > > > > > > > > > > 
> > > > > > > > > > > > I will not resist, we just drop this patch :)
> > > > > > > > > > > 
> > > > > > > > > > > Thank you!
> > > > > > > > > > > 
> > > > > > > > > > > The bug you are chasing happens when a given synchonize_rcu() interacts
> > > > > > > > > > > with RCU readers, correct?
> > > > > > > > > > > 
> > > > > > > > > > Below one:
> > > > > > > > > > 
> > > > > > > > > > <snip>
> > > > > > > > > > /*
> > > > > > > > > >  * RCU torture fake writer kthread.  Repeatedly calls sync, with a random
> > > > > > > > > >  * delay between calls.
> > > > > > > > > >  */
> > > > > > > > > > static int
> > > > > > > > > > rcu_torture_fakewriter(void *arg)
> > > > > > > > > > {
> > > > > > > > > > ...
> > > > > > > > > > <snip>
> > > > > > > > > > 
> > > > > > > > > > > In rcutorture, only the rcu_torture_writer() call to synchronize_rcu()
> > > > > > > > > > > interacts with rcu_torture_reader().  So my guess is that running
> > > > > > > > > > > many small TREE05 guest OSes would reproduce this bug more quickly.
> > > > > > > > > > > So instead of this:
> > > > > > > > > > > 
> > > > > > > > > > > 	--kconfig CONFIG_NR_CPUS=128
> > > > > > > > > > > 
> > > > > > > > > > > Do this:
> > > > > > > > > > > 
> > > > > > > > > > > 	--configs "16*TREE05"
> > > > > > > > > > > 
> > > > > > > > > > > Or maybe even this:
> > > > > > > > > > > 
> > > > > > > > > > > 	--configs "16*TREE05" --kconfig CONFIG_NR_CPUS=4
> > > > > > > > > > Thanks for input.
> > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > Thoughts?
> > > > > > > > > > > 
> > > > > > > > > > If you mean below splat:
> > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > i.e. with more nfakewriters.
> > > > > > > > > 
> > > > > > > > > Right, and large nfakewriters would help push the synchronize_rcu()
> > > > > > > > > wakeups off of the grace-period kthread.
> > > > > > > > > 
> > > > > > > > > > If you mean the one that has recently reported, i am not able to
> > > > > > > > > > reproduce it anyhow :)
> > > > > > > > > 
> > > > > > > > > Using larger numbers of smaller rcutorture guest OSes might help to
> > > > > > > > > reproduce it.  Maybe as small as three CPUs each.  ;-)
> > > > > > > > > 
> > > > > > > > OK. I will give a try this:
> > > > > > > > 
> > > > > > > > for (( i=0; i<$LOOPS; i++ )); do
> > > > > > > > 	tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 5 --configs \
> > > > > > > > 	'16*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1'
> > > > > > > > 	echo "Done $i"
> > > > > > > > done
> > > > > > > 
> > > > > > > Making each guest OS smaller needs "--kconfig CONFIG_NR_CPUS=4" (or
> > > > > > > whatever) as well, perhaps also increasing the "16*TREE05".
> > > > > > > 
> > > > > > 
> > > > > > By default we have NR_CPUS=8, we we discussed. Providing to kvm "--cpus 5"
> > > > > > parameter will just set number of CPUs for a VM to 5:
> > > > > > 
> > > > > > <snip>
> > > > > > ...
> > > > > > [    0.060672] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=5, Nodes=1
> > > > > > ...
> > > > > > <snip>
> > > > > > 
> > > > > > so, for my test i do not see why i need to set --kconfig CONFIG_NR_CPUS=4.
> > > > > > 
> > > > > > Am i missing something? :)
> > > > > 
> > > > > Because that gets you more guest OSes running on your system, each with
> > > > > one RCU-update kthread that is being checked by RCU reader kthreads.
> > > > > Therefore, it might double the rate at which you are able to reproduce
> > > > > this issue.
> > > > > 
> > > > You mean that setting --kconfig CONFIG_NR_CPUS=4 and 16*TREE05 will run
> > > > 4 separate KVM instances?
> > > 
> > > Almost but not quite.
> > > 
> > > I am assuming that you have a system with a multiple of eight CPUs.
> > > 
> > > If so, and assuming that Cheung's bug is an interaction between a fast
> > > synchronize_rcu() grace period and a reader task that this grace period
> > > is waiting on, having more and smaller guest OSes might make the problem
> > > happen faster.  So instead of your:
> > > 
> > > tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 5 --configs \
> > > '16*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1'
> > > 
> > > You might be able to double the number of reproductions of the bug
> > > per unit time by instead using:
> > > 
> > > tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 5 --configs \
> > > '32*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1' \
> > > --kconfig "CONFIG_NR_CPUS=4"
> > > 
> > > Does that seem reasonable to you?
> > >
> > It only runs one instance for me:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 5 --configs 32*TREE05 --memory 10G --bootargs rcutorture.fwd_progress=1 --kconfig CONFIG_NR_CPUS=4
> > ----Start batch 1: Mon Jan 27 08:20:17 PM CET 2025
> > TREE05 4: Starting build. Mon Jan 27 08:20:17 PM CET 2025
> > TREE05 4: Waiting for build to complete. Mon Jan 27 08:20:17 PM CET 2025
> > TREE05 4: Build complete. Mon Jan 27 08:21:26 PM CET 2025
> > ---- TREE05 4: Kernel present. Mon Jan 27 08:21:26 PM CET 2025
> > ---- Starting kernels. Mon Jan 27 08:21:26 PM CET 2025
> > 
> > with 4 CPUs inside VM :)
> > 
> And when running 16 instances with 4 CPUs each i can reproduce the
> splat which has been reported:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --configs \
>   '16*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1' \
>   --kconfig "CONFIG_NR_CPUS=4"
> 
> <snip>
> ...
> [    0.595251] ------------[ cut here ]------------
> [    0.595867] A full grace period is not passed yet: 0
> [    0.595875] WARNING: CPU: 1 PID: 16 at kernel/rcu/tree.c:1617 rcu_sr_normal_complete+0xa9/0xc0
> [    0.598248] Modules linked in:
> [    0.598649] CPU: 1 UID: 0 PID: 16 Comm: rcu_preempt Not tainted 6.13.0-02530-g8950af6a11ff #261
> [    0.599248] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [    0.600248] RIP: 0010:rcu_sr_normal_complete+0xa9/0xc0
> [    0.600913] Code: 48 29 c2 48 8d 04 0a ba 03 00 00 00 48 39 c2 79 0c 48 83 e8 04 48 c1 e8 02 48 8d 70 02 48 c7 c7 20 e9 33 b5 e8 d8 03 f4 ff 90 <0f> 0b 90 90 48 8d 7b 10 5b e9 f9 38 fb ff 66 0f 1f 84 00 00 00 00
> [    0.603249] RSP: 0018:ffffadad0008be60 EFLAGS: 00010282
> [    0.603925] RAX: 0000000000000000 RBX: ffffadad00013d10 RCX: 00000000ffffdfff
> [    0.605247] RDX: 0000000000000000 RSI: ffffadad0008bd10 RDI: 0000000000000001
> [    0.606247] RBP: 0000000000000000 R08: 0000000000009ffb R09: 00000000ffffdfff
> [    0.607248] R10: 00000000ffffdfff R11: ffffffffb56789a0 R12: 0000000000000005
> [    0.608247] R13: 0000000000031a40 R14: fffffffffffffb74 R15: 0000000000000000
> [    0.609250] FS:  0000000000000000(0000) GS:ffff9081f5c80000(0000) knlGS:0000000000000000
> [    0.610249] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.611248] CR2: 0000000000000000 CR3: 00000002f024a000 CR4: 00000000000006f0
> [    0.612249] Call Trace:
> [    0.612574]  <TASK>
> [    0.612854]  ? __warn+0x8c/0x190
> [    0.613248]  ? rcu_sr_normal_complete+0xa9/0xc0
> [    0.613840]  ? report_bug+0x164/0x190
> [    0.614248]  ? handle_bug+0x54/0x90
> [    0.614705]  ? exc_invalid_op+0x17/0x70
> [    0.615248]  ? asm_exc_invalid_op+0x1a/0x20
> [    0.615797]  ? rcu_sr_normal_complete+0xa9/0xc0
> [    0.616248]  rcu_gp_cleanup+0x403/0x5a0
> [    0.616248]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [    0.616818]  rcu_gp_kthread+0x136/0x1c0
> [    0.617249]  kthread+0xec/0x1f0
> [    0.617664]  ? __pfx_kthread+0x10/0x10
> [    0.618156]  ret_from_fork+0x2f/0x50
> [    0.618728]  ? __pfx_kthread+0x10/0x10
> [    0.619216]  ret_from_fork_asm+0x1a/0x30
> [    0.620251]  </TASK>
> ...
> <snip>
> 
> Linus tip-tree, HEAD is c4b9570cfb63501638db720f3bee9f6dfd044b82

Very good!  And of course, the next question is "does going to _full()
make the problem go away?"  ;-)

							Thanx, Paul
