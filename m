Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE7FC433DB
	for <rcu@archiver.kernel.org>; Sun, 21 Mar 2021 22:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C4261941
	for <rcu@archiver.kernel.org>; Sun, 21 Mar 2021 22:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhCUW3C (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 21 Mar 2021 18:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhCUW26 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 21 Mar 2021 18:28:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A31C6192B;
        Sun, 21 Mar 2021 22:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616365738;
        bh=ndidVnIP8iIXzvOnzRc7h9/HahXnNC1cisPzcAopuK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YPq3lhAN0RxwtNZdCneJ4V5jwuPqjtYB0NanzfVgHa2BrKAiKsvVk/IfG87rcwG04
         Xf9+Jr9v0H9eOV+0KaznzQOCi/qeYUz4HcOdfuQ/ooZWMqOXAX3vCStSfizdo9rkIc
         m+2PR1vmX4uGwCgTSyN00X4sH7QiCAL9hMDHKrafJTEpFDJvt99+nLSR28uDngC8zi
         4NaWO+0cv+C0mruDXACeHK3KxV2DXfUbsTt4lMAwH8Lgss7yXgyERzWzwt/tktO9Vn
         XhnPt2jbe8RvaQA3KbYbCpfYdn25qf/JYuI0+XITj63+jHcR//E/L0bbXtyV2/qT0c
         BbMVd1lEp+LmA==
Date:   Sun, 21 Mar 2021 23:28:55 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 2/3] rcu: Provide polling interfaces for
 Tiny RCU grace periods
Message-ID: <20210321222855.GA863290@lothringen>
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
 <20210304002632.23870-2-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304002632.23870-2-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 03, 2021 at 04:26:31PM -0800, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> There is a need for a non-blocking polling interface for RCU grace
> periods, so this commit supplies start_poll_synchronize_rcu() and
> poll_state_synchronize_rcu() for this purpose.  Note that the existing
> get_state_synchronize_rcu() may be used if future grace periods are
> inevitable (perhaps due to a later call_rcu() invocation).  The new
> start_poll_synchronize_rcu() is to be used if future grace periods
> might not otherwise happen.  Finally, poll_state_synchronize_rcu()
> provides a lockless check for a grace period having elapsed since
> the corresponding call to either of the get_state_synchronize_rcu()
> or start_poll_synchronize_rcu().
> 
> As with get_state_synchronize_rcu(), the return value from either
> get_state_synchronize_rcu() or start_poll_synchronize_rcu() is passed in
> to a later call to either poll_state_synchronize_rcu() or the existing
> (might_sleep) cond_synchronize_rcu().
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  include/linux/rcutiny.h | 11 ++++++-----
>  kernel/rcu/tiny.c       | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index 2a97334..69108cf4 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -17,14 +17,15 @@
>  /* Never flag non-existent other CPUs! */
>  static inline bool rcu_eqs_special_set(int cpu) { return false; }
>  
> -static inline unsigned long get_state_synchronize_rcu(void)
> -{
> -	return 0;
> -}
> +unsigned long get_state_synchronize_rcu(void);
> +unsigned long start_poll_synchronize_rcu(void);
> +bool poll_state_synchronize_rcu(unsigned long oldstate);
>  
>  static inline void cond_synchronize_rcu(unsigned long oldstate)
>  {
> -	might_sleep();
> +	if (poll_state_synchronize_rcu(oldstate))
> +		return;
> +	synchronize_rcu();

Perhaps cond_synchronize_rcu() could stay as it was. If it might
call synchronize_rcu() then it inherits its constraint to be
called from a quiescent state.

Thanks.
