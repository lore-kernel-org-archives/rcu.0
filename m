Return-Path: <SRS0=vvc8=3I=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ED4C33CAF
	for <rcu@archiver.kernel.org>; Sun, 19 Jan 2020 05:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7199B2072B
	for <rcu@archiver.kernel.org>; Sun, 19 Jan 2020 05:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579412966;
	bh=fNXuiOvTvps+28eGaw/37aOtI/N3ocD96xqPoPCMa6E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=kikFjvfZB9bCupc6wJ5je7j6l26xXrVulSrwIvTemiqwya2AldmIlgeud53thRAUx
	 p1q0FE3sU347D0OGzurySTujKNqD94rOPv77K25HJX/W8A3nS6+NI26NlNEFLDhNab
	 TZ+ng10hlyN9wdi7olvgrIob1MabcVQhIQGCVpo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgASFt0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 19 Jan 2020 00:49:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgASFt0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 19 Jan 2020 00:49:26 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B373B2071C;
        Sun, 19 Jan 2020 05:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579412964;
        bh=fNXuiOvTvps+28eGaw/37aOtI/N3ocD96xqPoPCMa6E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=klxXU6DsiMtNkXW+Q/zB5fqualOvcuHYfpsGoNktJPQ1rtlNbYJRnaFzqM90+vuNx
         dO+tQsisM19edSZ+RgokdQhbO3bvc+64Xz7xdQ3Cselg2uBBBHPQOTs7QlGomvuoJt
         Hrub28w1cQ3zHv7MmHqrYRJqKfSDYsXGqcN4oplU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8451B35227B9; Sat, 18 Jan 2020 21:49:24 -0800 (PST)
Date:   Sat, 18 Jan 2020 21:49:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rostedt@goodmis.org, bristot@redhat.com
Subject: Re: RCU_BOOST not working for me
Message-ID: <20200119054924.GA2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200117215814.GB206250@google.com>
 <20200117221804.GA211665@google.com>
 <20200117231756.GO2935@paulmck-ThinkPad-P72>
 <20200118023434.GB244899@google.com>
 <20200118043458.GT2935@paulmck-ThinkPad-P72>
 <20200118201937.GD244899@google.com>
 <20200118224708.GY2935@paulmck-ThinkPad-P72>
 <20200119015812.GF244899@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119015812.GF244899@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jan 18, 2020 at 08:58:12PM -0500, Joel Fernandes wrote:
> On Sat, Jan 18, 2020 at 02:47:08PM -0800, Paul E. McKenney wrote:
> > On Sat, Jan 18, 2020 at 03:19:37PM -0500, Joel Fernandes wrote:
> > > On Fri, Jan 17, 2020 at 08:34:58PM -0800, Paul E. McKenney wrote:
> > > > On Fri, Jan 17, 2020 at 09:34:34PM -0500, Joel Fernandes wrote:
> > > > > On Fri, Jan 17, 2020 at 03:17:56PM -0800, Paul E. McKenney wrote:
> > > > > [...] 
> > > > > > But rcutorture already has tests for RCU priority boosting.  Or are those
> > > > > > failing in some way?
> > > > > 
> > > > > Yes there are tests, but I thought of just a simple experiment to study this.
> > > > > Purely since it is existing RCU kernel code that I'd like to understand. And
> > > > > me/Daniel are also looking into possibly using run-time / trace-based
> > > > > verification some of these behaviors.
> > > > 
> > > > The functionality of rcu_state.cbovld should make that more entertaining.
> > > > 
> > > > But I would guess that the initial model would ignore memory footprint
> > > > and just model RCU priority boosting as kicking in a fixed time after
> > > > the beginning of the grace period.
> > > > 
> > > > Or do you guys have something else in mind?
> > > 
> > > Yes, that is the idea. And then turn the model into a unit test (for the
> > > measurement). Though I am also personally trying to convince myself that a
> > > unit test based on a model is better than the test in the kernel module I
> > > just posted. We're just looking at applying Daniel's modeling work to
> > > verification of behaviors like these.
> > > 
> > > A poor-man's alternative of a model-based test is just making sure that
> > > synchronize_rcu() finishes in a bounded period of time (basically test by
> > > observation than test by model) similar to what my kernel module did.  But I
> > > guess a model based test would be more accurate and more strict about what is
> > > considered a pass vs fail.
> > 
> > In one sense, fair enough.
> > 
> > But in a more practical sense, why would anyone put synchronize_rcu()
> > anywhere near their real-time fastpaths?  Even synchronize_rcu_expedited()
> > would be a rather brave choice for such a fastpath.
> 
> Oh, I was just talking in the context of a unit test for boost, such as the
> one I wrote. By measuring synchronize_rcu() time in the previous test I
> wrote, we can get a sense of if the BOOST worked or not. Since the point of
> BOOST is to shorten the otherwise lengthy grace period.

OK, agreed, for testing this makes much more sense.  ;-)

> > > I was also studying SRCU and could not find tracepoints so I am thinking of
> > > adding some to aid the study. I know for Tree-SRCU you are using timers and
> > > workqueues but the concept hasn't largely changed since [1] was written
> > > right?
> > 
> > At one point I had tracepoints for SRCU on my list, but the discussions
> > of tracepoints possibly being user API scared me off.
> 
> I find it hard to imagine why any sane userspace tooling would want to depend
> on RCU tracepoints. If they are just debug scripts like the one we've been
> thinking of writing, then that's fine.
> 
> The latest on "tracepoints as user API" that I learnt from last conferences
> is, if a tracepoint is so popular that userspace tools are using it and known
> to use it, then that because ABI/API. If they are not used or unpopular, then
> they are not so much as API. I believe the existing RCU tracepoints already
> there, haven't shown to be an issue so may be it is Ok for RCU?

Still, caution seems warranted, at least until the code accumulates
a bit more time.

> > SRCU has been rewritten from scratch something like three times since
> > that article was published.  The current version is only a few years old.
> > And there is some motivation for more modifications due to the size of
> > the srcu_struct structure.  (Maybe dynamically allocating the srcu_node
> > array or some such, though this is not free of hazard and hassle, either.)
> > Thus far, all complaints about the large size have been handled by other
> > means, but there have been several such complaints.  In addition, the
> > use of workqueues is still a bit on the experimental side.  Looking good
> > thus far, but the code is yet young.
> > 
> > But yes, had the code remained unchanged for 14 years, there wouldn't
> > be much downside to adding tracepoints.  But the code is less than three
> > years old.
> 
> Interesting! Thanks for the history.

History I can provide in abundance.  ;-)

							Thanx, Paul
