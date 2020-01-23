Return-Path: <SRS0=TYAb=3M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B150C2D0DB
	for <rcu@archiver.kernel.org>; Thu, 23 Jan 2020 16:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7066221D7E
	for <rcu@archiver.kernel.org>; Thu, 23 Jan 2020 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579797669;
	bh=SYOcg05hp0GKFRdLdX4OKweCK3oCGyHJiXYgJpSn9B0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=r7IfRU8uBeZGS3sK/m+Umv1GtVskhCaILBfr3BkDXAOqr9sdXn3IOnCRE0ZAQ5oAQ
	 PE+sUdLK9AboI+skhfVtNyP67VIcnHzo/d6ccHgdwgSHZkMw9SUIK1xHmkY/sHor94
	 C95rEOVgQpDL6Es5oR4ZlHmvucn1GkprRHRfZ6lo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgAWQlJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:41:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbgAWQlJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 23 Jan 2020 11:41:09 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EE2E21734;
        Thu, 23 Jan 2020 16:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579797668;
        bh=SYOcg05hp0GKFRdLdX4OKweCK3oCGyHJiXYgJpSn9B0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=wKcMTcEN8AXJfZr+rw4lPetdkINSK3OPE6IJftTzck/7ynnPzQnrDMgqysqUX83QW
         0tiuizAa/ivcdupeGkVy2gXHCxNRGeDDJb8JDwLAoTR9Cqtu+zmNj2aUNh9Ya/tF6H
         C4wWOKEqGw4r2TU86XoKPT5u6foDIhICEl0lrXgM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 593DA3520C31; Thu, 23 Jan 2020 08:41:08 -0800 (PST)
Date:   Thu, 23 Jan 2020 08:41:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     madhuparnabhowmik10@gmail.com
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, ebiederm@xmission.com,
        christian.brauner@ubuntu.com, oleg@redhat.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        frextrite@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH] sched.h: Annotate sighand_struct with __rcu
Message-ID: <20200123164108.GQ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200123145305.10652-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123145305.10652-1-madhuparnabhowmik10@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 23, 2020 at 08:23:05PM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> This patch fixes the following sparse errors by annotating the
> sighand_struct with __rcu
> 
> kernel/fork.c:1511:9: error: incompatible types in comparison expression
> kernel/exit.c:100:19: error: incompatible types in comparison expression
> kernel/signal.c:1370:27: error: incompatible types in comparison expression
> 
> This fix introduces the following sparse error in signal.c due to
> checking the sighand pointer without rcu primitives:
> 
> kernel/signal.c:1386:21: error: incompatible types in comparison expression
> 
> This new sparse error is also addressed in this patch.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> ---
>  include/linux/sched.h | 2 +-
>  kernel/signal.c       | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index b511e178a89f..7a351360ad54 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -918,7 +918,7 @@ struct task_struct {
>  
>  	/* Signal handlers: */
>  	struct signal_struct		*signal;
> -	struct sighand_struct		*sighand;
> +	struct sighand_struct __rcu		*sighand;
>  	sigset_t			blocked;
>  	sigset_t			real_blocked;
>  	/* Restored if set_restore_sigmask() was used: */
> diff --git a/kernel/signal.c b/kernel/signal.c
> index bcd46f547db3..1272def37462 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1383,7 +1383,8 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
>  		 * must see ->sighand == NULL.
>  		 */
>  		spin_lock_irqsave(&sighand->siglock, *flags);
> -		if (likely(sighand == tsk->sighand))
> +		if (likely(sighand == rcu_dereference_protected(tsk->sighand,
> +						lockdep_is_held(&sighand->siglock))))

Given that the return value is never dereferenced, you can use
rcu_access_pointer(), which may be used outside of an RCU read-side
critical section, and thus does not need the lockdep_is_held().  So this
change would save a line of code and would be a bit easier on the eyes.

							Thanx, Paul

>  			break;
>  		spin_unlock_irqrestore(&sighand->siglock, *flags);
>  	}
> -- 
> 2.17.1
> 
