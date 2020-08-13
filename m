Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6F5C433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 16:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A381020855
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 16:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597336145;
	bh=mYx4fJshJRqk657Xt+birvf0tGGQwEtc93N+G1qkWY8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=zW6QZT4k5+M/GJy2jJX5BodHF5F2+WvVyI0WWiPqHYs32wAiVWFzDeCmLXpZdaven
	 aoFgA8VOmgRuS7srsCPqumtACyGldbXA2YD1bPPEIu818wOPsWjOrNeC3IhD9/NSTE
	 zZYiNzsJpyVcVgpITHwBpb7EV7PBKsCKx9kM6/FI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHMQ3F (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgHMQ3F (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 12:29:05 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B7AF20658;
        Thu, 13 Aug 2020 16:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597336144;
        bh=mYx4fJshJRqk657Xt+birvf0tGGQwEtc93N+G1qkWY8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aLNRnS0+zf6iHufYdbxSvtDFlBhYmFBasFjQbTKkxOCe5q9tBY3BlWgS8OKyqfFMj
         gYMUr65UldczOkQpIaIkjw1tbgcXPx3QRQl9I0fzEoO9OlvGbeZ2wz6mppnDd/rdxR
         vQoJWdeuNGJ+1rVlp9BKSGoDEaUw3CL5N7ez0aEI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 74824352279C; Thu, 13 Aug 2020 09:29:04 -0700 (PDT)
Date:   Thu, 13 Aug 2020 09:29:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200813162904.GX4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813145335.GN9477@dhcp22.suse.cz>
 <20200813154159.GR4295@paulmck-ThinkPad-P72>
 <20200813155412.GP9477@dhcp22.suse.cz>
 <20200813160442.GV4295@paulmck-ThinkPad-P72>
 <20200813161357.GQ9477@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813161357.GQ9477@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 13, 2020 at 06:13:57PM +0200, Michal Hocko wrote:
> On Thu 13-08-20 09:04:42, Paul E. McKenney wrote:
> > On Thu, Aug 13, 2020 at 05:54:12PM +0200, Michal Hocko wrote:
> [...]
> > > If the whole bailout is guarded by CONFIG_PREEMPT_RT specific atomicity
> > > check then there is no functional problem - GFP_RT_SAFE would still be
> > > GFP_NOWAIT so functional wise the allocator will still do the right
> > > thing.
> > 
> > Perhaps it was just me getting confused, early hour Pacific Time and
> > whatever other excuses might apply.  But I thought that you still had
> > an objection to GFP_RT_SAFE based on changes in allocator semantics for
> > other users.
> 
> There is still that problem with lockdep complaining about raw->regular
> spinlock on !PREEMPT_RT that would need to get resolved somehow. Thomas
> is not really keen on adding some lockdep annotation mechanism and
> unfortunatelly I do not have a different idea how to get rid of those.

OK.  So the current situation requires a choice between these these
alternatives, each of which has shortcomings that have been mentioned
earlier in this thread:

1.	Prohibit invoking allocators from raw atomic context, such
	as when holding a raw spinlock.

2.	Adding a GFP_ flag.

3.	Reusing existing GFP_ flags/values/whatever to communicate
	the raw-context information that was to be communicated by
	the new GFP_ flag.

4.	Making lockdep forgive acquiring spinlocks while holding
	raw spinlocks, but only in CONFIG_PREEMPT_NONE=y kernels.

Am I missing anything?

						Thanx, Paul
