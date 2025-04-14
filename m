Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A7525D1E0;
	Mon, 14 Apr 2025 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640641; cv=none; b=LmYMexnLsExJfoCl/L/OrTkFhXwYUkbwXaAl0qhgDfEqPjBIEvjj+yLmazDNAP1b/RFmfKuoyK295VgsPHEzuOTgwaHagyjXZbDjEbvrT8r6w+lcge/ioWcVw6j7PEMoliH1xox6K/2JfCrOeQJ4xpFAKaKtPcxTC5McFw8OhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640641; c=relaxed/simple;
	bh=OJfDjFejWxWtrt/sjrPQztTjKO+5Bhi/fjLDHACNPlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umkkZuM8KZkDcLndVT5NnOcajwzBAu1MCHs6Ox9X97MFtBi6EwrXKHcWlxfezK5d8NWzyzcB8OrIKJvwhhJAHQNzISaMsIrGos2C7pIQWxn9jCZHZOpJiEfRJ1ogfwSwG7cQHixl0c0qVI1eXGOmaPJRa6/kvBYMQqVSA9PxtCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qC12SpF3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qC12SpF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D69C4CEE9;
	Mon, 14 Apr 2025 14:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744640640;
	bh=OJfDjFejWxWtrt/sjrPQztTjKO+5Bhi/fjLDHACNPlk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qC12SpF3HV5y/s0gh1ahd/BBZy6ymz/U3itu1UiGk416gojqjahX/ThrjSlodE2vw
	 c+naHcyzn1QBQghaCcIv7w0W3h/vhiabb6jsc175uiigpjigP5G0MmFT/aJ93tlO2e
	 aIy6I3Hvx5TPB+Dsc2m84w2UNu+woStwZDQ8+BN+2i0bVQJrOfL+awfuV/Sp2tORyt
	 qKz1zv9QneKJVFmWaJYElIGPwnNFeuqzOdn9TYaIzWB27ZBnZizX1zy9hDRtjJlXHb
	 CgBpN1vOJxBmGD2/bnicjmYdgsH7MQzS2SgrILJsFIG2J6KG6jMMpPX+FO7PUd/3XZ
	 4zrtKwEbGAhuw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 17496CE0848; Mon, 14 Apr 2025 07:24:00 -0700 (PDT)
Date: Mon, 14 Apr 2025 07:24:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, rcu <rcu@vger.kernel.org>
Subject: Re: [v3,1/2] rcutorture: Perform more frequent testing of ->gpwrap
Message-ID: <75bdde29-55f7-4210-a3ea-ea859a0e3a1a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <71ab408c-a01b-43a9-993c-4a55294e15ef@paulmck-laptop>
 <BE7C948D-5238-48C4-93E1-1BAE4CBBD391@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BE7C948D-5238-48C4-93E1-1BAE4CBBD391@joelfernandes.org>

