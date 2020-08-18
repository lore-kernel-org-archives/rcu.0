Return-Path: <SRS0=c1tG=B4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D268C433E1
	for <rcu@archiver.kernel.org>; Tue, 18 Aug 2020 16:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD81207DE
	for <rcu@archiver.kernel.org>; Tue, 18 Aug 2020 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597767237;
	bh=i/osbT4JGLM2WHPj4a6FDQcQ9reu9lXtYu+uvpCBQEE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=qiSnEyiTsm+37l6d0abqhGNXrnxzETitvjgAvj0iBYlp0Ku8DOexrAfnJvivkwqhO
	 aHSKOwpd7qDr1CX4JukVn+5hLMqCN5t6yUzlbCZPIeeHk6qrED06uC331PneiVkKKY
	 gWgGPKT8vT27i1eYazTf62+JVk22qTqOmQqUYCok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHRQN4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbgHRQN4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Aug 2020 12:13:56 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 596F4207DA;
        Tue, 18 Aug 2020 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597767235;
        bh=i/osbT4JGLM2WHPj4a6FDQcQ9reu9lXtYu+uvpCBQEE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=03MprkvPlHzEHpFG/RyjOx9tNAFMVa1A41U0L+2ALSxA7w6D+tul3V8CY1pTehgoq
         ITIuXMiwan2NvpAe3sKyhJWrBvuWUyJMhI9ooE+UpM2qe2DXxlzlpIAuMoDXh47oav
         l8MxfSgyn6Qa9lYNFTgrLRd7pWzhg9E1ONtUVjEA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 30C4135228F5; Tue, 18 Aug 2020 09:13:55 -0700 (PDT)
Date:   Tue, 18 Aug 2020 09:13:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200818161355.GE27891@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200814180224.GQ4295@paulmck-ThinkPad-P72>
 <875z9lkoo4.fsf@nanos.tec.linutronix.de>
 <20200814204140.GT4295@paulmck-ThinkPad-P72>
 <20200814215206.GL3982@worktop.programming.kicks-ass.net>
 <20200816225655.GA17869@pc636>
 <20200817082849.GA28270@dhcp22.suse.cz>
 <20200817222803.GE23602@paulmck-ThinkPad-P72>
 <20200818074344.GL28270@dhcp22.suse.cz>
 <20200818135327.GF23602@paulmck-ThinkPad-P72>
 <87o8n8hv5p.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8n8hv5p.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 18, 2020 at 04:43:14PM +0200, Thomas Gleixner wrote:
> On Tue, Aug 18 2020 at 06:53, Paul E. McKenney wrote:
> > On Tue, Aug 18, 2020 at 09:43:44AM +0200, Michal Hocko wrote:
> >> Thomas had a good point that it doesn't really make much sense to
> >> optimize for flooders because that just makes them more effective.
> >
> > The point is not to make the flooders go faster, but rather for the
> > system to be robust in the face of flooders.  Robust as in harder for
> > a flooder to OOM the system.
> >
> > And reducing the number of post-grace-period cache misses makes it
> > easier for the callback-invocation-time memory freeing to keep up with
> > the flooder, thus avoiding (or at least delaying) the OOM.
> 
> Throttling the flooder is incresing robustness far more than reducing
> cache misses.

True, but it takes time to identify a flooding event that needs to be
throttled (as in milliseconds).  This time cannot be made up.

And in the absence of a flooding event, the last thing you want to do
is to throttle call_rcu(), kfree_rcu(), and kvfree_rcu().

							Thanx, Paul
