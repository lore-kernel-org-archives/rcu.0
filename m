Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E412AD14;
	Fri, 11 Apr 2025 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744336056; cv=none; b=dOGx03bJmsXBiuZSY8Sao7GR95ViIuD2AlJ3h6FT+MkWYOKV3iiu/zifjjgGdEqsPLKX0LUxy2h/3Yx0BSWBy/7sZk5UcZ4SUHrjzKWPJLimsoWCUCZWwJ1cpzlV96gGiyIrfr++rU83sWTuaam7upxX67eYSJ5LMLHQWPYgm44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744336056; c=relaxed/simple;
	bh=fnW6kMUj6hpCryK1a6aCy8ewflUioOeFRbb2O2/tE6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJb+2B+T/YR/TSERKPuokNV0BhrcT3QAvRIm2Ger61rvqfV/fMLhXhP6Bum5R/1rZDH1uVXQJoAF4x60ZwLlebxGEpqGB9up225l27nh0toiiHWtwMDBKfGuw1RLSiNfjUq0b3XGXWQLFlyp9dQrEyUxwdORz3ihkA/sBAgEKrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyylG5bd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyylG5bd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5508BC4CEDD;
	Fri, 11 Apr 2025 01:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744336055;
	bh=fnW6kMUj6hpCryK1a6aCy8ewflUioOeFRbb2O2/tE6A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pyylG5bddjMYL3DZC6sBUhYJL6CnKdiy/yueq3DXgaeKM7Xd++Q3DQ8qYYU2kFDUM
	 EPPcgkpTItaZiMxaCm2Ri2xoSQH+mgGdc+YqUYwWBbTvLKTn8GjtOHv2mfJps2a+6A
	 cY+RpltCZk2FAdRUtgu7hvsk17Qz4BaWXJ8mB8BH1iYHQmE4tyy+p3JuwFjaI5bV7R
	 5qlCtqHSU9ZlpmoL1HtxU4tJufJVYJ4QJZqk3gJ1jyCQZHxpLPCkUZtYB8ydizjjfY
	 lM2EPX7Sf227IbC5zwZBjhPq8Llji5ktwCrUuqZs6xUFLh8SZqOBoYtJbtaAJcRlE9
	 aNsob1MHzC5CA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EE83CCE09CC; Thu, 10 Apr 2025 18:47:34 -0700 (PDT)
Date: Thu, 10 Apr 2025 18:47:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, rcu@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rcutorture: Perform more frequent testing of
 ->gpwrap
Message-ID: <78c902f2-3b01-49ce-85c0-3c748fa43224@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250410150329.3807285-1-joelagnelf@nvidia.com>
 <20250410150329.3807285-2-joelagnelf@nvidia.com>
 <11caaa93-7acf-417c-9223-1b14a76310b2@paulmck-laptop>
 <98e35c90-5df3-4841-b5b9-7e8d18bab4f8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98e35c90-5df3-4841-b5b9-7e8d18bab4f8@paulmck-laptop>

On Thu, Apr 10, 2025 at 11:54:13AM -0700, Paul E. McKenney wrote:
> On Thu, Apr 10, 2025 at 11:29:03AM -0700, Paul E. McKenney wrote:
> > On Thu, Apr 10, 2025 at 11:03:27AM -0400, Joel Fernandes wrote: >
> > Currently, the ->gpwrap is not tested (at all per my testing) due to
> > the > requirement of a large delta between a CPU's rdp->gp_seq and its
> > node's > rnp->gpseq.  > > This results in no testing of ->gpwrap being
> > set. This patch by default > adds 5 minutes of testing with ->gpwrap
> > forced by lowering the delta > between rdp->gp_seq and rnp->gp_seq to
> > just 8 GPs. All of this is > configurable, including the active time for
> > the setting and a full > testing cycle.  > > By default, the first 25
> > minutes of a test will have the _default_ > behavior there is right now
> > (ULONG_MAX / 4) delta. Then for 5 minutes, > we switch to a smaller delta
> > causing 1-2 wraps in 5 minutes. I believe > this is reasonable since we
> > at least add a little bit of testing for > usecases where ->gpwrap is set.
> > > > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > Much better, thank you!
> > 
> > One potential nit below.  I will run some tests on this version.
> 
> And please feel free to apply the following to both:
> 
> Tested-by: Paul E. McKenney <paulmck@kernel.org>

And this happy situation lasted only until I rebased onto v6.15-rc1 and
on top of this commit:

1342aec2e442 ("Merge branches 'rcu/misc-for-6.16', 'rcu/seq-counters-for-6.16' and 'rcu/torture-for-6.16' into rcu/for-next")

This got me the splat shown below when running rcutorture scenario SRCU-N.
I reverted this commit and tests pass normally.

Your other commit (ARM64 images) continues working fine.

							Thanx, Paul

------------------------------------------------------------------------

[   15.911885] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   15.912413] #PF: supervisor instruction fetch in kernel mode
[   15.912826] #PF: error_code(0x0010) - not-present page
[   15.913218] PGD 0 P4D 0 
[   15.913420] Oops: Oops: 0010 [#1] SMP PTI
[   15.913715] CPU: 3 UID: 0 PID: 62 Comm: rcu_torture_sta Not tainted 6.15.0-rc1-00047-g6e14cad86633 #19 PREEMPT(undef) 
[   15.914535] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[   15.915147] RIP: 0010:0x0
[   15.915348] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   15.915856] RSP: 0000:ffffa0380021fdc8 EFLAGS: 00010246
[   15.916256] RAX: 0000000000000000 RBX: ffffffffb6b02cc0 RCX: 000000000000000a
[   15.916802] RDX: 0000000000000000 RSI: ffff9f121f418cc0 RDI: 0000000000000000
[   15.917305] RBP: 0000000000000000 R08: ffff9f121f418d20 R09: 0000000000000000
[   15.917789] R10: 0000000000000000 R11: 0000000000000005 R12: ffffffffb6b02d20
[   15.918293] R13: 0000000000000000 R14: ffffa0380021fe50 R15: ffffa0380021fdf8
[   15.918801] FS:  0000000000000000(0000) GS:ffff9f1268a96000(0000) knlGS:0000000000000000
[   15.919313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.919628] CR2: ffffffffffffffd6 CR3: 0000000017c32000 CR4: 00000000000006f0
[   15.920004] Call Trace:
[   15.920139]  <TASK>
[   15.920256]  rcu_torture_stats_print+0x16b/0x670
[   15.920514]  ? __switch_to_asm+0x39/0x70
[   15.920719]  ? finish_task_switch.isra.0+0x76/0x250
[   15.920982]  ? __pfx_rcu_torture_stats+0x10/0x10
[   15.921222]  rcu_torture_stats+0x25/0x70
[   15.921435]  kthread+0xf1/0x1e0
[   15.921602]  ? __pfx_kthread+0x10/0x10
[   15.921797]  ? __pfx_kthread+0x10/0x10
[   15.922000]  ret_from_fork+0x2f/0x50
[   15.922193]  ? __pfx_kthread+0x10/0x10
[   15.922395]  ret_from_fork_asm+0x1a/0x30
[   15.922605]  </TASK>
[   15.922723] Modules linked in:
[   15.922890] CR2: 0000000000000000
[   15.923072] ---[ end trace 0000000000000000 ]---
