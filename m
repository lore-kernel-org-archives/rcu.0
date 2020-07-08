Return-Path: <SRS0=Ut75=AT=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FABC433DF
	for <rcu@archiver.kernel.org>; Wed,  8 Jul 2020 18:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 170472065D
	for <rcu@archiver.kernel.org>; Wed,  8 Jul 2020 18:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjWw46lO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgGHSsk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgGHSsk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 8 Jul 2020 14:48:40 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32842C061A0B;
        Wed,  8 Jul 2020 11:48:40 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d17so40713543ljl.3;
        Wed, 08 Jul 2020 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=W5hX+kPnjm24N1ajF8KR2pMHg0gzDDTK8NIYEnB0EOo=;
        b=fjWw46lOdZoJSMOyl4SJMTeSGa8bHJ9XJkP+cJuYAHjSIFFHrH9rVwhkM1Arrb9cav
         2PNp5knGYyVQsseqZ4ektqeMbNFHS9n6hYuhZTHhIk98qxqJh+99Hr+65qECWPToij9M
         Ie0fWh1DKljpIzWWOKiCl1gimMqyuM4PA/OWgqYip+IhxrDaMAlnK/mQfN8yJjkEDMNZ
         wdFco5upYRn7rZZmA16N33NTqbeQ0hIYP/zqOUeRd5uvbTjLLzzX03aVOU1hFvVRPxLS
         zxtvoEcl5HTAGIMFH58nxIHCgIT556BJ/wBeajaZ+yFTLsRaHKPDUqLOOnp7pLIV94EN
         b24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=W5hX+kPnjm24N1ajF8KR2pMHg0gzDDTK8NIYEnB0EOo=;
        b=DZhf7OP562WxgYuGlVU90/y9PZuGfF0cH6HjzrfJQ3Nv0qKBz8XYNQkyyIMgbbDofH
         a18DVq/s7BnJ3YRseWue6Ib0XJvW2e4geg8iddtpv1DjwwFyv6zsdG+E9LNHufZpN8FX
         9Rm5wYSuojZqDiWNSK+NTJCfh87eL2P5p63RGR709HYUaPQKB+KQjtA9GI2RxUYRkRLL
         O71q7iPFYqqy7ydDpGqDv1U18UE6RGIk08tZdZgVvLvtFggM0Ot/hMq0B3D3SSy1ZQp/
         RTOKVuKTnb0fxFwf5W4K4EqQTUtdgh8vLj7VUs87+vHAj/tm+zMSVUXxFqoru1WdHaWW
         mmEQ==
X-Gm-Message-State: AOAM533zgNcTjyLY517Y6R9NTPMYAP4oOKKefrlxO0z277MJPVyzqsg2
        54dH4GFmlFQlv5WIJRk1uTY=
X-Google-Smtp-Source: ABdhPJxKgu+LlHrDUqBuiMThTiIWXFApWz2cuQbl3c2wC69a5fJBKZ74/Ju/u3Kl56rIlRhQ2ttNYQ==
X-Received: by 2002:a2e:b70b:: with SMTP id j11mr20668840ljo.142.1594234118586;
        Wed, 08 Jul 2020 11:48:38 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id f5sm148644lja.17.2020.07.08.11.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 11:48:36 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 8 Jul 2020 20:48:34 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 03/17] rcu/tree: Skip entry into the page
 allocator for PREEMPT_RT
Message-ID: <20200708184834.GA3141@pc636>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
 <20200624201226.21197-3-paulmck@kernel.org>
 <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
 <20200630183534.GG9247@paulmck-ThinkPad-P72>
 <20200702141216.r4rbt5w3hjzafpgg@linutronix.de>
 <20200702164826.GQ9247@paulmck-ThinkPad-P72>
 <20200702201908.jfiacgvion6a4nmj@linutronix.de>
 <20200706210645.GJ9247@paulmck-ThinkPad-P72>
 <20200707173441.GA28267@pc636>
 <20200707184531.GC233429@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200707184531.GC233429@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 07, 2020 at 02:45:31PM -0400, Joel Fernandes wrote:
