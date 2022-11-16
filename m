Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E3EC4332F
	for <rcu@archiver.kernel.org>; Wed, 16 Nov 2022 16:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiKPQut (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Nov 2022 11:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbiKPQu0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Nov 2022 11:50:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D78D2654
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 08:48:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCAA8B81DFD
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 16:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D987C433D6;
        Wed, 16 Nov 2022 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668617309;
        bh=hqOQXWncjiWGU2gvC6GR+XBuzhRLsvlfFAiHZCJvies=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=m0my92uADGd/QLIlK6byXEYQ/GAxdK0W9Z5R2QZ9OSRu9mntWI9amHjEH6p+2KFey
         tEO1LPBQwUBqD8icO3OsMWWVA8FxIyDJKBEAHFMJPqe56rxaqnQ4hymj+XUVB/tskR
         pM1GY/oDtx9AoFjpE2gJbJwidNwUJNx97ywS78Xo5ZGZVRnCYMwNN/u/K7FHoBuVdJ
         MoF/ZjKlwqhOO+IveEMzRhs/uGAf6LClWwNTnMs2nmQwwwOci82zoks4qDzKv3p4va
         aEENMyBu0MYQA6Q6L5gcq7kVZszXjNmOhU/tHwokeov99c+0TPkT/bqEai+/GDzQF1
         4ywDge37is4bQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2C77A5C0865; Wed, 16 Nov 2022 08:48:29 -0800 (PST)
Date:   Wed, 16 Nov 2022 08:48:29 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>, rcu@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/2] srcu: Fix a misspelling in note
Message-ID: <20221116164829.GP4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221116015244.10539-1-kernelfans@gmail.com>
 <20221116133625.GB816333@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116133625.GB816333@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 16, 2022 at 02:36:25PM +0100, Frederic Weisbecker wrote:
> On Wed, Nov 16, 2022 at 09:52:43AM +0800, Pingfan Liu wrote:
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > To: rcu@vger.kernel.org
> > ---
> >  include/linux/srcutree.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > index e3014319d1ad..f52820e88018 100644
> > --- a/include/linux/srcutree.h
> > +++ b/include/linux/srcutree.h
> > @@ -48,7 +48,7 @@ struct srcu_data {
> >  struct srcu_node {
> >  	spinlock_t __private lock;
> >  	unsigned long srcu_have_cbs[4];		/* GP seq for children having CBs, but only */
> > -						/*  if greater than ->srcu_gq_seq. */
> > +						/*  if greater than ->srcu_gp_seq. */
> 
> Sharp eye ;-)
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Applied with both Reviewed-by tags, thank you all!

							Thanx, Paul

> >  	unsigned long srcu_data_have_cbs[4];	/* Which srcu_data structs have CBs for given GP? */
> >  	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
> >  	struct srcu_node *srcu_parent;		/* Next up in tree. */
> > -- 
> > 2.31.1
> > 
