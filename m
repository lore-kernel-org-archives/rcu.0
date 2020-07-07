Return-Path: <SRS0=8S7d=AS=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92429C433E1
	for <rcu@archiver.kernel.org>; Tue,  7 Jul 2020 17:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E6320773
	for <rcu@archiver.kernel.org>; Tue,  7 Jul 2020 17:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDkXLPAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgGGRer (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgGGReq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 7 Jul 2020 13:34:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A0CC061755;
        Tue,  7 Jul 2020 10:34:46 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id j11so2163998ljo.7;
        Tue, 07 Jul 2020 10:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HqaezhdqPdGVFEw62cPhcEDjkdmOZi2qrben8r1NKNs=;
        b=XDkXLPAL9cLpn7pNG3ZtQPH6Kr685pbOFOYMg6PY6A2HhWFRbq9cQy0whRSKlxXhCg
         x1Qdw9RQGjOMtI43QCpCj4rJm8EVNR7uWqAz2V99KqkFneqgWZ9f50Rdv2Gv6AM5JT5Q
         /wLxx/E20L4W8pieHAv9nzQh/cEGvKU+YF/elOllnfZ/uYjXsUx3wsuqIrNGhbK8v6GP
         srwRNZ9AfqJQrhb4nr8ohU80PjtxA4lLcr/52kYgH2ZRvFVKNa+5c1WEegZzfI8cnQDJ
         DTas6FAa62Pp+WL/7YLwN6QxGEOjlURdkcFTJ7us6XNS3EBgpNurjIad1dz7Slzfse5k
         XLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HqaezhdqPdGVFEw62cPhcEDjkdmOZi2qrben8r1NKNs=;
        b=gLqb75E2sIW36xv2DELj82+chs2OHEdC4jS1Bihr8xs70VqV1ORmccyY7raHGkW3kp
         wpfCF5nDfAgoS8gUr7ZXhVs9GS2JU6f/xGWWF+HtmGEpTJnUUggJrg/1MGAoBk4D67Ik
         oOk0Uw8d1aldvuIQVsTB2p7h9TnyiQSC9G135L+rY9+w3s3l5p35CaoXsZvdfWbM4u01
         ioJYcA2WjcAyVrSQPy8rr1+eV0p4hfUTHefcp4ieETRNnMskRt+qqvdyFzB6t96qPgUs
         goFiB+fVIowWvucxg4UtnEykpEnsM1dstL2WDMnqrym/JvXmOu9eDeo2yQoTeY71liSq
         44Zg==
X-Gm-Message-State: AOAM5316GO+awHOfSxhadCxn3oALn4h4s/4iiOjxwN02eN5npHlpAWmn
        qhG3Y335bRifIyR+Ewr6ME4=
X-Google-Smtp-Source: ABdhPJxP8QRaAZk0ZSlyMFdypc3JpRwOvNcAI00Kl+aNe2OM1rpCcyz0ad+hx8sKW4v1bGo+tkt1Jw==
X-Received: by 2002:a2e:3e15:: with SMTP id l21mr9108347lja.43.1594143284765;
        Tue, 07 Jul 2020 10:34:44 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id w2sm295568lji.41.2020.07.07.10.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 10:34:43 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 7 Jul 2020 19:34:41 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH tip/core/rcu 03/17] rcu/tree: Skip entry into the page
 allocator for PREEMPT_RT
Message-ID: <20200707173441.GA28267@pc636>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
 <20200624201226.21197-3-paulmck@kernel.org>
 <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
 <20200630183534.GG9247@paulmck-ThinkPad-P72>
 <20200702141216.r4rbt5w3hjzafpgg@linutronix.de>
 <20200702164826.GQ9247@paulmck-ThinkPad-P72>
 <20200702201908.jfiacgvion6a4nmj@linutronix.de>
 <20200706210645.GJ9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200706210645.GJ9247@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jul 06, 2020 at 02:06:45PM -0700, Paul E. McKenney wrote:
