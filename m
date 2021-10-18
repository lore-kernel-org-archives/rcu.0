Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316A9C433F5
	for <rcu@archiver.kernel.org>; Mon, 18 Oct 2021 21:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149286112D
	for <rcu@archiver.kernel.org>; Mon, 18 Oct 2021 21:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhJRVxB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 18 Oct 2021 17:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhJRVxB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 18 Oct 2021 17:53:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 067F861027;
        Mon, 18 Oct 2021 21:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634593849;
        bh=mLgSi2xtumYxIqCbU67hwJSn6yVpStslxKRIS+tQIzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DdSkjgxB9oOTLqp/1F0fEAopdX4rZqp1oWHFr9sGNB+uY42tawsW/+Cb3l0irjVxr
         pOVX9i7CUZARocInWWf48lnPm2zkkr5JpWcxrEvxo5ofmB2YOP77JAIS4DPRrV7+oM
         EK7IFeqI4I0+KYpztLbGJ+kXALY4uGEeBluetFOgdgg8yCa4ZYJ6BvFlVfush5TGrw
         7Hky3usbubYYyf/N02/f8HkTe0FxJ8sFl6WFBpuUvZFkTDxcHb4eRaobexv1/DNjN4
         X8wqfKqpUvbSCiz4VBYBxIrBb0O+DghUkCaqhYPXP7rW7Zm/amJpZnDhSQbDnUG+Og
         rl1IkAoZGUCTg==
Date:   Mon, 18 Oct 2021 23:50:46 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Fix misordered rcu_barrier() while
 (de-)offloading
Message-ID: <20211018215046.GA453817@lothringen>
References: <20211018113259.450292-1-frederic@kernel.org>
 <20211018161814.GS880162@paulmck-ThinkPad-P17-Gen-1>
 <20211018174242.GA450204@lothringen>
 <20211018183604.GT880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018183604.GT880162@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 18, 2021 at 11:36:04AM -0700, Paul E. McKenney wrote:
> On Mon, Oct 18, 2021 at 07:42:42PM +0200, Frederic Weisbecker wrote:
> > I think you're right. The real issue is something I wanted to
> > fix next: RCU_SEGCBLIST_RCU_CORE isn't cleared when nocb is enabled on
> > boot so rcu_core() always run concurrently with nocb kthreads in TREE04,
> > without holding rcu_barrier mutex of course (I mean with the latest patchset).
> 
> That would do it!
> 
> > Ok forget this patch, I'm testing again with simply clearing
> > RCU_SEGCBLIST_RCU_CORE on boot.
> 
> Sounds good, looking forward to it!

So yes that was indeed the real issue. I've pushed an "rcu/rt-v3" branch
which is the same as your dev.2021.10.07a branch but the first patch
"rcu/nocb: Prepare state machine for a new step" has this added:

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 3b470113ae38..2461fe8d0c23 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1171,8 +1171,8 @@ void __init rcu_init_nohz(void)
 		if (rcu_segcblist_empty(&rdp->cblist))
 			rcu_segcblist_init(&rdp->cblist);
 		rcu_segcblist_offload(&rdp->cblist, true);
-		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB);
-		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_GP);
+		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP);
+		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_RCU_CORE);
 	}
 	rcu_organize_nocb_kthreads();
 }


I still see the oom though, hopefully my series just makes an existing
problem more likely to happen.

Thanks.
