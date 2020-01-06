Return-Path: <SRS0=5w8b=23=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE81BC33C8C
	for <rcu@archiver.kernel.org>; Mon,  6 Jan 2020 18:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A8A2072A
	for <rcu@archiver.kernel.org>; Mon,  6 Jan 2020 18:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578333802;
	bh=w4tSvWW9FT+xvMySjiiCZplPPEPUrK9333CUJxTU5og=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=c3O3FoGya/BipoVz553Ust0RT/+p1yFBWALQqTBLa9IgTPDm5k5yZmQ9Lf85a0Cp1
	 ZFY+PUUI7NrkPoTOxIEbjL/8ZyZAov9OZ2TKgzXFTMnMG8BR3u47uLbE/5JY/vvGuv
	 dZh65SnEgUiraVBDt2Kgt40DxGZdU/Yw7QWazMjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgAFSDW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:03:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbgAFSDW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 6 Jan 2020 13:03:22 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9906B2070E;
        Mon,  6 Jan 2020 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578333801;
        bh=w4tSvWW9FT+xvMySjiiCZplPPEPUrK9333CUJxTU5og=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dcHOo6VIqKwVIGDOKcnL0hp0xEV+JoixVMjhBIkhrwq+wcujZo6Wzv80JNGI/1gth
         KwqttSZJHYY1AgMdjrL8izWg71GgQIjNguWVEln6szIcFwqbZKreijDYiUmTKYPKIG
         iCD8oeao1ndDYfAc28SNExEZiZe8fZRRMYXOJ96U=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 69F2B352274D; Mon,  6 Jan 2020 10:03:21 -0800 (PST)
Date:   Mon, 6 Jan 2020 10:03:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zilstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        Amol Grover <frextrite@gmail.com>
Subject: Re: RCU ideas discussed at LPC
Message-ID: <20200106180321.GK13449@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAEXW_YTyxm7QZwFV7KYpN2Sds=SDYqOvZ4+qfWL1_Kwx48Dusg@mail.gmail.com>
 <20191226010532.GP13449@paulmck-ThinkPad-P72>
 <20200104015617.GK189259@google.com>
 <20200104023133.GD13449@paulmck-ThinkPad-P72>
 <20200104212108.GM189259@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104212108.GM189259@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jan 04, 2020 at 04:21:08PM -0500, Joel Fernandes wrote:
> On Fri, Jan 03, 2020 at 06:31:33PM -0800, Paul E. McKenney wrote:
> > On Fri, Jan 03, 2020 at 08:56:17PM -0500, Joel Fernandes wrote:
> > > On Wed, Dec 25, 2019 at 05:05:32PM -0800, Paul E. McKenney wrote:

[ . . . ]

> > > > > How about doing this kind of call_rcu() to synchronize_rcu()
> > > > > transition automatically if the context allows it? I.e. Detect the
> > > > > context and if sleeping is allowed, then wait for the grace period
> > > > > synchronously in call_rcu(). Not sure about deadlocks and the like
> > > > > from this kind of waiting and have to think more.
> > > > 
> > > > This gets rather strange in a production PREEMPT=n build, so not a
> > > > fan, actually.  And in real-time systems, I pretty much have to splat
> > > > anyway if I slow down call_rcu() by that much.
> > > > 
> > > > So the preference is instead detecting such misconfiguration and issuing
> > > > appropriate diagnostics.  And making RCU more able to keep up when not
> > > > grossly misconfigured, hence the kfree_rcu() memory footprint being
> > > > fed into core RCU.
> > > 
> > > Ok. Is it not Ok to simply assume that a large number of callbacks queued
> > > along with observing high memory pressure, means RCU should be more
> > > aggressive anyway since whatever memory can be freed by invoking callbacks
> > > should be helpful anyway? Or were you thinking making RCU aggressive when
> > > there's a lot of memory pressure is not worth it, without knowing that RCU is
> > > the cause for it?
> > 
> > I used to have a memory-pressure switch for RCU, but the OOM guys hated
> > it.  But given a reliable "running short of memory" indicator, I would
> > be quite happy to use it.  After all, even if RCU is not at fault, it
> > might still be helpful for it to pull its memory-footprint horns in a bit.
> 
> With recent advances in PSI, I am wondering if those pressure signals (for
> memory) can be leveraged to pull the memory-footprint horns. I can look more
> into this, I am also looking into PSI for other work things.
> 
> One thing I am wondering though is, say we get a reliable signal -- what
> could RCU do? Were you thinking of having the FQS loop set the usual
> emergency flags and hope the "RCU-idle" CPUs enter quiescent states, along
> with additional signalling for rcu_read_unlock_special()?  Will think more
> about it..

I am thinking in terms of it reacting to memory pressure in the same way
that it currently does when it finds a CPU with more RCU callbacks than
it likes.  ;-)

> As far as testing goes, I was thinking of initially running rcuperf on a
> system with less memory and never entering OOM as a "test has passed"
> indication.

Agreed.  I would look at memory-pressure actions as an additional level
of memory-footprint guardrail, and I strongly encourage you to set up
your testing and deployment so as to allow production use at least one
guardrail that normal testing does not slam into.

(Yes, there also needs to be focused testing of the last guardrail, but
that should be separate, probably an rcutorture option where a reader
keeps spinning until memory pressure kicks in.)

> > > > > BTW, I have 2 interns working on RCU (Amol and Madupharna also on
> > > > > CC).
> > > > > They were selected among several others as a part of the
> > > > > LinuxFoundation mentorship program. They are familiar with RCU. I have
> > > > > asked them to look at some RCU-list work and RCU sparse work. However,
> > > > > I can also have them look into a few other things as time permits and
> > > > > depending on what interests them.
> > > > 
> > > > Dog paddling before cliff diving, please!  ;-)
> > > 
> > > Sure. They are working on relatively simpler things for their internship but
> > > I just put these ideas out there with them on CC so they can pick something
> > > else as well if they have time and interest ;-)
> > 
> > I considered pointing them at KCSAN reports, but about 5% of them require
> > global knowledge.  And it is never clear up front which are the 5%.  And
> > that 5% of "real bugs" is most of the motivation for things like KCSAN.
> 
> Interesting.
> 
> > > > > Thanks, Merry Christmas!
> > > > 
> > > > And to you and yours as well!
> > > 
> > > Hope you had a good holiday season!
> > 
> > It did!  First holiday season in quite a few years featuring all
> > three kids, though not all at once.  Might be awhile until the next
> > time that happens.  Something about them being about 30 years old and
> > widely dispersed.  ;-)
> 
> Oh nice, happy to hear that and hope this year end brings the same.
> 
> > As the little one becomes more aware, your holiday seasons should become
> > quite fun.  Don't miss out!  ;-)
> 
> Looking forward to it and will do ;)

;-) ;-) ;-)

								Thanx, Paul
