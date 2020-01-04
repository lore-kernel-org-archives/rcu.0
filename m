Return-Path: <SRS0=EP0b=2Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E278C00523
	for <rcu@archiver.kernel.org>; Sat,  4 Jan 2020 01:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5124217F4
	for <rcu@archiver.kernel.org>; Sat,  4 Jan 2020 01:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HY7Ol7oO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgADB4U (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 3 Jan 2020 20:56:20 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:37771 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgADB4U (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 3 Jan 2020 20:56:20 -0500
Received: by mail-pl1-f176.google.com with SMTP id c23so19643889plz.4
        for <rcu@vger.kernel.org>; Fri, 03 Jan 2020 17:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n7ymJJTP7ZnNgTCYCcBXtIb2+Q1m1j4aPbbyfZsIBwQ=;
        b=HY7Ol7oOtYhSodooo3VYM/KakAMY+VSYFJYxjSsFJzg3PUcWR07kBGNIbcqhPEGYVS
         bwExpMmRxbmA1LdVNAGnqaNe9JMROsRfcITFhMplXwPRZaRAvkeo5d8NzCdgtxuciGbn
         TzrUB68rwnSXolNZmbjasrVNCeIaKGBWQ611E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n7ymJJTP7ZnNgTCYCcBXtIb2+Q1m1j4aPbbyfZsIBwQ=;
        b=F6eeGAyfcn7007XtSZHu7gt2/oxjNfMNePf2fV105521kVIzv7K0T55ltD7EjpnsPe
         goamSLvG/YGR0E7GOAAlMVslLITBJk/K+w/HchFkd+SSGw5u2hOgLhJFORsJL/6358nv
         5Pr20IN9U8UCs1RspsdVxm9TxBpSbCFqkZ62BInVF+cYWNx62zAP0t9Rh0hJvdj1AKrl
         DvBSgWzPQP1NQLNqUm/DBL9OMaTfEKe6pkTHFubI6eb4sQ1Th+zHBqUCpkas6qLIpoPj
         vvlt/3qC8I4iq9LW5aVSWH8FCGlaeRFdBPcXmn81w7oEUE/8IjT/Y2Yu/NHv6TzYl3ul
         vXAg==
X-Gm-Message-State: APjAAAVGxZ+nU1gU+6I7nRbMHq7i8ms1F5zdCtwj5RJuYlcfSELrKLQv
        yW7cWF9I2LdqzHLzeoe9vg9Mwg==
X-Google-Smtp-Source: APXvYqwyd7s62p2xkMXd34JAVbIubNyw1F5Fg9zKzVQLLPmADBvux+GT1lX07hgyXm9ixLb2IM8oSw==
X-Received: by 2002:a17:902:8649:: with SMTP id y9mr95293169plt.67.1578102979013;
        Fri, 03 Jan 2020 17:56:19 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z13sm16180837pjz.15.2020.01.03.17.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 17:56:18 -0800 (PST)
Date:   Fri, 3 Jan 2020 20:56:17 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zilstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        Amol Grover <frextrite@gmail.com>
Subject: Re: RCU ideas discussed at LPC
Message-ID: <20200104015617.GK189259@google.com>
References: <CAEXW_YTyxm7QZwFV7KYpN2Sds=SDYqOvZ4+qfWL1_Kwx48Dusg@mail.gmail.com>
 <20191226010532.GP13449@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226010532.GP13449@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 25, 2019 at 05:05:32PM -0800, Paul E. McKenney wrote:
> On Wed, Dec 25, 2019 at 05:41:04PM -0500, Joel Fernandes wrote:
> > Hi Paul,
> > We were discussing some ideas on facebook so I wanted to just post
> > them here as well. This is in the context of the RCU section of RT MC
> > https://www.youtube.com/watch?v=bpyFQJV5gCI
> > 
> > Detecting high kfree_rcu() load
> > ----------
> > You mentioned about this. As I understand it, we did the kfree_rcu()
> > batching to let the system not do anything RCU related until a batch
> > has filled up enough or a timeout has occurred. This makes the GP
> > thread and the system do less work.
> > The problem you are raising in our facebook thread is, that during
> > heavy load the "batch" can be large and be dumped into call_rcu()
> > eventually. Wouldn't this be better handled generically within
> > call_rcu() itself, for the benefit of other non-kfree_rcu workloads?
> > That is if a large number of callbacks is dumped, then try to end the
> > GP more quickly. This likely doesn't need a signal from kfree_rcu()
> > since call_rcu() knows that it is being hammered.
> 
> Except that call_rcu() currently has no idea how many parcels of memory
> a given request from kfree_rcu() represents.

True. At the moment, neither does kfree_rcu() since we store only the
pointer. We could consult the low level allocator if they have this
information. If you could let me know how to make RCU more aggressive in this
case (once we know there's a problem), I could work on something like this. I
did have OOM issues in earlier versions of the kfree_rcu() patch. I could
boot a system with less memory and OOM it too with the tests even now.

> > Detecting recursive call_rcu() within call_rcu()
> > ---------
> > We could use a per-cpu variable to detect a scenario like this, though
> > I am not sure if preemption during call_rcu() itself would cause false
> > positives.
> 
> A call_rcu() from within an RCU callback function is legal and is
> sometimes done.  Or are you thinking of a call_rcu() from an interrupt
> handler interrupting another call_rcu()?

Oh, did not know this. I thought this was the point heavily discussed in the
LPC talk but must have misunderstood when you said you hoped no one was
precisely doing this..

> > All rcuogp and rcuop threads tied to a house keeping CPU
> > ---
> > In LPC you mentioned about the problem of OOM if all rcuo* threads
> > including the GP one are not able to keep up with heavy load. On
> > Facebook I had proposed something like this: What about making the
> > affinity setting to be a "soft affinity", that is respect it always
> > expect in the uncommon case. In the uncommon case of heavy load, let
> > the threads run wherever to prevent OOM. Sure that might make the
> > system a little more disruptive, but if we are approaching OOM we have
> > bigger problems right?
> 
> The problem is that there are a rather large number of ways to force
> a given kthread to execute only on a given CPU, and reverse-engineering
> all that within call_rcu() isn't reasonable.  An alternative is to
> disable offloading, wait for the offloaded callbacks to drain, then
> start up the usual softirq approach (or per-CPU kthread, as the case
> may be).  This self-throttles because whatever is generating callbacks
> gets preempted by softirq invocation.

Ok, agreed. Did you already implement the "disable offloading" code?

> > ---------
> > How about doing this kind of call_rcu() to synchronize_rcu()
> > transition automatically if the context allows it? I.e. Detect the
> > context and if sleeping is allowed, then wait for the grace period
> > synchronously in call_rcu(). Not sure about deadlocks and the like
> > from this kind of waiting and have to think more.
> 
> This gets rather strange in a production PREEMPT=n build, so not a
> fan, actually.  And in real-time systems, I pretty much have to splat
> anyway if I slow down call_rcu() by that much.
> 
> So the preference is instead detecting such misconfiguration and issuing
> appropriate diagnostics.  And making RCU more able to keep up when not
> grossly misconfigured, hence the kfree_rcu() memory footprint being
> fed into core RCU.

Ok. Is it not Ok to simply assume that a large number of callbacks queued
along with observing high memory pressure, means RCU should be more
aggressive anyway since whatever memory can be freed by invoking callbacks
should be helpful anyway? Or were you thinking making RCU aggressive when
there's a lot of memory pressure is not worth it, without knowing that RCU is
the cause for it?

> > is square root of N number of rcuogp0 threads - the right optimization?
> 
> If there were enough CPUs, it would be necessary to have three levels
> of hierarchy and to go to the cube root, but that would be more CPUs
> than I have seen used.
> > ---------
> > The question raised was can we do with fewer threads, or even just
> > one? You mentioned the square root might not be the right choice. How
> > do we test how well the system is doing. Are you running rcutorture
> > with a certain tree configuration and monitor memory footprint /
> > performance?
> 
> The issue prompting the hierarcy was wakeup overhead on the grace-period
> kthread.  Going to a hierarchy reduced the load on that single thread
> (which could otherwise become a bottleneck on large systems, and also
> reduced the absolute number of wakeups by up to almost a factor of two.
> Deepening the hierarchy would further reduce the wakeup load on the
> grace-period kthread, but would increase the total number of wakeups.
> 
> So this is not a matter of tweaks and optimizations.  I would need to
> see some horrible problem with the current setup to even consider
> making a change.

Ok, I only raised this because in the LPC talk you mentioned that you are not
sure if this is the right optimization. But I understand the rationale for
choosing some hierarchy in light of the wakeup performance improvements (I
already knew that this is why you had a hierarchy).

> > BTW, I have 2 interns working on RCU (Amol and Madupharna also on CC).
> > They were selected among several others as a part of the
> > LinuxFoundation mentorship program. They are familiar with RCU. I have
> > asked them to look at some RCU-list work and RCU sparse work. However,
> > I can also have them look into a few other things as time permits and
> > depending on what interests them.
> 
> Dog paddling before cliff diving, please!  ;-)

Sure. They are working on relatively simpler things for their internship but
I just put these ideas out there with them on CC so they can pick something
else as well if they have time and interest ;-)

> > Thanks, Merry Christmas!
> 
> And to you and yours as well!

Hope you had a good holiday season!

thanks,

 - Joel

