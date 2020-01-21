Return-Path: <SRS0=d+Zk=3K=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01399C32771
	for <rcu@archiver.kernel.org>; Tue, 21 Jan 2020 00:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE70D24125
	for <rcu@archiver.kernel.org>; Tue, 21 Jan 2020 00:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579564859;
	bh=TL8+hTSU7hnDRNLe87x5EES6PdrZ165vhPZ0MkxtH7w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=zX9tTxEaOP3JZ+1qBYknvd0vMhYn1NEulkALd/cJqaT4oZXDajuUIKPXa69OqXdiH
	 ckSpW/qqzzAz9aMb8LuEdHsSbae8lE+UdLZLKFyWbl6q+7YiMAUlOpWaXk1unwWQhs
	 YsMNqpGXhD05G9/n6evmPjpOK/wfFZQBunTuHv3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgAUAA7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jan 2020 19:00:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbgAUAA7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jan 2020 19:00:59 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB61C22527;
        Tue, 21 Jan 2020 00:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579564858;
        bh=TL8+hTSU7hnDRNLe87x5EES6PdrZ165vhPZ0MkxtH7w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=B3m2tFnN8sclNa990iPCP6BKZEo+QP6mX6mcW1I8tZxdj1fuV0nFEY4IGCTWjV3WJ
         OlaaNeX6URKcr3F3H/xx1O3IDKWUOnrL3OiXV3mGJpCRmB3PqBoLj26KCVnEQjdPRq
         A9A+97FTG+oG/guc93qspT2KDwGDNUH/DQ/BQ1cs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9C7DF3522745; Mon, 20 Jan 2020 16:00:58 -0800 (PST)
Date:   Mon, 20 Jan 2020 16:00:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Amol Grover <frextrite@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: Re: [PATCH] rculist: Add brackets around cond argument in
 __list_check_rcu macro
Message-ID: <20200121000058.GI2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200118165417.12325-1-frextrite@gmail.com>
 <20200119021425.GH244899@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119021425.GH244899@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jan 18, 2020 at 09:14:25PM -0500, Joel Fernandes wrote:
> On Sat, Jan 18, 2020 at 10:24:18PM +0530, Amol Grover wrote:
> > Passing a complex lockdep condition to __list_check_rcu results
> > in false positive lockdep splat due to incorrect expression
> > evaluation.
> > 
> > For example, a lockdep check condition `cond1 || cond2` is
> > evaluated as `!cond1 || cond2 && !rcu_read_lock_any_held()`
> > which, according to operator precedence, evaluates to
> > `!cond1 || (cond2 && !rcu_read_lock_any_held())`.
> > This would result in a lockdep splat when cond1 is false
> > and cond2 is true which is logically incorrect.
> > 
> > Signed-off-by: Amol Grover <frextrite@gmail.com>
> 
> Good catch!
> 
> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Queued for v5.7, thank you both!

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > ---
> >  include/linux/rculist.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> > index 4158b7212936..dce491f0b354 100644
> > --- a/include/linux/rculist.h
> > +++ b/include/linux/rculist.h
> > @@ -50,9 +50,9 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
> >  #define __list_check_rcu(dummy, cond, extra...)				\
> >  	({								\
> >  	check_arg_count_one(extra);					\
> > -	RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),		\
> > +	RCU_LOCKDEP_WARN(!(cond) && !rcu_read_lock_any_held(),		\
> >  			 "RCU-list traversed in non-reader section!");	\
> > -	 })
> > +	})
> >  #else
> >  #define __list_check_rcu(dummy, cond, extra...)				\
> >  	({ check_arg_count_one(extra); })
> > -- 
> > 2.24.1
> > 
