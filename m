Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CFDC4332F
	for <rcu@archiver.kernel.org>; Mon, 13 Sep 2021 23:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C83C61130
	for <rcu@archiver.kernel.org>; Mon, 13 Sep 2021 23:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244272AbhIMXUo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 13 Sep 2021 19:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245070AbhIMXRw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 13 Sep 2021 19:17:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 454F860FDA;
        Mon, 13 Sep 2021 23:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631574270;
        bh=Ub0V4Q81oxe1XsMj5ZBRwqtb17rpp6Rtp+hU97fNWPY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aApPjylgGlWmT+kikqn6rIM1HuUPQ6wUfTNKfdxKvCTgmn91wlKDUOomAf+VNbPzd
         nGMyt9a3eT8xHYcyiC/SJ6p7+Xo9mE2P6lprZyF8uihQuh7Ub5iKhhIATz3HhsBqsd
         gfVsP/vG6g8wiolbxHhz45gK772XyumNmOnkRVjWy6K4gVOWFVefGWsBaJgqzQf002
         8bz5QJSyZKvqP50mTyI49Q6tXJ+wRu5JUGuxUzGcIqopa6TzXqljBDUIOev3mcCSDP
         EFC4iHOrsGpZQZCjMbmHZVXJ3mJVrXFBtBXzkcebAUPZJAKn8Dxc/KVIAQ1rbVF+cU
         A/pjjcLJJkDHQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0E06F5C048F; Mon, 13 Sep 2021 16:04:30 -0700 (PDT)
Date:   Mon, 13 Sep 2021 16:04:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chun-Hung Tseng <henrybear327@gmail.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Huang <jserv@ccns.ncku.edu.tw>
Subject: Re: [PATCH] rcu: replace _________p1 with __UNIQUE_ID(rcu)
Message-ID: <20210913230430.GM4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210912204131.93206-1-henrybear327@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210912204131.93206-1-henrybear327@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 13, 2021 at 04:41:31AM +0800, Chun-Hung Tseng wrote:
> This commit replaced _________p1 with __UNIQUE_ID(rcu), which
> generates unique variable names during compilation. Necessary
> modifications due to the changes in the RCU macros have also been
> reflected in this commit.
> 
> The same idea is used for the min/max macros (commit 589a978 and commit
> e9092d0), which aims to reduce variable shadowing issues caused by hard
> coded variable names.
> 
> Signed-off-by: Jim Huang <jserv@ccns.ncku.edu.tw>
> Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>

OK, I will bite...

