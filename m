Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA91DA0E6
	for <rcu@vger.kernel.org>; Wed,  4 Sep 2024 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454787; cv=none; b=CVsy6vDumrRRUAPMZoziJjkEMoyYTQbqgpKg/gCewkihJ0LL3O5dmn2yZ1aPgxEI6MP7dcOoKQ+GER6eT8MROM7M+oo9dcX92vvaOBKxA1YiRfbgJ0srmWoEoze8PepQypdm56uVC652R3qhaKi04/sdhT+SSfCT/kqahhet26w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454787; c=relaxed/simple;
	bh=AvrksSYgVnkLbwpGjWw3j1GdFHk1ycS2LVGKwh0+v44=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kubaQnP4M288dkbvzQnf+leD8mzkjiftr8Pi28/DIcbQSA7BKap6HaEoztBCs2nJZjTokQsjIDh/hL9O/phEBUi1Dk79OPNW8K8AL0Ts1R6Vw8PWBBV1sY53fU1H+yNKjy5fI9v5YIr/af4Aw94O9YfLfwv4oX9VMWex6GQh21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhsxNQgE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhsxNQgE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB2DC4CEC2;
	Wed,  4 Sep 2024 12:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725454786;
	bh=AvrksSYgVnkLbwpGjWw3j1GdFHk1ycS2LVGKwh0+v44=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=nhsxNQgE3Dw34YKF9MLgGiUroGCg2eY1IyzoP7/GynWiKA7CqvXohN3BkWyrCVW/Y
	 lchu9IbciwLFjO3wnDSju6JqH9LMlys+nIE9GrGueZ46k6F518rYNUYRvcW4kMWPff
	 0mTxp5c2pgtyHxf7tLldNL3Eo8rJiOOI1P8dS82JZ8eoTRgp0gwSP4ahg9jOGVttq9
	 lN9hp0Bb5MUIGkgQtnsD4+lwrFOgPsujMXvNVpMbdDu3vPC93vqFBGzpgWDoJpslkJ
	 lYEm7GVAFLTH4uuYyKoFYPV1pbPE7a5jIt1m1lwCZX1QzQ2tyF7pK3MRAQaTiwnM+l
	 uhkN/ktfhbA1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2B670CE09D1; Wed,  4 Sep 2024 05:59:46 -0700 (PDT)
Date: Wed, 4 Sep 2024 05:59:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>,
	Z qiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: One-off rcu_nocb_rdp_deoffload bug
Message-ID: <236a1f66-f128-44e4-9272-7ae4dbad7485@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <2747e596-5359-4f32-b3e0-0b2368d37017@paulmck-laptop>
 <CALm+0cV0GwT5umPRZrZWg4oqXwdjcWz-NkxkhgxQkv=NypQthA@mail.gmail.com>
 <CAFTL4hzY09QEGE+sTqc02d2LkuH_ObYKiuVTfGnrtwjtYiwt4A@mail.gmail.com>
 <d31bdc50-a61b-446b-926d-b3ddde832a91@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d31bdc50-a61b-446b-926d-b3ddde832a91@paulmck-laptop>

On Tue, Aug 20, 2024 at 10:46:43AM -0700, Paul E. McKenney wrote:
> On Tue, Aug 20, 2024 at 04:43:39PM +0200, Frederic Weisbecker wrote:
> > Sorry for the html mail, I only have my phone ...
> > 
> > Le mar. 20 août 2024, 13:07, Z qiang <qiang.zhang1211@gmail.com> a écrit :
> > 
> > > >
> > > > Hello, Frederic,
> > > >
> > > > I have seen this once on Neeraj's tree with a few commits on top (-rcu
> > > > commit 46774278c74f ("rcutorture: Test start-poll primitives with
> > > > interrupts disabled").  But only the once so far.
> > > >
> > > > This is the WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist)) in
> > > > rcu_nocb_rdp_deoffload().
> > > >
> > > > Thoughts?
> > > >
> > >
> > > The rcu_segcblist_extract_done_cbs() doesn't reduce the count of
> > > rsclp->len,
> > > in rcu_do_bacth().  this may cause that after we execute the barrier rcu
> > > callback, before decrementing the count of rsclp->len,  the rcu_barrier()
> > > returns and makes a judgment of rcu_segcblist_n_cbs(&rdp->cblist)  in
> > > rcu_nocb_rdp_deoffload().
> > >
> > 
> > That sounds plausible! You just unlocked my thoughts running in circle
> > since yesterday.
> > 
> > 
> > > maybe can use WARN_ON_ONCE(rcu_segcblist_n_segment_cbs()) instead
> > > of WARN_ON_ONCE(rcu_segcblist_n_cbs())
> > >
> > > Thoughts?
> > 
> > I'll test that once I'm back from vacation the september 2nd. Thanks!
> 
> Thank you both!!!
> 
> Running -next over last night hit a number of boot-time splats, so I
> have no idea if this reproduces nicely.  Can't have everything!  ;-)

