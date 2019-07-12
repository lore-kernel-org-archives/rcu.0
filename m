Return-Path: <SRS0=P+IJ=VJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA83C742BD
	for <rcu@archiver.kernel.org>; Fri, 12 Jul 2019 13:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A472084B
	for <rcu@archiver.kernel.org>; Fri, 12 Jul 2019 13:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qgFQP1/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfGLNnO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Jul 2019 09:43:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39476 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfGLNnO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Jul 2019 09:43:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so348648pfn.6
        for <rcu@vger.kernel.org>; Fri, 12 Jul 2019 06:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dvwf5h5QheNfbAgZ15KkYPbUWiFiftC/9b/6E82GKtA=;
        b=qgFQP1/XvWXdvGQ0UVrwdQMLepBx+wCXYMQu3xo7zi/2/V5YeA3wOUEfqCCVRfNw3p
         o6Gqh4E2MWbXOZthselANaUI9bfG04UUG3kHvrVEDYb77WW1VFTPU3cV1kVI/48s2eAt
         vegLbPYXSJVu52lbaYEBI8lOA+9f4q92fHDz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dvwf5h5QheNfbAgZ15KkYPbUWiFiftC/9b/6E82GKtA=;
        b=XHAH+vM99Ag2Fl47dbKZnmSlzlAokeOQ5+lPrfmVPZxezxNg9iZDwrE41zaDocIq5r
         n+ahVdbi0sGjTDpKdY8xN8PdKhSTe7DIxe/lMtH7VXSBgrz2iFDr0j8WQjzdmdnRjKCF
         J4JpdR13ScLeTSmsE7Xjk6zE863dX6JE4b4R4unwDwYev9LNOihVBIs+H+rBLOGPassz
         hP6xYxx4vq3uCVcBINJS9ut2K/KsmQ3r6uDN/3v1JdhU2DPnfzQqjtkwynmB64BStPEf
         FYOBNlFGLw+u89HKI30QLfVS/nPAggmnVUBvi1XgYSoGTxJfmVX2fSVhzVwiYpOK3qdw
         zCcA==
X-Gm-Message-State: APjAAAVh0uNe+MwV+RTdycbOy8tuwceQ+jEB/ntf8QYtWtbr8fDhOVeA
        OkJkyHkVJPfDf6lPYFYbXF0=
X-Google-Smtp-Source: APXvYqyttS+EhdeWHy41kpYCkHqcfwOXBEX68JkxIMXiDyrl6XR78PzbQnwyrkKcVA47G4FlD+n8vw==
X-Received: by 2002:a17:90b:d8b:: with SMTP id bg11mr11915248pjb.30.1562938993722;
        Fri, 12 Jul 2019 06:43:13 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id i123sm14360138pfe.147.2019.07.12.06.43.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 06:43:12 -0700 (PDT)
Date:   Fri, 12 Jul 2019 09:43:11 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190712134311.GE92297@google.com>
References: <20190709124102.GR26519@linux.ibm.com>
 <20190710012025.GA20711@X58A-UD3R>
 <20190711123052.GI26519@linux.ibm.com>
 <20190711130849.GA212044@google.com>
 <20190711150215.GK26519@linux.ibm.com>
 <20190711164818.GA260447@google.com>
 <20190711195839.GA163275@google.com>
 <20190712063240.GD7702@X58A-UD3R>
 <20190712125116.GB92297@google.com>
 <20190712130242.GM26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712130242.GM26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jul 12, 2019 at 06:02:42AM -0700, Paul E. McKenney wrote:
> On Fri, Jul 12, 2019 at 08:51:16AM -0400, Joel Fernandes wrote:
> > On Fri, Jul 12, 2019 at 03:32:40PM +0900, Byungchul Park wrote:
> > > On Thu, Jul 11, 2019 at 03:58:39PM -0400, Joel Fernandes wrote:
> > > > Hmm, speaking of grace period durations, it seems to me the maximum grace
> > > > period ever is recorded in rcu_state.gp_max. However it is not read from
> > > > anywhere.
> > > > 
> > > > Any idea why it was added but not used?
> > > > 
> > > > I am interested in dumping this value just for fun, and seeing what I get.
> > > > 
> > > > I wonder also it is useful to dump it in rcutorture/rcuperf to find any
> > > > issues, or even expose it in sys/proc fs to see what worst case grace periods
> > > > look like.
> > > 
> > > Hi,
> > > 
> > > 	commit ae91aa0adb14dc33114d566feca2f7cb7a96b8b7
> > > 	rcu: Remove debugfs tracing
> > > 
> > > removed all debugfs tracing, gp_max also included.
> > > 
> > > And you sounds great. And even looks not that hard to add it like,
> > > 
> > > :)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index ad9dc86..86095ff 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -1658,8 +1658,10 @@ static void rcu_gp_cleanup(void)
> > >  	raw_spin_lock_irq_rcu_node(rnp);
> > >  	rcu_state.gp_end = jiffies;
> > >  	gp_duration = rcu_state.gp_end - rcu_state.gp_start;
> > > -	if (gp_duration > rcu_state.gp_max)
> > > +	if (gp_duration > rcu_state.gp_max) {
> > >  		rcu_state.gp_max = gp_duration;
> > > +		trace_rcu_grace_period(something something);
> > > +	}
> > 
> > Yes, that makes sense. But I think it is much better off as a readable value
> > from a virtual fs. The drawback of tracing for this sort of thing are:
> >  - Tracing will only catch it if tracing is on
> >  - Tracing data can be lost if too many events, then no one has a clue what
> >    the max gp time is.
> >  - The data is already available in rcu_state::gp_max so copying it into the
> >    trace buffer seems a bit pointless IMHO
> >  - It is a lot easier on ones eyes to process a single counter than process
> >    heaps of traces.
> > 
> > I think a minimal set of RCU counters exposed to /proc or /sys should not
> > hurt and could do more good than not. The scheduler already does this for
> > scheduler statistics. I have seen Peter complain a lot about new tracepoints
> > but not much (or never) about new statistics.
> > 
> > Tracing has its strengths but may not apply well here IMO. I think a counter
> > like this could be useful for tuning of things like the jiffies_*_sched_qs,
> > the stall timeouts and also any other RCU knobs. What do you think?
> 
> Is this one of those cases where eBPF is the answer, regardless of
> the question?  ;-)

It could be. Except that people who fancy busybox still could benefit from
the counter ;-)

And also, eBPF uses RCU itself heavily, so it would help if the debug related
counter itself didn't depend on it. ;-)

thanks,

- Joel

