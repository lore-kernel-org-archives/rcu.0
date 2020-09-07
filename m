Return-Path: <SRS0=L9Fg=CQ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE8FC43461
	for <rcu@archiver.kernel.org>; Mon,  7 Sep 2020 00:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A242080A
	for <rcu@archiver.kernel.org>; Mon,  7 Sep 2020 00:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXr9q2yZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgIGAMG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 6 Sep 2020 20:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgIGAMF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 6 Sep 2020 20:12:05 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA4BC061573;
        Sun,  6 Sep 2020 17:12:04 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id lo4so15876155ejb.8;
        Sun, 06 Sep 2020 17:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7IHuLoZTszc6cbgJPnkqQ2lqOVg60Edt4SQc7fvbdlk=;
        b=LXr9q2yZYz/wfipdWLCcqDyD4wGQl2yZ+gijgtVQLkNsfU42bhnucieA33a4a7zBvK
         VsAL8TYHpdfPeIP6BBKtV61Cg7leuOQDzXXsQiI/3cYVZDLXT0FPZ9l60K+aO8hHfMQS
         MWdtJijUlh9rWkxqaV0YllHdfLvEqTCeW1XeGSvRcQ6BkIskY3tYgqKPt+d5hhp3/y9k
         Blu+MAXr2H5vGTAzyw0dAuqBKMnxexNjidcRCBQi9kQoarpIayVWkUWsNgFTFs0rNwJw
         hx0VHcXcdaXvx+Yfs51JIQvl6+qw9AKte79jZZinbOcystxkLv6wWgoVwjaRNvf6z1fe
         67Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7IHuLoZTszc6cbgJPnkqQ2lqOVg60Edt4SQc7fvbdlk=;
        b=l+QhdAxsRGlhWe2t98iAiXi03Oeak3T+kdetr6ie85ItJeGI2A8fqPFmSOAoxCK+TH
         TK+mC6pat2lm+Mp7gP5cD8gQbBW0OKPmKjajYwW0JtmGfisXYA0TlxhAUNsrge0eOGW5
         st9pBijJiSPbQbtMqQOC6NECW7dMUMtYZ2lVMn9ReI/1Qlr8U62MiNlrT0iMpQppAWQ8
         6sjwIJdDU99AGAbAstdys8ThyEua43vFDF2efSgBzdTBMZCUvkIveJ+AejV8vYu2FlTP
         y0yHwjmDebxqF1mWTj68Qre8aen7Z0AjFB7LfmWBAxdFLxbslKhyp6CvUFcDKhY15q+g
         zA/w==
X-Gm-Message-State: AOAM5319955Ah2zbr+EX4j/z9Qe4e1O3YqmsAHei/zxMuEps50fOe15c
        iMXOJBmvxJR0TefLGC6V7SU=
X-Google-Smtp-Source: ABdhPJy7a+NzSC9oiAZBsO04AnbBX9MO3YumsPRajGetgRBGZb3nJ5bNUeaKqcKv21aGH9G0SXPQWQ==
X-Received: by 2002:a17:906:bcd5:: with SMTP id lw21mr18745846ejb.430.1599437523171;
        Sun, 06 Sep 2020 17:12:03 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id a18sm13640669ejy.71.2020.09.06.17.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Sep 2020 17:12:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id DE22427C0054;
        Sun,  6 Sep 2020 20:11:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 06 Sep 2020 20:11:59 -0400
X-ME-Sender: <xms:zXpVXx1fAhho8O-3J_U8dO9UjswQjwQqDmsQq_flH9ZyVLNaUse8pw>
    <xme:zXpVX4GpKHcM06R2werJHOODOxZtAY6pjZrfGe68HMm6mH0xOmNifpv2lp03gk1hm
    AHM5tBSqItWjAclUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:zXpVXx5q5lylayRB9Ob41m0e9rowSvQgDWoWYy3RcNGRPwqxbklj_g>
    <xmx:zXpVX-2O_a3O3cDBA52IzzuBej2gQuYkbmnoav8H4wrjKvWwpvXggw>
    <xmx:zXpVX0GNHmjxey42VaDtMbhaopozIeqgO_wu0wbD-NKkw7fus4b1Og>
    <xmx:z3pVXyXfBCXxa97FEr9_jikGBRdBa2i_ut6WWpybmgIvbPsrZLOgYO5_VXg>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id DC3B4306467D;
        Sun,  6 Sep 2020 20:11:56 -0400 (EDT)
