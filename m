Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F9D3B9D9E;
	Thu,  8 Oct 2026 03:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431607; cv=none; b=i7Zo2DD6ja9e43gsKE/K3eleClNyF8CpOv2ATWs4zRgmxmzeDyMkwSw2lvZh/wN8c0MNbhXYsvOdHW27evLcrd4AFsEdS8u0anXLUSOigWOzwc+WhD2vt2JGabkM8LtWNp4dM2EZ/2JOZ3Xh6i3zlKbEq8P40HpoAOJ3wj6aadw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431607; c=relaxed/simple;
	bh=TNgSDnYZD7YbDnL55kcEPHrC6ar9UysWeHhomCcSwDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0VtMz+CCREjTQ+ayWzvwEWn4RVQnJpBnwuh9WveEraIwU1ENNEHO/EFIv/fzF47AWbWqXs8QtTdoNtg16V9AgPfU9/EZmpH+mcrd8GJuuUsQoj+iFZzYXM3njyjZGc0VI4FGO8tLGOLiwOsSNenmoLNjrHK3wukdOS0ctNsO44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onAKJSq7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onAKJSq7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323CE1F000FF;
	Thu,  8 Oct 2026 03:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791431606;
	bh=ao6xX+MlqWLBH+HbKwuIuhQxFZx4B7vINuewFzQGug0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=onAKJSq77SZPHzsXnimXTG2OVTiLUY+pWHtG6nNoG3hQ0LVjVhwyfAoXEJ+td6XUH
	 bBJ1yAp1mklbwh12PLYu7UvQXrf07YlAwOCr9ggQH/8mLrWJt7Hhd7egLT2ChX297k
	 zH04ZpOXLy1wMvLX2jaR1vdHpw01EcdssVVCjnRqXd4w8zMa4nCBXBfx4xZiv7C9Tc
	 o0fW+Uk7Gz+QbKAQZ704vLeEbgS1SPCGt3SgyCWNfuFgLwRFKvmFaBSlApqFopg0hU
	 FZe0KMcpTQvk0UuclFOdVCIZArcVuGnz1nzj9cYbxDChnb+gjf2fXpLwun/M8WV+8o
	 lng3lx0sk175g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D4F3ACE0D79; Wed,  7 Oct 2026 20:53:25 -0700 (PDT)
Date: Wed, 7 Oct 2026 20:53:25 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>, Wang Lian <lianux.mm@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Bradley Morgan <brads@mainlining.org>, rcu@vger.kernel.org,
	lkmm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [BUG] Splat during modest hazptrtorture run
Message-ID: <a411c4d9-2a38-4a9d-bf8f-66f9c50394a1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1f885062-4905-4d9c-9293-615c145d2d6b@paulmck-laptop>
 <5b5dbb90-69ad-4a8f-8583-f5ba162744d3@efficios.com>
 <631c13bc-671e-4cf3-b466-0408d7600ab2@paulmck-laptop>
 <CAN_Opa_a5MbG_50DTg=Eu_f5X_ZiYUdyzVGiAzHGhP__xDpxnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN_Opa_a5MbG_50DTg=Eu_f5X_ZiYUdyzVGiAzHGhP__xDpxnw@mail.gmail.com>

On Thu, Oct 08, 2026 at 09:39:50AM +0800, KunWu Chan wrote:
> On Wed, Oct 7, 2026 at 11:59 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Oct 07, 2026 at 03:09:27AM -0400, Mathieu Desnoyers wrote:
> > > On 2026-10-06 19:40, Paul E. McKenney wrote:
> > > > Hello!
> > > >
> > > > This is all new code, so the bug could be anywhere.  So you all need
> > > > to know.  ;-)

TL;DR: Adding the first patch in Mathieu's four-patch series cures this
for me.

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
> > > >     if (i > 1) {
> > > >             pr_cont("%s", "!!! ");
> > > >             atomic_inc(&n_hazptr_torture_error);
> > > >             WARN_ON_ONCE(i > 1); // Too-short grace period
> > > >     }
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
> >
> > > Does it run the additional series from Kunwu Chan found at
> > > https://lore.kernel.org/lkml/20261002170847.3653663-1-kunwu.chan@gmail.com/ ?
> >
> 
> Hi Paul,
> 
> I have posted v3 of the series since then. The link in Mathieu's
> question points to v2.
> 
> Please use the latest v3 series here:
> https://lore.kernel.org/all/20261005171529.1378809-1-kunwu.chan@gmail.com/

I do it the old way with out b4, so I would have bot there.  I will
hold off a bit for merge-window preparation, though.

> I wasn't able to reproduce the warning with my current setup(without
> my series).
> Could you share the .config and the exact command line you used to run the
> test? That may help me reproduce it.

I used this command line, which creates the .config:

tools/testing/selftests/rcutorture/bin/kvm.sh --torture hazptr --allcpus --configs "2*CFLIST" --duration 90m --trust-make

This was on an ARM system, in case that matters.

But pulling in Mathieu's first patch took care of this issue for me.

							Thanx, Paul

> Thanks,
> Kunwu
> 
> > No, but if you are good with it I will pull it in.
> >
> > May I add your Acked-by or Reviewed-by?
> >
> >                                                         Thanx, Paul
> >
> > > Thanks,
> > >
> > > Mathieu
> > >
> > > >
> > > > For that matter, can anyone else reproduce this?
> > > >
> > > >                                                             Thanx, Paul
> > >
> > >
> > > --
> > > Mathieu Desnoyers
> > > EfficiOS Inc.
> > > https://www.efficios.com
