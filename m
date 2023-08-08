Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83A8C07E8A
	for <rcu@archiver.kernel.org>; Tue,  8 Aug 2023 19:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjHHTRe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbjHHTRS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Aug 2023 15:17:18 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F186EF83BD
        for <rcu@vger.kernel.org>; Tue,  8 Aug 2023 09:39:20 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6879986a436so975441b3a.0
        for <rcu@vger.kernel.org>; Tue, 08 Aug 2023 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691512759; x=1692117559;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wpg6aIffbYjICJhycB3Bph3fxU0UaKYZ32RPKTrhmtc=;
        b=E9GnE5R/lyqXlGh7kSjVyR3YEzmaGZpo3a8UxrPMsSsRjmBohRvrVAYI+VL8joJYRV
         +l4hRoTDNfo6hnpjHnj0nY5txvCNTSOAR7qxKTyk9rlTKh7q0/X3PvBhe22L8cE/b3pb
         ur2LW9OR7AnFrQlalom+OKyWIiokjmyAIwTzPCpxpO871ruBA11YrmUKo+E0gYSIaDAE
         c2Ii28StqrLfTF/pfLiqfziTYx07t55PRTZXu7xXd1R9M1HYttrTImX79glazgX/q5SS
         HOML9nS+lb3imNZ2YNkG7TFeRsduCF5bl8boszN+359YhaDb77X5cOcYcvYe4JpcN4qZ
         2TNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512759; x=1692117559;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpg6aIffbYjICJhycB3Bph3fxU0UaKYZ32RPKTrhmtc=;
        b=jzYj7GEr6qhJ4Zoyodh9FPfV+ML+A8ta3DG6lFsfQEhhZbVZy4aK9QMIoXa1logyZn
         +Uw1dHbnpIdUR5e92PYlLM8y2g1Rb4ICoh5UGjI3iQHbuDXAKPNfQrr99hWeI0PKZzwM
         2nYjCa8TIgR8W1k/Y3Sxx/HFI638qNpfjeO2OB5OqVlVT+Qcf0Isktuu+RzopcoJWgRx
         frFUXaTMxHh9FWz+HJqKCeKfrXaceCWT8usiSik5hcdiM69K7SZL5ZWYhE2SbA5YL2Sw
         bknLNoNi1XG+AY1cgD/9uRTtljYg8/Sy+aQnRXGp34RtrCr2tguIlbVyBH/mj+6DVfXZ
         Mm6A==
X-Gm-Message-State: AOJu0YwRJQsCpsqfxn0w+JW0FXA5fENBdkQZqYqmh6ysasT2bakwzQ8+
        nmGXjRURFruOz20RspnK5ISNvYPGrnF1rHaY5cg=
X-Google-Smtp-Source: APBJJlEd8UgUmVjTGODajLkItGQ9rG+lZy4ypLT00ATvxhzy6MYHUWJPNACQWVHeXI8Weqa+eylbDA==
X-Received: by 2002:a17:90a:6c97:b0:263:730b:f568 with SMTP id y23-20020a17090a6c9700b00263730bf568mr25207579pjj.3.1691481032358;
        Tue, 08 Aug 2023 00:50:32 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090a410400b00263154aab24sm7244870pjf.57.2023.08.08.00.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 00:50:31 -0700 (PDT)
Message-ID: <5757e341-b261-14de-e052-46606d530460@bytedance.com>
Date:   Tue, 8 Aug 2023 15:50:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 46/48] mm: shrinker: make memcg slab shrink lockless
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, vbabka@suse.cz,
        roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
        paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
        cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
        gregkh@linuxfoundation.org, muchun.song@linux.dev,
        simon.horman@corigine.com, dlemoal@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
 <20230807110936.21819-47-zhengqi.arch@bytedance.com>
 <ZNGr+1orhHaBORJG@dread.disaster.area>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <ZNGr+1orhHaBORJG@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Dave,

On 2023/8/8 10:44, Dave Chinner wrote:
> On Mon, Aug 07, 2023 at 07:09:34PM +0800, Qi Zheng wrote:
>> Like global slab shrink, this commit also uses refcount+RCU method to make
>> memcg slab shrink lockless.
> 
> This patch does random code cleanups amongst the actual RCU changes.
> Can you please move the cleanups to a spearate patch to reduce the
> noise in this one?

Sure, will do.

> 
>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>> index d318f5621862..fee6f62904fb 100644
>> --- a/mm/shrinker.c
>> +++ b/mm/shrinker.c
>> @@ -107,6 +107,12 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
>>   					 lockdep_is_held(&shrinker_rwsem));
>>   }
>>   
>> +static struct shrinker_info *shrinker_info_rcu(struct mem_cgroup *memcg,
>> +					       int nid)
>> +{
>> +	return rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
>> +}
> 
> This helper doesn't add value. It doesn't tell me that
> rcu_read_lock() needs to be held when it is called, for one....

How about adding a comment or an assertion here?

