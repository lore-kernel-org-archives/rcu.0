Return-Path: <SRS0=T7aT=4F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67797C34022
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 19:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3677420637
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 19:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bz4NpGUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgBQTcK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:32:10 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37253 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgBQTcK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Feb 2020 14:32:10 -0500
Received: by mail-qk1-f193.google.com with SMTP id c188so17260282qkg.4
        for <rcu@vger.kernel.org>; Mon, 17 Feb 2020 11:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IypIMEVd3k7kVnBAt1jKOLi72b/Kw5ufuDZuohQdR2s=;
        b=bz4NpGUh0UvxkyARFC5k462IP2BTK4nNTYXXDwabI/BgJW/0spkTl3OOhF8/Ntf+Nk
         Yz+dlas+uO2Bkp/xd9ZkqgRKJLQGHaSOKOGPddQrLT3KAXGnPlCTsMfw4pV5iwF7rG2F
         vKpnA5ggDug+pZbc7t2UlV5B0yQYu8DElSCOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IypIMEVd3k7kVnBAt1jKOLi72b/Kw5ufuDZuohQdR2s=;
        b=VwVEhHet+wfH5nVGXDcDM/zOI9xoxayb1l5PfJJjcBDtit0uB5XLQ9sBvMYy/+jcTq
         UkysXT597uxb2LdKblhDYptAcaV+O+BGoN91PkuYmJg2ZuSozM+S1qcRKr6IgsYSeGNO
         YOOJy8NgbFdjP7L+o6lkZ6eHUfPOBRw4CXPcI3gKh6iIz4GI3vvGI5C/zX5+8xZCh59H
         8/Hq6uW+BwFkCI5rdxh2T0YL+OIkCXHEcgPOKLPGLHsu1pLkcRVbM/tdH0BbYbLYiL1j
         m/y9xoUEMsgUrJaSLgiZ2U44T9HcE804XcB/1xGFNRtDZ/mYlUwATy4B9agaX9qRbTwy
         CXVw==
X-Gm-Message-State: APjAAAUItWXSxM6x3YXlUUCrklF1so/VlBeSaO85x59ADv4tiXzi47ik
        WURVtFU+OKZaBHPltDFQSETVnw==
X-Google-Smtp-Source: APXvYqzNrqZW51jSKGxzYefY2j5kBEoKA5DEb5NMoSNUc6ykhs5QFJAFa08SXhWaAcIW4PYcAd+afg==
X-Received: by 2002:ae9:dcc1:: with SMTP id q184mr15372784qkf.480.1581967929123;
        Mon, 17 Feb 2020 11:32:09 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y91sm692591qtd.13.2020.02.17.11.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 11:32:08 -0800 (PST)
Date:   Mon, 17 Feb 2020 14:32:08 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, dipankar@in.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>, fweisbec@gmail.com,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH tip/core/rcu 1/3] rcu-tasks: *_ONCE() for
 rcu_tasks_cbs_head
Message-ID: <20200217193208.GB192553@google.com>
References: <20200215002446.GA15663@paulmck-ThinkPad-P72>
 <20200215002520.15746-1-paulmck@kernel.org>
 <20200217123851.GR14914@hirez.programming.kicks-ass.net>
 <20200217182302.GD112239@google.com>
 <CANpmjNPci1HwEdKB9=AsZ0+UJ9Wgk9Z7ATpUXyVpiJCqSGf_Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPci1HwEdKB9=AsZ0+UJ9Wgk9Z7ATpUXyVpiJCqSGf_Eg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 17, 2020 at 07:38:01PM +0100, Marco Elver wrote:
> On Mon, 17 Feb 2020 at 19:23, Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Mon, Feb 17, 2020 at 01:38:51PM +0100, Peter Zijlstra wrote:
> > > On Fri, Feb 14, 2020 at 04:25:18PM -0800, paulmck@kernel.org wrote:
> > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > >
> > > > The RCU tasks list of callbacks, rcu_tasks_cbs_head, is sampled locklessly
> > > > by rcu_tasks_kthread() when waiting for work to do.  This commit therefore
> > > > applies READ_ONCE() to that lockless sampling and WRITE_ONCE() to the
> > > > single potential store outside of rcu_tasks_kthread.
> > > >
> > > > This data race was reported by KCSAN.  Not appropriate for backporting
> > > > due to failure being unlikely.
> > >
> > > What failure is possible here? AFAICT this is (again) one of them
> > > load-complare-against-constant-discard patterns that are impossible to
> > > mess up.
> >
> > You mean that because we are only testing for NULL, so load/store tearing of
> > rcu_tasks_cbs_head is not an issue right?
> >
> > I agree. Even with invented stores, worst case we have a false-wakeup and go
> > right back to sleep. Or, we read a partial rcu_tasks_cbs_head, and then go
> > acquire the lock and read the whole thing correctly under lock.
> >
> > I wonder if we can teach KCSAN to actually ignore this kind of situation so
> > we don't need to employ READ_ONCE() for no reason. Basically ask it to not
> > bother if the read was only NULL-testing. +Marco since it is KCSAN related.
> 
> This came up before. It requires somehow making the compiler tell us
> what type of operation we're doing and in what context:
> https://lore.kernel.org/lkml/CANpmjNNZQsatHexXHm4dXvA0na6r9xMgVD5R+-8d7VXEBRi32w@mail.gmail.com/

Oh, wow. Ok.

> In particular:
> 
> > > This particular rule relies on semantic analysis that is beyond what
> > > the TSAN instrumentation currently supports. Right now we support GCC
> > > and Clang; changing the compiler probably means we'd end up with only
> > > one (probably Clang), and many more years before the change has
> > > propagated to the majority of used compiler versions. It'd be good if
> > > we can do this purely as a change in the kernel's codebase.
> 
> Load/store tearing might not be an issue, but we also have to be aware
> of things like load fusing, e.g. in a loop.

Ok. Makes sense.

> That being said, there may be ways to get similar results without yet
> changing the compiler.

Interesting. thanks!

- Joel


> Thanks,
> -- Marco
> 
> > thanks,
> >
> >  - Joel
> >
> >
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > ---
> > > >  kernel/rcu/update.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > > > index 6c4b862..a27df76 100644
> > > > --- a/kernel/rcu/update.c
> > > > +++ b/kernel/rcu/update.c
> > > > @@ -528,7 +528,7 @@ void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func)
> > > >     rhp->func = func;
> > > >     raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
> > > >     needwake = !rcu_tasks_cbs_head;
> > > > -   *rcu_tasks_cbs_tail = rhp;
> > > > +   WRITE_ONCE(*rcu_tasks_cbs_tail, rhp);
> > > >     rcu_tasks_cbs_tail = &rhp->next;
> > > >     raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
> > > >     /* We can't create the thread unless interrupts are enabled. */
> > > > @@ -658,7 +658,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
> > > >             /* If there were none, wait a bit and start over. */
> > > >             if (!list) {
> > > >                     wait_event_interruptible(rcu_tasks_cbs_wq,
> > > > -                                            rcu_tasks_cbs_head);
> > > > +                                            READ_ONCE(rcu_tasks_cbs_head));
> > > >                     if (!rcu_tasks_cbs_head) {
> > > >                             WARN_ON(signal_pending(current));
> > > >                             schedule_timeout_interruptible(HZ/10);
> > > > --
> > > > 2.9.5
> > > >