On Mon, Apr 14, 2025 at 08:07:24AM -0400, Joel Fernandes wrote:
> 
> 
> > On Apr 11, 2025, at 3:18 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Fri, Apr 11, 2025 at 05:36:32AM -0000, Joel Fernandes wrote:
> >> Hello, Paul,
> >> 
> >>> On Fri, 11 Apr 2025 05:33:16 GMT, "Paul E. McKenney" wrote:
> >>> On Thu, Apr 10, 2025 at 11:54:13AM -0700, Paul E. McKenney wrote:
> >>>> On Thu, Apr 10, 2025 at 11:29:03AM -0700, Paul E. McKenney wrote:
> >>>>> On Thu, Apr 10, 2025 at 11:03:27AM -0400, Joel Fernandes wrote: >
> >>>>> Currently, the ->gpwrap is not tested (at all per my testing) due to
> >>>>> the > requirement of a large delta between a CPU's rdp->gp_seq and its
> >>>>> node's > rnp->gpseq.  > > This results in no testing of ->gpwrap being
> >>>>> set. This patch by default > adds 5 minutes of testing with ->gpwrap
> >>>>> forced by lowering the delta > between rdp->gp_seq and rnp->gp_seq to
> >>>>> just 8 GPs. All of this is > configurable, including the active time for
> >>>>> the setting and a full > testing cycle.  > > By default, the first 25
> >>>>> minutes of a test will have the _default_ > behavior there is right now
> >>>>> (ULONG_MAX / 4) delta. Then for 5 minutes, > we switch to a smaller delt
> >>> a
> >>>>> causing 1-2 wraps in 5 minutes. I believe > this is reasonable since we
> >>>>> at least add a little bit of testing for > usecases where ->gpwrap is se
> >>> t.
> >>>>>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> >>>>> 
> >>>>> Much better, thank you!
> >>>>> 
> >>>>> One potential nit below.  I will run some tests on this version.
> >>>> 
> >>>> And please feel free to apply the following to both:
> >>>> 
> >>>> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> >>> 
> >>> And this happy situation lasted only until I rebased onto v6.15-rc1 and
> >>> on top of this commit:
> >>> 
> >>> 1342aec2e442 ("Merge branches 'rcu/misc-for-6.16', 'rcu/seq-counters-for-6.1
> >>> 6' and 'rcu/torture-for-6.16' into rcu/for-next")
> >>> 
> >>> This got me the splat shown below when running rcutorture scenario SRCU-N.
> >>> I reverted this commit and tests pass normally.
> >>> 
> >>> Your other commit (ARM64 images) continues working fine.
> >> 
> >> Interesting.. it seems to be crashing during statistics printing.
> >> 
> >> I am wondering if the test itself uncovered a bug or the bug is in the test
> >> itself.
> > 
> > Both are quite possible, also a bug somewhere else entirely.
> 
> I may not get to debugging it for this merge window so I am leaning to defer it.

The usual cause is use of an rcu_torture_ops function pointer without
having first checked that it is non-NULL.  But I suspect that you already
checked for this.

> >> Looking forward to your test with the other patch and we could hold off on this
> >> one till we have more data about what is going on.
> > 
> > This one got lot of OOMs when tests of RCU priority boosting overlapped
> > with testing of RCU callback flooding on TREE03, as in 13 of the 14
> > 9-hour runs.  Back on v6.14-rc1, these were quite rare.
> > 
> > Ah, and I am carrying this as an experimental patch:
> > 
> > 269b9b5be09d ("EXP sched: Disable DL server if sysctl_sched_rt_runtime is -1")
> > 
> > Just checking to see if this is still something I should be carrying.
> 
> I think since it exposing boost issues, we should carry it! However since it is also noisy, maybe for short term we not carry it in any trees since we are getting close to posting the topic branches.

I am carrying it in -rcu, but marked "EXP" so that I don't post it or
send it along in a pull request.

> Do you see the same boost issues or frequency of them when carrying it on 6.15-rc1 without any of this merge windows changes?
> 
> By the way I have to rewrite that EXP patch at some point based on a review of it but functionally that patch is good.

I just now started a short test with it reverted.

Oh, and yours and Boqun's latest passed overnight tests except for a
few Kconfig issues including the PREEMPT_RT pair:

75cf58ef310a ("Merge branches 'rcu/misc-for-6.16', 'rcu/seq-counters-for-6.16' and 'rcu/torture-for-6.16' into rcu/for-next")

This is a known Kconfig issue in torture.sh, fixed by this -rcu commit:

2e26af16b7b6 ("torture.sh: Force CONFIG_RCU_NOCB_CPU=y for --do-rt configurations")

There are also Kconfig issues with a few of the KCSAN rcutorture scenarios
that I am looking into.  And torture.sh needs to be more aggressive about
reporting these...

							Thanx, Paul

> Thanks,
> 
> - Joel 
> 
> > 
> >                            Thanx, Paul
> > 
> >> thanks,
> >> 
> >> - Joel
> >> 
> >> 
> >> 
> >> 
> >>> 
> >>>                            Thanx, Paul
> >>> 
> >>> ------------------------------------------------------------------------
> >>> 
> >>> [   15.911885] BUG: kernel NULL pointer dereference, address: 00000000000000
> >>> 00
> >>> [   15.912413] #PF: supervisor instruction fetch in kernel mode
> >>> [   15.912826] #PF: error_code(0x0010) - not-present page
> >>> [   15.913218] PGD 0 P4D 0
> >>> [   15.913420] Oops: Oops: 0010 [#1] SMP PTI
> >>> [   15.913715] CPU: 3 UID: 0 PID: 62 Comm: rcu_torture_sta Not tainted 6.15.
> >>> 0-rc1-00047-g6e14cad86633 #19 PREEMPT(undef)
> >>> [   15.914535] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15
> >>> .0-1 04/01/2014
> >>> [   15.915147] RIP: 0010:0x0
> >>> [   15.915348] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> >>> [   15.915856] RSP: 0000:ffffa0380021fdc8 EFLAGS: 00010246
> >>> [   15.916256] RAX: 0000000000000000 RBX: ffffffffb6b02cc0 RCX: 000000000000
> >>> 000a
> >>> [   15.916802] RDX: 0000000000000000 RSI: ffff9f121f418cc0 RDI: 000000000000
> >>> 0000
> >>> [   15.917305] RBP: 0000000000000000 R08: ffff9f121f418d20 R09: 000000000000
> >>> 0000
> >>> [   15.917789] R10: 0000000000000000 R11: 0000000000000005 R12: ffffffffb6b0
> >>> 2d20
> >>> [   15.918293] R13: 0000000000000000 R14: ffffa0380021fe50 R15: ffffa0380021
> >>> fdf8
> >>> [   15.918801] FS:  0000000000000000(0000) GS:ffff9f1268a96000(0000) knlGS:0
> >>> 000000000000000
> >>> [   15.919313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> [   15.919628] CR2: ffffffffffffffd6 CR3: 0000000017c32000 CR4: 000000000000
> >>> 06f0
> >>> [   15.920004] Call Trace:
> >>> [   15.920139]  <TASK>
> >>> [   15.920256]  rcu_torture_stats_print+0x16b/0x670
> >>> [   15.920514]  ? __switch_to_asm+0x39/0x70
> >>> [   15.920719]  ? finish_task_switch.isra.0+0x76/0x250
> >>> [   15.920982]  ? __pfx_rcu_torture_stats+0x10/0x10
> >>> [   15.921222]  rcu_torture_stats+0x25/0x70
> >>> [   15.921435]  kthread+0xf1/0x1e0
> >>> [   15.921602]  ? __pfx_kthread+0x10/0x10
> >>> [   15.921797]  ? __pfx_kthread+0x10/0x10
> >>> [   15.922000]  ret_from_fork+0x2f/0x50
> >>> [   15.922193]  ? __pfx_kthread+0x10/0x10
> >>> [   15.922395]  ret_from_fork_asm+0x1a/0x30
> >>> [   15.922605]  </TASK>
> >>> [   15.922723] Modules linked in:
> >>> [   15.922890] CR2: 0000000000000000
> >>> [   15.923072] ---[ end trace 0000000000000000 ]---
