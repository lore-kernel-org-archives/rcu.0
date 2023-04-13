Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB890C77B71
	for <rcu@archiver.kernel.org>; Thu, 13 Apr 2023 14:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjDMOuN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Apr 2023 10:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDMOuM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Apr 2023 10:50:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD763A90
        for <rcu@vger.kernel.org>; Thu, 13 Apr 2023 07:49:51 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a4f8e5d190so6741245ad.1
        for <rcu@vger.kernel.org>; Thu, 13 Apr 2023 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681397391; x=1683989391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Muyh3IamnE6ZXDdZVJY7OPyQrN7OXiGiKOYyXgJGepo=;
        b=fjnRyzylBZKtO3ZmkaMWPg3zH8+StLYzJbPcaouyG2InQdEBl+f98v5P2uwE+Lp+vf
         QOAX0rjfrlg560sCfarppCv3qTJSdS3nNP4Jm7BqUV6FeZzpOMatS8gQylnsAlglyl5Y
         pfO0UaoE6MwEaZJLoehzRVqpFC0liewCjsSw4UxX/45Px8PP3jFSrbkoN2ZtmuNM8ezU
         cVBxbnQSnY7en6Un7ANRr+DA91wuPCCqw/hjvwW/u3PazyXiCZO+5r1UwJ6SGv14CMgW
         bppOv+6seAwcOBKNJSMpK2r+6uyYTPKhHIo0cpaoSVLtxSAwNxrsKV8xs5A2t+jY3THn
         xgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681397391; x=1683989391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Muyh3IamnE6ZXDdZVJY7OPyQrN7OXiGiKOYyXgJGepo=;
        b=i6KDKit/wGDfI8qI6K6sIYgDMdMYiU+/MD2NjR6aRYf39IcZidPmBs2plZAWFyHaFg
         X/NrvvHqeg5BMPqn42YwAe7E2/UDzwnlWuak8EtOeM2hoFW9PD7/3Rclcoo0ouX+xL/I
         djc5834XCHpn0KZmDFQ+kDiiyDEsotd/CWt7Xc7RgoKSZ/l8MOrSZNL0n0Aaj3DJnWFN
         vGCrTPUBwO3xdYvYfi/UKVDfL5q8eUeUrN+CEqaKEgty9CxStL5XKKGX3Qpvg7UVQbNs
         TiPgPlnfZGixpzi35mLYe1/JRlX2poThREh0FGB5UqV6dB/5BGmOW/CrArYx/imZQFZJ
         eUqw==
X-Gm-Message-State: AAQBX9ewXloi+QoecoT2BML6RpeaV2lpe7Am8FhPz8EZPmGAlnBl6nzh
        lUinwodzJyqauIn0/PI4rO8AUQ==
X-Google-Smtp-Source: AKy350ZuESBw6VXWyAMZYgNqo7cuyPBDfOGHxCLXaVZ1+aPQGZJqQlgsGmjF4s98yYZBorJ2lir/2w==
X-Received: by 2002:a17:90a:1954:b0:246:aedc:496 with SMTP id 20-20020a17090a195400b00246aedc0496mr2003572pjh.2.1681397390630;
        Thu, 13 Apr 2023 07:49:50 -0700 (PDT)
Received: from [10.200.11.168] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id p15-20020a17090a2d8f00b00246626343aesm3288291pjd.25.2023.04.13.07.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 07:49:50 -0700 (PDT)
Message-ID: <162e6281-8828-e0bc-2b91-183b7f3a1f65@bytedance.com>
Date:   Thu, 13 Apr 2023 22:49:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] mm: slub: annotate kmem_cache_node->list_lock as
 raw_spinlock
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhao Gongyi <zhaogongyi@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20230411130854.46795-1-zhengqi.arch@bytedance.com>
 <c6ea3b17-a89c-6f66-5c86-967f1da601b4@suse.cz>
 <ccaf5e8e-3457-a2cf-b6eb-794cbf1b46f5@bytedance.com>
 <f54cfeb9-f1c3-e656-d344-4cbf97a7c28a@suse.cz>
 <932bf921-a076-e166-4f95-1adb24d544cf@bytedance.com>
 <ZDZG6wlWIE4dzd4W@Boquns-Mac-mini.local>
 <PH0PR11MB58805856C1C47D49D1BA8092DA9B9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <e6a21ac6-939c-c686-387b-20f81ba5be53@suse.cz>
 <20230412124735.GE628377@hirez.programming.kicks-ass.net>
 <76e15f10-d3f1-2cab-63cb-25aa3b4f2cd4@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <76e15f10-d3f1-2cab-63cb-25aa3b4f2cd4@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 2023/4/13 00:44, Qi Zheng wrote:
> 
> 
> On 2023/4/12 20:47, Peter Zijlstra wrote:
>> On Wed, Apr 12, 2023 at 08:50:29AM +0200, Vlastimil Babka wrote:
>>
>>>> --- a/lib/debugobjects.c
>>>> +++ b/lib/debugobjects.c
>>>> @@ -562,10 +562,10 @@ __debug_object_init(void *addr, const struct 
>>>> debug_obj_descr *descr, int onstack
>>>>          unsigned long flags;
>>>>
>>>>          /*
>>>> -        * On RT enabled kernels the pool refill must happen in 
>>>> preemptible
>>>> +        * The pool refill must happen in preemptible
>>>>           * context:
>>>>           */
>>>> -       if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
>>>> +       if (preemptible())
>>>>                  fill_pool();
>>>
>>> +CC Peterz
>>>
>>> Aha so this is in fact another case where the code is written with
>>> actual differences between PREEMPT_RT and !PREEMPT_RT in mind, but
>>> CONFIG_PROVE_RAW_LOCK_NESTING always assumes PREEMPT_RT?
>>
>> Ooh, tricky, yes. PROVE_RAW_LOCK_NESTING always follows the PREEMP_RT
>> rules and does not expect trickery like the above.
>>
>> Something like the completely untested below might be of help..
>>
>> ---
>> diff --git a/include/linux/lockdep_types.h 
>> b/include/linux/lockdep_types.h
>> index d22430840b53..f3120d6a7d9e 100644
>> --- a/include/linux/lockdep_types.h
>> +++ b/include/linux/lockdep_types.h
>> @@ -33,6 +33,7 @@ enum lockdep_wait_type {
>>   enum lockdep_lock_type {
>>       LD_LOCK_NORMAL = 0,    /* normal, catch all */
>>       LD_LOCK_PERCPU,        /* percpu */
>> +    LD_LOCK_WAIT,        /* annotation */
>>       LD_LOCK_MAX,
>>   };
>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>> index 50d4863974e7..a4077f5bb75b 100644
>> --- a/kernel/locking/lockdep.c
>> +++ b/kernel/locking/lockdep.c
>> @@ -2279,8 +2279,9 @@ static inline bool usage_skip(struct lock_list 
>> *entry, void *mask)
>>        * As a result, we will skip local_lock(), when we search for irq
>>        * inversion bugs.
>>        */
>> -    if (entry->class->lock_type == LD_LOCK_PERCPU) {
>> -        if (DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < 
>> LD_WAIT_CONFIG))
>> +    if (entry->class->lock_type != LD_LOCK_NORMAL) {
>> +        if (entry->class->lock_type == LD_LOCK_PERCPU &&
>> +            DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < 
>> LD_WAIT_CONFIG))
>>               return false;
>>           return true;
>> @@ -4752,7 +4753,8 @@ static int check_wait_context(struct task_struct 
>> *curr, struct held_lock *next)
>>       for (; depth < curr->lockdep_depth; depth++) {
>>           struct held_lock *prev = curr->held_locks + depth;
>> -        u8 prev_inner = hlock_class(prev)->wait_type_inner;
>> +        struct lock_class *class = hlock_class(prev);
>> +        u8 prev_inner = class->wait_type_inner;
>>           if (prev_inner) {
>>               /*
>> @@ -4762,6 +4764,12 @@ static int check_wait_context(struct 
>> task_struct *curr, struct held_lock *next)
>>                * Also due to trylocks.
>>                */
>>               curr_inner = min(curr_inner, prev_inner);
>> +
>> +            /*
>> +             * Allow override for annotations.
>> +             */
>> +            if (unlikely(class->lock_type == LD_LOCK_WAIT))
>> +                curr_inner = prev_inner;
>>           }
>>       }
>> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
>> index df86e649d8be..fae71ef72a16 100644
>> --- a/lib/debugobjects.c
>> +++ b/lib/debugobjects.c
>> @@ -565,8 +565,16 @@ __debug_object_init(void *addr, const struct 
>> debug_obj_descr *descr, int onstack
>>        * On RT enabled kernels the pool refill must happen in preemptible
>>        * context:
>>        */
>> -    if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
>> +    if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
>> +        static lockdep_map dep_map = {
> 
>                  static struct lockdep_map dep_map = {
> 
>> +            .name = "wait-type-override",
>> +            .wait_type_inner = LD_WAIT_SLEEP,
>> +            .lock_type = LD_LOCK_WAIT,
>> +        };
>> +        lock_map_acquire(&dep_map);
>>           fill_pool();
>> +        lock_map_release(&dep_map);
>> +    }
>>       db = get_bucket((unsigned long) addr);
> 
> I just tested the above code, and then got the following
> warning:
> 

> 
> It seems that the LD_WAIT_SLEEP we set is already greater than the
> LD_WAIT_SPIN of the current context.
> 

Can we do something like below? This solves the warning I encountered.

diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index d22430840b53..f3120d6a7d9e 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -33,6 +33,7 @@ enum lockdep_wait_type {
  enum lockdep_lock_type {
         LD_LOCK_NORMAL = 0,     /* normal, catch all */
         LD_LOCK_PERCPU,         /* percpu */
+       LD_LOCK_WAIT,           /* annotation */
         LD_LOCK_MAX,
  };

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index dcd1d5bfc1e0..6859dba8a3aa 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2289,8 +2289,9 @@ static inline bool usage_skip(struct lock_list 
*entry, void *mask)
          * As a result, we will skip local_lock(), when we search for irq
          * inversion bugs.
          */
-       if (entry->class->lock_type == LD_LOCK_PERCPU) {
-               if (DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < 
LD_WAIT_CONFIG))
+       if (entry->class->lock_type != LD_LOCK_NORMAL) {
+               if (entry->class->lock_type == LD_LOCK_PERCPU &&
+                   DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < 
LD_WAIT_CONFIG))
                         return false;

                 return true;
@@ -3981,6 +3982,9 @@ static inline int
  valid_state(struct task_struct *curr, struct held_lock *this,
             enum lock_usage_bit new_bit, enum lock_usage_bit bad_bit)
  {
+       if (unlikely(hlock_class(this)->lock_type == LD_LOCK_WAIT))
+               return 1;
+
         if (unlikely(hlock_class(this)->usage_mask & (1 << bad_bit))) {
                 graph_unlock();
                 print_usage_bug(curr, this, bad_bit, new_bit);
@@ -4768,7 +4772,8 @@ static int check_wait_context(struct task_struct 
*curr, struct held_lock *next)

         for (; depth < curr->lockdep_depth; depth++) {
                 struct held_lock *prev = curr->held_locks + depth;
-               u8 prev_inner = hlock_class(prev)->wait_type_inner;
+               struct lock_class *class = hlock_class(prev);
+               u8 prev_inner = class->wait_type_inner;

                 if (prev_inner) {
                         /*
@@ -4778,9 +4783,19 @@ static int check_wait_context(struct task_struct 
*curr, struct held_lock *next)
                          * Also due to trylocks.
                          */
                         curr_inner = min(curr_inner, prev_inner);
+
+                       /*
+                        * Allow override for annotations.
+                        */
+                       if (unlikely(class->lock_type == LD_LOCK_WAIT))
+                               curr_inner = prev_inner;
                 }
         }

+       if (unlikely(hlock_class(next)->lock_type == LD_LOCK_WAIT &&
+                    curr_inner == LD_WAIT_SPIN))
+               curr_inner = LD_WAIT_CONFIG;
+
         if (next_outer > curr_inner)
                 return print_lock_invalid_wait_context(curr, next);

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index df86e649d8be..a8a69991b0d0 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -565,8 +565,16 @@ __debug_object_init(void *addr, const struct 
debug_obj_descr *descr, int onstack
          * On RT enabled kernels the pool refill must happen in preemptible
          * context:
          */
-       if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
+       if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+               static struct lockdep_map dep_map = {
+                       .name = "wait-type-override",
+                       .wait_type_inner = LD_WAIT_CONFIG,
+                       .lock_type = LD_LOCK_WAIT,
+               };
+               lock_map_acquire(&dep_map);
                 fill_pool();
+               lock_map_release(&dep_map);
+       }

         db = get_bucket((unsigned long) addr);

-- 
Thanks,
Qi
