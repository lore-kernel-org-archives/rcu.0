Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EDBC28D13
	for <rcu@archiver.kernel.org>; Thu, 25 Aug 2022 15:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241716AbiHYPdy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 25 Aug 2022 11:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241502AbiHYPdw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 25 Aug 2022 11:33:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4B77E800
        for <rcu@vger.kernel.org>; Thu, 25 Aug 2022 08:33:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E7AF734B1C;
        Thu, 25 Aug 2022 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661441629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cfyIo/fWtZ0Kl9RkV9OkZsoueDvL268XlCDEAcWlf6g=;
        b=lWckUr0karFGm5BwYE1fKEaEsEfWOb3iB8xp1uRj4fWsT/GkIan46t7+pj5LZjcdYOxFXI
        CVDL+BN8RBtOCzzqDdW76FOwW7lr5eP+R/ZnEraNduu0z8XQSZC2t6fbgJyL+l477MnBbU
        B4ZX2u6VgsRZv9vuBOAXKFL1SDVBmbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661441629;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cfyIo/fWtZ0Kl9RkV9OkZsoueDvL268XlCDEAcWlf6g=;
        b=pULmF3Hnbrko+YKKTgYmwxPZbsZ113c13NnQVyrk+6AqTBX+Xa2v92XHezRabPwdbf6F79
        sWwGNVC5pMMNW6AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF4B313A8E;
        Thu, 25 Aug 2022 15:33:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IIK8MF2WB2PZaAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 25 Aug 2022 15:33:49 +0000
Message-ID: <a13be7c9-7b6f-58f9-cf53-f51a8ad0d238@suse.cz>
Date:   Thu, 25 Aug 2022 17:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: How to increase rcu_head size without breaking -mm ?
Content-Language: en-US
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     willy@infradead.org, paulmck@kernel.org, rcu <rcu@vger.kernel.org>
References: <85afd876-d8bb-0804-b2c5-48ed3055e702@joelfernandes.org>
 <be4edb7f-031b-905e-d615-560ac206d82a@suse.cz>
 <ed9ebc8e-0ea8-4e5b-45fc-38f2538e7d36@suse.cz>
 <9ac74328-decf-bf67-d943-121008ed59b8@suse.cz> <YweOepUcoY3Sol8J@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YweOepUcoY3Sol8J@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 8/25/22 17:00, Joel Fernandes wrote:
