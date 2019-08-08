Return-Path: <SRS0=c+fI=WE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BCFC0650F
	for <rcu@archiver.kernel.org>; Thu,  8 Aug 2019 12:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0D621880
	for <rcu@archiver.kernel.org>; Thu,  8 Aug 2019 12:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kWjbyGWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbfHHM4K (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:56:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35290 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732608AbfHHM4K (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 8 Aug 2019 08:56:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so44087966pfn.2
        for <rcu@vger.kernel.org>; Thu, 08 Aug 2019 05:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OtemChIEVGtJbxJJpBFCr2nTOqMHnbsEXzW5cKzteo4=;
        b=kWjbyGWqidY0esTpgRlGghoSN3673Vz24/GbBa7A3OYHmQn5XdvfvXDNxaNyTdMkqu
         pgpnnK4kQAokwd5olZzYW5VATudS8gEJAVb8bsJEV5tP1xrUsO9ix7Mck+oNYgkGFOTb
         s90krmQQcGm96RvldlEReHcUzoTmmJt5SDUyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OtemChIEVGtJbxJJpBFCr2nTOqMHnbsEXzW5cKzteo4=;
        b=I5+M8wft/KL9hF2XUbqzKWKQdrkmGS4lqPymSUZ/NFaYg6w+VzwUGHLVoh63yrhGYv
         rRJ2zPTKToSjRUHgegHy62m4DTlKNtMjD/HrcdIQDPB4gR45k7gppzP8v15AfcEOiKXI
         8D/ydQ43DGZ2892lkb+joHR8h9oL5WKvi2xHFnfkapQVAVDhWTLNuRu5BlSMFNB9ChDn
         O92iCQX0aqhV+pptvVpKfJIVeL6dCezdYd9LG/TFxovlMJwbFpV50goMednOmRwtYhq8
         DhtroYzjdJeTuQbZvx7Vdbf7fc6sJB3I52GED7KgLA12+s4evo7owMnO8QOP6oMS4aUQ
         azmg==
X-Gm-Message-State: APjAAAVwUsVvFJ/823CPyosg4DaxT+2lBlme8KPlz1uspPsKJi+xmPty
        4AP8PdN+nyVDDGdaFnypd5AlvQ==
X-Google-Smtp-Source: APXvYqzdVN1niKwKrvdyMNQqDVV5nZq/c1fiJTRRKYyZjxa6qCbcI/aN7ZvKVmXfy3ehRw7my00lCw==
X-Received: by 2002:a63:7b18:: with SMTP id w24mr12649044pgc.328.1565268969416;
        Thu, 08 Aug 2019 05:56:09 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id f64sm101708912pfa.115.2019.08.08.05.56.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 05:56:08 -0700 (PDT)
Date:   Thu, 8 Aug 2019 08:56:07 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, kernel-team@android.com,
        kernel-team@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190808125607.GB261256@google.com>
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190808095232.GA30401@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808095232.GA30401@X58A-UD3R>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 08, 2019 at 06:52:32PM +0900, Byungchul Park wrote:
> On Wed, Aug 07, 2019 at 10:52:15AM -0700, Paul E. McKenney wrote:
> > > > On Tue, Aug 06, 2019 at 05:20:40PM -0400, Joel Fernandes (Google) wrote:
> > [ . . . ]
> > > > > +	for (; head; head = next) {
> > > > > +		next = head->next;
> > > > > +		head->next = NULL;
> > > > > +		__call_rcu(head, head->func, -1, 1);
> > > > 
> > > > We need at least a cond_resched() here.  200,000 times through this loop
> > > > in a PREEMPT=n kernel might not always be pretty.  Except that this is
> > > > invoked directly from kfree_rcu() which might be invoked with interrupts
> > > > disabled, which precludes calls to cond_resched().  So the realtime guys
> > > > are not going to be at all happy with this loop.
> > > 
> > > Ok, will add this here.
> > > 
> > > > And this loop could be avoided entirely by having a third rcu_head list
> > > > in the kfree_rcu_cpu structure.  Yes, some of the batches would exceed
> > > > KFREE_MAX_BATCH, but given that they are invoked from a workqueue, that
> > > > should be OK, or at least more OK than queuing 200,000 callbacks with
> > > > interrupts disabled.  (If it turns out not to be OK, an array of rcu_head
> > > > pointers can be used to reduce the probability of oversized batches.)
> > > > This would also mean that the equality comparisons with KFREE_MAX_BATCH
> > > > need to become greater-or-equal comparisons or some such.
> > > 
> > > Yes, certainly we can do these kinds of improvements after this patch, and
> > > then add more tests to validate the improvements.
> > 
> > Out of pity for people bisecting, we need this fixed up front.
> > 
> > My suggestion is to just allow ->head to grow until ->head_free becomes
> > available.  That way you are looping with interrupts and preemption
> > enabled in workqueue context, which is much less damaging than doing so
> > with interrupts disabled, and possibly even from hard-irq context.
> 
> Agree.
> 
> Or after introducing another limit like KFREE_MAX_BATCH_FORCE(>=
> KFREE_MAX_BATCH):
> 
> 1. Try to drain it on hitting KFREE_MAX_BATCH as it does.
> 
>    On success: Same as now.
>    On fail: let ->head grow and drain if possible, until reaching to
>             KFREE_MAX_BATCH_FORCE.
> 
> 3. On hitting KFREE_MAX_BATCH_FORCE, give up batching but handle one by
>    one from now on to prevent too many pending requests from being
>    queued for batching work.

I also agree. But this _FORCE thing will still not solve the issue Paul is
raising which is doing this loop possibly in irq disabled / hardirq context.
We can't even cond_resched() here. In fact since _FORCE is larger, it will be
even worse. Consider a real-time system with a lot of memory, in this case
letting ->head grow large is Ok, but looping for long time in IRQ disabled
would not be Ok.

But I could make it something like:
1. Letting ->head grow if ->head_free busy
2. If head_free is busy, then just queue/requeue the monitor to try again.

This would even improve performance, but will still risk going out of memory.

Thoughts?

thanks,

 - Joel

> 
> This way, we can avoid both:
> 
> 1. too many requests being queued and
> 2. __call_rcu() bunch of requests within a single kfree_rcu().
> 
> Thanks,
> Byungchul
> 
> > 
> > But please feel free to come up with a better solution!
> > 
> > [ . . . ]
