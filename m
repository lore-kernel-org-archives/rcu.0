Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4646CC433EF
	for <rcu@archiver.kernel.org>; Mon, 18 Oct 2021 18:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ACF761212
	for <rcu@archiver.kernel.org>; Mon, 18 Oct 2021 18:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhJRSiQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 18 Oct 2021 14:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231590AbhJRSiQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 18 Oct 2021 14:38:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A94446115A;
        Mon, 18 Oct 2021 18:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634582164;
        bh=huimII72Q6HT5Fu0WQPjq91uUSA7jxarOr1mN4dR+H8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mvwzRFnxr/Np5yDpnoa0oSduExfW8jepix6pVUE+4UvSlqOb2GyHEeBsCrJTg6PXz
         5Hpovqqqswjplnwfb95Ay65SyV8niyYC1zRr31AXJoH2udmVVdjHg5ugrvwow5Luow
         t6F4r/+D2ANSFlw2/JjY1EMhY7VVMCiFCgnITwQ0Mnxs+M9J/JmWQxncuCMKy5m42x
         S9rnTI+9BHcr5BpKS8KYg5O03Jp0JWlsWhQmM7u1TmMsFWZYgNlg8yLFizgQ8wRFEL
         0gQwt5g+Mty5TstF3G8UannWbsFAwOGk3dfAug83c5vsTpXcHd3aG6Nwb0NA9rs76O
         fONTQxy2YW+lQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7AD645C0DF2; Mon, 18 Oct 2021 11:36:04 -0700 (PDT)
Date:   Mon, 18 Oct 2021 11:36:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Fix misordered rcu_barrier() while
 (de-)offloading
Message-ID: <20211018183604.GT880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211018113259.450292-1-frederic@kernel.org>
 <20211018161814.GS880162@paulmck-ThinkPad-P17-Gen-1>
 <20211018174242.GA450204@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018174242.GA450204@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 18, 2021 at 07:42:42PM +0200, Frederic Weisbecker wrote:
> On Mon, Oct 18, 2021 at 09:18:14AM -0700, Paul E. McKenney wrote:
> > On Mon, Oct 18, 2021 at 01:32:59PM +0200, Frederic Weisbecker wrote:
> > > When an rdp is in the process of (de-)offloading, rcu_core() and the
> > > nocb kthreads can process callbacks at the same time. This leaves many
> > > possible scenarios leading to an rcu barrier to execute before
> > > the preceding callbacks. Here is one such example:
> > > 
> > >             CPU 0                                  CPU 1
> > >        --------------                         ---------------
> > >      call_rcu(callbacks1)
> > >      call_rcu(callbacks2)
> > >      // move callbacks1 and callbacks2 on the done list
> > >      rcu_advance_callbacks()
> > >      call_rcu(callbacks3)
> > >      rcu_barrier_func()
> > >          rcu_segcblist_entrain(...)
> > >                                             nocb_cb_wait()
> > >                                                 rcu_do_batch()
> > >                                                     callbacks1()
> > >                                                     cond_resched_tasks_rcu_qs()
> > >      // move callbacks3 and rcu_barrier_callback()
> > >      // on the done list
> > >      rcu_advance_callbacks()
> > >      rcu_core()
> > >          rcu_do_batch()
> > >              callbacks3()
> > >              rcu_barrier_callback()
> > >                                                     //MISORDERING
> > >                                                     callbacks2()
> > > 
> > > Fix this with preventing two concurrent rcu_do_batch() on a  same rdp
> > > as long as an rcu barrier callback is pending somewhere.
> > > 
> > > Reported-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> > > Cc: Uladzislau Rezki <urezki@gmail.com>
> > 
> > Yow!
> > 
> > But how does the (de-)offloading procedure's acquisition of
> > rcu_state.barrier_mutex play into this?  In theory, that mutex was
> > supposed to prevent these sorts of scenarios.  In practice, it sounds
> > like the shortcomings in this theory should be fully explained so that
> > we don't get similar bugs in the future.  ;-)
> 
> I think you're right. The real issue is something I wanted to
> fix next: RCU_SEGCBLIST_RCU_CORE isn't cleared when nocb is enabled on
> boot so rcu_core() always run concurrently with nocb kthreads in TREE04,
> without holding rcu_barrier mutex of course (I mean with the latest patchset).

That would do it!

> Ok forget this patch, I'm testing again with simply clearing
> RCU_SEGCBLIST_RCU_CORE on boot.

Sounds good, looking forward to it!

							Thanx, Paul
