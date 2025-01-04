Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794722914;
	Sat,  4 Jan 2025 01:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735953287; cv=none; b=qSm8/oLtF/yBJs+Hrvyaf4FAy+wgn4w5g831Wfr1WsjKf3J3qQCErtCe/vZJc7WLCdXpK9MQymXzh5hom4wIvZTHtts/emwOCyMH8X/8DesYKFmgVRw9iSBo673qxiIGOBZ861vOE22uw7oyowgJSYtPdvm+obmYJnsVSodgxmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735953287; c=relaxed/simple;
	bh=HqMXK1wC2oDxS29DmLcwJV6pK6bB08okpn9m9iDlouU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyweEh6v00QCRbtaZRoItRjrUnrDVhHsWS0wm6NW3OgRB732v2A1Rcx4dRXRTpPJYfPSRdNv7cheTMmPlt8iUSicG1n9L4GGk8lucU0m6hdXPJYn05bmV4fZGRUOvqRKpKic7j4NCkjvnGj6sj5iVmm7YvcUVGmJPsxB5NNhBo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIuP2oMS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIuP2oMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE168C4CED6;
	Sat,  4 Jan 2025 01:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735953287;
	bh=HqMXK1wC2oDxS29DmLcwJV6pK6bB08okpn9m9iDlouU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XIuP2oMSsVWXiLxYzNoQGMuC4qMCRshpF6qTi2JJ3qACIOb2IKTQjNQrbwb8wMdtS
	 sGFAeSm16WOJtwB549GgpdbzMaa4r/mUQ45zD20TXqYeWP8EhZlVeQX9EppQvkhfBi
	 WNIWMBHDwqFqTZAR82KIqXSlu1oS7+4q8uJ3jLx8PWQ7z9gnhjslsK57Xazs2fbTsZ
	 olGL7hzBZWo0uv9uYyAhQTtDJTnTma5RhRtj4zDUVv+5f0prHHLJLqIOxiafsC+4jL
	 teBdItwI+wivDTsqZ+HpGNJ3YwAPXu0X0cdAxmSnkV2N2wU960sndQJjauveFtttc4
	 QdNhqS1Y+TXZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9767CCE3844; Fri,  3 Jan 2025 17:14:46 -0800 (PST)
Date: Fri, 3 Jan 2025 17:14:46 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: syzbot <syzbot+16a19b06125a2963eaee@syzkaller.appspotmail.com>,
	acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	jolsa@kernel.org, kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
	mhiramat@kernel.org, mingo@redhat.com, namhyung@kernel.org,
	oleg@redhat.com, peterz@infradead.org,
	syzkaller-bugs@googlegroups.com, RCU <rcu@vger.kernel.org>
Subject: Re: [syzbot] [perf?] [trace?] KCSAN: assert: race in
 srcu_gp_start_if_needed
Message-ID: <77c8887d-e69c-4554-9c9f-c9d755c7aff5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <6743acf4.050a0220.1cc393.004d.GAE@google.com>
 <CANpmjNMQ7ZVG0i9j1K7J0yKrtfrFfHi6kXaA7FLKmX5T4yWXTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMQ7ZVG0i9j1K7J0yKrtfrFfHi6kXaA7FLKmX5T4yWXTw@mail.gmail.com>

On Sun, Nov 24, 2024 at 11:48:46PM +0100, Marco Elver wrote:
> +Cc RCU
> 
> On Sun, 24 Nov 2024 at 23:47, syzbot
> <syzbot+16a19b06125a2963eaee@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    42d9e8b7ccdd Merge tag 'powerpc-6.13-1' of git://git.kerne..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10a00778580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3d7fd5be0e73b8b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=16a19b06125a2963eaee
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/ef231513adc7/disk-42d9e8b7.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/54caaac5960b/vmlinux-42d9e8b7.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/85b5a6566143/bzImage-42d9e8b7.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+16a19b06125a2963eaee@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: assert: race in srcu_get_delay kernel/rcu/srcutree.c:658 [inline]
> > BUG: KCSAN: assert: race in srcu_funnel_gp_start kernel/rcu/srcutree.c:1089 [inline]
> > BUG: KCSAN: assert: race in srcu_gp_start_if_needed+0x808/0x9f0 kernel/rcu/srcutree.c:1339

Hmmm...  All of those are from slow paths, so locking looks to be the
best approach.

A very lightly tested prototype patch is shown below (for which feedback
is most welcome), and thank you all for your testing efforts!

							Thanx, Paul

------------------------------------------------------------------------

commit a955c6a7168f7b204784e4ef7e4db9d017043f73
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Jan 3 17:04:49 2025 -0800

    srcu: Force synchronization for srcu_get_delay()
    
    Currently, srcu_get_delay() can be called concurrently, for example,
    by a CPU that is the first to request a new grace period and the CPU
    processing the current grace period.  Although concurrent access is
    harmless, it unnecessarily expands the state space.  Additionally,
    all calls to srcu_get_delay() are from slow paths.
    
    This commit therefore protects all calls to srcu_get_delay() with
    ssp->srcu_sup->lock, which is already held on the invocation from the
    srcu_funnel_gp_start() function.  While in the area, this commit also
    adds a lockdep_assert_held() to srcu_get_delay() itself.
    
    Reported-by: syzbot+16a19b06125a2963eaee@syzkaller.appspotmail.com
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7c7304dee6457..a60acc9cf2f32 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -648,6 +648,7 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 	unsigned long jbase = SRCU_INTERVAL;
 	struct srcu_usage *sup = ssp->srcu_sup;
 
+	lockdep_assert_held(&ACCESS_PRIVATE(ssp->srcu_sup, lock));
 	if (srcu_gp_is_expedited(ssp))
 		jbase = 0;
 	if (rcu_seq_state(READ_ONCE(sup->srcu_gp_seq))) {
@@ -675,9 +676,13 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 void cleanup_srcu_struct(struct srcu_struct *ssp)
 {
 	int cpu;
+	unsigned long delay;
 	struct srcu_usage *sup = ssp->srcu_sup;
 
-	if (WARN_ON(!srcu_get_delay(ssp)))
+	spin_lock_irq_rcu_node(ssp->srcu_sup);
+	delay = srcu_get_delay(ssp);
+	spin_unlock_irq_rcu_node(ssp->srcu_sup);
+	if (WARN_ON(!delay))
 		return; /* Just leak it! */
 	if (WARN_ON(srcu_readers_active(ssp)))
 		return; /* Just leak it! */
@@ -1100,7 +1105,9 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
 {
 	unsigned long curdelay;
 
+	spin_lock_irq_rcu_node(ssp->srcu_sup);
 	curdelay = !srcu_get_delay(ssp);
+	spin_unlock_irq_rcu_node(ssp->srcu_sup);
 
 	for (;;) {
 		if (srcu_readers_active_idx_check(ssp, idx))
@@ -1849,7 +1856,9 @@ static void process_srcu(struct work_struct *work)
 	ssp = sup->srcu_ssp;
 
 	srcu_advance_state(ssp);
+	spin_lock_irq_rcu_node(ssp->srcu_sup);
 	curdelay = srcu_get_delay(ssp);
+	spin_unlock_irq_rcu_node(ssp->srcu_sup);
 	if (curdelay) {
 		WRITE_ONCE(sup->reschedule_count, 0);
 	} else {
