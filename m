Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B698C4332F
	for <rcu@archiver.kernel.org>; Fri, 23 Dec 2022 12:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiLWM6v (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 23 Dec 2022 07:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWM6u (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 23 Dec 2022 07:58:50 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EE01E3C5
        for <rcu@vger.kernel.org>; Fri, 23 Dec 2022 04:58:49 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d7so4903755pll.9
        for <rcu@vger.kernel.org>; Fri, 23 Dec 2022 04:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WOQV74jquFkLu6sSEOYWKiWZTxwQNm5F9GqaGK8bu48=;
        b=oHXJUCHPAE3cNbJ0wWpwTucwW/Sp6zE4RdXYo+1rahHfhapBxvgGAwwNzS/O0YLEzk
         5/YXNrDZRc5BK4I8xz3kz32hPk9/IS0LrNbb3+FDzdOJhmfy0NP2rMnIA/REucENjjGP
         pr5ak60hR51NJfqSPck1likVf2MnP/8M2VRNltXSf85RVWUKeEJei23LXVpNGbuXWmPL
         2K7xSKbfHXnMukqDDvO2Fmb+hH8HkiQzL2GFwoxeSbr1o3yJBQBHpDxVgU/bdn7yveN7
         CTsuSP1ePCxYSZTsVbQX6JEwaVMynIj0ht/RUADyb9Uo2jj9qVtFauhOsuLt65C0IlM7
         HyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOQV74jquFkLu6sSEOYWKiWZTxwQNm5F9GqaGK8bu48=;
        b=cuVjKmGdD5uQdqq1+zpU90RPCSe88Oi7xjBW+x1GI7nsNhQufjLzU4a8fuFNtekkh9
         4dUaKuOH4rUnPQt3QHotX/3CWvMylpQwE3HwdSqHeA98ptjjvdxdtwCqk4+GP7ngyrEq
         kcOBeyPiScl9OX1Un5n5q6xst5RX92tvm1fFGGAF291aYIM45iftB8luGX1GTonjvvoY
         gTlQPasaSd2xnP2nBqTYO5rflK4K05wrxAUSEGPhKNDRrG+YbvdcxTW29fjrFJbizKo6
         +1R5xoKDsd+CJFaE5NhEF2OFNUDb3Fd5aC2C/DVs8vpWAPx61NuizGVzx+F/m4sipSjq
         ffLA==
X-Gm-Message-State: AFqh2kpqcQFqgTRJdj4S/UQKQcETnCqhQMj+D9oHS2IJoR68blwAlx3f
        kaldmztIgkuxT8yA/3g/zHYGGlqZtQ==
X-Google-Smtp-Source: AMrXdXsZi+UAbxIbdeM0asMcCnVve+x6b1wPRTdF7CchelsjB0YaElu56utzMCkR4f1h5rpqi2kolw==
X-Received: by 2002:a17:902:e8d3:b0:189:eadb:45c7 with SMTP id v19-20020a170902e8d300b00189eadb45c7mr10191830plg.37.1671800328577;
        Fri, 23 Dec 2022 04:58:48 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m6-20020a170902db8600b001780e4e6b65sm2347949pld.114.2022.12.23.04.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 04:58:47 -0800 (PST)
Date:   Fri, 23 Dec 2022 20:58:40 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] srcu: Add notes for not-effective mutex
Message-ID: <Y6WmAKJl0DLMa5Zy@piliu.users.ipa.redhat.com>
References: <20221214142446.56543-1-kernelfans@gmail.com>
 <20221218175313.GQ4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221218175313.GQ4001@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Dec 18, 2022 at 09:53:13AM -0800, Paul E. McKenney wrote:
> On Wed, Dec 14, 2022 at 10:24:46PM +0800, Pingfan Liu wrote:
> > Capped by the design and implementation of workqueue, the same work can not
> > be re-entrant.
> > 
> > SRCU has only a single work ssp->work, there is no way to occur the
> > concurrent scene in its state machine. Hence the mutexes for the
> > concurrency in the state machine is unnecessary. On the other hand,
> > using two works to utilize the window from the release of srcu_gp_mutex
> > to the end of srcu_gp_end() to enhance the parallelism has limited
> > effect. [1]
> > 
> > To save any trying of improving parallelism by using two work_struct,
> > put some notes around the srcu_gp_mutex and srcu_cb_mutex. And keep them
> > instead of removing them, in case in future, the state machine is moved
> > out of the protection of workqueue non-reentrant protection.
> 
> Thank you for continuning to push on this!
> 
> But let's step back and take a wider view, plus summarize a bit.
> 
> First, as we have discussed, it is necessary to make RCU work not just
> right now, but also to keep it from becoming too fragile.  This notion of
> "fragile" isn't yet something that can be reasonably measured, but one
> could unreasonably measure it by either comparing the number of words
> of English required to explain why it works on the one hand and making
> lots of random changes and seeing what fraction of those changes break
> something on the other.  These unreasonable measures are, just like the
> name says, unreasonable.  But I hope that they give an intuitive notion
> of what the goal must be.  Again, I don't know of a reasonable scientific
> (let alone mathematical) way of expressing it.
> 

Yes, I get the point of srcu_gp_mutex, which keeps the code from
becoming too fragile. But the carefully designed srcu_cb_mutex may leave
room for people to have fantasy. My purpose just reminders someone in
future it is known and tried.

> As you noted, the current state is unsatisfying.  There are two different
> mechanisms providing mutual exclusion.  This code is nowhere near a
> fastpath, so the added overhead is absolutely *not* a concern (not yet,
> that we know of, anyway), but there are still risks, for example:
> 
> 1.	Latent bugs could be introduced that suddenly make their presence
> 	known should the code ever be relying solely on the mutexes for
> 	mutual exclusion.
> 
> 2.	People imagine other purposes for either the single workqueue
> 	or the mutexes, and inject bugs based on the fact that their
> 	imagination of the design has diverged from the actual design.
> 
> These risks are not huge, especially compared to other risks in the
> code base.  For but one example, the code that provides the memory-order
> guarantees for synchronize_rcu() are intricate and spread widely over the
> code.  As they must be in order to make important fastpaths fast, which
> is a benefit that is important enough to make taking that risk worthwhile.
> 

As said above, I understood this and srcu_gp_mutex is not my target. (I
am sorry that my comment may give wrong impression)

> So what are the options here?
> 
> 1.	Leave it as it is, with the non-huge risks as called out above.
> 

Due to the test data, it is dim for the outlook of this patch.

I am fine with option one. But if necessary, I am also OK with some
comment around srcu_cb_mutex, which may save someone's time in future.


Thanks,

	Pingfan

> 2.	Add comments, as in this commit.  One risk here is that someone
> 	adds the concurrency, but fails to remove the comments, which
> 	are now obsolete and confusing.
> 
> 3.	Add words describing the current double-provided mutual exclusion
> 	to one of the RCU design documents.
> 
> 4.	Leave mainline and -rcu as they are, but add your
> 	multiple-workqueue patch to one of the RCU design documents
> 	covering SRCU so that it doesn't get lost should it ever become
> 	necessary to speed up SRCU grace periods.
> 
> 5.	Leave mainline as it is, but add your multiple-workqueue patch to
> 	-rcu with a not-for-mainline branch marking its presence so that
> 	this change can be easily applied later, if needed.  (For another
> 	example of this, see the sysidle.2017.05.11a branch, which was
> 	actually in mainline for some time and then later removed because
> 	it was not being used.)
> 
> 6.	Make the workqueue supply concurrency, as in your earlier patch.
> 	As noted in the email threads, this adds risk for no known
> 	user-visible benefit.
> 
> 7.	Remove the mutexes, and rely on the workqueue for the needed
> 	mutual exclusion.  This is unlikely to make the code more
> 	readable, and makes it more difficult to add concurrency if it
> 	is ever needed.
> 
> 8.	Make the workqueue supply concurrency, but only when a given
> 	kernel-boot parameter or Kconfig option is supplied.  Enable
> 	this concurrency only during selected rcutorture tests.
> 	This has the advantage of actually testing the placement and
> 	usage of the mutexes, but on the other hand it increases test
> 	effort for no known end-user-visible benefit.
> 
> Are there other options?
> 
> 							Thanx, Paul
> 
> > Some test data to show how dual work_struct affects the SRCU
> > performance:
> > 
> > -1. on 144 cpus hpe-dl560gen10
> >   modprobe rcutorture   torture_type=srcud  fwd_progress=144 fwd_progress_holdoff=1 shutdown_secs=36000 stat_interval=60 verbose=1
> >   # base line
> >   [37587.632155] srcud:  End-test grace-period state: g28287244 f0x0 total-gps=28287244
> >   # two dual work_struct
> >   [36443.468017] srcud:  End-test grace-period state: g29026056 f0x0 total-gps=29026056
> > 
> > -2. on 256 cpus amd-milan
> >   modprobe rcutorture   torture_type=srcud  fwd_progress=256 fwd_progress_holdoff=1 shutdown_secs=36000 stat_interval=60 verbose=1
> >   # base line
> >   [36093.605732] srcud:  End-test grace-period state: g10850284 f0x0 total-gps=10850284
> >   # two dual work_struct
> >   [36093.856713] srcud:  End-test grace-period state: g10672632 f0x0 total-gps=10672632
> > 
> > The first test shows that it has about 2.6% improvement, while the
> > second test shows it has no significant effect.
> > 
> > [1]: https://lore.kernel.org/rcu/Y5nC2yBhaUYirByo@piliu.users.ipa.redhat.com/T/#maf99cf1d92077a1b0b8e5c411c79fa4444576624
> > 
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > To: rcu@vger.kernel.org
> > ---
> >  include/linux/srcutree.h | 4 ++++
> >  kernel/rcu/srcutree.c    | 5 ++++-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > index 558057b517b7..f199c31493ab 100644
> > --- a/include/linux/srcutree.h
> > +++ b/include/linux/srcutree.h
> > @@ -66,8 +66,12 @@ struct srcu_struct {
> >  						/* First node at each level. */
> >  	int srcu_size_state;			/* Small-to-big transition state. */
> >  	struct mutex srcu_cb_mutex;		/* Serialize CB preparation. */
> > +						/* Not take effect since the only single sdp->work */
> > +						/* meets the workqueue non-reentrant condition */
> >  	spinlock_t __private lock;		/* Protect counters and size state. */
> >  	struct mutex srcu_gp_mutex;		/* Serialize GP work. */
> > +						/* Not take effect since the only single sdp->work */
> > +						/* meets the workqueue non-reentrant condition */
> >  	unsigned int srcu_idx;			/* Current rdr array element. */
> >  	unsigned long srcu_gp_seq;		/* Grace-period seq #. */
> >  	unsigned long srcu_gp_seq_needed;	/* Latest gp_seq needed. */
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index ce39907fa381..8ebb1a240219 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -815,7 +815,10 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> >  	struct srcu_node *snp;
> >  	int ss_state;
> >  
> > -	/* Prevent more than one additional grace period. */
> > +	/*
> > +	 * Prevent more than one additional grace period. But at present, it does
> > +	 * not take effect. Refer to the note at the definition.
> > +	 * /
> >  	mutex_lock(&ssp->srcu_cb_mutex);
> >  
> >  	/* End the current grace period. */
> > -- 
> > 2.31.1
> > 
