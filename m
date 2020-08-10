Return-Path: <SRS0=7B7l=BU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304F7C433E4
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 19:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE5C72080C
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 19:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="TQhmmfhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgHJT0E (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbgHJTZ4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 10 Aug 2020 15:25:56 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EC8C061788
        for <rcu@vger.kernel.org>; Mon, 10 Aug 2020 12:25:56 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id l13so4802144qvt.10
        for <rcu@vger.kernel.org>; Mon, 10 Aug 2020 12:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6NK05E7+a+qY74gt/Y7cgaAf4SZZd8DleX0uQk2zvrs=;
        b=TQhmmfhVaS669gpgbmJwtN8zKhBJrHFRetxkFoyMGpTXDsCSiIj8FIUKwG18hC6REk
         WGkNqZPxoSQOlx3g1CzHmp/CUGmIZDygfWfvPr8Rz1zQkzZISdn9BfkM0PFqGcRHQyCG
         OurWHcPnB0OF7wRSEFPzecRXkd7EV5+xWLNw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6NK05E7+a+qY74gt/Y7cgaAf4SZZd8DleX0uQk2zvrs=;
        b=kBruRFoWizlJnxQ3MaGrnqwrREjSaZNy0nx5Y+1/xYwdWa+PJmaszL+PKOZ41pJGGN
         69wQ3DHjZ9eU9lu/qBW/4M9Ck+kE2TaMXeuoK8vE5HciOY/Wa8YIdulu+jyQ3YplpH/j
         n5H+OM/FUsCMZ2aROVDzqpjlVSvnVZ5dEB5hUTKcbsM++Jac2rLeBmy7sG2lZVIflrMD
         C5qei14CtryG8inXTtaozW3hR5SUTZdngVzmwg1tTLIfhl+AcTwIlISW9O4lOUQTG+Y2
         FvKWPwLi/sXjraNcpQuDmGLufvc0LTIanw4NYVtW8igpPYloNwLnFl8OsLs4JDnXXrwI
         5MPA==
X-Gm-Message-State: AOAM5324VKFAB5qOglSsZj9kGtL2u0ae03L/hTAeBcnEW0MPnPXpvgCb
        qK+n8SDvxKzx+GI340szew11ag==
X-Google-Smtp-Source: ABdhPJx/vyIwl+B3fOFDD/Vgmeqhfn1LxXfLfu/hHAOEA9OP+Z6H4TYDhWBp1/KSnU/UR2uNvK+NIA==
X-Received: by 2002:ad4:54c6:: with SMTP id j6mr30088230qvx.126.1597087555155;
        Mon, 10 Aug 2020 12:25:55 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id 128sm14479207qkk.101.2020.08.10.12.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 12:25:54 -0700 (PDT)
Date:   Mon, 10 Aug 2020 15:25:54 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        peterz@infradead.org, Randy Dunlap <rdunlap@infradead.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, vineethrp@gmail.com
Subject: Re: [PATCH v4 1/5] rcu/tree: Add a warning if CPU being onlined did
 not report QS already
Message-ID: <20200810192554.GD2865655@google.com>
References: <20200807170722.2897328-1-joel@joelfernandes.org>
 <20200807170722.2897328-2-joel@joelfernandes.org>
 <20200810154654.GJ4295@paulmck-ThinkPad-P72>
 <20200810173931.GB2253395@google.com>
 <20200810175717.GM4295@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810175717.GM4295@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 10, 2020 at 10:57:17AM -0700, Paul E. McKenney wrote:
> On Mon, Aug 10, 2020 at 01:39:31PM -0400, Joel Fernandes wrote:
> > On Mon, Aug 10, 2020 at 08:46:54AM -0700, Paul E. McKenney wrote:
> > > On Fri, Aug 07, 2020 at 01:07:18PM -0400, Joel Fernandes (Google) wrote:
> > > > Currently, rcu_cpu_starting() checks to see if the RCU core expects a
> > > > quiescent state from the incoming CPU.  However, the current interaction
> > > > between RCU quiescent-state reporting and CPU-hotplug operations should
> > > > mean that the incoming CPU never needs to report a quiescent state.
> > > > First, the outgoing CPU reports a quiescent state if needed.  Second,
> > > > the race where the CPU is leaving just as RCU is initializing a new
> > > > grace period is handled by an explicit check for this condition.  Third,
> > > > the CPU's leaf rcu_node structure's ->lock serializes these checks.
> > > > 
> > > > This means that if rcu_cpu_starting() ever feels the need to report
> > > > a quiescent state, then there is a bug somewhere in the CPU hotplug
> > > > code or the RCU grace-period handling code.  This commit therefore
> > > > adds a WARN_ON_ONCE() to bring that bug to everyone's attention.
> > > > 
> > > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > > Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> > > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > >  kernel/rcu/tree.c | 9 ++++++++-
> > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 65e1b5e92319..a49fa3b60faa 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3996,7 +3996,14 @@ void rcu_cpu_starting(unsigned int cpu)
> > > >  	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
> > > >  	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
> > > >  	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
> > > > -	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
> > > > +
> > > > +	/*
> > > > +	 * XXX: The following rcu_report_qs_rnp() is redundant. If the below
> > > > +	 * warning does not fire, consider replacing it with the "else" block,
> > > > +	 * by June 2021 or so (while keeping the warning). Refer to RCU's
> > > > +	 * Requirements documentation for the rationale.
> > > 
> > > Let's suppose that this change is made, and further that in a year or
> > > two the "if" statement below is replaced with its "else" block.
> > > 
> > > Now let's suppose that (some years after that) a hard-to-trigger bug
> > > makes its way into RCU's CPU-hotplug code that would have resulted in
> > > the WARN_ON_ONCE() triggering, but that this bug turns out to be not so
> > > hard to trigger in certain large production environments.
> > > 
> > > Let's suppose further that you have moved on to where you are responsible
> > > for one of these large production environments.  How would this
> > > hypothetical RCU/CPU-hotplug bug manifest?
> > 
> > It could manifest as an RCU stall (after the warning triggers) since RCU
> > would wait forever.
> > 
> > Were you thinking it is not worth doing this? I thought we wanted to remove
> > the reundant rcu_report_qs_rnp here to solidify everyone's understanding of
> > the code and fail early if there's something misunderstood (since such
> > misunderstanding could mean there are other hidden bugs somewhere). The
> > counter-argument to that being, making the code robust is more important for
> > the large production failure scenario where failures are costly.
> 
> The benefits of removing code that is in theory redundant was my thought
> at one point, but sleeping on this several times since has made me much
> less favorable to this change.  And perhaps my experiences with my new
> employer have affected my views on this as well.  You never know!  ;-)

Can we just keep the warning then, and delete the comments to revisit?

IMHO a comment saying this rcu_report_qs_rnp() is not necessary here but is
done anyway, would be quite useful to a code reader, (with appropriate
comments to point to RCU requirements section and the added warning) :-)

thanks,

 - Joel

> 
> 							Thanx, Paul
> 
> > thanks,
> > 
> >  - Joel
> > 
> > 
> > > 							Thanx, Paul
> > > 
> > > > +	 */
> > > > +	if (WARN_ON_ONCE(rnp->qsmask & mask)) { /* RCU waiting on incoming CPU? */
> > > >  		rcu_disable_urgency_upon_qs(rdp);
> > > >  		/* Report QS -after- changing ->qsmaskinitnext! */
> > > >  		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
> > > > -- 
> > > > 2.28.0.236.gb10cc79966-goog
> > > > 
