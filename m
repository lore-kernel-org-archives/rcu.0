Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26CEC433EF
	for <rcu@archiver.kernel.org>; Sat, 28 May 2022 23:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiE1XxA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 28 May 2022 19:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiE1XxA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 28 May 2022 19:53:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B4D79390
        for <rcu@vger.kernel.org>; Sat, 28 May 2022 16:52:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 392D260C22
        for <rcu@vger.kernel.org>; Sat, 28 May 2022 23:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C10C34114;
        Sat, 28 May 2022 23:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653781977;
        bh=FQkLTTiekiFiHIZ7BxYWAAbJLYSynRjJnOwkTJL9k4A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jnfSkj43gO0DNXEnEP1FU3Pm2o59bffSgkXfMYnS2LGgYzvgv163oyiuRJvqM67qa
         /tOTJIxuxIRxIyDeK4JICSSdzXetShwbBZRMUFgqaw/QQAL9WBZv2loKAyok6Id9Kp
         FD3o73KB/oPZbcVBMW+mccMr54hlvEIbUFr/7G/U3+GertYJ38JR1Mkk3ir7bLUB7g
         lFeZ1Kv2Q55LLbBJOoqm+R+mH2Ach7ELZ31KNbcjK7dssB3E4TW2/szJPqnJjdDCV8
         oWsIdP3rWmf05564bEsPjh/Nf9OhQ3i5s1Bp7Esytz3kquAHiuj7Br3r1qTGW04BvV
         wwPiQenhFrW+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 318FF5C0269; Sat, 28 May 2022 16:52:57 -0700 (PDT)
Date:   Sat, 28 May 2022 16:52:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>, rcu@vger.kernel.org,
        kasan-dev@googlegroups.com, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] rcu: tiny: record kvfree_call_rcu() call stack for KASAN
Message-ID: <20220528235257.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220527170743.04c21d235467.I1f79da0f90fb9b557ec34932136c656bc64b8fbf@changeid>
 <CACT4Y+bm++gFi8QYNk41g_ihZuvrMO5O2T_3E7r0h+_PRfShuQ@mail.gmail.com>
 <20220527152403.GS1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527152403.GS1790663@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 27, 2022 at 08:24:03AM -0700, Paul E. McKenney wrote:
> On Fri, May 27, 2022 at 05:13:18PM +0200, Dmitry Vyukov wrote:
> > On Fri, 27 May 2022 at 17:07, Johannes Berg <johannes@sipsolutions.net> wrote:
> > >
> > > From: Johannes Berg <johannes.berg@intel.com>
> > >
> > > When running KASAN with Tiny RCU (e.g. under ARCH=um, where
> > > a working KASAN patch is now available), we don't get any
> > > information on the original kfree_rcu() (or similar) caller
> > > when a problem is reported, as Tiny RCU doesn't record this.
> > >
> > > Add the recording, which required pulling kvfree_call_rcu()
> > > out of line for the KASAN case since the recording function
> > > (kasan_record_aux_stack_noalloc) is neither exported, nor
> > > can we include kasan.h into rcutiny.h.
> > >
> > > without KASAN, the patch has no size impact (ARCH=um kernel):
> > >     text       data         bss         dec        hex    filename
> > >  6151515    4423154    33148520    43723189    29b29b5    linux
> > >  6151515    4423154    33148520    43723189    29b29b5    linux + patch
> > >
> > > with KASAN, the impact on my build was minimal:
> > >     text       data         bss         dec        hex    filename
> > > 13915539    7388050    33282304    54585893    340ea25    linux
> > > 13911266    7392114    33282304    54585684    340e954    linux + patch
> > >    -4273      +4064         +-0        -209
> > >
> > > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > 
> > >From KASAN perspective:
> > 
> > Acked-by: Dmitry Vyukov <dvyukov@google.com>
> > 
> > What tree should it go into? mm? rcu? +Paul
> 
> If Johannes is johill on IRC, I already agreed to take it.  If not,
> we might have dueling patches.
> 
> Ah, "Berg" -> "Hill".  I never would have figured that out without
> this hint.  ;-)

And applied with Dmitry's ack.  It will show up on -rcu after my next
rebase.

							Thanx, Paul

> > > ---
> > >  include/linux/rcutiny.h | 11 ++++++++++-
> > >  kernel/rcu/tiny.c       | 14 ++++++++++++++
> > >  2 files changed, 24 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> > > index 5fed476f977f..d84e13f2c384 100644
> > > --- a/include/linux/rcutiny.h
> > > +++ b/include/linux/rcutiny.h
> > > @@ -38,7 +38,7 @@ static inline void synchronize_rcu_expedited(void)
> > >   */
> > >  extern void kvfree(const void *addr);
> > >
> > > -static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > +static inline void __kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >  {
> > >         if (head) {
> > >                 call_rcu(head, func);
> > > @@ -51,6 +51,15 @@ static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >         kvfree((void *) func);
> > >  }
> > >
> > > +#ifdef CONFIG_KASAN_GENERIC
> > > +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
> > > +#else
> > > +static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > +{
> > > +       __kvfree_call_rcu(head, func);
> > > +}
> > > +#endif
> > > +
> > >  void rcu_qs(void);
> > >
> > >  static inline void rcu_softirq_qs(void)
> > > diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> > > index 340b3f8b090d..58ff3721d975 100644
> > > --- a/kernel/rcu/tiny.c
> > > +++ b/kernel/rcu/tiny.c
> > > @@ -217,6 +217,20 @@ bool poll_state_synchronize_rcu(unsigned long oldstate)
> > >  }
> > >  EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
> > >
> > > +#ifdef CONFIG_KASAN_GENERIC
> > > +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > +{
> > > +       if (head) {
> > > +               void *ptr = (void *) head - (unsigned long) func;
> > > +
> > > +               kasan_record_aux_stack_noalloc(ptr);
> > > +       }
> > > +
> > > +       __kvfree_call_rcu(head, func);
> > > +}
> > > +EXPORT_SYMBOL_GPL(kvfree_call_rcu);
> > > +#endif
> > > +
> > >  void __init rcu_init(void)
> > >  {
> > >         open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
> > > --
> > > 2.36.1
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20220527170743.04c21d235467.I1f79da0f90fb9b557ec34932136c656bc64b8fbf%40changeid.
