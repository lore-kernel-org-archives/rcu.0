Return-Path: <SRS0=j199=WK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A758FC32753
	for <rcu@archiver.kernel.org>; Wed, 14 Aug 2019 17:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3E620665
	for <rcu@archiver.kernel.org>; Wed, 14 Aug 2019 17:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Jq1WJLMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfHNRWh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:22:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33211 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbfHNRWh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Aug 2019 13:22:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so53971791pfq.0
        for <rcu@vger.kernel.org>; Wed, 14 Aug 2019 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tKeZkHVdOTrrbp3L6xiLYQzT4PgNeWVgJQ71pR7Y1hc=;
        b=Jq1WJLMwYfOmDtdlMvLrPfs483e6jQtjYKl+AAfH0yGzvtGSJJLPMsWePCTcLNKMVD
         cy0HrsN51kEFY1pHyD7ey4tjU72XdiwPntsGqoW/lhKTnpsu7S62HWyZQbZymaM13Q9d
         DIcUGp1c7vxz2uMzIJz7ijs67TMWf04Pssp1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tKeZkHVdOTrrbp3L6xiLYQzT4PgNeWVgJQ71pR7Y1hc=;
        b=JJ4eR9Yfa5kaTTz1mByMO//7PCDNBk2f9Eqoqev8e5edkVUeoFLMHNJoig+RcvvnGx
         Gt1+i/3fRYmotXc9FdlaQep+tryHhZ33USCDO12IBFGfLIElm6bWsjLpXyw7mMx2ufX8
         J8gmo88aR0GwUNIpmmKJ1tS1vmAzkpAkMqP9Rb20d+JtFntRuFeKQCwmsMjrqnslX1KF
         AQOhGPcljLP/huIBNBfFvQBndFRb7BZcig7SjAuCLr4i7lnb4Nu20staV4tJYgpZGUEo
         afygGTBqI/cPZACOvElaL/c68UKV5GAACm/d5hhsAWFxm6eioTEvfctRwDJ0E+Frt0uz
         JZEg==
X-Gm-Message-State: APjAAAX41+0DdMfPvgdiI66bVgT/bcxkePoFHAIUUjVNCBPF1q3dv2Aa
        bxmIqBpnAkyOl5rP8eFuFIYPnw==
X-Google-Smtp-Source: APXvYqytE1M4/ayfarH7qXRQ/lomdLGUawyJeO7H22yRrGzjc3MD2Vf7zQBRnVNFFKiHv6DgKBg34g==
X-Received: by 2002:a17:90a:fc95:: with SMTP id ci21mr804345pjb.52.1565803355964;
        Wed, 14 Aug 2019 10:22:35 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g18sm267119pgm.9.2019.08.14.10.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 10:22:35 -0700 (PDT)
Date:   Wed, 14 Aug 2019 13:22:33 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, byungchul.park@lge.com,
        kernel-team@android.com, kernel-team@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/2] rcu/tree: Add basic support for kfree_rcu batching
Message-ID: <20190814172233.GA68498@google.com>
References: <20190813170046.81707-1-joel@joelfernandes.org>
 <20190813190738.GH28441@linux.ibm.com>
 <20190814143817.GA253999@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814143817.GA253999@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 14, 2019 at 10:38:17AM -0400, Joel Fernandes wrote:
> On Tue, Aug 13, 2019 at 12:07:38PM -0700, Paul E. McKenney wrote:
 [snip]
> > > - * Queue an RCU callback for lazy invocation after a grace period.
> > > - * This will likely be later named something like "call_rcu_lazy()",
> > > - * but this change will require some way of tagging the lazy RCU
> > > - * callbacks in the list of pending callbacks. Until then, this
> > > - * function may only be called from __kfree_rcu().
> > > + * Maximum number of kfree(s) to batch, if this limit is hit then the batch of
> > > + * kfree(s) is queued for freeing after a grace period, right away.
> > >   */
> > > -void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > +struct kfree_rcu_cpu {
> > > +	/* The rcu_work node for queuing work with queue_rcu_work(). The work
> > > +	 * is done after a grace period.
> > > +	 */
> > > +	struct rcu_work rcu_work;
> > > +
> > > +	/* The list of objects being queued in a batch but are not yet
> > > +	 * scheduled to be freed.
> > > +	 */
> > > +	struct rcu_head *head;
> > > +
> > > +	/* The list of objects that have now left ->head and are queued for
> > > +	 * freeing after a grace period.
> > > +	 */
> > > +	struct rcu_head *head_free;
> > 
> > So this is not yet the one that does multiple batches concurrently
> > awaiting grace periods, correct?  Or am I missing something subtle?
> 
> Yes, it is not. I honestly, still did not understand that idea. Or how it
> would improve things. May be we can discuss at LPC on pen and paper? But I
> think that can also be a follow-up optimization.

I got it now. Basically we can benefit a bit more by having another list
(that is have multiple kfree_rcu batches in flight). I will think more about
it - but hopefully we don't need to gate this patch by that.

It'll be interesting to see what rcuperf says about such an improvement :)

thanks,

 - Joel

