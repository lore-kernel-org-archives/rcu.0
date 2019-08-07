Return-Path: <SRS0=3nIp=WD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679E3C433FF
	for <rcu@archiver.kernel.org>; Wed,  7 Aug 2019 00:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CE9216F4
	for <rcu@archiver.kernel.org>; Wed,  7 Aug 2019 00:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="j4Vr99Vv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfHGAQT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Aug 2019 20:16:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43719 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfHGAQT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Aug 2019 20:16:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so42404670pfg.10
        for <rcu@vger.kernel.org>; Tue, 06 Aug 2019 17:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FtC0cRwRFViRh+oC5nf5XGyHUrSjxKEafeh3vM76bEw=;
        b=j4Vr99Vv6CZvUbgT91mm0YEUm+f4ZqZ/T3CocdL2hXst5jQWyo0Ieu8bV4y39rCUwz
         YxCw1gJiJOB+LGQtrFNnDZ8pv7/Ju02bGoRFzInIQCdw0WpY4y2wqtnBPvdWGez41nms
         fvFx+iCNJTLuwzUEC9FOD6b9CneyeRaoRfBCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FtC0cRwRFViRh+oC5nf5XGyHUrSjxKEafeh3vM76bEw=;
        b=ifpUxRfoAEKGMCANZvwNLe4U/0S+NUvM7RIeZOrrwDnZ7S0GbtwqunzH2C8K/QtG+8
         Q762WkJ9lpo7wxyg00IIBk3r+9PIKxzmLSjTNDNkgV28IiwYovmCzG79FrbUwvyKkk18
         9BreLUjVtYiLOtio2AmSDB4QXZP/IgvGa56MD1+c2jX27T4vHlsi5KFTISqdp0YFCmCi
         l3VLfwBwI3ozM01ORfj7xhSG9LagyQ903NYyZUdq0qYsx/E2BF91PtIH/3TJ4xHO8XNs
         jZkRTDTscir92BG/7n+M0xbk9hSH9EQhxrzOtJiJ4canyJACvFm7JXdOGQlHcg0o1N6j
         OQvw==
X-Gm-Message-State: APjAAAVaKEyEgsMipZfelY4wBWntO+fQCx8WnoyPBflDn4Zi6EtMeY4m
        KK8+hUjvmkgZ+jfI8bIsZQRHxg==
X-Google-Smtp-Source: APXvYqxg2vwdH0pleZe2WK7OXcffptD3UyS+UFyV5uQel68e3DM8zJ5Xe0ekxy7mhWu2xjopO7KdWQ==
X-Received: by 2002:a65:430a:: with SMTP id j10mr5490648pgq.374.1565136978917;
        Tue, 06 Aug 2019 17:16:18 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a15sm122087675pfg.102.2019.08.06.17.16.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 17:16:17 -0700 (PDT)
Date:   Tue, 6 Aug 2019 20:16:16 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH RFC tip/core/rcu 02/14] rcu/nocb: Add bypass callback
 queueing
Message-ID: <20190807001616.GA169551@google.com>
References: <20190802151435.GA1081@linux.ibm.com>
 <20190802151501.13069-2-paulmck@linux.ibm.com>
 <20190807000313.GA161170@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807000313.GA161170@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 06, 2019 at 08:03:13PM -0400, Joel Fernandes wrote:
> On Fri, Aug 02, 2019 at 08:14:49AM -0700, Paul E. McKenney wrote:
> > Use of the rcu_data structure's segmented ->cblist for no-CBs CPUs
> > takes advantage of unrelated grace periods, thus reducing the memory
> > footprint in the face of floods of call_rcu() invocations.  However,
> > the ->cblist field is a more-complex rcu_segcblist structure which must
> > be protected via locking.  Even though there are only three entities
> > which can acquire this lock (the CPU invoking call_rcu(), the no-CBs
> > grace-period kthread, and the no-CBs callbacks kthread), the contention
> > on this lock is excessive under heavy stress.
> > 
> > This commit therefore greatly reduces contention by provisioning
> > an rcu_cblist structure field named ->nocb_bypass within the
> > rcu_data structure.  Each no-CBs CPU is permitted only a limited
> > number of enqueues onto the ->cblist per jiffy, controlled by a new
> > nocb_nobypass_lim_per_jiffy kernel boot parameter that defaults to
> > about 16 enqueues per millisecond (16 * 1000 / HZ).  When that limit is
> > exceeded, the CPU instead enqueues onto the new ->nocb_bypass.
> 
> Looks quite interesting. I am guessing the not-no-CB (regular) enqueues don't
> need to use the same technique because both enqueues / callback execution are
> happening on same CPU..
> 
> Still looking through patch but I understood the basic idea. Some nits below:
> 
> [snip]
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index 2c3e9068671c..e4df86db8137 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -200,18 +200,26 @@ struct rcu_data {
> >  	atomic_t nocb_lock_contended;	/* Contention experienced. */
> >  	int nocb_defer_wakeup;		/* Defer wakeup of nocb_kthread. */
> >  	struct timer_list nocb_timer;	/* Enforce finite deferral. */
> > +	unsigned long nocb_gp_adv_time;	/* Last call_rcu() CB adv (jiffies). */
> > +
> > +	/* The following fields are used by call_rcu, hence own cacheline. */
> > +	raw_spinlock_t nocb_bypass_lock ____cacheline_internodealigned_in_smp;
> > +	struct rcu_cblist nocb_bypass;	/* Lock-contention-bypass CB list. */
> > +	unsigned long nocb_bypass_first; /* Time (jiffies) of first enqueue. */
> > +	unsigned long nocb_nobypass_last; /* Last ->cblist enqueue (jiffies). */
> > +	int nocb_nobypass_count;	/* # ->cblist enqueues at ^^^ time. */
> 
> Can these and below fields be ifdef'd out if !CONFIG_RCU_NOCB_CPU so as to
> keep the size of struct smaller for benefit of systems that don't use NOCB?
> 
> 
> >  
> >  	/* The following fields are used by GP kthread, hence own cacheline. */
> >  	raw_spinlock_t nocb_gp_lock ____cacheline_internodealigned_in_smp;
> > -	bool nocb_gp_sleep;
> > -					/* Is the nocb GP thread asleep? */
> > +	struct timer_list nocb_bypass_timer; /* Force nocb_bypass flush. */
> > +	bool nocb_gp_sleep;		/* Is the nocb GP thread asleep? */
> 
> And these too, I think.

Please ignore this comment, I missed that these were already ifdef'd out
since it did not appear in the diff.

thanks!
