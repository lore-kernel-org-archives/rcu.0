Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD02C4338F
	for <rcu@archiver.kernel.org>; Fri, 23 Jul 2021 03:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7DE60E9C
	for <rcu@archiver.kernel.org>; Fri, 23 Jul 2021 03:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhGWDIz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 22 Jul 2021 23:08:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233459AbhGWDIy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 22 Jul 2021 23:08:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E8D760C41;
        Fri, 23 Jul 2021 03:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627012168;
        bh=a/MzGD2JOFlT48VZrtsABw6EGXuz8j8DNqs9KHjpaTw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=njQpXxkXflDf08JcOzCsV2Ov2Ux7pXNIg/BkwqrLZWQTau5J/EGSKD0lKQq8WMXbX
         W614zU870H8KV15+VeNd0TqZsIRKdTxkjzBwDAS2ooZCpBrcnK315A5girJqULK9WB
         Y70GiTbeEhobIVPd+O919nkJc/l2ZG0SGRqIbok4Drb5Ay3adiuwKyOnM3FbqNSrr+
         SLvPC8+gk7ENbh1t3CfSYUM5MPkRvTFJU3PIWbjfP32KkbbpyQm87s9Kk2M/h/9xOk
         Oa0ViQlUqhVaChj503SIrpCkI3Vc0K1yM1k+CGKU14uJZKvRoep4ketnZgeMRqUIhA
         hAv++2kSHSGbA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6CA2F5C011C; Thu, 22 Jul 2021 20:49:28 -0700 (PDT)
Date:   Thu, 22 Jul 2021 20:49:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     donghai qiao <donghai.w.qiao@gmail.com>, rcu@vger.kernel.org
Subject: Re: RCU: rcu stall issues and an approach to the fix
Message-ID: <20210723034928.GE4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAOzhvcPb=NMCHCqyDiyWiX9DjR=RXgdQRfJDkJOdazugHe7+Zw@mail.gmail.com>
 <YPoNgcLgJY/POS4u@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPoNgcLgJY/POS4u@boqun-archlinux>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jul 23, 2021 at 08:29:53AM +0800, Boqun Feng wrote:
> On Thu, Jul 22, 2021 at 04:08:06PM -0400, donghai qiao wrote:
> > RCU experts,
> > 
> > When you reply, please also keep me CC'ed.
> > 
> > The problem of RCU stall might be an old problem and it can happen quite often.
> > As I have observed, when the problem occurs,  at least one CPU in the system
> > on which its rdp->gp_seq falls behind others by 4 (qs).
> > 
> > e.g.  On CPU 0, rdp->gp_seq = 0x13889d, but on other CPUs, their
> > rdp->gp_seq = 0x1388a1.
> > 
> > Because RCU stall issues can last a long period of time, the number of callbacks
> > in the list rdp->cblist of all CPUs can accumulate to thousands. In
> > the worst case,
> > it triggers panic.
> > 
> > When looking into the problem further, I'd think the problem is related to the
> > Linux scheduler. When the RCU core detects the stall on a CPU, rcu_gp_kthread
> > would send a rescheduling request via send_IPI to that CPU to try to force a
> > context switch to make some progress. However, at least one situation can fail
> > this effort, which is when the CPU is running a user thread and it is the only
> > user thread in the rq, then this attempted context switching will not happen
> > immediately. In particular if the system is also configured with NOHZ_FULL for
> 
> Correct me if I'm wrong, if a CPU is solely running a user thread, how
> can that CPU stall RCU? Because you need to be in a RCU read-side
> critical section to stall RCU. Or the problem you're talking here is
> about *recovering* from RCU stall?

Excellent point, Boqun!

Donghai, have you tried reproducing this using a kernel built with
CONFIG_RCU_EQS_DEBUG=y?

							Thanx, Paul

> Regards,
> Boqun
> 
> > the CPU and as long as the user thread is running, the forced context
> > switch will
> > never happen unless the user thread volunteers to yield the CPU. I think this
> > should be one of the major root causes of these RCU stall issues. Even if
> > NOHZ_FULL is not configured, there will be at least 1 tick delay which can
> > affect the realtime kernel, by the way.
> > 
> > But it seems not a good idea to craft a fix from the scheduler side because
> > this has to invalidate some existing scheduling optimizations. The current
> > scheduler is deliberately optimized to avoid such context switching.  So my
> > question is why the RCU core cannot effectively update qs for the stalled CPU
> > when it detects that the stalled CPU is running a user thread?  The reason
> > is pretty obvious because when a CPU is running a user thread, it must not
> > be in any kernel read-side critical sections. So it should be safe to close
> > its current RCU grace period on this CPU. Also, with this approach we can make
> > RCU work more efficiently than the approach of context switch which needs to
> > go through an IPI interrupt and the destination CPU needs to wake up its
> > ksoftirqd or wait for the next scheduling cycle.
> > 
> > If my suggested approach makes sense, I can go ahead to fix it that way.
> > 
> > Thanks
> > Donghai
