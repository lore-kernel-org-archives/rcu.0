Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2207C433B4
	for <rcu@archiver.kernel.org>; Wed, 12 May 2021 21:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94149613B5
	for <rcu@archiver.kernel.org>; Wed, 12 May 2021 21:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387711AbhELV2W (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 May 2021 17:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344556AbhELT1k (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 May 2021 15:27:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5662B61182;
        Wed, 12 May 2021 19:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620847586;
        bh=eSoV/aEdtGCTeb6pk9JF8nSRnnQKGfJnLa3hlfVjizI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=X3V5fF5vJksEMhr77Xb85Auo544MmaQBjg8SUN7lpgMyXOTuHEc1rxQBDDBLMNBPF
         5Zz8kirXFIw/H4g+ITOXROVgwkeZxpxSWhsJ8JVJ7kOQCLOvz86LBHW6bvdbzp5keE
         ugzWNgslBfw9jDdbqUULpVFmX+5iNBvRZQRGBvi+8Jj7Ka9Qh72YQiRXuu4fwxD8qZ
         KqXcaAgRTEJ/E1R94jip92fD4OVOGh32a7HJ57+arn+ThbwMC5zyOyqtjWdKrN7kMC
         gMN4UyMnKdgavVqSSmEcSkqgh83qYp1AjeFJ1rudTqkywEkYTV9ZZWzk5bOrAod9X0
         u4GvfvuURq/Ng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F14D45C0379; Wed, 12 May 2021 12:26:25 -0700 (PDT)
Date:   Wed, 12 May 2021 12:26:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH tip/core/rcu 10/10] rcu: Fix various typos in comments
Message-ID: <20210512192625.GV975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
 <20210511230336.2894314-10-paulmck@kernel.org>
 <YJwdFeb825Nzhpo2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJwdFeb825Nzhpo2@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, May 12, 2021 at 08:23:17PM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > From: Ingo Molnar <mingo@kernel.org>
> > 
> > Fix ~12 single-word typos in RCU code comments.
> > 
> > [ paulmck: Apply feedback from Randy Dunlap. ]
> > Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/srcutree.c                                     | 4 ++--
> >  kernel/rcu/sync.c                                         | 4 ++--
> >  kernel/rcu/tasks.h                                        | 8 ++++----
> >  kernel/rcu/tree.c                                         | 4 ++--
> >  kernel/rcu/tree.h                                         | 2 +-
> >  kernel/rcu/tree_plugin.h                                  | 2 +-
> >  .../selftests/rcutorture/formal/srcu-cbmc/src/locks.h     | 2 +-
> >  7 files changed, 13 insertions(+), 13 deletions(-)
> 
> There's one more I missed.

Good eyes, and I have folded this in, thank you!

							Thanx, Paul

> Thanks,
> 
> 	Ingo
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 60ad78560be3..a7dd763a70c3 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3848,7 +3848,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
>   *
>   * If a full RCU grace period has elapsed since the earlier call from
>   * which oldstate was obtained, return @true, otherwise return @false.
> - * If @false is returned, it is the caller's responsibilty to invoke this
> + * If @false is returned, it is the caller's responsibility to invoke this
>   * function later on until it does return @true.  Alternatively, the caller
>   * can explicitly wait for a grace period, for example, by passing @oldstate
>   * to cond_synchronize_rcu() or by directly invoking synchronize_rcu().
> 
