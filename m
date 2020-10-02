Return-Path: <SRS0=VPhX=DJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7DDC4363D
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 14:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B1F206C9
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601649681;
	bh=8qRWrCX+pD9/FmbSS60gLVNFhIqZkPM1+7o0Jwbm5L0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=lpw1dzr4my+kbbfTyhtCGSki9n2WUSrYl7uIkatwiCSZaDHg736mj5ISkI9KA1Uu0
	 iPV/shnpVF/zsBZjwPWNjnjqpYzlgUp6EaFkYDgWlQ3l/np0HHglpQfArQ6QTQaz5D
	 TiRNO+9jv1mtksydrxeTALinZXGPubXgI94ogIcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJBOlV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 2 Oct 2020 10:41:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBOlU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 2 Oct 2020 10:41:20 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CE45206B2;
        Fri,  2 Oct 2020 14:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601649680;
        bh=8qRWrCX+pD9/FmbSS60gLVNFhIqZkPM1+7o0Jwbm5L0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oYHNeuOcbgFuyB6hXsBSfJogwpHhaiMVWimaoL8NkehxfSxHoHRlYGw485T7NZkjE
         8DO6+LLuc7awTmLBB5tzhZzgVBynYEhCd2+FbH2yFtSUkLU0Uqu3TVtRfcFgA5gzFa
         Ugn4bu94as0sT7mQRaSnkwVUHiy0REPB6SEzodGg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 261393522838; Fri,  2 Oct 2020 07:41:20 -0700 (PDT)
Date:   Fri, 2 Oct 2020 07:41:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20201002144120.GI29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz>
 <20200929220742.GB8768@pc636>
 <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
 <20201001192626.GA29606@pc636>
 <20201002071123.GB20872@dhcp22.suse.cz>
 <20201002085014.GC3227@techsingularity.net>
 <20201002090729.GU2628@hirez.programming.kicks-ass.net>
 <20201002094502.GD3227@techsingularity.net>
 <20201002095858.GN2611@hirez.programming.kicks-ass.net>
 <20201002101952.GE3227@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002101952.GE3227@techsingularity.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 02, 2020 at 11:19:52AM +0100, Mel Gorman wrote:
> On Fri, Oct 02, 2020 at 11:58:58AM +0200, Peter Zijlstra wrote:
> > > It's enabled by default by enough distros that adding too many checks
> > > is potentially painful. Granted it would be missed by most benchmarking
> > > which tend to control allocations from userspace but a lot of performance
> > > problems I see are the "death by a thousand cuts" variety.
> > 
> > Oh quite agreed, aka death by accounting. But if people are enabling
> > DEBUG options in production kernels, there's something wrong, no?
> > 
> 
> You'd think but historically I believe DEBUG_VM was enabled for some
> distributions because it made certain classes of problems easier to debug
> early. There is also a recent trend for enabling various DEBUG options for
> "hardening" even when they protect very specific corner cases or are for
> intended for kernel development. I've pushed back where I have an opinion
> that matters but it's generally corrosive.
> 
> > Should we now go add CONFIG_REALLY_DEBUG_STAY_AWAY_ALREADY options?
> 
> It's heading in that direction :(

Given that you guys have just reiterated yet again that you are very
unhappy with either a GFP_ flag or a special function like the one that
Peter Zijlstra put together, it would be very helpful if you were to at
least voice some level of support for Thomas Gleixner's patchset, which,
if accepted, will allow me to solve at least 50% of the problem.

https://lore.kernel.org/lkml/20200928233041.GA23230@paulmck-ThinkPad-P72/
	Patch series including Thomas's patchset.
https://lore.kernel.org/lkml/20201001210750.GA25287@paulmck-ThinkPad-P72/
	Corresponding pull request.

							Thanx, Paul
