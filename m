Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92431466AE6;
	Wed,  7 Oct 2026 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791390252; cv=none; b=ja7+mwMSZnbmrmb8dnzoeCcdeqHcsrM23wPsZNeq8O2/2i1ar1K7XIC+PRyyGsNmiaJ5No0jVvGuzQ2YQj8AXi9oSFF1KAk9XZSSF9P3190pj3+i648iA15ihKYmhs8l0fEw81aLONX4Vs/E7CYvX0QH+H//bvJS1VaHUT9hdpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791390252; c=relaxed/simple;
	bh=4OszIjF3tcpJ2EJQWBqL9eE3CNnjykvL2QM89bZ9FrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdra5OGqxX+bibUQXlW4MOyTH//RhYJ+dZB1aMLufk0mVqMv7BgkVyRzpfCIdbGfu3SEy0LiQa3HPB196qzfwFFu+HWDWgNbSYEtiyu36mI9F+NqCNteEdlAI86cQFQ/QFHov/tIbLH3pRhzR5WqgWP9jDMs27cMFJPv108sziM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOZsWKtU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOZsWKtU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC381F000FF;
	Wed,  7 Oct 2026 16:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791390251;
	bh=RIAcwHIKtPjeouAqV7xsexWrYX1o4ka5Z3GJfZrT48Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=GOZsWKtUCTLI6fR70RjnpSFue4XzFY+cnrhOWppnBs+JULsXYX60uYV+K47zv8ecB
	 bNNHzMs28zycXceIo/M+9Xq+ZZWVI0qNlks4yZk878Jri2XvtylITaphBQqwXQ+RnW
	 QWkL0a10tsLlkH8bVlmjZOOwJVY9UZDGEfjl0rEXo1zgE127t2bdeby2Ax1s4ucDiT
	 5F7Q/BEPqGsHHroG5EU8yaslio0OyD4F5ImtVlyazSXClNJiTldJIieBH3i+yACy2v
	 aXP5nMfCyiH4tAZlqTFcziQNdTk4xybCCAL+gHmH6Va9+7SInOme1ioiVX7ChWCF7E
	 h6LWPL37ArDEg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C7993CE0D79; Wed,  7 Oct 2026 09:24:10 -0700 (PDT)
Date: Wed, 7 Oct 2026 09:24:10 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun@kernel.org>, Kunwu Chan <kunwu.chan@gmail.com>,
	Wang Lian <lianux.mm@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	Bradley Morgan <brads@mainlining.org>, rcu@vger.kernel.org,
	lkmm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [BUG] Splat during modest hazptrtorture run
Message-ID: <56fb0598-0b94-4726-ab64-c5314bdcdc41@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1f885062-4905-4d9c-9293-615c145d2d6b@paulmck-laptop>
 <5b5dbb90-69ad-4a8f-8583-f5ba162744d3@efficios.com>
 <631c13bc-671e-4cf3-b466-0408d7600ab2@paulmck-laptop>
 <37deae99-c7b7-4640-8b7b-9b2811f26c48@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37deae99-c7b7-4640-8b7b-9b2811f26c48@efficios.com>

