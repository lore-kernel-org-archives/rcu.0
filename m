Return-Path: <SRS0=BsRz=AR=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C769C433E0
	for <rcu@archiver.kernel.org>; Mon,  6 Jul 2020 19:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6646C207D0
	for <rcu@archiver.kernel.org>; Mon,  6 Jul 2020 19:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYnk6pX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgGFT4E (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 6 Jul 2020 15:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGFT4D (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 6 Jul 2020 15:56:03 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B8DC061755;
        Mon,  6 Jul 2020 12:56:03 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f5so31142822ljj.10;
        Mon, 06 Jul 2020 12:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D2zoZJIZqel2uVFq5DHARgYdOCSETFeeGsEkv8xs8eY=;
        b=HYnk6pX+Y51ijZR97ziMELX5JGdJdHBKcBpufZhFcvEtAAe9cftVxwDOBGC8YPW1Mg
         G7GxKtxvW7ECmQHjTwfyZY1iz25/TWGn7rF1KX4O0Vgrx9egA4nto3HhFDkrEw6a+vHd
         Oi3hYboF9uFht9GK+lgmGtJGEvyc+/DQ8Pvh4p79JT9mJlZ+bk5Fqf8r905vffNV4dam
         IlBTY4+8w41aklnJpun/MXyJYX+YAPccl+mpGsaQ4dJ5epc9NO5ezRDgJR01fWTxA64M
         rXieku9Pl5ewSpdEdg8oo3/XftD1D1ywzj8DKpyGAwnlZMCU2eeVwepItU13IeIKLo5m
         2PzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D2zoZJIZqel2uVFq5DHARgYdOCSETFeeGsEkv8xs8eY=;
        b=Wt2P+voYiI6rRweYDtr/v+0wstjf9eA9L18WrOMM6qMB4SRsohj37TUMH+39NNuI1+
         ljSU7+HidyY9LFKlmJJdIqG50jbvN7xTZ+g0t9k8S3kN3SSbSbQdSDkvViBhPnht8QKH
         6tZnHy4gAEHcwLcGnl6ggQ5hGFzyvQhCZo/dySLVGFaCG96KSTHw+nfOYwg9ChIiDFIz
         whfgdsZE/vXV12oDRMIcbOaxU6y82MboBVDgzhyZR6BLPUmiJXlCKVULForuBHGYJqUI
         m1MSG4YJJyvkRedagPnb3llAJg/y0xm/lKnKqbwDNsxIuk6Vg/ouxbucRstZDuTDLJDP
         2vWg==
X-Gm-Message-State: AOAM531z/lnRhcOBtfuH4CFdUsTBRCoa2SMsYoIEOb3ny24iCxXcJcdd
        Ih/TR975Ssd2bhFeK5luyAk=
X-Google-Smtp-Source: ABdhPJwE/tGywhIDj+Oox6U4FhC9wfLr0L/iYKqtdozVBmtnJdVsFYHT+N1qRBT0VG2ske8LjjSRHw==
X-Received: by 2002:a2e:9208:: with SMTP id k8mr26462297ljg.461.1594065361565;
        Mon, 06 Jul 2020 12:56:01 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id v5sm7999577ljd.10.2020.07.06.12.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 12:56:00 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 6 Jul 2020 21:55:57 +0200
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
Message-ID: <20200706195557.GA24082@pc636>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
 <20200624201226.21197-3-paulmck@kernel.org>
 <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
 <20200630183534.GG9247@paulmck-ThinkPad-P72>
 <20200702141216.r4rbt5w3hjzafpgg@linutronix.de>
 <20200702194506.GA31478@pc636>
 <20200706194232.GA233429@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706194232.GA233429@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jul 06, 2020 at 03:42:32PM -0400, Joel Fernandes wrote:
> On Thu, Jul 02, 2020 at 09:45:06PM +0200, Uladzislau Rezki wrote:
> > On Thu, Jul 02, 2020 at 04:12:16PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2020-06-30 11:35:34 [-0700], Paul E. McKenney wrote:
> > > > > This is not going to work together with the "wait context validator"
> > > > > (CONFIG_PROVE_RAW_LOCK_NESTING). As of -rc3 it should complain about
> > > > > printk() which is why it is still disabled by default.
> > > > 
> > > > Fixing that should be "interesting".  In particular, RCU CPU stall
> > > > warnings rely on the raw spin lock to reduce false positives due
> > > > to race conditions.  Some thought will be required here.
> > > 
> > > I don't get this part. Can you explain/give me an example where to look
> > > at?
> > > 
> > > > > So assume that this is fixed and enabled then on !PREEMPT_RT it will
> > > > > complain that you have a raw_spinlock_t acquired (the one from patch
> > > > > 02/17) and attempt to acquire a spinlock_t in the memory allocator.
> > > > 
> > > > Given that the slab allocator doesn't acquire any locks until it gets
> > > > a fair way in, wouldn't it make sense to allow a "shallow" allocation
> > > > while a raw spinlock is held?  This would require yet another GFP_ flag,
> > > > but that won't make all that much of a difference in the total.  ;-)
> > > 
> > > That would be one way of dealing with. But we could go back to
> > > spinlock_t and keep the memory allocation even for RT as is. I don't see
> > > a downside of this. And we would worry about kfree_rcu() from real
> > > IRQ-off region once we get to it.
> > > 
> 
> Sorry for my late reply as the day job and family demanded a lot last week...
> 
> > Another way of fixing it is just dropping the lock letting the page
> > allocator to do an allocation without our "upper/local" lock. I did a
> > proposal like that once upon a time, so maybe it is a time to highlight
> > it again:
> > <snip>
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 21c2fa5bd8c3..249f10a89bb9 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3278,9 +3278,11 @@ static void kfree_rcu_monitor(struct work_struct *work)
> >  }
> > 
> >  static inline bool
> > -kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > +kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
> > +       void *ptr, unsigned long *flags)
> >  {
> >         struct kvfree_rcu_bulk_data *bnode;
> > +       struct kfree_rcu_cpu *tmp;
> >         int idx;
> > 
> >         if (unlikely(!krcp->initialized))
> > @@ -3306,6 +3308,9 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> >                         if (IS_ENABLED(CONFIG_PREEMPT_RT))
> >                                 return false;
> > 
> > +                       migrate_disable();
> > +                       krc_this_cpu_unlock(krcp, *flags);
> 
> If I remember, the issue here is that migrate_disable is not implemented on a
> non-RT kernel due to issues with starvation.
> 
It is implemented. Please have a look linux/preempt.h for regular kernel.

--
Vlad Rezki
