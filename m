Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689A8C433E0
	for <rcu@archiver.kernel.org>; Mon, 15 Mar 2021 23:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3252D64F64
	for <rcu@archiver.kernel.org>; Mon, 15 Mar 2021 23:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhCOXLa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 15 Mar 2021 19:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233397AbhCOXLS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 15 Mar 2021 19:11:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06BF364E07;
        Mon, 15 Mar 2021 23:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615849878;
        bh=cyt5+m+H54MVA06BZt1j4xvZoJYimo2TbsujhwdmfqY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vBsskRe2rS+ejZ+ePVYbUtBliABoidDpSi6G1pcG5gTi4XUX25/C3YC8KV0CbGfEN
         VUEv/i4iJzDjflOXFzPaXtSPZVy+U6O53VrQI5JSNuEN8+zjOeR5u3Wz8nFBYSzicY
         LC3Pfj45R4SPIsVs3jZdw84fQpL1M9bQNvyE/D9kAKfUEHVBMiEjQB4PuPLNgEc0SN
         wh/E1qYUZdhCp+nXCsptsEG29dTJ0OlUSoUsqxWJDO0M+8UTvxOk3vC8evkphEIkUc
         dpzc/Z3iEElfeZ9qgEY/rTFZmo48JZFEj9SRJGzhYQPC+1gl9tAkmbxpBB1DcoL1iW
         PlWqOernvxXDg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C315235239EE; Mon, 15 Mar 2021 16:11:17 -0700 (PDT)
Date:   Mon, 15 Mar 2021 16:11:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 06/10] softirq: Don't try waking ksoftirqd
 before it has been spawned
Message-ID: <20210315231117.GP2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210303235958.GA22373@paulmck-ThinkPad-P72>
 <20210304000019.22459-6-paulmck@kernel.org>
 <20210312113641.GA3646@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312113641.GA3646@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 12, 2021 at 12:36:41PM +0100, Frederic Weisbecker wrote:
> On Wed, Mar 03, 2021 at 04:00:15PM -0800, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > If there is heavy softirq activity, the softirq system will attempt
> > to awaken ksoftirqd and will stop the traditional back-of-interrupt
> > softirq processing.  This is all well and good, but only if the
> > ksoftirqd kthreads already exist, which is not the case during early
> > boot, in which case the system hangs.
> > 
> > One reproducer is as follows:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs "TREE03" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y CONFIG_NO_HZ_IDLE=y CONFIG_HZ_PERIODIC=n" --bootargs "threadirqs=1" --trust-make
> > 
> > This commit therefore adds a couple of existence checks for ksoftirqd
> > and forces back-of-interrupt softirq processing when ksoftirqd does not
> > yet exist.  With this change, the above test passes.
> > 
> > Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Reported-by: Uladzislau Rezki <urezki@gmail.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > [ paulmck: Remove unneeded check per Sebastian Siewior feedback. ]
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Applied, thank you!

							Thanx, Paul
