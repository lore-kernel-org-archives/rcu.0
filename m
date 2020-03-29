Return-Path: <SRS0=XH5Y=5O=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE70C2D0E5
	for <rcu@archiver.kernel.org>; Sun, 29 Mar 2020 22:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E59620748
	for <rcu@archiver.kernel.org>; Sun, 29 Mar 2020 22:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Sa3XsSQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgC2W4N (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 29 Mar 2020 18:56:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44793 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgC2W4N (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 29 Mar 2020 18:56:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id x16so13636093qts.11
        for <rcu@vger.kernel.org>; Sun, 29 Mar 2020 15:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TJUFuH5KI2cZeG3dkXjBAuM8SjtTTH30E3rFuv3OGCg=;
        b=Sa3XsSQLz2mkDf/5sLGfSQ7Vyl1lUmWKfhRMVL7R+7miFvuqoKiwq36dppLeid4wbv
         E9SQax0/bwLG51GUAK4kpEp84YZ8f219FZrSOoc5uiS00O7V50M7tYYtaUzDeAXsAKOH
         tfI2zXGiODKH3+zHWltzD09kbH+DkhG5qikQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TJUFuH5KI2cZeG3dkXjBAuM8SjtTTH30E3rFuv3OGCg=;
        b=QREpSkifmjJocyJEN+dEUk+ECYT3XtpiOLwSNlqlMyPf2m9qWm95igZdYQG9XyF9oc
         UwQRoZxdqzxZ96+TmFUSZXQ+jDnIxSmYpST5w6elYUBQfI5+hArbjGhtebBgg8WHv5CY
         rY1Tz1f+KimcL4iCGiKGTsWgZylST0xiZFxpndcPBpgiWzgYkYwnFyNzPUMc2uhQvH/x
         T8URBgIaTW005EiW49ONZb5/drhY2Vot0coS1w1Pw0qp85KDE7GFzxyQBYGgk16L5oeP
         HIfDdXPVILcAZaZVXI5wlHvSy5tHeWaO0Ls03dJbMPx4vNaYvDjP5bUH89KAzKuCZfDh
         8+MQ==
X-Gm-Message-State: ANhLgQ0TUaedJmLRlZv1rbshlVun8I+OxIRIIxUt+8hf5O7XCPQgAZeB
        PqmURcd3xhYcQEKZRJutSVldLQ==
X-Google-Smtp-Source: ADFU+vsHL7i9mYzYurArqMn3V4kQowmno4mencJGmYVzboRlh/IPPsuFeXXs7WY9W8MeSJ8wEovxiQ==
X-Received: by 2002:ac8:32db:: with SMTP id a27mr9632473qtb.165.1585522571587;
        Sun, 29 Mar 2020 15:56:11 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e66sm9058483qkd.129.2020.03.29.15.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 15:56:10 -0700 (PDT)
Date:   Sun, 29 Mar 2020 18:56:10 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 4/7] rcu/tree: support reclaim for head-less object
Message-ID: <20200329225610.GA102186@google.com>
References: <20200323113621.12048-1-urezki@gmail.com>
 <20200323113621.12048-5-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323113621.12048-5-urezki@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 23, 2020 at 12:36:18PM +0100, Uladzislau Rezki (Sony) wrote:
> Update the kvfree_call_rcu() with head-less support, it
> means an object without any rcu_head structure can be
> reclaimed after GP.
> 
> To store pointers there are two chain-arrays maintained
> one for SLAB and another one is for vmalloc. Both types
> of objects(head-less variant and regular one) are placed
> there based on the type.
> 
> It can be that maintaining of arrays becomes impossible
> due to high memory pressure. For such reason there is an
> emergency path. In that case objects with rcu_head inside
> are just queued building one way list. Later on that list
> is drained.
> 
> As for head-less variant. Such objects do not have any
> rcu_head helper inside. Thus it is dynamically attached.
> As a result an object consists of back-pointer and regular
> rcu_head. It implies that emergency path can detect such
> object type, therefore they are tagged. So a back-pointer
> could be freed as well as dynamically attached wrapper.
> 
> Even though such approach requires dynamic memory it needs
> only sizeof(unsigned long *) + sizeof(struct rcu_head) bytes,
> thus SLAB is used to obtain it. Finally if attaching of the
> rcu_head and queuing get failed, the current context has
> to follow might_sleep() annotation, thus below steps could
> be applied:
>    a) wait until a grace period has elapsed;
>    b) direct inlining of the kvfree() call.

Very nice work, Vlad! And beautifully split! Makes it easy to review! One
comment below but otherwise patches 1-4 look good to me, I will look at
others as well now. I have some patches on top of the series, mostly little
clean ups which I will send together with yours.

> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 94 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 86 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 869a72e25d38..5a64c92feafc 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2892,19 +2892,34 @@ static void kfree_rcu_work(struct work_struct *work)
>  	 * when we could not allocate a bulk array.
>  	 *
>  	 * Under that condition an object is queued to the
> -	 * list instead.
> +	 * list instead. Please note that head-less objects
> +	 * have dynamically attached rcu_head, so they also
> +	 * contain a back-pointer that has to be freed.
>  	 */
>  	for (; head; head = next) {
>  		unsigned long offset = (unsigned long)head->func;
> -		void *ptr = (void *)head - offset;
> +		bool headless;
> +		void *ptr;
>  
>  		next = head->next;
> +
> +		/* We tag the headless object, if so adjust offset. */
> +		headless = (((unsigned long) head - offset) & BIT(0));
> +		if (headless)
> +			offset -= 1;

Just to be sure, can vmalloc() ever allocate an object at an odd valued
memory address? I'm not fully sure looking at vmalloc code whether this is
the case.

As per the tagging, allocated objects have to at least at a 2-byte boundary
for the pointer's BIT(0) to be available. If that's not the case, we need to
add a warning to the code at a bare minimum.

Another approach which is better I think is to add the tag to the offset
itself. So if the offset is > LONG_MAX / 2 or something like that, then
assume it is headless, and override offset to sizeof(unsigned long *) in that
case. Then you would arrive at the correct pointer for the wrapper. That
would take care of the case where in the future, either SLAB or vmalloc()
ends up returning pointers that are only byte-aligned.

Thoughts?

thanks,

 - Joel


> +
> +		ptr = (void *) head - offset;
>  		debug_rcu_head_unqueue((struct rcu_head *)ptr);
> +
>  		rcu_lock_acquire(&rcu_callback_map);
>  		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
>  
> -		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
> +		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset))) {
> +			if (headless)
> +				kvfree((void *) *((unsigned long *) ptr));
> +
>  			kvfree(ptr);
> +		}
>  
>  		rcu_lock_release(&rcu_callback_map);
>  		cond_resched_tasks_rcu_qs();
> @@ -3053,6 +3068,25 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
>  	return true;
>  }
>  
> +static inline struct rcu_head *
> +attach_rcu_head_to_object(void *obj)
> +{
> +	unsigned long *ptr;
> +
> +	ptr = kmalloc(sizeof(unsigned long *) +
> +			sizeof(struct rcu_head), GFP_NOWAIT | __GFP_NOWARN);
> +
> +	if (!ptr)
> +		ptr = kmalloc(sizeof(unsigned long *) +
> +				sizeof(struct rcu_head), GFP_ATOMIC | __GFP_NOWARN);
> +
> +	if (!ptr)
> +		return NULL;
> +
> +	ptr[0] = (unsigned long) obj;
> +	return ((struct rcu_head *) ++ptr);
> +}
> +
>  /*
>   * Queue a request for lazy invocation of appropriate free routine after a
>   * grace period. Please note there are three paths are maintained, two are the
> @@ -3071,20 +3105,37 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	unsigned long flags;
>  	struct kfree_rcu_cpu *krcp;
>  	bool expedited_drain = false;
> +	bool success;
>  	void *ptr;
>  
> +	if (head) {
> +		ptr = (void *) head - (unsigned long) func;
> +	} else {
> +		/*
> +		 * Please note there is a limitation for the head-less
> +		 * variant, that is why there is a clear rule for such
> +		 * objects:
> +		 *
> +		 * use it from might_sleep() context only. For other
> +		 * places please embed an rcu_head to your structures.
> +		 */
> +		might_sleep();
> +		ptr = (unsigned long *) func;
> +	}
> +
>  	local_irq_save(flags);	// For safely calling this_cpu_ptr().
>  	krcp = this_cpu_ptr(&krc);
>  	if (krcp->initialized)
>  		spin_lock(&krcp->lock);
>  
> -	ptr = (void *)head - (unsigned long)func;
> -
>  	// Queue the object but don't yet schedule the batch.
>  	if (debug_rcu_head_queue(ptr)) {
>  		// Probable double kfree_rcu(), just leak.
>  		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
>  			  __func__, head);
> +
> +		/* Mark as success and leave. */
> +		success = true;
>  		goto unlock_return;
>  	}
>  
> @@ -3092,7 +3143,22 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	 * Under high memory pressure GFP_NOWAIT can fail,
>  	 * in that case the emergency path is maintained.
>  	 */
> -	if (!kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr)) {
> +	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
> +	if (!success) {
> +		/* Is headless object? */
> +		if (head == NULL) {
> +			head = attach_rcu_head_to_object(ptr);
> +			if (head == NULL)
> +				goto unlock_return;
> +
> +			/*
> +			 * Tag the headless object. Such objects have a back-pointer
> +			 * to the original allocated memory, that has to be freed as
> +			 * well as dynamically attached wrapper/head.
> +			 */
> +			func = (rcu_callback_t) (sizeof(unsigned long *) + 1);
> +		}
> +
>  		head->func = func;
>  		head->next = krcp->head;
>  		krcp->head = head;
> @@ -3104,15 +3170,15 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  		 * appropriate free calls.
>  		 */
>  		expedited_drain = true;
> +		success = true;
>  	}
>  
>  	WRITE_ONCE(krcp->count, krcp->count + 1);
>  
>  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> -	    !krcp->monitor_todo) {
> +			!krcp->monitor_todo) {
>  		krcp->monitor_todo = true;
> -
>  		schedule_delayed_work(&krcp->monitor_work,
>  			expedited_drain ? 0:KFREE_DRAIN_JIFFIES);
>  	}
> @@ -3121,6 +3187,18 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	if (krcp->initialized)
>  		spin_unlock(&krcp->lock);
>  	local_irq_restore(flags);
> +
> +	/*
> +	 * High memory pressure, so inline kvfree() after
> +	 * synchronize_rcu(). We can do it from might_sleep()
> +	 * context only, so the current CPU can pass the QS
> +	 * state.
> +	 */
> +	if (!success) {
> +		debug_rcu_head_unqueue(ptr);
> +		synchronize_rcu();
> +		kvfree(ptr);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(kvfree_call_rcu);
>  
> -- 
> 2.20.1
> 
