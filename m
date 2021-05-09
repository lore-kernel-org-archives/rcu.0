Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83AAC433ED
	for <rcu@archiver.kernel.org>; Sun,  9 May 2021 23:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7B8E61361
	for <rcu@archiver.kernel.org>; Sun,  9 May 2021 23:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhEJABB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 9 May 2021 20:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229853AbhEJABA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 9 May 2021 20:01:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C4EC61055;
        Sun,  9 May 2021 23:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620604795;
        bh=EaSzfc7lZ7OaPdMxSs94vjWb7HX+0UW9m/tgEeudR8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HQ8xCiWE1anFnQ2j9qSE+l1Epz3zTnz6snHgRJ8tPZsqDoQazgXLr9QmfKs400Xsf
         2SYJ/OO4tgX+gORYo1zlu+b0EcLCiC61caVpoxTSibsPAFWtox9o8LmOliz8L6vgs1
         wyBsq7b2YDLC59QUrLZUJKo8FYEQOcAGoHHA5x5Y=
Date:   Sun, 9 May 2021 16:59:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v1 4/5] kvfree_rcu: Refactor kfree_rcu_monitor()
 function
Message-Id: <20210509165954.347dd3cd8e8815b9dce67cfb@linux-foundation.org>
In-Reply-To: <20210428134422.1894-4-urezki@gmail.com>
References: <20210428134422.1894-1-urezki@gmail.com>
        <20210428134422.1894-4-urezki@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, 28 Apr 2021 15:44:21 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> Rearm the monitor work directly from its own function that
> is kfree_rcu_monitor(). So this patch puts the invocation
> timing control in one place.
>
> ...
>
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3415,37 +3415,44 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
>  	return !repeat;
>  }
>  
> -static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
> -					  unsigned long flags)
> +/*
> + * This function queues a new batch. If success or nothing to
> + * drain it returns 1. Otherwise 0 is returned indicating that
> + * a reclaim kthread has not processed a previous batch.
> + */
> +static inline int kfree_rcu_drain(struct kfree_rcu_cpu *krcp)
>  {
> +	unsigned long flags;
> +	int ret;
> +
> +	raw_spin_lock_irqsave(&krcp->lock, flags);
> +
>  	// Attempt to start a new batch.
> -	if (queue_kfree_rcu_work(krcp)) {
> +	ret = queue_kfree_rcu_work(krcp);

This code has changed slightly in mainline.  Can you please redo,
retest and resend?

> +	if (ret)
>  		// Success! Our job is done here.
>  		krcp->monitor_todo = false;
> -		raw_spin_unlock_irqrestore(&krcp->lock, flags);
> -		return;
> -	}

It's conventional to retain the braces here, otherwise the code looks
weird.  Unless you're a python programmer ;)


