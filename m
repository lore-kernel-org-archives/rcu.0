Return-Path: <SRS0=7B7l=BU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8C7C433E0
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 17:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D97FC207DA
	for <rcu@archiver.kernel.org>; Mon, 10 Aug 2020 17:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fhfrPCq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgHJRly (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 10 Aug 2020 13:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbgHJRly (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 10 Aug 2020 13:41:54 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2A2C061788
        for <rcu@vger.kernel.org>; Mon, 10 Aug 2020 10:41:53 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 2so9107279qkf.10
        for <rcu@vger.kernel.org>; Mon, 10 Aug 2020 10:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZgxUTpC3twfhDgLxDpKH9wmzW30NoIG84L3Ndjm0dhw=;
        b=fhfrPCq0VVBvEn4w+fHNzuo9aiElAafeASu/UEjct9hKGqgabShPFbYIcWRbQuLU/w
         VEHBsfM6ComEV1m62Xtn3WbWZFl4O1F4CLcN+8DPBdZRUdXEP4gdWxwf4ZYagl/4casz
         t+NE9CODfJLwOroS7qijjWFiBjd2DjfFX+saQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZgxUTpC3twfhDgLxDpKH9wmzW30NoIG84L3Ndjm0dhw=;
        b=MnCjk/PYmBO8SADNdjuFB6T6UN4c5u8jtQtdR2w6puyaVrxOoT0hSEEPDG+6D1zEBc
         WNsjC73fmm45K6WMeFBg/FPVvSjOpxFOzIB2HaqSaYRMQjPepQfVh/xOp/8EffH/jqCN
         hGvTfkjPp1hUAGtHGtG1q6H+UM3kMO2FvavMkMze8F3vfH9j81n9IM3IZGsJn0MN+0Nk
         B4CHXWkRh7BGVomuoPf8YzL2a53GTST2I41Dhvsv6Vjjq4clCrOpM8vbdSDf9tRvNWCo
         rcqeSHjkOzd2CUrk55AhcirxSDrzgolatl+TpW64KiJKi5T1YhCQfxjMiQYECTuG8mEA
         r5oA==
X-Gm-Message-State: AOAM531XTzl01hpPKCAWJjnVHTbcr8g4e87w3TFnNyq6XWKJ8kmZLj+p
        bDqkxuUxjnFBe8I8e9BIhtMfNg==
X-Google-Smtp-Source: ABdhPJwT6hEOLcCL1aSm6xou0TMMwI8u550PCMYSuiGAlPRLCiuycGNYyxUhupGBpDcbP7ZhV34yow==
X-Received: by 2002:a37:a746:: with SMTP id q67mr27689424qke.93.1597081312083;
        Mon, 10 Aug 2020 10:41:52 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id z197sm14857700qkb.66.2020.08.10.10.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 10:41:51 -0700 (PDT)
Date:   Mon, 10 Aug 2020 13:41:51 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        neeraju@codeaurora.org, "Paul E. McKenney" <paulmck@kernel.org>,
        peterz@infradead.org, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        vineethrp@gmail.com
Subject: Re: [PATCH v4 5/5] docs: Update RCU's hotplug requirements with a
 bit about design
Message-ID: <20200810174151.GC2253395@google.com>
References: <20200807170722.2897328-1-joel@joelfernandes.org>
 <20200807170722.2897328-6-joel@joelfernandes.org>
 <4b8646fd-7644-bd8a-54ad-d0cb80b04317@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b8646fd-7644-bd8a-54ad-d0cb80b04317@infradead.org>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 07, 2020 at 07:10:38PM -0700, Randy Dunlap wrote:
> Hi--
> 
> On 8/7/20 10:07 AM, Joel Fernandes (Google) wrote:
> > RCU's hotplug design will help understand the requirements an RCU
> > implementation needs to fullfill, such as dead-lock avoidance.
> > 
> > The rcu_barrier() section of the "Hotplug CPU" section already talks
> > about deadlocks, however the description of what else can deadlock other
> > than rcu_barrier is rather incomplete.
> > 
> > This commit therefore continues the section by describing how RCU's
> > design handles CPU hotplug in a deadlock-free way.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thank you Randy for pointing these out. I will fix the nits in the next revision.

Regards,

 - Joel


> >  .../RCU/Design/Requirements/Requirements.rst  | 22 +++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> > index 16c64a2eff93..0a4148b9f743 100644
> > --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> > +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> > @@ -1940,6 +1940,28 @@ deadlock. Furthermore, ``rcu_barrier()`` blocks CPU-hotplug operations
> >  during its execution, which results in another type of deadlock when
> >  invoked from a CPU-hotplug notifier.
> >  
> > +Also, RCU's implementation avoids serious deadlocks which could occur due to
> > +interaction between hotplug, timers and grace period processing. It does so by
> > +maintaining its own bookkeeping of every CPU's hotplug state, independent of
> > +the various CPU masks and by reporting quiescent states at explicit points.  It
> > +may come across as a surprise, but the force quiescent state loop (FQS) does
> > +not report quiescent states for offline CPUs and is not required to.
> > +
> > +For an offline CPU, the quiescent state will be reported in either of:
> > +1. During CPU offlining, using RCU's hotplug notifier (``rcu_report_dead()``).
> 
>                         note, uses (), which is good:                      ()
> 
> > +2. During grace period initialization (``rcu_gp_init``) if it detected a race
> 
>       add for consistency & readability:    rcu_gp_init()
> 
> > +   with CPU offlining, or a race with a task unblocking on a node which
> > +   previously had all of its CPUs offlined.
> > +
> > +The CPU onlining path (``rcu_cpu_starting``) does not need to a report
> 
>       ditto:                rcu_cpu_starting()
> 
> > +quiescent state for an offline CPU in fact it would trigger a warning if a
> 
> Missing something; maybe like so:
> 
>                    for an offline CPU; in fact
> 
> > +quiescent state was not already reported for that CPU.
> > +
> > +During the checking/modification of RCU's hotplug bookkeeping, the
> > +corresponding CPU's leaf node lock is held. This avoids race conditions between
> > +RCU's hotplug notifier hooks, grace period initialization code and the FQS loop
> > +which can concurrently refer to or modify the bookkeeping.
> > +
> >  Scheduler and RCU
> >  ~~~~~~~~~~~~~~~~~
> >  
> > 
> 
> cheers.
> -- 
> ~Randy
> 