And it is now a two-off given another one last night's testing.  This was
from 168 hours of TREE01 on my -rcu "dev" branch (as opposed to -next),
but I have run many runs over the past two weeks.  So it is reproducible,
but rare.

Ah, and if it matters, I synched up to Neeraj's latest as of about 18
hours ago just before starting this test.


							Thanx, Paul

------------------------------------------------------------------------

[13375.559536] ------------[ cut here ]------------
[13375.560748] WARNING: CPU: 27 PID: 103 at kernel/rcu/tree_nocb.h:1061 rcu_nocb_rdp_deoffload+0x292/0x2a0
[13375.563088] Modules linked in:
[13375.563861] CPU: 27 UID: 0 PID: 103 Comm: rcu_nocb_toggle Not tainted 6.11.0-rc1-00141-gc5fc1889f28b #1923
[13375.566261] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[13375.569047] RIP: 0010:rcu_nocb_rdp_deoffload+0x292/0x2a0
[13375.570373] Code: e9 3c ff ff ff 4c 89 e6 48 89 ef e8 88 fd e0 00 e9 3b fe ff ff 90 0f 0b 90 48 8b 83 c0 00 00 00 48 85 c0 0f 84 0b fe ff ff 90 <0f> 0b 90 e9 02 fe ff ff e8 d1 4f e0 00 90 90 90 90 90 90 90 90 90
[13375.574999] RSP: 0018:ffffafa9c04b3e30 EFLAGS: 00010002
[13375.576302] RAX: 000000000000007c RBX: ffff8f4a1eb6f480 RCX: 000000000000002b
[13375.578069] RDX: 0000000000000001 RSI: 000000000000002b RDI: ffff8f4a1eb6f5f0
[13375.579837] RBP: ffff8f4a1eb6f5f0 R08: 000000000000002a R09: 0000000000000001
[13375.581608] R10: ffffffff8d99b408 R11: 00000000001d1c76 R12: 0000000000000246
[13375.583376] R13: 0000000000000000 R14: ffff8f4a1ea2f480 R15: 0000000000000001
[13375.585149] FS:  0000000000000000(0000) GS:ffff8f4a1f0c0000(0000) knlGS:0000000000000000
[13375.587158] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[13375.588598] CR2: 0000000000000000 CR3: 0000000002e0c000 CR4: 00000000000006f0
[13375.590360] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[13375.592163] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[13375.593943] Call Trace:
[13375.594572]  <TASK>
[13375.595102]  ? __warn+0x7e/0x120
[13375.595917]  ? rcu_nocb_rdp_deoffload+0x292/0x2a0
[13375.597091]  ? report_bug+0x18e/0x1a0
[13375.598013]  ? handle_bug+0x3d/0x70
[13375.598892]  ? exc_invalid_op+0x18/0x70
[13375.599935]  ? asm_exc_invalid_op+0x1a/0x20
[13375.600987]  ? rcu_nocb_rdp_deoffload+0x292/0x2a0
[13375.602163]  rcu_nocb_cpu_deoffload+0x70/0xa0
[13375.603262]  rcu_nocb_toggle+0x136/0x1c0
[13375.604250]  ? __pfx_rcu_nocb_toggle+0x10/0x10
[13375.605361]  kthread+0xd1/0x100
[13375.606159]  ? __pfx_kthread+0x10/0x10
[13375.607102]  ret_from_fork+0x2f/0x50
[13375.608001]  ? __pfx_kthread+0x10/0x10
[13375.608941]  ret_from_fork_asm+0x1a/0x30
[13375.609928]  </TASK>
[13375.610486] ---[ end trace 0000000000000000 ]---
