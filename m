Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11CFC433EF
	for <rcu@archiver.kernel.org>; Mon, 30 May 2022 15:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242198AbiE3Ppg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 30 May 2022 11:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242333AbiE3PpT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 30 May 2022 11:45:19 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2553321C1FB
        for <rcu@vger.kernel.org>; Mon, 30 May 2022 07:54:28 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id cv1so10173248qvb.5
        for <rcu@vger.kernel.org>; Mon, 30 May 2022 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NTN+MQKx+bW62ij1InQIm3FPO6tkTdvmk6KoOotLnkA=;
        b=p5NYs907YLzIn6KK/UM34qwlh7J3KXLVjeM4jLcHIDwFETu//iiZc6Y+oTVJTJYfk0
         WCzAa3l+YmhOTtLUJc5U0YK1CpXlE9n+k6hFR+pvHS4D4AmJZ0M3TbdpfPzJFIWVFX2e
         g3AiZPA2cCT1vMjODQJGfnRI6+hrZ8ZPQ3zfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NTN+MQKx+bW62ij1InQIm3FPO6tkTdvmk6KoOotLnkA=;
        b=yfqkz6AI8PGp4/ulYH3k6aFtuIRx1dbR+G7+3utP/jPel5Bo+B+jWWIBUyO1JvqHKp
         hR9U/ds/OWv8E+8tZ9uD1y181VITmytLmRd75B6CAAq74bFdbSO4/yOZngR/qqbhZToN
         37SjlQNx7xMfW10KY2NM1hMnbWFC+yua2upNzYk6+FJ4lh/HwWziVAFM45pPWLcwL4R9
         Wi3XjWk6qcc7590yeyGc4R4finaKq8E6cjpf46G9kGIRpflkG8BaT2uWObZ5zB7snXXp
         mvKkip94JuWJTEzcdSz+odb/qS4XJp7fYIzyerN/rexG0chCQay+Hg6HooDoxoF7pvPe
         Z3Ew==
X-Gm-Message-State: AOAM530xJ9J2RAvYkE/bifWPav+ciGXQgdQde3czxWczqBo6dgJWjLMU
        2udu/wN15RHDJPSkKb8RYuHASA==
X-Google-Smtp-Source: ABdhPJxwhvKHi5Oogs1dIw6NPGO27uJqpjJERPgU07bcPrx+89alf2G16ok5h7I7ycWkcTfPmRBl1w==
X-Received: by 2002:ad4:4eef:0:b0:464:4c08:4599 with SMTP id dv15-20020ad44eef000000b004644c084599mr5357489qvb.67.1653922467550;
        Mon, 30 May 2022 07:54:27 -0700 (PDT)
Received: from [10.0.0.27] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id q78-20020a37a751000000b006a5ddd669fbsm5860952qke.103.2022.05.30.07.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 07:54:27 -0700 (PDT)
Message-ID: <2f370485-915d-a6c9-8d82-d4f1bd200c9e@joelfernandes.org>
Date:   Mon, 30 May 2022 10:54:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC v1 01/14] rcu: Add a lock-less lazy RCU implementation
Content-Language: en-US
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-2-joel@joelfernandes.org>
 <YoNl3o+JvDas5xxF@pc638.lan>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <YoNl3o+JvDas5xxF@pc638.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Vlad,

Thanks for the comments. I replied inline:

