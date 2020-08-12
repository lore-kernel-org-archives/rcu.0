Return-Path: <SRS0=nsBp=BW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4695EC433E1
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 13:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F5F204FD
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597239055;
	bh=cwOQ8I7U7gjXjc6i067qRtdy6jYZGJ/UHwnd00Cd3ZU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=q9Ngr8Hoy68PKR/tk01jQcOnTw7y98aGDXrmvo/3JM5Iq1nP1NTqtAtdghV30ioBy
	 BPrTTLHT4apr/brIRCO0MtYJK/EJufJ+oGjDpEcx3H9PiQKY4SFn/Rl8d8/IKBz39m
	 W0DX8vh7dAfsQuHtH53ijtcNC5AWbpSy0EMaqZMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgHLNav (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:30:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbgHLNaq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 Aug 2020 09:30:46 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85779204FD;
        Wed, 12 Aug 2020 13:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597239045;
        bh=cwOQ8I7U7gjXjc6i067qRtdy6jYZGJ/UHwnd00Cd3ZU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=1QzLJEo/ocgkyqYpwGOSOMFqaSu1BRmFAMGRDMkYYB9/Ji1yM9SMxht4KYpi2V3PW
         TTMZ1rifaVsEowkrTWHwrXf0XuGzJMBJDjgDTvDhJU2whdTvgEidO/XmaDV2bC1tFS
         YtZ0ixuRSZlChyT7V7SvYr5Y/YfESuk2wptW8VMY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6280C35230C2; Wed, 12 Aug 2020 06:30:45 -0700 (PDT)
Date:   Wed, 12 Aug 2020 06:30:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200812133045.GE4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200812042945.GB4295@paulmck-ThinkPad-P72>
 <871rkc6z7x.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rkc6z7x.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 12, 2020 at 10:32:50AM +0200, Thomas Gleixner wrote:
> Paul,
> 
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> > On Wed, Aug 12, 2020 at 02:13:25AM +0200, Thomas Gleixner wrote:
> >> That much I understood, but I somehow failed to figure the why out
> >> despite the elaborate changelog. 2 weeks of 30+C seem to have cooked my
> >> brain :)
> >
> > Ouch!!!  And what on earth is Germany doing being that warm???
> 
> The hot air exhaustion of politicians, managers and conspiracy
> mythomaniacs seens to have contributed extensivly to global warming
> lately.

In that case, our only hope here in this geography is that we are in a
simulation, so that the hot air will cause a signed integer overflow to
negative numbers some fraction of the time.  :-(

> >> But what makes me really unhappy is that my defense line against
> >> allocations from truly atomic contexts (from RT POV) which was enforced
> >> on RT gets a real big gap shot into it.
> >
> > Understood, and agreed:  We do need to keep the RT degradation in
> > check.
> 
> Not only that. It's bad practice in general to do memory allocations
> from such contexts if not absolutely necessary and the majority of cases
> which we cleaned up over time were just from the "works for me and why
> should I care and start to think" departement.

Agreed, and I continue to see some of that myself.  :-/

> >> I can understand your rationale and what you are trying to solve. So, if
> >> we can actually have a distinct GFP variant:
> >> 
> >>   GFP_I_ABSOLUTELY_HAVE_TO_DO_THAT_AND_I_KNOW_IT_CAN_FAIL_EARLY
> >> 
> >> which is easy to grep for then having the page allocator go down to the
> >> point where zone lock gets involved is not the end of the world for
> >> RT in theory - unless that damned reality tells otherwise. :)
> >
> > I have no objection to an otherwise objectionable name in this particular
> > case.  After all, we now have 100 characters per line, right?  ;-)
> 
> Hehe. I can live with the proposed NO_LOCK name or anything distinct
> which the mm people can agree on.

Sounds good.  ;-)

> >> To make it consistent the same GFP_ variant should allow the slab
> >> allocator go to the point where the slab cache is exhausted.
> >
> > Why not wait until someone has an extremely good reason for needing
> > this functionality from the slab allocators?  After all, leaving out
> > the slab allocators would provide a more robust defense line.  Yes,
> > consistent APIs are very good things as a general rule, but maybe this
> > situation is one of the exceptions to that rule.
> 
> Fair enough.
> 
> >> Having a distinct and clearly defined GFP_ variant is really key to
> >> chase down offenders and to make reviewers double check upfront why this
> >> is absolutely required.
> >
> > Checks for that GFP_ variant could be added to automation, though reality
> > might eventually prove that to be a mixed blessing.
> 
> Did you really have to remind me and destroy my illusions before I was
> able to marvel at them?

Apologies!  I am afraid that it has become a reflex due to living in
this time and place.  My further fear is that I will have all to great
an opportunity for further reinforcing this reflex in the future.  :-/

							Thanx, Paul
