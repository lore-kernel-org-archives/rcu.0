Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2011C64E7B
	for <rcu@archiver.kernel.org>; Wed,  2 Dec 2020 15:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F67D20C56
	for <rcu@archiver.kernel.org>; Wed,  2 Dec 2020 15:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgLBPZp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 2 Dec 2020 10:25:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgLBPZp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 2 Dec 2020 10:25:45 -0500
Date:   Wed, 2 Dec 2020 07:25:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606922704;
        bh=M+CFICUDJwLUUez721Zick06gs3zdFQf3OD7+kJZf+I=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Sl8lzJG5NotbcMfdLHmiCkMHe0sfEJHguCpPbAQJWRtAiDc/qgLNr3Twb5vSFzs7z
         bPNTi04qu7yZWabvGCDqLnFPomPQr1S0SXX1x1tNabmB7fNuDOHIlYT8v9eSTadpY/
         CTpGYIJkub6P6WWsp8AqvOR3KXXo3/PJPlzzRi+I=
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] rcu/segcblist: Add debug checks for segment lengths
Message-ID: <20201202152503.GL1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201119035222.GA18458@paulmck-ThinkPad-P72>
 <20201119035613.GA18816@paulmck-ThinkPad-P72>
 <20201119183252.GA812262@google.com>
 <20201119192241.GZ1437@paulmck-ThinkPad-P72>
 <CAEXW_YSRQ+r_CjFOOEZ38BBRpkhjs5UbpfhGCzA8=XywEU0u8Q@mail.gmail.com>
 <20201119201615.GA1437@paulmck-ThinkPad-P72>
 <20201119204221.GB812262@google.com>
 <CAEXW_YSHVzzm=fLtamB=K5tjiwUNrYK76MxqfW2w0MJKO5LsTw@mail.gmail.com>
 <20201202042143.GK1437@paulmck-ThinkPad-P72>
 <20201202145838.GA949146@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202145838.GA949146@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 02, 2020 at 09:58:38AM -0500, Joel Fernandes wrote:
> On Tue, Dec 01, 2020 at 08:21:43PM -0800, Paul E. McKenney wrote:
> > On Tue, Dec 01, 2020 at 05:26:32PM -0500, Joel Fernandes wrote:
> > > On Thu, Nov 19, 2020 at 3:42 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > On Thu, Nov 19, 2020 at 12:16:15PM -0800, Paul E. McKenney wrote:
> > > > > On Thu, Nov 19, 2020 at 02:44:35PM -0500, Joel Fernandes wrote:
> > > > > > On Thu, Nov 19, 2020 at 2:22 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > > > > > On Wed, Nov 18, 2020 at 11:15:41AM -0500, Joel Fernandes (Google) wrote:
> > > > > > > > > > > > After rcu_do_batch(), add a check for whether the seglen counts went to
> > > > > > > > > > > > zero if the list was indeed empty.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > > > > > >
> > > > > > > > > > > Queued for testing and further review, thank you!
> > > > > > > > > >
> > > > > > > > > > FYI, the second of the two checks triggered in all four one-hour runs of
> > > > > > > > > > TREE01, all four one-hour runs of TREE04, and one of the four one-hour
> > > > > > > > > > runs of TREE07.  This one:
> > > > > > > > > >
> > > > > > > > > > WARN_ON_ONCE(count != 0 && rcu_segcblist_n_segment_cbs(&rdp->cblist) == 0);
> > > > > > > > > >
> > > > > > > > > > That is, there are callbacks in the list, but the sum of the segment
> > > > > > > > > > counts is nevertheless zero.  The ->nocb_lock is held.
> > > > > > > > > >
> > > > > > > > > > Thoughts?
> > > > > > > > >
> > > > > > > > > FWIW, TREE01 reproduces it very quickly compared to the other two
> > > > > > > > > scenarios, on all four run, within five minutes.
> > > > > > > >
> > > > > > > > So far for TREE01, I traced it down to an rcu_barrier happening so it could
> > > > > > > > be related to some interaction with rcu_barrier() (Just a guess).
> > > > > > >
> > > > > > > Well, rcu_barrier() and srcu_barrier() are the only users of
> > > > > > > rcu_segcblist_entrain(), if that helps.  Your modification to that
> > > > > > > function looks plausible to me, but the system's opinion always overrules
> > > > > > > mine.  ;-)
> > > > > >
> > > > > > Right. Does anything the bypass code standout? That happens during
> > > > > > rcu_barrier() as well, and it messes with the lengths.
> > > > >
> > > > > In theory, rcu_barrier_func() flushes the bypass before doing the
> > > > > entrain, and does the rcu_segcblist_entrain() afterwards.
> > > > >
> > > > > Ah, and that is the issue.  If ->cblist is empty and ->nocb_bypass
> > > > > is not, then ->cblist length will be nonzero, and none of the
> > > > > segments will be nonzero.
> > > > >
> > > > > So you need something like this for that second WARN, correct?
> > > > >
> > > > >       WARN_ON_ONCE(!rcu_segcblist_empty(&rdp->cblist) &&
> > > > >                    rcu_segcblist_n_segment_cbs(&rdp->cblist) == 0);
> > > 
> > > Just started to look into it again. If the &rdp->cblist is empty, that
> > > means the bypass list could not have been used (Since per comments on
> > > rcu_nocb_try_bypass() , the bypass list is in use only when the cblist
> > > is non-empty). So the cblist was non empty, then the segment counts
> > > should not sum to 0.  So I don't think that explains it. Anyway, I
> > > will try the new version of your warning in case there is something
> > > about bypass lists that I'm missing.
> > 
> > Good point.  I really did see failures, though.  Do they show up for
> > you?
> 
> Yeah I do see failures. Once I change the warning as below, the failures go
> away though. So looks like indeed a segcblist can be empty when the bypass
> list has something in it?  If you agree, could you change the warning to as
> below? The tests failing before all pass 1 hour rcutorture testing now
> (TREE01, TREE04 and TREE07).

I agree with the fix, which should not be too surprising.  ;-)

But can you tell me how you can have a non-zero count while all the
segment counts sum to zero?  Yes, you told me why nothing should be
placed in the bypass list while cblist is empty.  Is that really the
only way this state can be entered?

							Thanx, Paul

> ---8<-----------------------
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 91e35b521e51..3cd92b7df8ac 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2554,7 +2554,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  	WARN_ON_ONCE(!IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
>  		     count != 0 && rcu_segcblist_empty(&rdp->cblist));
>  	WARN_ON_ONCE(count == 0 && rcu_segcblist_n_segment_cbs(&rdp->cblist) != 0);
> -	WARN_ON_ONCE(count != 0 && rcu_segcblist_n_segment_cbs(&rdp->cblist) == 0);
> +	WARN_ON_ONCE(!rcu_segcblist_empty(&rdp->cblist) &&
> +		     rcu_segcblist_n_segment_cbs(&rdp->cblist) == 0);
>  
>  	rcu_nocb_unlock_irqrestore(rdp, flags);
>  
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
