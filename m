Return-Path: <SRS0=UQpt=3H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380BDC32771
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 22:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09082246AB
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 22:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579387630;
	bh=Ylbsl9ryALxbj2lr452htNV6kBm+rNvgV4VX6DHdvP8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=HHRJfaxQbLOxVklVN9T/Gtb+P4UNsQDx7M2snarOpaxJJBvyFM6YtsA86pGlmXY9j
	 ovPd7AnR4c+ispP9dY5M/FgQ1W4IZzvJ7HCQ0FCL9w5uKeyaWPnsEyG+UUv44ZarNj
	 kS7u4uYpa/oY33AVzv3JiFN3Q6mHvCYuqnMpVARo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgARWrJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 18 Jan 2020 17:47:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbgARWrJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 18 Jan 2020 17:47:09 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6D22246AA;
        Sat, 18 Jan 2020 22:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579387628;
        bh=Ylbsl9ryALxbj2lr452htNV6kBm+rNvgV4VX6DHdvP8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iQ4bGRHjUM6di1wC0FVUScscsYvKoBIEKnI4AcndII1B+PpVTa2e6av8PqDKtPuqE
         3Ojy4Uf3bfurTNXFC8c7x2CcPDYb+PE59e2tXPtpIG4pBF9E1LcmJOTedHeG+ditsl
         jYu/FS8QP9Zu4VH4zHHkAExOOELbXsjc2gh37amE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AFEB335227D6; Sat, 18 Jan 2020 14:47:08 -0800 (PST)
Date:   Sat, 18 Jan 2020 14:47:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rostedt@goodmis.org, bristot@redhat.com
Subject: Re: RCU_BOOST not working for me
Message-ID: <20200118224708.GY2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200117215814.GB206250@google.com>
 <20200117221804.GA211665@google.com>
 <20200117231756.GO2935@paulmck-ThinkPad-P72>
 <20200118023434.GB244899@google.com>
 <20200118043458.GT2935@paulmck-ThinkPad-P72>
 <20200118201937.GD244899@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118201937.GD244899@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jan 18, 2020 at 03:19:37PM -0500, Joel Fernandes wrote:
> On Fri, Jan 17, 2020 at 08:34:58PM -0800, Paul E. McKenney wrote:
> > On Fri, Jan 17, 2020 at 09:34:34PM -0500, Joel Fernandes wrote:
> > > On Fri, Jan 17, 2020 at 03:17:56PM -0800, Paul E. McKenney wrote:
> > > [...] 
> > > > But rcutorture already has tests for RCU priority boosting.  Or are those
> > > > failing in some way?
> > > 
> > > Yes there are tests, but I thought of just a simple experiment to study this.
> > > Purely since it is existing RCU kernel code that I'd like to understand. And
> > > me/Daniel are also looking into possibly using run-time / trace-based
> > > verification some of these behaviors.
> > 
> > The functionality of rcu_state.cbovld should make that more entertaining.
> > 
> > But I would guess that the initial model would ignore memory footprint
> > and just model RCU priority boosting as kicking in a fixed time after
> > the beginning of the grace period.
> > 
> > Or do you guys have something else in mind?
> 
> Yes, that is the idea. And then turn the model into a unit test (for the
> measurement). Though I am also personally trying to convince myself that a
> unit test based on a model is better than the test in the kernel module I
> just posted. We're just looking at applying Daniel's modeling work to
> verification of behaviors like these.
> 
> A poor-man's alternative of a model-based test is just making sure that
> synchronize_rcu() finishes in a bounded period of time (basically test by
> observation than test by model) similar to what my kernel module did.  But I
> guess a model based test would be more accurate and more strict about what is
> considered a pass vs fail.

In one sense, fair enough.

But in a more practical sense, why would anyone put synchronize_rcu()
anywhere near their real-time fastpaths?  Even synchronize_rcu_expedited()
would be a rather brave choice for such a fastpath.

> I was also studying SRCU and could not find tracepoints so I am thinking of
> adding some to aid the study. I know for Tree-SRCU you are using timers and
> workqueues but the concept hasn't largely changed since [1] was written
> right?

At one point I had tracepoints for SRCU on my list, but the discussions
of tracepoints possibly being user API scared me off.

> [1] https://lwn.net/Articles/202847/

SRCU has been rewritten from scratch something like three times since
that article was published.  The current version is only a few years old.
And there is some motivation for more modifications due to the size of
the srcu_struct structure.  (Maybe dynamically allocating the srcu_node
array or some such, though this is not free of hazard and hassle, either.)
Thus far, all complaints about the large size have been handled by other
means, but there have been several such complaints.  In addition, the
use of workqueues is still a bit on the experimental side.  Looking good
thus far, but the code is yet young.

But yes, had the code remained unchanged for 14 years, there wouldn't
be much downside to adding tracepoints.  But the code is less than three
years old.

							Thanx, Paul

> thanks!
> 
>  - Joel
> 
> > 							Thanx, Paul
> > 
> > PS.  Steve, yes, I do well remember our earlier discussions about readers
> >      inheriting priority from the highest-priority synchronize_rcu().  ;-)
