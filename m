Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E3FC433DF
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 18:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3202078D
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 18:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597428146;
	bh=ZtFbeBLn03RDB5oZH3Gooo/sJjOAKTmCpMDp7uR0kao=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=1g+dmFjJkWh7bc420oiddlhJp72nixSeRt7mkE07Gy3afFdqexl9KQaNtaoptGfE/
	 0i1XIxBgcHfPahs+dRFKPxkT/T0t+1QAzgqjz4io7ra0/V1RSk8dCVRcQMVcuZd0P3
	 8HbwBGh2NnRZods/YvEEHDmkkgYhliZ39bsm6buE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgHNSCZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 14:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgHNSCZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 14:02:25 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B482520771;
        Fri, 14 Aug 2020 18:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597428144;
        bh=ZtFbeBLn03RDB5oZH3Gooo/sJjOAKTmCpMDp7uR0kao=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=w2Slc3ZGErIbvmUQkYgTipC+xLVqw+0CNBnpfh4LGUX0RRa5yjeuH1DkIL811d7b1
         zsy1y8zYb0mstf9kw8QvnLXKTIqXooKxQWlMzlNSoGL7UBP4MHv3iNJ/QEN1k1cN/a
         7xhXTM3Mi8fg7HXgEEVLf627p3iyqZ7i8KhdxXR8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8B3833522A0E; Fri, 14 Aug 2020 11:02:24 -0700 (PDT)
Date:   Fri, 14 Aug 2020 11:02:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
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
Message-ID: <20200814180224.GQ4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813182618.GX2674@hirez.programming.kicks-ass.net>
 <20200813185257.GF4295@paulmck-ThinkPad-P72>
 <20200813220619.GA2674@hirez.programming.kicks-ass.net>
 <875z9m3xo7.fsf@nanos.tec.linutronix.de>
 <20200814083037.GD3982@worktop.programming.kicks-ass.net>
 <20200814141425.GM4295@paulmck-ThinkPad-P72>
 <20200814161106.GA13853@paulmck-ThinkPad-P72>
 <20200814174924.GI3982@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814174924.GI3982@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 14, 2020 at 07:49:24PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 14, 2020 at 09:11:06AM -0700, Paul E. McKenney wrote:
> > Just to make sure we are talking about the same thing, please see below
> > for an untested patch that illustrates how I was interpreting your words.
> > Was this what you had in mind?
> 
> No, definitely not.
> 
> Also, since we used to be able to use call_rcu() _everywhere_, including
> under zone->lock, how's that working with you calling the
> page-allocating from it?

Indeed, that is exactly the problem we are trying to solve.

							Thanx, Paul
