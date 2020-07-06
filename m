Return-Path: <SRS0=BsRz=AR=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F71DC433DF
	for <rcu@archiver.kernel.org>; Mon,  6 Jul 2020 20:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2731820BED
	for <rcu@archiver.kernel.org>; Mon,  6 Jul 2020 20:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FP3kmo9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgGFU3w (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgGFU3v (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 6 Jul 2020 16:29:51 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64648C061794
        for <rcu@vger.kernel.org>; Mon,  6 Jul 2020 13:29:51 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e12so30044334qtr.9
        for <rcu@vger.kernel.org>; Mon, 06 Jul 2020 13:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E1cpgB63aTx62rfdyAN52wQdXPNJ9PzG1Y0V51rY+uo=;
        b=FP3kmo9X+mlo/KJkw2tV5QI2wvKjZbW8ZSfMqXNwNwOdvPRyJzaU9A6nNCX2lU6zm5
         0OhUwvf0u7qFd9lZ7jxzKK4kfGZ1EeMe9ZXz5vvi6tRMyjM1Twm91I0oP4QZWInpjnn6
         3ypYHq1KcSe4K9wjSvDpaU9VboGZz0uU4cJgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E1cpgB63aTx62rfdyAN52wQdXPNJ9PzG1Y0V51rY+uo=;
        b=CdLRQwHngGhMCXTze6D4oLKiW1/4LmIZLIOzloHFz5+/qIKWn6Ljbt/OeBGW8o053M
         kN8rPtrN5f+ATUlvyxxSbsLwj7UQIVltrVpNZL2B1BGdXSORlty0Fza4fHAc2zuabfSj
         c0TETt4S+Na7wW+2ikWgXR9sAJiWZw1nRx2UpZ3PGfbi+dRMXXOcb/0sXISTvF4YctKb
         FavRcPYh+L5o8CS9Y6yxhk14H/ZSB7YDq1n+133fniuppYxyI01KAtnZHwhR17zmxm+F
         FDNfRkwF/BmfiQ4DsB56p/U5DRX78n99wo9IyIEOHGcH2A68yePHzec1MSGMuUi3JFTm
         W/jw==
X-Gm-Message-State: AOAM5308Hcyj3YzT2eXyJwr9bFNijVUq7rPQf5e6JR3l24OCjIkpcRh7
        DeMaDh4Modfb6rtkSk3SKgEwdQ==
X-Google-Smtp-Source: ABdhPJzrKAgLpmzG0AueY+67qSsWEG8wy2SX0+wTaju4O1ndcK6emMwXEMdTB3Gj73h+cDrgGh9hWA==
X-Received: by 2002:ac8:409d:: with SMTP id p29mr51480132qtl.369.1594067390519;
        Mon, 06 Jul 2020 13:29:50 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id q5sm21058291qkq.36.2020.07.06.13.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:29:50 -0700 (PDT)
Date:   Mon, 6 Jul 2020 16:29:49 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20200706202949.GB233429@google.com>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
 <20200624201226.21197-3-paulmck@kernel.org>
 <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
 <20200630183534.GG9247@paulmck-ThinkPad-P72>
 <20200702141216.r4rbt5w3hjzafpgg@linutronix.de>
 <20200702194506.GA31478@pc636>
 <20200706194232.GA233429@google.com>
 <20200706195557.GA24082@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706195557.GA24082@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jul 06, 2020 at 09:55:57PM +0200, Uladzislau Rezki wrote:
[...]
> > > Another way of fixing it is just dropping the lock letting the page
> > > allocator to do an allocation without our "upper/local" lock. I did a
> > > proposal like that once upon a time, so maybe it is a time to highlight
> > > it again:
> > > <snip>
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 21c2fa5bd8c3..249f10a89bb9 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3278,9 +3278,11 @@ static void kfree_rcu_monitor(struct work_struct *work)
> > >  }
> > > 
> > >  static inline bool
> > > -kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > > +kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
> > > +       void *ptr, unsigned long *flags)
> > >  {
> > >         struct kvfree_rcu_bulk_data *bnode;
> > > +       struct kfree_rcu_cpu *tmp;
> > >         int idx;
> > > 
> > >         if (unlikely(!krcp->initialized))
> > > @@ -3306,6 +3308,9 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > >                         if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > >                                 return false;
> > > 
> > > +                       migrate_disable();
> > > +                       krc_this_cpu_unlock(krcp, *flags);
> > 
> > If I remember, the issue here is that migrate_disable is not implemented on a
> > non-RT kernel due to issues with starvation.
> > 
> It is implemented. Please have a look linux/preempt.h for regular kernel.

Yeah sorry, I meant it is not implemented in the right way in the sense - it
disables migration with the preempt-disable hammer.

Anyway, I think as we discussed on IRC, your proposal will work for both
kernels while allowing us to keep the internal lock as raw.

thanks,

 - Joel

