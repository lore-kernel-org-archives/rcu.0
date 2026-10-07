Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B2E39DBCF;
	Wed,  7 Oct 2026 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791388778; cv=none; b=TH0GwnCntmFswUh/C8W5hOWHpdLCcCEeWhwU/f//at++4zWfGekUCTLvj6iFFUhhu/A3/Tqkhr+VmuYJAb1b7tBdwVTF4jaIXn6Xv5tGEg6Ytb4FZam1i1Qfa597eRksa29gAGLGPZaN+NKs/q3yRxueiISgjzSc0OyhlOEsc68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791388778; c=relaxed/simple;
	bh=xni4mBOc+TP2c3EaIV/uGbdfmg++C6u0mjlzF8HLkWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMtZrnArZstch5hlGH3SdEq6/Icp9FzM7U3Eb362caqFvVCKCYl/vr5aCqO8hYn4EBAKB9MCwdwFF3Cd+wkCaL+rWr65QD76hqSN9fMxtfXkjSuANZm+sU341asJqDJSU8ISh8NGB2wcG0gFqz63ZUd9rznMiYXMSYi6nrERKGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEeLPz/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEeLPz/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF7D1F000FF;
	Wed,  7 Oct 2026 15:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791388776;
	bh=xanHNmJBAxmNLnjp0hQn2Xei9P+bddhEQEgYqq1ICcM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=DEeLPz/JOt2E9KOBS84F9EHjvX8zvgatpqnJB3wfcy0wLzl4G6k3X5W3NgmC0Ui6N
	 3QSwKaj+lwoWgdV6r4fpdNkTbYqj3uGDDgx9McCu9BbtwGU6zM1EGfwECn7QQni9T8
	 xaaeRbZo1xaVf31kgVc7I1yNLXpyRyCkAKYzeUYN9/w+mT+f5dc+pXsYkq4KpbFops
	 t7p1f1yTPIybjwVbKIwgahWR8WQAvR6FsC155w95McSdeGx5fORBNWLceEjSBnB4Ue
	 /2ZGyOpoIuqiLyNiE4XBCf0R1lO+bTonqBwt6ynFW6VTMy/8fJdm9o/ssg7v3UFjdb
	 /xkilAoVQ3G4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4B8C2CE0D79; Wed,  7 Oct 2026 08:59:36 -0700 (PDT)
Date: Wed, 7 Oct 2026 08:59:36 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun@kernel.org>, Kunwu Chan <kunwu.chan@gmail.com>,
	Wang Lian <lianux.mm@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	Bradley Morgan <brads@mainlining.org>, rcu@vger.kernel.org,
	lkmm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [BUG] Splat during modest hazptrtorture run
Message-ID: <631c13bc-671e-4cf3-b466-0408d7600ab2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1f885062-4905-4d9c-9293-615c145d2d6b@paulmck-laptop>
 <5b5dbb90-69ad-4a8f-8583-f5ba162744d3@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b5dbb90-69ad-4a8f-8583-f5ba162744d3@efficios.com>

On Wed, Oct 07, 2026 at 03:09:27AM -0400, Mathieu Desnoyers wrote:
> On 2026-10-06 19:40, Paul E. McKenney wrote:
> > Hello!
> > 
> > This is all new code, so the bug could be anywhere.  So you all need
> > to know.  ;-)
> > 
> > I got this from the NOPREEMPT variant of hazptr during a nominal
> > "--duration 60" run of torture.sh on x86 with the guest OS split across
> > two NUMA nodes:
> > 
> > [  137.765104] WARNING: kernel/rcu/hazptrtorture.c:658 at hazptr_torture_stats_print+0x25b/0x4f0, CPU#1: hazptr_torture_/136
> > [  137.768647] Modules linked in:
> > [  137.768891] CPU: 1 UID: 0 PID: 136 Comm: hazptr_torture_ Not tainted 7.3.0-rc5-00661-ga1f1e4890d1d-dirty #193 PREEMPTLAZY
> > [  137.769683] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-6.el9 11/05/2023
> > [  137.770319] RIP: 0010:hazptr_torture_stats_print+0x25b/0x4f0
> > [  137.770735] Code: 48 83 c4 20 e8 86 44 fe ff 41 83 fd 01 7e 23 48 c7 c6 6e 85 17 b0 48 c7 c7 db 27 17 b0 e8 6d 44 fe ff f0 ff 05 76 6e 0a 02 90 <0f> 0b 90 4c 8b 64 24 70 48 c7 c7 73 85 17 b0 e8 51 44 fe ff 48 8b
> > [  137.772061] RSP: 0018:ffffa738004ffdf0 EFLAGS: 00010202
> > [  137.772435] RAX: 0000000000000004 RBX: ffffa738004ffe08 RCX: 0000000000000027
> > [  137.772950] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
> > [  137.773455] RBP: ffffa738004ffe60 R08: 4000000000001236 R09: ffffffffb01727df
> > [  137.773980] R10: 0000000020212121 R11: 0000000020212121 R12: 0000000000000000
> > [  137.774479] R13: 0000000000000002 R14: 000000000002ffd6 R15: 0000000000034f03
> > [  137.775000] FS:  0000000000000000(0000) GS:ffff999c2e502000(0000) knlGS:0000000000000000
> > [  137.775578] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  137.776001] CR2: 0000000000000000 CR3: 0000000008830000 CR4: 00000000000006f0
> > [  137.776512] Call Trace:
> > [  137.776700]  <TASK>
> > [  137.776863]  ? __pfx_hazptr_torture_stats+0x10/0x10
> > [  137.777207]  hazptr_torture_stats+0x25/0x70
> > [  137.777508]  kthread+0xd9/0x110
> > [  137.777751]  ? __pfx_kthread+0x10/0x10
> > [  137.778017]  ret_from_fork+0x1bd/0x220
> > [  137.778285]  ? __pfx_kthread+0x10/0x10
> > [  137.778560]  ret_from_fork_asm+0x1a/0x30
> > [  137.778849]  </TASK>
> > [  137.779007] ---[ end trace 0000000000000000 ]---
> > 
> > I have not yet seen this during a PREEMPT run.  Line 658 of
> > hazptrtorture.c is the WARN_ON_ONCE() below:
> > 
> > 	if (i > 1) {
> > 		pr_cont("%s", "!!! ");
> > 		atomic_inc(&n_hazptr_torture_error);
> > 		WARN_ON_ONCE(i > 1); // Too-short grace period
> > 	}
> > 
> > Any thoughts on what might be causing this?
> 
> Hi Paul!
> 
> Can you share which tree and branch (commit) this is running ?
> 
> Does it include my fix from this series ? That would be patch 1 of:
> 
> https://lore.kernel.org/lkml/20260927155134.4740-1-mathieu.desnoyers@efficios.com/

Ah, no, I somehow got the impression that this series was going to be
updated, so did not apply it.  Apologies!

I will pull these in.

> Does it run the additional series from Kunwu Chan found at
> https://lore.kernel.org/lkml/20261002170847.3653663-1-kunwu.chan@gmail.com/ ?

No, but if you are good with it I will pull it in.

May I add your Acked-by or Reviewed-by?

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> > 
> > For that matter, can anyone else reproduce this?
> > 
> > 								Thanx, Paul
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