> ---
>  include/linux/rcupdate.h | 44 +++++++++++++++++++++++-----------------
>  include/linux/srcu.h     |  3 ++-
>  2 files changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 434d12fe2d4f..a5ab20822040 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -370,39 +370,41 @@ static inline void rcu_preempt_sleep_check(void) { }
>   * Converts @p from an __rcu pointer to a __kernel pointer.
>   * This allows an __rcu pointer to be used with xchg() and friends.
>   */
> -#define unrcu_pointer(p)						\
> +#define __unrcu_pointer(p, local)					\
>  ({									\
> -	typeof(*p) *_________p1 = (typeof(*p) *__force)(p);		\
> +	typeof(*p) *local = (typeof(*p) *__force)(p);			\

Why not like this?

	typeof(*p) *__UNIQUE_ID(rcu) = (typeof(*p) *__force)(p);	\

Then we don't need the extra argument and the changes to the calls.

So what C-preprocessor subtlety am I missing?

							Thanx, Paul

>  	rcu_check_sparse(p, __rcu);					\
> -	((typeof(*p) __force __kernel *)(_________p1)); 		\
> +	((typeof(*p) __force __kernel *)(local)); 			\
>  })
> +#define unrcu_pointer(p) __unrcu_pointer(p, __UNIQUE_ID(rcu))
>  
> -#define __rcu_access_pointer(p, space) \
> +#define __rcu_access_pointer(p, local, space) \
>  ({ \
> -	typeof(*p) *_________p1 = (typeof(*p) *__force)READ_ONCE(p); \
> +	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>  	rcu_check_sparse(p, space); \
> -	((typeof(*p) __force __kernel *)(_________p1)); \
> +	((typeof(*p) __force __kernel *)(local)); \
>  })
> -#define __rcu_dereference_check(p, c, space) \
> +#define __rcu_dereference_check(p, local, c, space) \
>  ({ \
>  	/* Dependency order vs. p above. */ \
> -	typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
> +	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
>  	rcu_check_sparse(p, space); \
> -	((typeof(*p) __force __kernel *)(________p1)); \
> +	((typeof(*p) __force __kernel *)(local)); \
>  })
> -#define __rcu_dereference_protected(p, c, space) \
> +#define __rcu_dereference_protected(p, local, c, space) \
>  ({ \
>  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
>  	rcu_check_sparse(p, space); \
>  	((typeof(*p) __force __kernel *)(p)); \
>  })
> -#define rcu_dereference_raw(p) \
> +#define __rcu_dereference_raw(p, local) \
>  ({ \
>  	/* Dependency order vs. p above. */ \
> -	typeof(p) ________p1 = READ_ONCE(p); \
> -	((typeof(*p) __force __kernel *)(________p1)); \
> +	typeof(p) local = READ_ONCE(p); \
> +	((typeof(*p) __force __kernel *)(local)); \
>  })
> +#define rcu_dereference_raw(p) __rcu_dereference_raw(p, __UNIQUE_ID(rcu))
>  
>  /**
>   * RCU_INITIALIZER() - statically initialize an RCU-protected global variable
> @@ -489,7 +491,7 @@ do {									      \
>   * when tearing down multi-linked structures after a grace period
>   * has elapsed.
>   */
> -#define rcu_access_pointer(p) __rcu_access_pointer((p), __rcu)
> +#define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
>  
>  /**
>   * rcu_dereference_check() - rcu_dereference with debug checking
> @@ -525,7 +527,8 @@ do {									      \
>   * annotated as __rcu.
>   */
>  #define rcu_dereference_check(p, c) \
> -	__rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
> +	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
> +				(c) || rcu_read_lock_held(), __rcu)
>  
>  /**
>   * rcu_dereference_bh_check() - rcu_dereference_bh with debug checking
> @@ -540,7 +543,8 @@ do {									      \
>   * rcu_read_lock() but also rcu_read_lock_bh() into account.
>   */
>  #define rcu_dereference_bh_check(p, c) \
> -	__rcu_dereference_check((p), (c) || rcu_read_lock_bh_held(), __rcu)
> +	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
> +				(c) || rcu_read_lock_bh_held(), __rcu)
>  
>  /**
>   * rcu_dereference_sched_check() - rcu_dereference_sched with debug checking
> @@ -555,7 +559,8 @@ do {									      \
>   * only rcu_read_lock() but also rcu_read_lock_sched() into account.
>   */
>  #define rcu_dereference_sched_check(p, c) \
> -	__rcu_dereference_check((p), (c) || rcu_read_lock_sched_held(), \
> +	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
> +				(c) || rcu_read_lock_sched_held(), \
>  				__rcu)
>  
>  /*
> @@ -565,7 +570,8 @@ do {									      \
>   * The no-tracing version of rcu_dereference_raw() must not call
>   * rcu_read_lock_held().
>   */
> -#define rcu_dereference_raw_check(p) __rcu_dereference_check((p), 1, __rcu)
> +#define rcu_dereference_raw_check(p) \
> +	__rcu_dereference_check((p), __UNIQUE_ID(rcu), 1, __rcu)
>  
>  /**
>   * rcu_dereference_protected() - fetch RCU pointer when updates prevented
> @@ -584,7 +590,7 @@ do {									      \
>   * but very ugly failures.
>   */
>  #define rcu_dereference_protected(p, c) \
> -	__rcu_dereference_protected((p), (c), __rcu)
> +	__rcu_dereference_protected((p), __UNIQUE_ID(rcu), (c), __rcu)
>  
>  
>  /**
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index e6011a9975af..01226e4d960a 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -117,7 +117,8 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
>   * lockdep_is_held() calls.
>   */
>  #define srcu_dereference_check(p, ssp, c) \
> -	__rcu_dereference_check((p), (c) || srcu_read_lock_held(ssp), __rcu)
> +	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
> +				(c) || srcu_read_lock_held(ssp), __rcu)
>  
>  /**
>   * srcu_dereference - fetch SRCU-protected pointer for later dereferencing
> -- 
> 2.25.1
> 
