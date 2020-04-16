Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDFDC2BB85
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 14:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA0B21D94
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 14:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gbLblsjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392640AbgDPOnM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403745AbgDPOm4 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 10:42:56 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5074DC061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 07:42:56 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w29so16141226qtv.3
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 07:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=2Y0HHoxKbmIqd4tykPOdy+1wN9gUwXEV3GmjArqRwkw=;
        b=gbLblsjcfzfP7rguZiBD7Zg1IHbAdDo6rk+7oveePF06b4bSQn0OZ6q8zrqaAgCP1P
         MSUyaGacoNXqS6LAoLEsYe6Vyt9InzJjkmy9HOYsUviyw9xw1TplFBXwiwbaG1DHe6e7
         4g9jzwdTbqvebZJQAya0/bswQLNg8/q6LimGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=2Y0HHoxKbmIqd4tykPOdy+1wN9gUwXEV3GmjArqRwkw=;
        b=kroVUy7lE0TGDYOYQGQqTItvcgT1S0gIhFdaJd4CHlf+fFRy2OGx6J2KOLiPJiHqs1
         zsOy4qkE4lH3GxuXXijegpY1oNY2ubNfxDrkygzXE3kyFlVzQ3QLuN6swlO7atTYJnB/
         xEPGHSdd4cjU9TzCVfl03cNqcBz8FCsvPoBXlSWen8jS5tm4KylKJu2IADIqgldbTtW4
         JMvwy3hfH4vu1Fp7rK+HpVZd9BXwfBt4SjxZUycF/PRMJd4vjzPlU0r8kZdGoFx2Kaf0
         3AO5jE4ohadwbDal+ATmgIy5PYW11mniTp9WSLjZrO/ujoVtWMDJXACViDnSgPaSqNNS
         Ao9w==
X-Gm-Message-State: AGi0PuZjObOwOZctJw8aC37jUj6yDnUhSabefpvILl7j0smWkUki2YYz
        NGYlbHJOjABU87YtEJEpJoJ//A==
X-Google-Smtp-Source: APiQypLEWzYYqgws0QYNQAxHVduY4HjlebwxwQC+I4HnxRNastuiVExp2L+GldMIDWdoz4bWOvx/LA==
X-Received: by 2002:ac8:23e3:: with SMTP id r32mr6725909qtr.268.1587048175258;
        Thu, 16 Apr 2020 07:42:55 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n4sm14678901qkh.38.2020.04.16.07.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 07:42:54 -0700 (PDT)
Date:   Thu, 16 Apr 2020 10:42:54 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, urezki@gmail.com
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416144254.GC90777@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415160034.662274-2-bigeasy@linutronix.de>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

+Vlad

Hi Sebastian,

On Wed, Apr 15, 2020 at 06:00:32PM +0200, Sebastian Andrzej Siewior wrote:
> The per-CPU variable is initialized at runtime in
> kfree_rcu_batch_init(). This function is invoked before
> `rcu_scheduler_active' is set to `RCU_SCHEDULER_RUNNING'. After the
> initialisation, `->initialized' is to true.
> 
> The spin_lock is only acquired if `->initialized' is set to true. The
> worqueue item is only used if `rcu_scheduler_active' set to
> RCU_SCHEDULER_RUNNING' which happens after initialisation.
> 
> Use a static initializer for krc.lock and remove the runtime
> initialisation of the lock. Since the lock can now be always acquired,
> remove the `->initialized' check.
> The local_irq_save() is removed and raw_cpu_ptr() + spin_lock_irqsave()
> is used. The worst case scenario is that after raw_cpu_ptr() the code
> has been moved to another CPU. This is "okay" because the data strucure
> itself is protected with a lock.
> Add a warning in kfree_rcu_batch_init() to ensure that this function is
> invoked before `RCU_SCHEDULER_RUNNING' to ensure that the worker is not
> used earlier.
> 
> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/rcu/tree.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index f288477ee1c26..5b0b63dd04b02 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2893,7 +2893,6 @@ struct kfree_rcu_cpu_work {
>   * @lock: Synchronize access to this structure
>   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
>   * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
> - * @initialized: The @lock and @rcu_work fields have been initialized
>   *
>   * This is a per-CPU structure.  The reason that it is not included in
>   * the rcu_data structure is to permit this code to be extracted from
> @@ -2908,12 +2907,13 @@ struct kfree_rcu_cpu {
>  	spinlock_t lock;
>  	struct delayed_work monitor_work;
>  	bool monitor_todo;
> -	bool initialized;
>  	// Number of objects for which GP not started
>  	int count;
>  };
>  
> -static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
> +static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
> +	.lock	= __SPIN_LOCK_UNLOCKED(krc.lock),
> +};
>  
>  static __always_inline void
>  debug_rcu_head_unqueue_bulk(struct rcu_head *head)
> @@ -3080,9 +3080,6 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
>  {
>  	struct kfree_rcu_bulk_data *bnode;
>  
> -	if (unlikely(!krcp->initialized))
> -		return false;
> -
>  	lockdep_assert_held(&krcp->lock);
>  
>  	/* Check if a new block is required. */
> @@ -3139,10 +3136,8 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	unsigned long flags;
>  	struct kfree_rcu_cpu *krcp;
>  
> -	local_irq_save(flags);	// For safely calling this_cpu_ptr().
> -	krcp = this_cpu_ptr(&krc);
> -	if (krcp->initialized)
> -		spin_lock(&krcp->lock);
> +	krcp = raw_cpu_ptr(&krc);
> +	spin_lock_irqsave(&krcp->lock, flags);

I agree with the patch, except for this bit. Would it be ok to split the
other parts of this patch into separate patch(es)?

For this part of the patch, I am wondering what is the value in it. For one,
we don't want migration between sampling the value of the pointer, and
actually using it. One reason at least is because we have certain resources
in the per-cpu structure that take advantage of cache locality (such as the
kfree_rcu_cpu::krw_arr array). In the common case, the callback would be
executed on the same CPU it is queued on. All of the access is local to the
CPU.

I know the work item can still be handled on other CPUs so we are not
strictly doing it in the worst case (however per my understanding, the work
item is executed in the same CPU most of the time).

Also on a slightly related note, could you share with me why this_cpu_ptr()
is unsafe to call in non-preemptible context, but raw_cpu_ptr() is ok? Just
curious on that.

thanks,

 - Joel


>  
>  	// Queue the object but don't yet schedule the batch.
>  	if (debug_rcu_head_queue(head)) {
> @@ -3172,9 +3167,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	}
>  
>  unlock_return:
> -	if (krcp->initialized)
> -		spin_unlock(&krcp->lock);
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore(&krcp->lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(kfree_call_rcu);
>  
> @@ -4137,17 +4130,16 @@ static void __init kfree_rcu_batch_init(void)
>  	int cpu;
>  	int i;
>  
> +	WARN_ON(rcu_scheduler_active == RCU_SCHEDULER_RUNNING);
>  	for_each_possible_cpu(cpu) {
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
> -		spin_lock_init(&krcp->lock);
>  		for (i = 0; i < KFREE_N_BATCHES; i++) {
>  			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
>  			krcp->krw_arr[i].krcp = krcp;
>  		}
>  
>  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
> -		krcp->initialized = true;
>  	}
>  	if (register_shrinker(&kfree_rcu_shrinker))
>  		pr_err("Failed to register kfree_rcu() shrinker!\n");
> -- 
> 2.26.0
> 
