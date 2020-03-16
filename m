Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840BBC18E5B
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 15:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539482051A
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 15:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Zv0maAsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbgCPPZp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:25:45 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44644 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731483AbgCPPZp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 11:25:45 -0400
Received: by mail-qk1-f195.google.com with SMTP id j4so10268847qkc.11
        for <rcu@vger.kernel.org>; Mon, 16 Mar 2020 08:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M5hp6/t2ZsKT75fwra74pWmebOAKqUocp3RwbuJ8/24=;
        b=Zv0maAshwddKvlvMcnrPDSBBChRsr7/8sMOgsHpfJthkmVcZy/uJ51nB+DHHfJLXrn
         jwdJo8o0CSc8VCeXA+byetdsPQ3q9UxPQ/dxi/lyTcopXlvXQHQ49uonH94pmpZUrNAV
         wYEuv0nFSAcQBIpPFW9swNHO7A4wHYgGlhQ1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M5hp6/t2ZsKT75fwra74pWmebOAKqUocp3RwbuJ8/24=;
        b=V8W6K2PoXbkHnm6waOnpMWLcQyhMHfC3BxiKFx484FY+BlBTL8WUzFsmDnzp76s6q1
         cQk44Sc3v1iOvqjFdSGPfYbnfonXJoGd8VdMbf3g8Vk3B/OVIrtqCgc/lgA6uA+Xa9DI
         sHFW0+iskNszNBlMdIccG55xN2b91aHvwrVP9C4C4J52axyMfr37oG6BZGuR2C1NveHW
         s6Pv9QULRXjRiRrkssIDoFskbM+xNVRANUkisJw8BtpI7LRWaMbvmtjzff+qZ9xplaWS
         Jr+1Kb9U6JnnfDyMnmwHoL3WyJE7W2K0nxXyL2srCpQcutD9dYoJrjOzLNcekV8Y37u0
         iNMg==
X-Gm-Message-State: ANhLgQ25nweFbT2awTRWavfvd28QvIfQcHj25VWoKGzu0E9tmdAIBfef
        mO9gTZohBeAnyKLnyM+dX2e/Tg==
X-Google-Smtp-Source: ADFU+vsK6FYdsELiy121wFGZQBIEBHVByxajp4l7URHWGvPTIppXrDZkCmM54Waz+TS2gZrzsbYXKw==
X-Received: by 2002:ae9:de06:: with SMTP id s6mr242282qkf.34.1584372342909;
        Mon, 16 Mar 2020 08:25:42 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t7sm11989327qtr.88.2020.03.16.08.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:25:42 -0700 (PDT)
Date:   Mon, 16 Mar 2020 11:25:41 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v1 5/6] rcu: rename kfree_call_rcu()/__kfree_rcu()
Message-ID: <20200316152541.GD190951@google.com>
References: <20200315181840.6966-1-urezki@gmail.com>
 <20200315181840.6966-6-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315181840.6966-6-urezki@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Mar 15, 2020 at 07:18:39PM +0100, Uladzislau Rezki (Sony) wrote:
> Rename kfree_call_rcu() to the kvfree_call_rcu().
> The reason is, it is capable of freeing vmalloc()
> memory now.
> 
> Do the same with __kfree_rcu() macro, it becomes
> __kvfree_rcu(), the reason is the same as pointed
> above.

Vlad, this patch does not apply to my branch that I shared with you. Sorry if
I was not clear earlier, could we work on the same branch to avoid conflicts?

I based the kfree_rcu shrinker patches on an 'rcu/kfree' branch in my git
tree: https://github.com/joelagnel/linux-kernel/tree/rcu/kfree

For now I manually applied 5/6. All others applied cleanly.

Updated the tree as I continue to review your patches.

thanks,

 - Joel


> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/rcupdate.h | 8 ++++----
>  include/linux/rcutiny.h  | 2 +-
>  include/linux/rcutree.h  | 2 +-
>  kernel/rcu/tree.c        | 8 ++++----
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index e4961631a44f..6c660fa1f551 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -805,10 +805,10 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>  /*
>   * Helper macro for kfree_rcu() to prevent argument-expansion eyestrain.
>   */
> -#define __kfree_rcu(head, offset) \
> +#define __kvfree_rcu(head, offset) \
>  	do { \
>  		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offset)); \
> -		kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
> +		kvfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
>  	} while (0)
>  
>  /**
> @@ -827,7 +827,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>   * Because the functions are not allowed in the low-order 4096 bytes of
>   * kernel virtual memory, offsets up to 4095 bytes can be accommodated.
>   * If the offset is larger than 4095 bytes, a compile-time error will
> - * be generated in __kfree_rcu().  If this error is triggered, you can
> + * be generated in __kvfree_rcu(). If this error is triggered, you can
>   * either fall back to use of call_rcu() or rearrange the structure to
>   * position the rcu_head structure into the first 4096 bytes.
>   *
> @@ -842,7 +842,7 @@ do {									\
>  	typeof (ptr) ___p = (ptr);					\
>  									\
>  	if (___p)							\
> -		__kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
> +		__kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
>  } while (0)
>  
>  /**
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index 045c28b71f4f..4cae3dd77173 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -34,7 +34,7 @@ static inline void synchronize_rcu_expedited(void)
>  	synchronize_rcu();
>  }
>  
> -static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
>  	call_rcu(head, func);
>  }
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index 45f3f66bb04d..3a7829d69fef 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -33,7 +33,7 @@ static inline void rcu_virt_note_context_switch(int cpu)
>  }
>  
>  void synchronize_rcu_expedited(void);
> -void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
> +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
>  
>  void rcu_barrier(void);
>  bool rcu_eqs_special_set(int cpu);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index bb9544238396..19e6cb970c38 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3054,18 +3054,18 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
>  }
>  
>  /*
> - * Queue a request for lazy invocation of kfree_bulk()/kfree() after a grace
> + * Queue a request for lazy invocation of kfree_bulk()/kvfree() after a grace
>   * period. Please note there are two paths are maintained, one is the main one
>   * that uses kfree_bulk() interface and second one is emergency one, that is
>   * used only when the main path can not be maintained temporary, due to memory
>   * pressure.
>   *
> - * Each kfree_call_rcu() request is added to a batch. The batch will be drained
> + * Each kvfree_call_rcu() request is added to a batch. The batch will be drained
>   * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
>   * be free'd in workqueue context. This allows us to: batch requests together to
>   * reduce the number of grace periods during heavy kfree_rcu() load.
>   */
> -void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
>  	unsigned long flags;
>  	struct kfree_rcu_cpu *krcp;
> @@ -3112,7 +3112,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  		spin_unlock(&krcp->lock);
>  	local_irq_restore(flags);
>  }
> -EXPORT_SYMBOL_GPL(kfree_call_rcu);
> +EXPORT_SYMBOL_GPL(kvfree_call_rcu);
>  
>  void __init kfree_rcu_scheduler_running(void)
>  {
> -- 
> 2.20.1
> 