On 5/17/22 05:07, Uladzislau Rezki wrote:
>> diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
>> index 0cfb009a99b9..8968b330d6e0 100644
>> --- a/kernel/rcu/Makefile
>> +++ b/kernel/rcu/Makefile
>> @@ -16,3 +16,4 @@ obj-$(CONFIG_RCU_REF_SCALE_TEST) += refscale.o
>>  obj-$(CONFIG_TREE_RCU) += tree.o
>>  obj-$(CONFIG_TINY_RCU) += tiny.o
>>  obj-$(CONFIG_RCU_NEED_SEGCBLIST) += rcu_segcblist.o
>> +obj-$(CONFIG_RCU_LAZY) += lazy.o
>> diff --git a/kernel/rcu/lazy.c b/kernel/rcu/lazy.c
>> new file mode 100644
>> index 000000000000..55e406cfc528
>> --- /dev/null
>> +++ b/kernel/rcu/lazy.c
>> @@ -0,0 +1,145 @@
>> +/*
>> + * Lockless lazy-RCU implementation.
>> + */
>> +#include <linux/rcupdate.h>
>> +#include <linux/shrinker.h>
>> +#include <linux/workqueue.h>
>> +#include "rcu.h"
>> +
>> +// How much to batch before flushing?
>> +#define MAX_LAZY_BATCH		2048
>> +
>> +// How much to wait before flushing?
>> +#define MAX_LAZY_JIFFIES	10000
>> +
>> +// We cast lazy_rcu_head to rcu_head and back. This keeps the API simple while
>> +// allowing us to use lockless list node in the head. Also, we use BUILD_BUG_ON
>> +// later to ensure that rcu_head and lazy_rcu_head are of the same size.
>> +struct lazy_rcu_head {
>> +	struct llist_node llist_node;
>> +	void (*func)(struct callback_head *head);
>> +} __attribute__((aligned(sizeof(void *))));
>> +
>> +struct rcu_lazy_pcp {
>> +	struct llist_head head;
>> +	struct delayed_work work;
>> +	atomic_t count;
>> +};
>> +DEFINE_PER_CPU(struct rcu_lazy_pcp, rcu_lazy_pcp_ins);
>> +
>> +// Lockless flush of CPU, can be called concurrently.
>> +static void lazy_rcu_flush_cpu(struct rcu_lazy_pcp *rlp)
>> +{
>> +	struct llist_node *node = llist_del_all(&rlp->head);
>> +	struct lazy_rcu_head *cursor, *temp;
>> +
>> +	if (!node)
>> +		return;
>> +
>> +	llist_for_each_entry_safe(cursor, temp, node, llist_node) {
>> +		struct rcu_head *rh = (struct rcu_head *)cursor;
>> +		debug_rcu_head_unqueue(rh);
>> +		call_rcu(rh, rh->func);
>> +		atomic_dec(&rlp->count);
>> +	}
>> +}
>> +
>> +void call_rcu_lazy(struct rcu_head *head_rcu, rcu_callback_t func)
>> +{
>> +	struct lazy_rcu_head *head = (struct lazy_rcu_head *)head_rcu;
>> +	struct rcu_lazy_pcp *rlp;
>> +
>> +	preempt_disable();
>> +        rlp = this_cpu_ptr(&rcu_lazy_pcp_ins);
>> +	preempt_enable();
>>
> Can we get rid of such explicit disabling/enabling preemption?

Ok I'll try. Last I checked, something needs to disable preemption to
prevent warnings with sampling the current processor ID.

>> +
>> +	if (debug_rcu_head_queue((void *)head)) {
>> +		// Probable double call_rcu(), just leak.
>> +		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
>> +				__func__, head);
>> +
>> +		// Mark as success and leave.
>> +		return;
>> +	}
>> +
>> +	// Queue to per-cpu llist
>> +	head->func = func;
>> +	llist_add(&head->llist_node, &rlp->head);
>> +
>> +	// Flush queue if too big
>> +	if (atomic_inc_return(&rlp->count) >= MAX_LAZY_BATCH) {
>> +		lazy_rcu_flush_cpu(rlp);
>>
> Can we just schedule the work instead of drawn from the caller context?
> For example it can be a hard-irq context.

You raise a good point. Ok I'll do that. Though if the CB list is small,
I would prefer to do it inline. I will look more into it.

> 
>> +	} else {
>> +		if (!delayed_work_pending(&rlp->work)) {
>> +			schedule_delayed_work(&rlp->work, MAX_LAZY_JIFFIES);
>> +		}
>> +	}
>> +}
> EXPORT_SYMBOL_GPL()? to be able to use in kernel modules.
> 

Sure, will fix.

Thanks,

 - Joel
