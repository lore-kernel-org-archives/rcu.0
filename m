Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EC4C433EF
	for <rcu@archiver.kernel.org>; Mon, 18 Oct 2021 22:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46BA36112D
	for <rcu@archiver.kernel.org>; Mon, 18 Oct 2021 22:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhJRWgh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 18 Oct 2021 18:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhJRWgh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 18 Oct 2021 18:36:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 475A760FF2;
        Mon, 18 Oct 2021 22:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634596465;
        bh=d4KFdbfmDFz08tdoqsC4PF8m3qoNzd75LwESQP7Q1Pc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=COzgfxBpt1iB64aNXOAeufFUrzIfwOu3DpoCQ2R9XMfMxAlnKANDS60r2/OmYLk2A
         PHZ48qcAhy9fdSaE/jcPYG2ZWqTicLGH4i5tODIZZwSoYFiDTWtMNePVUxjspLfIce
         DniIPYQkLYUbItoJ+cKkcO8Xklv5X0xuSwSSeKjw/EApBPoxBU+3Kl9z3X6pp/IwfX
         vXK+KVxvMZj0O1XP7Nj7R/eAGcCHeLykJK1qwEzHNkv/xnzPRVWBDrvTG6BxpMcNyb
         yiK6IIRPwgSUOB5nZ+QgH9+zw3cO8qx+P0NkdI8UqDgixtvu4c3mTwiYBJJnNlAzUP
         cHLIc23Bdx8PA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 149C55C0DF2; Mon, 18 Oct 2021 15:34:25 -0700 (PDT)
Date:   Mon, 18 Oct 2021 15:34:25 -0700
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
Message-ID: <20211018223425.GW880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211018113259.450292-1-frederic@kernel.org>
 <20211018161814.GS880162@paulmck-ThinkPad-P17-Gen-1>
 <20211018174242.GA450204@lothringen>
 <20211018183604.GT880162@paulmck-ThinkPad-P17-Gen-1>
 <20211018215046.GA453817@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018215046.GA453817@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 18, 2021 at 11:50:46PM +0200, Frederic Weisbecker wrote:
> On Mon, Oct 18, 2021 at 11:36:04AM -0700, Paul E. McKenney wrote:
> > On Mon, Oct 18, 2021 at 07:42:42PM +0200, Frederic Weisbecker wrote:
> > > I think you're right. The real issue is something I wanted to
> > > fix next: RCU_SEGCBLIST_RCU_CORE isn't cleared when nocb is enabled on
> > > boot so rcu_core() always run concurrently with nocb kthreads in TREE04,
> > > without holding rcu_barrier mutex of course (I mean with the latest patchset).
> > 
> > That would do it!
> > 
> > > Ok forget this patch, I'm testing again with simply clearing
> > > RCU_SEGCBLIST_RCU_CORE on boot.
> > 
> > Sounds good, looking forward to it!
> 
> So yes that was indeed the real issue. I've pushed an "rcu/rt-v3" branch
> which is the same as your dev.2021.10.07a branch but the first patch
> "rcu/nocb: Prepare state machine for a new step" has this added:
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 3b470113ae38..2461fe8d0c23 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1171,8 +1171,8 @@ void __init rcu_init_nohz(void)
>  		if (rcu_segcblist_empty(&rdp->cblist))
>  			rcu_segcblist_init(&rdp->cblist);
>  		rcu_segcblist_offload(&rdp->cblist, true);
> -		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB);
> -		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_GP);
> +		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP);
> +		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_RCU_CORE);
>  	}
>  	rcu_organize_nocb_kthreads();
>  }
> 
> 
> I still see the oom though, hopefully my series just makes an existing
> problem more likely to happen.

Yes, I have been seeing that without your patch, at least unless I bump
up memory a bit.

Looking forward to the new series!

							Thanx, Paul
