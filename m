Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A9F199FB0
	for <rcu@vger.kernel.org>; Tue, 25 Feb 2025 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506070; cv=none; b=WBOlFUKODbTHs0Ny1lkKfndfV95y7gVtGRBn/Zc0a72aDIsiu2zc+iTO4vlyJA9bZsj1tnQ7X+tYAXn4WLjeOuXPbcOhatNRuV4ViEhcYYagSIZ+oeAdF4xkAX2mc09kmmW1B/r1HtxFKD2Qt12mOzO/Y6C8+toFUJjoaHg/pbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506070; c=relaxed/simple;
	bh=Hi9Qt4j3wbT82Es4ld+NEtZ8tzrYE1y99t90TehkLq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ME5EBlhIj1L7s2Ao6DywTDVXD+CsCUyCPdx8KJ5u4fId73J9XkQc8QLHNNm+ONHn+Su/EIC3O5hPCGkia03ytxQQL52ZN7Re38tQa2cY/3uhWwCBQKMICzQQHQJ5akW0MgoC47BT/PBNwf3FWqbNsPvvQ7txrYYYihlaqGTuP0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFWEDeQh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFWEDeQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC55C4CEDD;
	Tue, 25 Feb 2025 17:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740506069;
	bh=Hi9Qt4j3wbT82Es4ld+NEtZ8tzrYE1y99t90TehkLq4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=GFWEDeQh9D0gL03n5pTbe0SLDqWeZOOIKpIkbYaV2KTjcVHPPPJPqZJjr2tckEsaM
	 UrX9i/YqWMiq3oZV6qOM35/Vlvyl5Ntr9oA5Cfwj45UomIcN+3fwYq+55LqoouFF3l
	 tvaO0kaXE8iPtv+tvQgG/zu0uzCRzRwQiXyrJl1Qxzod0nfTtOBQvfYD67aOrEJGxb
	 qsX8lZfDYqOUMb1g6EaUcCFl4crS9iHjFf4Wt5T4xZpb6YoBHIPw6cKMifGTyCC8qC
	 cvE6aGaP7N+6i5CjhOHWWDq+kiUfZ4wp76LipMac+JUpg0NfZ5alW73G8IbhcsU+nD
	 k8UcHP2r3O3Tg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 62E56CE045A; Tue, 25 Feb 2025 09:54:29 -0800 (PST)
Date: Tue, 25 Feb 2025 09:54:29 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rcu@vger.kernel.org
Subject: Re: Testing of shared RCU branching
Message-ID: <267f54c6-4604-41fc-8cc9-6adb761fa257@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c5bd6873-6e29-4f44-9c40-fbdffc6d1165@paulmck-laptop>
 <Z73rFVTHr-etZ8SE@Mac.home>
 <Z73rn9nqlCwns1IY@Mac.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73rn9nqlCwns1IY@Mac.home>

On Tue, Feb 25, 2025 at 08:11:11AM -0800, Boqun Feng wrote:
> On Tue, Feb 25, 2025 at 08:08:53AM -0800, Boqun Feng wrote:
> > On Tue, Feb 25, 2025 at 07:58:01AM -0800, Paul E. McKenney wrote:
> > > Hello, Boqun,
> > > 
> > > I have run overnight tests on your earlier branches here:
> > > 
> > > ccb986e8b69f ("MAINTAINERS: Update Joel's email address")
> > > 
> 
> Oh and I should have let you know, I updated next and dev branch, the
> latest ones are:
> 
> 	next.2025.02.24a and dev.2025.02.24a in rcu repo.

Very well, I will try them out later today.

> Regards,
> Boqun
> 
> > > These passed other than a KCSAN complaint involving
> > > rcu_preempt_deferred_qs_handler() and rcu_read_unlock_special().
> > > This looks like the plain C-language writes to ->defer_qs_iw_pending.
> > > 
> > > My guess is that this is low probability, despite having happened twice,
> > > and that it happens when rcu_read_unlock_special() is interrupted,
> > > resulting in rcu_preempt_deferred_qs_handler() being invoked as an
> > > IRQ-work handler.  Keeping in mind that RCU runs KCSAN so as to locate
> > > data races between task and handler on the same CPU.
> > > 
> > > Thoughts?
> > > 
> > 
> > Do you have a KCSAN of this? Also this is not a regression, right?
> > Meaning you probably have seen this before? Anyway, it should be an easy
> > fix (just using READ_ONCE() and WRITE_ONCE()). I can send the fix out
> > and put it in.

Here you go!  And you are right, if it is a regression, it is from a
long time ago, though something more recent might have made it more
probable.

In any case, not at all urgent.

							Thanx, Paul

------------------------------------------------------------------------

[  624.037869] ==================================================================
[  624.037883] BUG: KCSAN: data-race in rcu_preempt_deferred_qs_handler / rcu_read_unlock_special
[  624.037906]
[  624.037909] read to 0xffffa034df2eff90 of 1 bytes by task 45 on cpu 3:
[  624.037916]  rcu_read_unlock_special+0x177/0x260
[  624.037925]  __rcu_read_unlock+0x92/0xa0
[  624.037935]  rt_spin_unlock+0x9b/0xc0
[  624.037946]  __local_bh_enable+0x10e/0x170
[  624.037957]  __local_bh_enable_ip+0xe9/0x140
[  624.037967]  rcu_cpu_kthread+0x95f/0x1190
[  624.037976]  smpboot_thread_fn+0x230/0x320
[  624.037985]  kthread+0x3b8/0x400
[  624.037995]  ret_from_fork+0x35/0x40
[  624.038025]  ret_from_fork_asm+0x1a/0x30
[  624.038036]
[  624.038039] write to 0xffffa034df2eff90 of 1 bytes by task 43 on cpu 3:
[  624.038046]  rcu_preempt_deferred_qs_handler+0x1e/0x30
[  624.038057]  irq_work_single+0xaf/0x160
[  624.038066]  run_irq_workd+0x92/0xd0
[  624.038075]  smpboot_thread_fn+0x230/0x320
[  624.038085]  kthread+0x3b8/0x400
[  624.038095]  ret_from_fork+0x35/0x40
[  624.038105]  ret_from_fork_asm+0x1a/0x30
[  624.038116]
[  624.038118] no locks held by irq_work/3/43.
[  624.038123] irq event stamp: 202724
[  624.038126] hardirqs last  enabled at (202724): [<ffffffffa8950831>] finish_task_switch+0x131/0x320
[  624.038138] hardirqs last disabled at (202723): [<ffffffffa9f8ce02>] __schedule+0xe2/0xbb0
[  624.038146] softirqs last  enabled at (0): [<ffffffffa88dbfd1>] copy_process+0x4e1/0x1cc0
[  624.038159] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  624.038167]
[  624.038169] Reported by Kernel Concurrency Sanitizer on:
[  624.038173] CPU: 3 UID: 0 PID: 43 Comm: irq_work/3 Not tainted 6.14.0-rc1-00080-gd6558730a4de #6410
[  624.038185] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[  624.038191] ==================================================================

