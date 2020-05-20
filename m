Return-Path: <SRS0=9J+a=7C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510DDC433E0
	for <rcu@archiver.kernel.org>; Wed, 20 May 2020 19:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24402207D3
	for <rcu@archiver.kernel.org>; Wed, 20 May 2020 19:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xqOCj1hi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgETTAA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 May 2020 15:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgETS77 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 May 2020 14:59:59 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D79FC061A0E
        for <rcu@vger.kernel.org>; Wed, 20 May 2020 11:59:59 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c24so3449922qtw.7
        for <rcu@vger.kernel.org>; Wed, 20 May 2020 11:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ARORx90bNZfE3lIvpSPFr7pFGC2F13RJPiz07NfvAWg=;
        b=xqOCj1hi7zsdkF4h7T7VpVsacljZUmQ98KBXk4BC/Dbn1LZa5faEmx2QjtoDIrVUFb
         P6lu0RuOXjmco5U/CykEp8x4g7RdNl7UvG4m0sChWHzGk3hIX45vYFUqw7L/RamVwzoI
         IUgUbP9dHwHRi8zBAlVHX2JlNghk6esJwZciA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ARORx90bNZfE3lIvpSPFr7pFGC2F13RJPiz07NfvAWg=;
        b=FvpXWO0h9gnqkBnZflZjaovk5DO1SakY/zRNLbOPt0iwjYHCKjpzUeu50E3O8cwWjy
         0adGOc1l33G/vGah0vSE0HSPqdLTDa0nw69tI9Lgv1dDBnzBIoqE2tBNH06j4At31zn6
         j/rE5kYnCKWQnfgADHjmZ1ngRjGyMGvBOWcet89HHNAEr9tki8DTPgLR3BwCIhIOhKsO
         P3esgvLby8XI0bBuh9CwoEgahrd1ogFEhM1Y+rudMAsCDqHtJYULYfy9Gj/EhUUAmk2f
         n+Vo7XeBh28NULy4T3ewMFv+8TQX/vdJhiSHDrYKofjn0N4o5UrdyA9C78+k8y08Cipj
         gI8w==
X-Gm-Message-State: AOAM531eCNDXSnkzHhTd7ISRXdRA2ZIHbTgICU0KpKdV/x4hrqRD2UXn
        Oh8mE1/JrvAbMqwcSt7OhPQZBQ==
X-Google-Smtp-Source: ABdhPJxKFQ4mBEMmbP/Kvr56rfPGG/twBhTQVRIoKgmz5lGIunly4e1J2W2rXX4eFpW+AV4T6MpO7A==
X-Received: by 2002:ac8:6a09:: with SMTP id t9mr6859997qtr.7.1590001198693;
        Wed, 20 May 2020 11:59:58 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h12sm3428451qte.31.2020.05.20.11.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 11:59:58 -0700 (PDT)
Date:   Wed, 20 May 2020 14:59:57 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org
Subject: Re: [PATCH 3/8] srcu: Use local_lock() for per-CPU struct srcu_data
 access
Message-ID: <20200520185957.GB261674@google.com>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-4-bigeasy@linutronix.de>
 <20200520102407.GF317569@hirez.programming.kicks-ass.net>
 <20200520120608.mwros5jurmidxxfv@linutronix.de>
 <20200520174259.GA247557@google.com>
 <20200520182800.sdp6t6bgbhn4kkqk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200520182800.sdp6t6bgbhn4kkqk@linutronix.de>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, May 20, 2020 at 08:28:00PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-05-20 13:42:59 [-0400], Joel Fernandes wrote:
> > Hi Sebastian,
> Hi Joel,
> 
> > For pointer stability, can we just use get_local_ptr() and put_local_ptr()
> > instead of adding an extra lock? This keeps the pointer stable while keeping
> > the section preemptible on -rt. And we already have a lock in rcu_data, I
> > prefer not to add another lock if possible.
> 
> What is this get_local_ptr() doing? I can't find it anywhere…

I replied about it in the other thread.

 
> > > I remember Paul looked at that patch a few years ago and he said that
> > > that disabling interrupts here is important and matches the other part
> > > instance where the interrupts are disabled. Looking at it now, it seems
> > > that there is just pointer stability but I can't tell if
> > > rcu_segcblist_pend_cbs() needs more than just this.
> > 
> > Which 'other part' are you referring to? Your patch removed local_irq_save()
> > from other places as well right?
> 
> The patch converted hunks.
> 

So then there are no other local_irq_save() to match with. Or may be I did
not understand your concern, could you share any threads from past
discussions about disabling interrupts in this code? You mentioned about a
discussion from few years ago.

> > 
> >  - Joel
> > 
> > ---8<-----------------------
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 8ff71e5d0fe8b..5f49919205317 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -778,13 +778,17 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
> >  	unsigned long tlast;
> >  
> >  	/* If the local srcu_data structure has callbacks, not idle.  */
> > -	local_irq_save(flags);
> > -	sdp = this_cpu_ptr(ssp->sda);
> > +	sdp = get_local_ptr(ssp->sda);
> > +	spin_lock_irqsave_rcu_node(sdp, flags);
> 
> You acquire the node lock which was not acquired before. Is that okay?
> How is get_local_ptr() different to raw_cpu_ptr()?

get_cpu_ptr() disables preemption which you might not want, right?

Most (all?) other paths are accessing the cblist under lock so I added it
here to be safe. This is anyway called from a slowpath. Do you see a problem?

thanks,

 - Joel