> 
>>   static int expand_one_shrinker_info(struct mem_cgroup *memcg, int new_size,
>>   				    int old_size, int new_nr_max)
>>   {
>> @@ -198,7 +204,7 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>>   		struct shrinker_info_unit *unit;
>>   
>>   		rcu_read_lock();
>> -		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
>> +		info = shrinker_info_rcu(memcg, nid);
> 
> ... whilst the original code here was obviously correct.
> 
>>   		unit = info->unit[shriner_id_to_index(shrinker_id)];
>>   		if (!WARN_ON_ONCE(shrinker_id >= info->map_nr_max)) {
>>   			/* Pairs with smp mb in shrink_slab() */
>> @@ -211,7 +217,7 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>>   
>>   static DEFINE_IDR(shrinker_idr);
>>   
>> -static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>> +static int shrinker_memcg_alloc(struct shrinker *shrinker)
> 
> Cleanups in a separate patch.

OK.

> 
>> @@ -253,10 +258,15 @@ static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
>>   {
>>   	struct shrinker_info *info;
>>   	struct shrinker_info_unit *unit;
>> +	long nr_deferred;
>>   
>> -	info = shrinker_info_protected(memcg, nid);
>> +	rcu_read_lock();
>> +	info = shrinker_info_rcu(memcg, nid);
>>   	unit = info->unit[shriner_id_to_index(shrinker->id)];
>> -	return atomic_long_xchg(&unit->nr_deferred[shriner_id_to_offset(shrinker->id)], 0);
>> +	nr_deferred = atomic_long_xchg(&unit->nr_deferred[shriner_id_to_offset(shrinker->id)], 0);
>> +	rcu_read_unlock();
>> +
>> +	return nr_deferred;
>>   }
> 
> This adds two rcu_read_lock() sections to every call to
> do_shrink_slab(). It's not at all clear ifrom any of the other code
> that do_shrink_slab() now has internal rcu_read_lock() sections....

The xchg_nr_deferred_memcg() will only be called in shrink_slab_memcg(),
so other code doesn't need to know that information?

> 
>> @@ -464,18 +480,23 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>   	if (!mem_cgroup_online(memcg))
>>   		return 0;
>>   
>> -	if (!down_read_trylock(&shrinker_rwsem))
>> -		return 0;
>> -
>> -	info = shrinker_info_protected(memcg, nid);
>> +again:
>> +	rcu_read_lock();
>> +	info = shrinker_info_rcu(memcg, nid);
>>   	if (unlikely(!info))
>>   		goto unlock;
>>   
>> -	for (; index < shriner_id_to_index(info->map_nr_max); index++) {
>> +	if (index < shriner_id_to_index(info->map_nr_max)) {
>>   		struct shrinker_info_unit *unit;
>>   
>>   		unit = info->unit[index];
>>   
>> +		/*
>> +		 * The shrinker_info_unit will not be freed, so we can
>> +		 * safely release the RCU lock here.
>> +		 */
>> +		rcu_read_unlock();
> 
> Why - what guarantees that the shrinker_info_unit exists at this
> point? We hold no reference to it, we hold no reference to any
> shrinker, etc. What provides this existence guarantee?

The shrinker_info_unit is never freed unless the memcg is destroyed.
Here we hold the refcount of this memcg (mem_cgroup_iter() -->
css_tryget()), so the shrinker_info_unit will not be freed.

> 
>> +
>>   		for_each_set_bit(offset, unit->map, SHRINKER_UNIT_BITS) {
>>   			struct shrink_control sc = {
>>   				.gfp_mask = gfp_mask,
>> @@ -485,12 +506,14 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>   			struct shrinker *shrinker;
>>   			int shrinker_id = calc_shrinker_id(index, offset);
>>   
>> +			rcu_read_lock();
>>   			shrinker = idr_find(&shrinker_idr, shrinker_id);
>> -			if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
>> -				if (!shrinker)
>> -					clear_bit(offset, unit->map);
>> +			if (unlikely(!shrinker || !shrinker_try_get(shrinker))) {
>> +				clear_bit(offset, unit->map);
>> +				rcu_read_unlock();
>>   				continue;
>>   			}
>> +			rcu_read_unlock();
>>   
>>   			/* Call non-slab shrinkers even though kmem is disabled */
>>   			if (!memcg_kmem_online() &&
>> @@ -523,15 +546,20 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>   					set_shrinker_bit(memcg, nid, shrinker_id);
>>   			}
>>   			freed += ret;
>> -
>> -			if (rwsem_is_contended(&shrinker_rwsem)) {
>> -				freed = freed ? : 1;
>> -				goto unlock;
>> -			}
>> +			shrinker_put(shrinker);
> 
> Ok, so why is this safe to call without holding the rcu read lock?
> The global shrinker has to hold the rcu_read_lock() whilst calling
> shrinker_put() to guarantee the validity of the list next pointer,
> but we don't hold off RCU here so what guarantees a racing global
> shrinker walk doesn't trip over this shrinker_put() call dropping
> the refcount to zero and freeing occuring in a different context...

This will not be a problem, even if shrinker::refcount is reduced to
0 here, the racing global shrinker walk already holds the rcu lock.

         shrink_slab            shrink_slab_memcg
         ===========            =================

         rcu_read_lock()
         shrinker_put()
                                shrinker_put()

And in shrink_slab_memcg(), the shrinker is not required to traverse the
next bit in the shrinker_info_unit::map, so there is no need to hold the
rcu lock to ensure the existence of this shrinker.

> 
> 
>> +		/*
>> +		 * We have already exited the read-side of rcu critical section
>> +		 * before calling do_shrink_slab(), the shrinker_info may be
>> +		 * released in expand_one_shrinker_info(), so reacquire the
>> +		 * shrinker_info.
>> +		 */
>> +		index++;
>> +		goto again;
> 
> With that, what makes the use of shrinker_info in
> xchg_nr_deferred_memcg() in do_shrink_slab() coherent and valid?

Holding rcu lock can ensure that the old shrinker_info will not be
freed, and the shrinker_info_unit::nr_deferred can also be indexed from
the old shrinker_info::unit[x], so the updated nr_deferred will not be
lost.

Thanks,
Qi

> 
> -Dave.