> On Thu, Jul 02, 2020 at 10:19:08PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2020-07-02 09:48:26 [-0700], Paul E. McKenney wrote:
> > > On Thu, Jul 02, 2020 at 04:12:16PM +0200, Sebastian Andrzej Siewior wrote:
> > > > On 2020-06-30 11:35:34 [-0700], Paul E. McKenney wrote:
> > > > > > This is not going to work together with the "wait context validator"
> > > > > > (CONFIG_PROVE_RAW_LOCK_NESTING). As of -rc3 it should complain about
> > > > > > printk() which is why it is still disabled by default.
> > > > > 
> > > > > Fixing that should be "interesting".  In particular, RCU CPU stall
> > > > > warnings rely on the raw spin lock to reduce false positives due
> > > > > to race conditions.  Some thought will be required here.
> > > > 
> > > > I don't get this part. Can you explain/give me an example where to look
> > > > at?
> > > 
> > > Starting from the scheduler-clock interrupt's call into RCU,
> > > we have rcu_sched_clock_irq() which calls rcu_pending() which
> > > calls check_cpu_stall() which calls either print_cpu_stall() or
> > > print_other_cpu_stall(), depending on whether the stall is happening on
> > > the current CPU or on some other CPU, respectively.
> > > 
> > > Both of these last functions acquire the rcu_node structure's raw ->lock
> > > and expect to do printk()s while holding it.
> > 
> > …
> > > Thoughts?
> > 
> > Okay. So in the RT queue there is a printk() rewrite which fixes this
> > kind of things. Upstream the printk() interface is still broken in this
> > regard and therefore CONFIG_PROVE_RAW_LOCK_NESTING is disabled.
> > [Earlier the workqueue would also trigger a warning but this has been
> > fixed as of v5.8-rc1.]
> > This was just me explaining why this bad, what debug function would
> > report it and why it is not enabled by default.
> 
> Whew!!!  ;-)
> 
> > > > > > So assume that this is fixed and enabled then on !PREEMPT_RT it will
> > > > > > complain that you have a raw_spinlock_t acquired (the one from patch
> > > > > > 02/17) and attempt to acquire a spinlock_t in the memory allocator.
> > > > > 
> > > > > Given that the slab allocator doesn't acquire any locks until it gets
> > > > > a fair way in, wouldn't it make sense to allow a "shallow" allocation
> > > > > while a raw spinlock is held?  This would require yet another GFP_ flag,
> > > > > but that won't make all that much of a difference in the total.  ;-)
> > > > 
> > > > That would be one way of dealing with. But we could go back to
> > > > spinlock_t and keep the memory allocation even for RT as is. I don't see
> > > > a downside of this. And we would worry about kfree_rcu() from real
> > > > IRQ-off region once we get to it.
> > > 
> > > Once we get to it, your thought would be to do per-CPU queuing of
> > > memory from IRQ-off kfree_rcu(), and have IRQ work or some such clean
> > > up after it?  Or did you have some other trick in mind?
> > 
> > So for now I would very much like to revert the raw_spinlock_t back to
> > the spinlock_t and add a migrate_disable() just avoid the tiny
> > possible migration between obtaining the CPU-ptr and acquiring the lock
> > (I think Joel was afraid of performance hit).
> 
> Performance is indeed a concern here.
> 
> > Should we get to a *real* use case where someone must invoke kfree_rcu()
> > from a hard-IRQ-off region then we can think what makes sense. per-CPU
> > queues and IRQ-work would be one way of dealing with it.
> 
> It looks like workqueues can also be used, at least in their current
> form.  And timers.
> 
> Vlad, Joel, thoughts?
>
Some high level thoughts:

Currently everything is done in workqueue context, it means all freeing
happens there. For RT kernel we can invoke a page allocator only for single
kfree_rcu() argument(though we skip it). As for double one, it is impossible,
that is why a simple path is used by linking rcu_head among each other for
further reclaim in wq context. As of now, for RT, everything is already
deferred.

If we revert to spinlock_t then calling of kfree_rcu() from hard IRQ
context is broken, even though we think that for RT kernel it will
never happen. Therefore i do not see a clear motivation and benefits
why we should revert to spinlock_t.

IMHO, if we can avoid of such drawback i would go with that way, i.e.
i would not like to think what to do with that when it becomes broken.

Thanks!

--
Vlad Rezki