Date:   Mon, 7 Sep 2020 08:11:55 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 05/13] rcu: Always set .need_qs from
 __rcu_read_lock() for strict GPs
Message-ID: <20200907001155.GG7503@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200831181101.GA950@paulmck-ThinkPad-P72>
 <20200831181120.1044-5-paulmck@kernel.org>
 <20200904040534.GD7922@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200904134142.GB29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904134142.GB29330@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 04, 2020 at 06:41:42AM -0700, Paul E. McKenney wrote:
> On Fri, Sep 04, 2020 at 12:05:34PM +0800, Boqun Feng wrote:
> > Hi Paul,
> > 
> > On Mon, Aug 31, 2020 at 11:11:12AM -0700, paulmck@kernel.org wrote:
> > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > 
> > > The ->rcu_read_unlock_special.b.need_qs field in the task_struct
> > > structure indicates that the RCU core needs a quiscent state from the
> > > corresponding task.  The __rcu_read_unlock() function checks this (via
> > > an eventual call to rcu_preempt_deferred_qs_irqrestore()), and if set
> > > reports a quiscent state immediately upon exit from the outermost RCU
> > > read-side critical section.
> > > 
> > > Currently, this flag is only set when the scheduling-clock interrupt
> > > decides that the current RCU grace period is too old, as in about
> > > one full second too old.  But if the kernel has been built with
> > > CONFIG_RCU_STRICT_GRACE_PERIOD=y, we clearly do not want to wait that
> > > long.  This commit therefore sets the .need_qs field immediately at the
> > > start of the RCU read-side critical section from within __rcu_read_lock()
> > > in order to unconditionally enlist help from __rcu_read_unlock().
> > > 
> > 
> > So why not make rcu_preempt_deferred_qs_irqrestore() always treat
> > need_qs is true if CONFIG_RCU_STRICT_GRACE_PERIOD = y? IOW:
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 982fc5be5269..2a9f31545453 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -449,6 +449,8 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
> >  	 * t->rcu_read_unlock_special cannot change.
> >  	 */
> >  	special = t->rcu_read_unlock_special;
> > +	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) && rcu_state.gp_kthread)
> > +		special.b.need_qs = true;
> >  	rdp = this_cpu_ptr(&rcu_data);
> >  	if (!special.s && !rdp->exp_deferred_qs) {
> >  		local_irq_restore(flags);
> > 
> > , and in this way, you can save one store for each rcu_read_lock() ;-)
> 
> Because unless I am missing something subtle, if the .need_qs
> flag is not set, execution is not guaranteed to reach
> rcu_preempt_deferred_qs_irqrestore().
> 

Fair enough. Although I think we can also add IS_ENABLED(...) check to
make the outermost rcu_read_unlock() to call rcu_read_unlock_special()
unconditionally, but that's too much I think.

Regards,
Boqun

> 							Thanx, Paul
> 
> > Regards,
> > Boqun
> > 
> > > But note the additional check for rcu_state.gp_kthread, which prevents
> > > attempts to awaken RCU's grace-period kthread during early boot before
> > > there is a scheduler.  Leaving off this check results in early boot hangs.
> > > So early that there is no console output.  Thus, this additional check
> > > fails until such time as RCU's grace-period kthread has been created,
> > > avoiding these empty-console hangs.
> > > 
> > > Reported-by Jann Horn <jannh@google.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  kernel/rcu/tree_plugin.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index 44cf77d..668bbd2 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -376,6 +376,8 @@ void __rcu_read_lock(void)
> > >  	rcu_preempt_read_enter();
> > >  	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
> > >  		WARN_ON_ONCE(rcu_preempt_depth() > RCU_NEST_PMAX);
> > > +	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) && rcu_state.gp_kthread)
> > > +		WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
> > >  	barrier();  /* critical section after entry code. */
> > >  }
> > >  EXPORT_SYMBOL_GPL(__rcu_read_lock);
> > > -- 
> > > 2.9.5
> > > 