> On Tue, Jul 07, 2020 at 07:34:41PM +0200, Uladzislau Rezki wrote:
> > On Mon, Jul 06, 2020 at 02:06:45PM -0700, Paul E. McKenney wrote:
> > > On Thu, Jul 02, 2020 at 10:19:08PM +0200, Sebastian Andrzej Siewior wrote:
> > > > On 2020-07-02 09:48:26 [-0700], Paul E. McKenney wrote:
> > > > > On Thu, Jul 02, 2020 at 04:12:16PM +0200, Sebastian Andrzej Siewior wrote:
> > > > > > On 2020-06-30 11:35:34 [-0700], Paul E. McKenney wrote:
> > > > > > > > This is not going to work together with the "wait context validator"
> > > > > > > > (CONFIG_PROVE_RAW_LOCK_NESTING). As of -rc3 it should complain about
> > > > > > > > printk() which is why it is still disabled by default.
> > > > > > > 
> > > > > > > Fixing that should be "interesting".  In particular, RCU CPU stall
> > > > > > > warnings rely on the raw spin lock to reduce false positives due
> > > > > > > to race conditions.  Some thought will be required here.
> > > > > > 
> > > > > > I don't get this part. Can you explain/give me an example where to look
> > > > > > at?
> > > > > 
> > > > > Starting from the scheduler-clock interrupt's call into RCU,
> > > > > we have rcu_sched_clock_irq() which calls rcu_pending() which
> > > > > calls check_cpu_stall() which calls either print_cpu_stall() or
> > > > > print_other_cpu_stall(), depending on whether the stall is happening on
> > > > > the current CPU or on some other CPU, respectively.
> > > > > 
> > > > > Both of these last functions acquire the rcu_node structure's raw ->lock
> > > > > and expect to do printk()s while holding it.
> > > > 
> > > > …
> > > > > Thoughts?
> > > > 
> > > > Okay. So in the RT queue there is a printk() rewrite which fixes this
> > > > kind of things. Upstream the printk() interface is still broken in this
> > > > regard and therefore CONFIG_PROVE_RAW_LOCK_NESTING is disabled.
> > > > [Earlier the workqueue would also trigger a warning but this has been
> > > > fixed as of v5.8-rc1.]
> > > > This was just me explaining why this bad, what debug function would
> > > > report it and why it is not enabled by default.
> > > 
> > > Whew!!!  ;-)
> > > 
> > > > > > > > So assume that this is fixed and enabled then on !PREEMPT_RT it will
> > > > > > > > complain that you have a raw_spinlock_t acquired (the one from patch
> > > > > > > > 02/17) and attempt to acquire a spinlock_t in the memory allocator.
> > > > > > > 
> > > > > > > Given that the slab allocator doesn't acquire any locks until it gets
> > > > > > > a fair way in, wouldn't it make sense to allow a "shallow" allocation
> > > > > > > while a raw spinlock is held?  This would require yet another GFP_ flag,
> > > > > > > but that won't make all that much of a difference in the total.  ;-)
> > > > > > 
> > > > > > That would be one way of dealing with. But we could go back to
> > > > > > spinlock_t and keep the memory allocation even for RT as is. I don't see
> > > > > > a downside of this. And we would worry about kfree_rcu() from real
> > > > > > IRQ-off region once we get to it.
> > > > > 
> > > > > Once we get to it, your thought would be to do per-CPU queuing of
> > > > > memory from IRQ-off kfree_rcu(), and have IRQ work or some such clean
> > > > > up after it?  Or did you have some other trick in mind?
> > > > 
> > > > So for now I would very much like to revert the raw_spinlock_t back to
> > > > the spinlock_t and add a migrate_disable() just avoid the tiny
> > > > possible migration between obtaining the CPU-ptr and acquiring the lock
> > > > (I think Joel was afraid of performance hit).
> > > 
> > > Performance is indeed a concern here.
> > > 
> > > > Should we get to a *real* use case where someone must invoke kfree_rcu()
> > > > from a hard-IRQ-off region then we can think what makes sense. per-CPU
> > > > queues and IRQ-work would be one way of dealing with it.
> > > 
> > > It looks like workqueues can also be used, at least in their current
> > > form.  And timers.
> > > 
> > > Vlad, Joel, thoughts?
> > >
> > Some high level thoughts:
> > 
> > Currently everything is done in workqueue context, it means all freeing
> > happens there. For RT kernel we can invoke a page allocator only for single
> > kfree_rcu() argument(though we skip it). As for double one, it is impossible,
> > that is why a simple path is used by linking rcu_head among each other for
> > further reclaim in wq context. As of now, for RT, everything is already
> > deferred.
> > 
> > If we revert to spinlock_t then calling of kfree_rcu() from hard IRQ
> > context is broken, even though we think that for RT kernel it will
> > never happen. Therefore i do not see a clear motivation and benefits
> > why we should revert to spinlock_t.
> > 
> > IMHO, if we can avoid of such drawback i would go with that way, i.e.
> > i would not like to think what to do with that when it becomes broken.
> 
> I am also of Vlad's opinion. It seems to me that doing the migrate_disable()
> before dropping the raw spinlock should suffice.
> 
> Note that in the future, we may have other users of this path such as
> a potential kmem_cache_free_rcu(). It seems burdensome to make these all
> callable only from sleepable-context.
> 
> Is there a drawback of doing migrate_disable before dropping the raw internal
> lock, that I'm missing?
> 
I used migrate_disable() just to underline that we want to stay on the
same CPU. We can go with preempt_enable()/preempt_disable() what is
exactly the same as migrate_disable() for regular kernel.

--
Vlad Rezki
