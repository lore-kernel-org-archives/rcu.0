Return-Path: <SRS0=RJ7G=DR=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E9BC433E7
	for <rcu@archiver.kernel.org>; Sat, 10 Oct 2020 03:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 289F3208C7
	for <rcu@archiver.kernel.org>; Sat, 10 Oct 2020 03:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602300183;
	bh=eVc2LNjDgAxspVc+VPD9v9TKMZoHeBScs7c2MoWawVU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=fA2bDm/adX9Cql//d/fwDCILKCjuYPnTY3OUgBUjuYXQLQRihuqkolDeDzpHp0U2h
	 pI3CNYcMPY8cEx8yW73fqkhaourYd+S8SrZIW1msUenk2ScMVtG7iUOwtqcPtUwfa4
	 D1jMnGfpAqjm4rkf0Hj/eHlOGFNnjY4ZsO1S8Eok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgJJDUh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 9 Oct 2020 23:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730365AbgJJC5t (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 9 Oct 2020 22:57:49 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1341E2076B;
        Sat, 10 Oct 2020 02:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602298664;
        bh=eVc2LNjDgAxspVc+VPD9v9TKMZoHeBScs7c2MoWawVU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=T9/9xBB/PoG7a+O4eRl3644fcjQmkcEQ4b5TXnb2DeITulAb3QKzJfRPWt+bP4hnF
         F2NjStCuyAl1M4Yz8FwddsFTYM90KHOkG4TvLxuLG4/igS/MxhDp9Ky4etCcUIEsF9
         awGJzH/QOndOeX7kmjjzWiyF7YhpYDjT+DKDb/34=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D38AE3522837; Fri,  9 Oct 2020 19:57:43 -0700 (PDT)
Date:   Fri, 9 Oct 2020 19:57:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     dave@stgolabs.net, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, natechancellor@gmail.com,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] rcutorture: remove unneeded check
Message-ID: <20201010025743.GN29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201009194736.2364-1-trix@redhat.com>
 <20201009201825.GL29330@paulmck-ThinkPad-P72>
 <03e3eeed-6072-ccb8-a9c6-c79a99c701b8@redhat.com>
 <20201009235033.GM29330@paulmck-ThinkPad-P72>
 <92f82632-adbd-ca85-d516-6540a49f01ab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92f82632-adbd-ca85-d516-6540a49f01ab@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 09, 2020 at 05:24:37PM -0700, Tom Rix wrote:
> 
> On 10/9/20 4:50 PM, Paul E. McKenney wrote:
> > On Fri, Oct 09, 2020 at 02:18:41PM -0700, Tom Rix wrote:
> >> On 10/9/20 1:18 PM, Paul E. McKenney wrote:
> >>> On Fri, Oct 09, 2020 at 12:47:36PM -0700, trix@redhat.com wrote:
> >>>> From: Tom Rix <trix@redhat.com>
> >>>>
> >>>> clang static analysis reports this problem:
> >>>>
> >>>> rcutorture.c:1999:2: warning: Called function pointer
> >>>>   is null (null dereference)
> >>>>         cur_ops->sync(); /* Later readers see above write. */
> >>>>         ^~~~~~~~~~~~~~~
> >>>>
> >>>> This is a false positive triggered by an earlier, later ignored
> >>>> NULL check of sync() op.  By inspection of the rcu_torture_ops,
> >>>> the sync() op is never uninitialized.  So this earlier check is
> >>>> not needed.
> >>> You lost me on this one.  This check is at the very beginning of
> >>> rcu_torture_fwd_prog_nr().  Or are you saying that clang is seeing an
> >>> earlier check in one of rcu_torture_fwd_prog_nr()'s callers?  If so,
> >>> where exactly is this check?
> >>>
> >>> In any case, the check is needed because all three functions are invoked
> >>> if there is a self-propagating RCU callback that ensures that there is
> >>> always an RCU grace period outstanding.
> >>>
> >>> Ah.  Is clang doing local analysis and assuming that because there was
> >>> a NULL check earlier, then the pointer might be NULL later?  That does
> >>> not seem to me to be a sound check.
> >>>
> >>> So please let me know exactly what is causing clang to emit this
> >>> diagnostic.  It might or might not be worth fixing this, but either way
> >>> I need to understand the situation so as to be able to understand the
> >>> set of feasible fixes.
> >>>
> >>> 						Thanx, Paul
> >> In rcu_prog_nr() there is check for for sync.
> >>
> >> if ( ... cur_op->sync ...
> >>
> >>    do something
> >>
> >> This flags in clang's static analyzer as 'could be null'
> >>
> >> later in the function, in a reachable block it is used
> >>
> >> cur_ops->sync()
> >>
> >> I agree this is not a good check that's why i said is was a false positive.
> >>
> >> However when looking closer at how cur_ops is set, it is never uninitialized.
> >>
> >> So the check is not needed.
> > OK, got it, and thank you for the explanation.
> >
> >> This is not a fix, the code works fine.  It is a small optimization.
> > Well, there really is a bug.  Yes, right now all ->sync pointers are
> > non-NULL, but they have not been in the past and might not be in the
> > future.  So if ->sync is NULL, rcu_torture_fwd_prog_nr() either should
> > not be called or it should return immediately without doing anything.
> >
> > My current thought is something like the (untested) patch below, of
> > course with your Reported-by.
> >
> > Thoughts?
> 
> Yes that would be fine.
> 
> In in review these other cases need to be been take care of.

I am having a difficult time interpreting this sentence, but will
optimistically assume that it means that you are good with this approach.
If my optimism is unwarranted, please let me know so I can fix whatever
might be broken.

> Reported-by: Tom Rix <trix@redhat.com>

How does the commit below look?

							Thanx, Paul

------------------------------------------------------------------------

commit 75c79a5dd72c1bb59f6bd6c5ec36f3a6516795cd
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Oct 9 19:51:55 2020 -0700

    rcutorture: Don't do need_resched() testing if ->sync is NULL
    
    If cur_ops->sync is NULL, rcu_torture_fwd_prog_nr() will nevertheless
    attempt to call through it.  This commit therefore flags cases where
    neither need_resched() nor call_rcu() forward-progress testing
    can be performed due to NULL function pointers, and also causes
    rcu_torture_fwd_prog_nr() to take an early exit if cur_ops->sync()
    is NULL.
    
    Reported-by: Tom Rix <trix@redhat.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index beba9e7..44749be 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1989,7 +1989,9 @@ static void rcu_torture_fwd_prog_nr(struct rcu_fwd *rfp,
 	unsigned long stopat;
 	static DEFINE_TORTURE_RANDOM(trs);
 
-	if  (cur_ops->call && cur_ops->sync && cur_ops->cb_barrier) {
+	if (!cur_ops->sync) 
+		return; // Cannot do need_resched() forward progress testing without ->sync.
+	if (cur_ops->call && cur_ops->cb_barrier) {
 		init_rcu_head_on_stack(&fcs.rh);
 		selfpropcb = true;
 	}
@@ -2215,8 +2217,8 @@ static int __init rcu_torture_fwd_prog_init(void)
 
 	if (!fwd_progress)
 		return 0; /* Not requested, so don't do it. */
-	if (!cur_ops->stall_dur || cur_ops->stall_dur() <= 0 ||
-	    cur_ops == &rcu_busted_ops) {
+	if ((!cur_ops->sync && !cur_ops->call) ||
+	    !cur_ops->stall_dur || cur_ops->stall_dur() <= 0 || cur_ops == &rcu_busted_ops) {
 		VERBOSE_TOROUT_STRING("rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test");
 		return 0;
 	}
