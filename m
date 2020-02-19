Return-Path: <SRS0=W0OP=4H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C124C3404D
	for <rcu@archiver.kernel.org>; Wed, 19 Feb 2020 00:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D93424658
	for <rcu@archiver.kernel.org>; Wed, 19 Feb 2020 00:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582071401;
	bh=q8d6bMowdR3/X3NFByctGhiYj21CvwWmJenI2e7QtGE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=hqo9IfA+OK5Q4dQZ48uQlth2chbQzaIhX5EZhWfSxXJrWUTNL+xwWzaGyqFC1fUGK
	 VS6Dfa0EzprJHYgVXdcUf+fZItzNLHu5gTm8hSInLNnW0MCWeCe5CPAeNxsC7AM3tY
	 5xZw23/Ln8oy0Z05LAHxFtaH2ut6umG94360o4Kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgBSAQl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:16:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:55664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgBSAQl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Feb 2020 19:16:41 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36C2F24656;
        Wed, 19 Feb 2020 00:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582071400;
        bh=q8d6bMowdR3/X3NFByctGhiYj21CvwWmJenI2e7QtGE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uMnr8gEgC6TNTarUS/HBQim8Y/114l43sr66637H1i8gqjWrU/5cml4tYNG/osaLu
         GTas9R2yDJ5hfmw/uxlvQ15v9jjV8I9KQaDJA9Q27PpGP14aiCHbndhIBNeGbaK1hn
         +aYDZb6xHFAIkH439GfHdgNzlFW02dEyagGJ1hSo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0A9563520856; Tue, 18 Feb 2020 16:16:40 -0800 (PST)
Date:   Tue, 18 Feb 2020 16:16:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 1/3] rcu-tasks: *_ONCE() for
 rcu_tasks_cbs_head
Message-ID: <20200219001640.GP2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200215002520.15746-1-paulmck@kernel.org>
 <20200217123851.GR14914@hirez.programming.kicks-ass.net>
 <20200217181615.GP2935@paulmck-ThinkPad-P72>
 <20200218075648.GW14914@hirez.programming.kicks-ass.net>
 <20200218162719.GE2935@paulmck-ThinkPad-P72>
 <20200218201142.GF11457@worktop.programming.kicks-ass.net>
 <20200218202226.GJ2935@paulmck-ThinkPad-P72>
 <20200218174503.3d4e4750@gandalf.local.home>
 <20200218225455.GN2935@paulmck-ThinkPad-P72>
 <20200219000144.GA26663@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219000144.GA26663@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Feb 18, 2020 at 07:01:44PM -0500, Joel Fernandes wrote:
> On Tue, Feb 18, 2020 at 02:54:55PM -0800, Paul E. McKenney wrote:
> > On Tue, Feb 18, 2020 at 05:45:03PM -0500, Steven Rostedt wrote:
> > > On Tue, 18 Feb 2020 12:22:26 -0800
> > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > 
> > > > On Tue, Feb 18, 2020 at 09:11:42PM +0100, Peter Zijlstra wrote:
> > > > > On Tue, Feb 18, 2020 at 08:27:19AM -0800, Paul E. McKenney wrote:  
> > > > > > On Tue, Feb 18, 2020 at 08:56:48AM +0100, Peter Zijlstra wrote:  
> > > > >   
> > > > > > > I just took offence at the Changelog wording. It seems to suggest there
> > > > > > > actually is a problem, there is not.  
> > > > > > 
> > > > > > Quoting the changelog: "Not appropriate for backporting due to failure
> > > > > > being unlikely."  
> > > > > 
> > > > > That implies there is failure, however unlikely.
> > > > > 
> > > > > In this particular case there is absolutely no failure, except perhaps
> > > > > in KCSAN. This patch is a pure annotation such that KCSAN can understand
> > > > > the code.
> > > > > 
> > > > > Like said, I don't object to the actual patch, but I do think it is
> > > > > important to call out false negatives or to describe the actual problem
> > > > > found.  
> > > > 
> > > > I don't feel at all comfortable declaring that there is absolutely
> > > > no possibility of failure.
> > > 
> > > Perhaps wording it like so:
> > > 
> > > "There's know known issue with the current code, but the *_ONCE()
> > > annotations here makes KCSAN happy, allowing us to focus on KCSAN
> > > warnings that can help bring about known issues in other code that we
> > > can fix, without being distracted by KCSAN warnings that we do not see
> > > a problem with."
> > > 
> > > ?
> > 
> > That sounds more like something I might put in rcutodo.html as a statement
> > of the RCU approach to KCSAN reports.
> > 
> > But switching to a different situation (for variety, if nothing else),
> > what about the commit shown below?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 35bc02b04a041f32470ae6d959c549bcce8483db
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Tue Feb 18 13:41:02 2020 -0800
> > 
> >     rcutorture: Mark data-race potential for rcu_barrier() test statistics
> >     
> >     The n_barrier_successes, n_barrier_attempts, and
> >     n_rcu_torture_barrier_error variables are updated (without access
> >     markings) by the main rcu_barrier() test kthread, and accessed (also
> >     without access markings) by the rcu_torture_stats() kthread.  This of
> >     course can result in KCSAN complaints.
> >     
> >     Because the accesses are in diagnostic prints, this commit uses
> >     data_race() to excuse the diagnostic prints from the data race.  If this
> >     were to ever cause bogus statistics prints (for example, due to store
> >     tearing), any misleading information would be disambiguated by the
> >     presence or absence of an rcutorture splat.
> >     
> >     This data race was reported by KCSAN.  Not appropriate for backporting
> >     due to failure being unlikely and due to the mild consequences of the
> >     failure, namely a confusing rcutorture console message.
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index 5453bd5..b3301f3 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -1444,9 +1444,9 @@ rcu_torture_stats_print(void)
> >  		atomic_long_read(&n_rcu_torture_timers));
> >  	torture_onoff_stats();
> >  	pr_cont("barrier: %ld/%ld:%ld\n",
> > -		n_barrier_successes,
> > -		n_barrier_attempts,
> > -		n_rcu_torture_barrier_error);
> > +		data_race(n_barrier_successes),
> > +		data_race(n_barrier_attempts),
> > +		data_race(n_rcu_torture_barrier_error));
> 
> Would it be not worth just fixing the data-race within rcutorture itself?

I could use WRITE_ONCE() for updates and READ_ONCE() for statistics.
However, my current rule is that diagnostic code that is not participating
in the core synchronization uses data_race().  That way, if I do a typo
and write to (say) n_barrier_attempts in some other thread, KCSAN will
know to yell at me.

							Thanx, Paul