> On Thu, Aug 25, 2022 at 10:14:16AM +0200, Vlastimil Babka wrote:
>> 
>> On 8/25/22 09:50, Vlastimil Babka wrote:
>> > 
>> > On 8/25/22 09:13, Vlastimil Babka wrote:
>> >> On 8/25/22 04:56, Joel Fernandes wrote:
>> >>> Hi,
>> >>> I am trying to add some debug information to rcu_head for some patches, and need
>> >>> your help! At least this used to work some time ago (> 1 year).
>> >> 
>> >> Hmm, got a patch of how it worked back then? Because what I see (in v5.12)
>> >> struct page definition:
>> >> 
>> >> 	struct rcu_head rcu_head;
>> >> 
>> >> is in union with the whole of
>> >> 
>> >> 	struct {        /* slab, slob and slub */ ... }
>> >> 
>> >> which starts with
>> >> 
>> >> 	union { struct list_head slab_list;  ... }
>> >> 	struct kmem_cache *slab_cache; /* not slob */
>> >> 
>> >> and there's e.g. kmem_rcu_free() in mm/slab.c that does
>> >> 
>> >>         page = container_of(head, struct page, rcu_head);
>> >>         cachep = page->slab_cache;
>> >> 
>> >> and very similar thing in mm/slub.c rcu_free_slab() - we assume that the
>> >> rcu_head and slab_cache fields can coexist.
>> >> 
>> >> So this looks silently fragile to me? In case rcu_head becomes larger than
>> >> list_head, e.g. with your buf[4], it would start overlaping the
>> >> page->slab_cache field, no?
>> >> 
>> >> AFAICS the way it's structured now in struct slab in mm/slab.h, it makes the
>> >> overlap impossible, thus the struct slab will grow as rcu_head grows, and
>> >> offsets of the later fields stop matching struct page counterparts, which
>> >> doesn't grow. Hmm.
>> > 
>> > The following has made things compile for both SLUB and SLAB (didn't adjust
>> > SLOB), the idea is to define more explicitly that everything can overlap
>> > with rcu_head except slab_cache. So the structures don't even grow in the
>> > end. Which requires moving slab_cache field around. Which would be fine
>> > except for SLUB and its cmpxchg_double usage, which requires the
>> > freelist+counter fields to be 128bit aligned, which means we can't fit it
>> > all with these constraints. So that's broken with the patch and I don't see
>> > an easy way to fix this.
>> 
>> Ah maybe I found a way. It requires that rcu_head in struct slab would be at
>> different offset in struct page, and we drop the particular SLAB_MATCH
>> check. I think it should be fine as we don't cast struct slab to struct page
>> in the rcu calls/callbacks so it was probably there just for intermediate
>> steps of the struct slab series, and can be dropped now.
>> 
>> So this should allow you to use up to 32 bytes of rcu_head.
> 
> Thanks a lot, Vlastimil! I can confirm it builds, some comments below:
> 
>> ----8<----
>> diff --git a/include/linux/types.h b/include/linux/types.h
>> index ea8cf60a8a79..daf7682a7a3b 100644
>> --- a/include/linux/types.h
>> +++ b/include/linux/types.h
>> @@ -220,6 +220,7 @@ struct ustat {
>>  struct callback_head {
>>  	struct callback_head *next;
>>  	void (*func)(struct callback_head *head);
>> +	char buf[4];
>>  } __attribute__((aligned(sizeof(void *))));
>>  #define rcu_head callback_head
>>  
>> diff --git a/mm/slab.h b/mm/slab.h
>> index 4ec82bec15ec..dd49851f9814 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -12,37 +12,45 @@ struct slab {
>>  #if defined(CONFIG_SLAB)
>>  
>>  	union {
>> -		struct list_head slab_list;
>> +		struct {
>> +			struct list_head slab_list;
>> +			void *freelist;	/* array of free object indexes */
>> +			void *s_mem;	/* first object */
>> +		};
>>  		struct rcu_head rcu_head;
> 
> Does this present any problems for SLAB_TYPESAFE_BY_RCU such as the slab
> being in use before the end of a grace-period? I was concerned about the
> freelist being corrupted by the rcu_head storage, since its now in a union
> with it. If this does not matter, then that's all good.

Good point, I didn't check that. If we're freeing the slab then nothing
should be using it at that point, including the freelist pointer. Only the
actual object storage is guaranteed not to go away or become overwritten for
SLAB_TYPESAFE_BY_RCU caches.

But we need to check the slab freeing functions themselves.
It looks like SLAB is fine, slab_destroy() there takes care to copy the
freelist pointer away before call_rcu() already and then it only works with
the copy. Also nothing should need s_mem either, in case you need more bytes
for the rcu_head debug.

SLUB seems also fine as the freeing doesn't try to look at the freelist even
in case of debugging consistency checks being enabled. It could be a problem
in case of a double-free, but that's already a problem anyway.
In case you need more than the 8 bytes of freelist pointer, then overwriting
the next 'counters' union would be a problem for the consistency checks as
it reads slab->objects from there.
But I guess we could do those checks before call_rcu, so the callback would
then only free the slab page. The state expected by those checks doesn't
depend on the grace period expiring.

>> @@ -66,9 +74,13 @@ struct slab {
>>  #define SLAB_MATCH(pg, sl)						\
>>  	static_assert(offsetof(struct page, pg) == offsetof(struct slab, sl))
>>  SLAB_MATCH(flags, __page_flags);
>> +#ifdef CONFIG_SLUB
>> +SLAB_MATCH(compound_head, slab_cache);	/* Ensure bit 0 is clear */
>> +#else
>>  SLAB_MATCH(compound_head, slab_list);	/* Ensure bit 0 is clear */
>> +#endif
>>  #ifndef CONFIG_SLOB
>> -SLAB_MATCH(rcu_head, rcu_head);
>> +// SLAB_MATCH(rcu_head, rcu_head); /* not necessary, hopefully? */
> 
> I think if it helps, I can make this check as a dependency on a default-off
> debug config option.

It wouldn't help as with this patch, for SLUB the rcu_head would start at
different offset regardless of whether you enable the option to increase its
size.

> Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> thanks,
> 
>  - Joel
> 

