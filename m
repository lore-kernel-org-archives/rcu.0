Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86243C432BE
	for <rcu@archiver.kernel.org>; Mon, 30 Aug 2021 18:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64ADD60F3A
	for <rcu@archiver.kernel.org>; Mon, 30 Aug 2021 18:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhH3SrR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:47:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232695AbhH3SrE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 30 Aug 2021 14:47:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71A9960E98;
        Mon, 30 Aug 2021 18:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630349170;
        bh=J23JT3g5G0Rq/agAJPJs93+AxpcQHeDG5rGcBdcVQmw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AESHqYHp5trjKc05XVKr0DmGCOB4OApA5VeZrTR7vguCf3WEoazddObwXaYtaXoaP
         P3df2vVNJdsdWCKI4NUR0E+HcCxM134uwomPCnYGrTM5cu77AAh057E/ax5p+W4i3W
         1q5NbXta4J1mi3ngNvH7LcZwkMQI4A5ZXwk1T+0uK0Kr3dlzWyXKR23RizWn00kfxj
         MxTFvuRAZAOWe1b2Ix4Yd0e6egDQAMASER45suA2o9yKdCZ0Atls4b0n1kgIZu57el
         IqaDtYMRYpHuBQ2XubFzClv5ll0eaUYmpbp4myR6n0PIL8+puu/XH1CNPLswpAkSjr
         fndMhomjaiF0A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3CFAF5C0566; Mon, 30 Aug 2021 11:46:10 -0700 (PDT)
Date:   Mon, 30 Aug 2021 11:46:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Waiman Long <longman@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH] rcu: Avoid unneeded function call in rcu_read_unlock()
Message-ID: <20210830184610.GX4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210827022122.15816-1-longman@redhat.com>
 <20210827183455.GP4156@paulmck-ThinkPad-P17-Gen-1>
 <CAEf4BzZ+OauJV_O5VDSM_WydA-xxLKcmx0vzT3P02CESzrJcnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ+OauJV_O5VDSM_WydA-xxLKcmx0vzT3P02CESzrJcnw@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 30, 2021 at 11:36:51AM -0700, Andrii Nakryiko wrote:
> On Fri, Aug 27, 2021 at 11:34 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Aug 26, 2021 at 10:21:22PM -0400, Waiman Long wrote:
> > > Since commit aa40c138cc8f3 ("rcu: Report QS for outermost
> > > PREEMPT=n rcu_read_unlock() for strict GPs"). A real function call
> > > rcu_read_unlock_strict() is added to the inlined rcu_read_unlock().
> > > The rcu_read_unlock_strict() call is only needed if the performance
> > > sagging CONFIG_RCU_STRICT_GRACE_PERIOD option is set. This config
> > > option isn't set for most production kernels while the function call
> > > overhead remains.
> > >
> > > To provide a slight performance improvement, the
> > > CONFIG_RCU_STRICT_GRACE_PERIOD config check is moved from
> > > rcu_read_unlock_strict() to __rcu_read_unlock() so that the function
> > > call can be compiled out in most cases.
> > >
> > > Besides, the GPL exported rcu_read_unlock_strict() also impact the
> > > the compilation of non-GPL kernel modules as rcu_read_unlock() is a
> > > frequently used kernel API.
> > >
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> >
> > Nice, and good eyes!!!
> >
> > I have queued this for v5.16, that is, not the upcoming merge window
> > but the one after that.
> >
> > I did my usual wordsmithing, so please check the following in case I
> > messed something up.  I intentionally omitted the EXPORT_SYMBOL_GPL()
> > discussion because:
> >
> > 1.      Kernels built with CONFIG_PREEMPT=y have the same issue
> >         with the __rcu_read_lock() and __rcu_read_unlock() functions.
> >
> > 2.      Many other RCU functions are EXPORT_SYMBOL_GPL() and have
> >         been for almost two decades.
> >
> > But if someone does use RCU readers within CONFIG_PREEMPT=n kernels from
> > a binary module, I will happily refer them to you for any RCU issues
> > that they encounter.  ;-)
> >
> > I am also CCing the BPF guys in case my interpretation of the code in
> > the BPF verifier is incorrect.
> >
> 
> LGTM from the BPF side, nothing really changed about when
> rcu_read_unlock_strict is an actual function vs no-op macro. It's also
> important to minimize the number of function calls in the context of
> recent LBR on-demand work done by Song, so this is a great
> improvement!

Thank you for looking this over!  May I add your Acked-by or similar?

                                                         Thanx, Paul

> > ------------------------------------------------------------------------
> >
> > commit 4a9f53b997b809c0256838e31c604aeeded2345a
> > Author: Waiman Long <longman@redhat.com>
> > Date:   Thu Aug 26 22:21:22 2021 -0400
> >
> >     rcu: Avoid unneeded function call in rcu_read_unlock()
> >
> >     Since commit aa40c138cc8f3 ("rcu: Report QS for outermost PREEMPT=n
> >     rcu_read_unlock() for strict GPs") the function rcu_read_unlock_strict()
> >     is invoked by the inlined rcu_read_unlock() function.  However,
> >     rcu_read_unlock_strict() is an empty function in production kernels,
> >     which are built with CONFIG_RCU_STRICT_GRACE_PERIOD=n.
> >
> >     There is a mention of rcu_read_unlock_strict() in the BPF verifier,
> >     but this is in a deny-list, meaning that BPF does not care whether
> >     rcu_read_unlock_strict() is ever called.
> >
> >     This commit therefore provides a slight performance improvement
> >     by hoisting the check of CONFIG_RCU_STRICT_GRACE_PERIOD from
> >     rcu_read_unlock_strict() into rcu_read_unlock(), thus avoiding the
> >     pointless call to an empty function.
> >
> >     Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> >     Cc: Andrii Nakryiko <andrii@kernel.org>
> >     Signed-off-by: Waiman Long <longman@redhat.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 434d12fe2d4f..5e0beb5c5659 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -71,7 +71,8 @@ static inline void __rcu_read_lock(void)
> >  static inline void __rcu_read_unlock(void)
> >  {
> >         preempt_enable();
> > -       rcu_read_unlock_strict();
> > +       if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
> > +               rcu_read_unlock_strict();
> >  }
> >
> >  static inline int rcu_preempt_depth(void)
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 7a4876a3a882..0b55c647ab80 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -814,8 +814,7 @@ void rcu_read_unlock_strict(void)
> >  {
> >         struct rcu_data *rdp;
> >
> > -       if (!IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ||
> > -          irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
> > +       if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
> >                 return;
> >         rdp = this_cpu_ptr(&rcu_data);
> >         rcu_report_qs_rdp(rdp);