On Wed, Oct 07, 2026 at 12:03:37PM -0400, Mathieu Desnoyers wrote:
> On 2026-10-07 11:59, Paul E. McKenney wrote:
> > On Wed, Oct 07, 2026 at 03:09:27AM -0400, Mathieu Desnoyers wrote:
> > > On 2026-10-06 19:40, Paul E. McKenney wrote:
> > > > Hello!
> > > > 
> > > > This is all new code, so the bug could be anywhere.  So you all need
> > > > to know.  ;-)
> > > > 
> > > > I got this from the NOPREEMPT variant of hazptr during a nominal
> > > > "--duration 60" run of torture.sh on x86 with the guest OS split across
> > > > two NUMA nodes:
> > > > 
> > > > [  137.765104] WARNING: kernel/rcu/hazptrtorture.c:658 at hazptr_torture_stats_print+0x25b/0x4f0, CPU#1: hazptr_torture_/136
> > > > [  137.768647] Modules linked in:
> > > > [  137.768891] CPU: 1 UID: 0 PID: 136 Comm: hazptr_torture_ Not tainted 7.3.0-rc5-00661-ga1f1e4890d1d-dirty #193 PREEMPTLAZY
> > > > [  137.769683] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-6.el9 11/05/2023
> > > > [  137.770319] RIP: 0010:hazptr_torture_stats_print+0x25b/0x4f0
> > > > [  137.770735] Code: 48 83 c4 20 e8 86 44 fe ff 41 83 fd 01 7e 23 48 c7 c6 6e 85 17 b0 48 c7 c7 db 27 17 b0 e8 6d 44 fe ff f0 ff 05 76 6e 0a 02 90 <0f> 0b 90 4c 8b 64 24 70 48 c7 c7 73 85 17 b0 e8 51 44 fe ff 48 8b
> > > > [  137.772061] RSP: 0018:ffffa738004ffdf0 EFLAGS: 00010202
> > > > [  137.772435] RAX: 0000000000000004 RBX: ffffa738004ffe08 RCX: 0000000000000027
> > > > [  137.772950] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
> > > > [  137.773455] RBP: ffffa738004ffe60 R08: 4000000000001236 R09: ffffffffb01727df
> > > > [  137.773980] R10: 0000000020212121 R11: 0000000020212121 R12: 0000000000000000
> > > > [  137.774479] R13: 0000000000000002 R14: 000000000002ffd6 R15: 0000000000034f03
> > > > [  137.775000] FS:  0000000000000000(0000) GS:ffff999c2e502000(0000) knlGS:0000000000000000
> > > > [  137.775578] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [  137.776001] CR2: 0000000000000000 CR3: 0000000008830000 CR4: 00000000000006f0
> > > > [  137.776512] Call Trace:
> > > > [  137.776700]  <TASK>
> > > > [  137.776863]  ? __pfx_hazptr_torture_stats+0x10/0x10
> > > > [  137.777207]  hazptr_torture_stats+0x25/0x70
> > > > [  137.777508]  kthread+0xd9/0x110
> > > > [  137.777751]  ? __pfx_kthread+0x10/0x10
> > > > [  137.778017]  ret_from_fork+0x1bd/0x220
> > > > [  137.778285]  ? __pfx_kthread+0x10/0x10
> > > > [  137.778560]  ret_from_fork_asm+0x1a/0x30
> > > > [  137.778849]  </TASK>
> > > > [  137.779007] ---[ end trace 0000000000000000 ]---
> > > > 
> > > > I have not yet seen this during a PREEMPT run.  Line 658 of
> > > > hazptrtorture.c is the WARN_ON_ONCE() below:
> > > > 
> > > > 	if (i > 1) {
> > > > 		pr_cont("%s", "!!! ");
> > > > 		atomic_inc(&n_hazptr_torture_error);
> > > > 		WARN_ON_ONCE(i > 1); // Too-short grace period
> > > > 	}
> > > > 
> > > > Any thoughts on what might be causing this?
> > > 
> > > Hi Paul!
> > > 
> > > Can you share which tree and branch (commit) this is running ?
> > > 
> > > Does it include my fix from this series ? That would be patch 1 of:
> > > 
> > > https://lore.kernel.org/lkml/20260927155134.4740-1-mathieu.desnoyers@efficios.com/
> > 
> > Ah, no, I somehow got the impression that this series was going to be
> > updated, so did not apply it.  Apologies!
> > 
> > I will pull these in.
> 
> About the patches introducing ptr_eq(), I plan to handle Linus' feedback
> perhaps in an additional patch and have the "generic" ptr_eq()
> implemented under asm-generic, and a x86-specific implementation of it
> in assembly. Are you OK with this being a follow up or would you prefer
> I fold this in the original patch ?

So I did get the right impression, then!  Don't worry, it won't happen
again.  ;-)

Ah, and my memory is also colored by the fact that we really need to
dispense with the wildcards altogether to avoid inflicting one of the
weaknesses of RCU (susceptibility to delay) onto hazard pointers.

Please fold the fix into the original.  I will pull in your patch 1/1
in as an EXP patch for testing purposes in the meantime, just in case
further events affect 1/1 as well as 1/2.

> > > Does it run the additional series from Kunwu Chan found at
> > > https://lore.kernel.org/lkml/20261002170847.3653663-1-kunwu.chan@gmail.com/ ?
> > 
> > No, but if you are good with it I will pull it in.
> > 
> > May I add your Acked-by or Reviewed-by?
> 
> With LPC going on, I did not have time to review it, sorry. Not yet
> please.

No problem!  Given that hazard pointers isn't likely to make the v7.4
merge window, we do have time.

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> > 
> > 							Thanx, Paul
> > 
> > > Thanks,
> > > 
> > > Mathieu
> > > 
> > > > 
> > > > For that matter, can anyone else reproduce this?
> > > > 
> > > > 								Thanx, Paul
> > > 
> > > 
> > > -- 
> > > Mathieu Desnoyers
> > > EfficiOS Inc.
> > > https://www.efficios.com
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
