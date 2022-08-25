Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90592C28D13
	for <rcu@archiver.kernel.org>; Thu, 25 Aug 2022 08:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbiHYIOU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 25 Aug 2022 04:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239512AbiHYIOU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 25 Aug 2022 04:14:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD75E5C34C
        for <rcu@vger.kernel.org>; Thu, 25 Aug 2022 01:14:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2CBE120A6F;
        Thu, 25 Aug 2022 08:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661415257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aOpaSBiOtqYNUf3Vwgx9gJZ+pualrFMxioa+DYNeAR4=;
        b=IgdOmn7nCaZnd448P4z6k+6wtSzjSpfbi12MMbL1J5vCVkKf+oZe0yvofo1C1Ls+YcuX5Z
        xiBo35JXzf5fs8nE1qdWWkdMrzBnu5X0AEum/shsqXYCr/JwhyuP4BtEB+azzeOAsDiGdA
        hblLZhplD9nRXpvKKucA5e+FUTEXVng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661415257;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aOpaSBiOtqYNUf3Vwgx9gJZ+pualrFMxioa+DYNeAR4=;
        b=ltb0y3d1uurwQLG7Dj3rKWCS//Zo6VZcmOn35MmPw7YQTGE+ixQFdpOl3++q6ez1wgm2Qm
        +Pz3V47vjBtGOfBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1638913A8E;
        Thu, 25 Aug 2022 08:14:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c8LaBFkvB2PlJgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 25 Aug 2022 08:14:17 +0000
Message-ID: <9ac74328-decf-bf67-d943-121008ed59b8@suse.cz>
Date:   Thu, 25 Aug 2022 10:14:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: How to increase rcu_head size without breaking -mm ?
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Joel Fernandes <joel@joelfernandes.org>, willy@infradead.org,
        paulmck@kernel.org, rcu <rcu@vger.kernel.org>
References: <85afd876-d8bb-0804-b2c5-48ed3055e702@joelfernandes.org>
 <be4edb7f-031b-905e-d615-560ac206d82a@suse.cz>
 <ed9ebc8e-0ea8-4e5b-45fc-38f2538e7d36@suse.cz>
In-Reply-To: <ed9ebc8e-0ea8-4e5b-45fc-38f2538e7d36@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


On 8/25/22 09:50, Vlastimil Babka wrote:
> 
> On 8/25/22 09:13, Vlastimil Babka wrote:
>> On 8/25/22 04:56, Joel Fernandes wrote:
>>> Hi,
>>> I am trying to add some debug information to rcu_head for some patches, and need
>>> your help! At least this used to work some time ago (> 1 year).
>> 
>> Hmm, got a patch of how it worked back then? Because what I see (in v5.12)
>> struct page definition:
>> 
>> 	struct rcu_head rcu_head;
>> 
>> is in union with the whole of
>> 
>> 	struct {        /* slab, slob and slub */ ... }
>> 
>> which starts with
>> 
>> 	union { struct list_head slab_list;  ... }
>> 	struct kmem_cache *slab_cache; /* not slob */
>> 
>> and there's e.g. kmem_rcu_free() in mm/slab.c that does
>> 
>>         page = container_of(head, struct page, rcu_head);
>>         cachep = page->slab_cache;
>> 
>> and very similar thing in mm/slub.c rcu_free_slab() - we assume that the
>> rcu_head and slab_cache fields can coexist.
>> 
>> So this looks silently fragile to me? In case rcu_head becomes larger than
>> list_head, e.g. with your buf[4], it would start overlaping the
>> page->slab_cache field, no?
>> 
>> AFAICS the way it's structured now in struct slab in mm/slab.h, it makes the
>> overlap impossible, thus the struct slab will grow as rcu_head grows, and
>> offsets of the later fields stop matching struct page counterparts, which
>> doesn't grow. Hmm.
> 
> The following has made things compile for both SLUB and SLAB (didn't adjust
> SLOB), the idea is to define more explicitly that everything can overlap
> with rcu_head except slab_cache. So the structures don't even grow in the
> end. Which requires moving slab_cache field around. Which would be fine
> except for SLUB and its cmpxchg_double usage, which requires the
> freelist+counter fields to be 128bit aligned, which means we can't fit it
> all with these constraints. So that's broken with the patch and I don't see
> an easy way to fix this.

Ah maybe I found a way. It requires that rcu_head in struct slab would be at
different offset in struct page, and we drop the particular SLAB_MATCH
check. I think it should be fine as we don't cast struct slab to struct page
in the rcu calls/callbacks so it was probably there just for intermediate
steps of the struct slab series, and can be dropped now.

So this should allow you to use up to 32 bytes of rcu_head.

----8<----
diff --git a/include/linux/types.h b/include/linux/types.h
index ea8cf60a8a79..daf7682a7a3b 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -220,6 +220,7 @@ struct ustat {
 struct callback_head {
 	struct callback_head *next;
 	void (*func)(struct callback_head *head);
+	char buf[4];
 } __attribute__((aligned(sizeof(void *))));
 #define rcu_head callback_head
 
diff --git a/mm/slab.h b/mm/slab.h
index 4ec82bec15ec..dd49851f9814 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -12,37 +12,45 @@ struct slab {
 #if defined(CONFIG_SLAB)
 
 	union {
-		struct list_head slab_list;
+		struct {
+			struct list_head slab_list;
+			void *freelist;	/* array of free object indexes */
+			void *s_mem;	/* first object */
+		};
 		struct rcu_head rcu_head;
 	};
 	struct kmem_cache *slab_cache;
-	void *freelist;	/* array of free object indexes */
-	void *s_mem;	/* first object */
 	unsigned int active;
 
 #elif defined(CONFIG_SLUB)
 
-	union {
-		struct list_head slab_list;
-		struct rcu_head rcu_head;
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-		struct {
-			struct slab *next;
-			int slabs;	/* Nr of slabs left */
-		};
-#endif
-	};
 	struct kmem_cache *slab_cache;
-	/* Double-word boundary */
-	void *freelist;		/* first free object */
+
 	union {
-		unsigned long counters;
 		struct {
-			unsigned inuse:16;
-			unsigned objects:15;
-			unsigned frozen:1;
+			union {
+				struct list_head slab_list;
+#ifdef CONFIG_SLUB_CPU_PARTIAL
+				struct {
+					struct slab *next;
+					int slabs;	/* Nr of slabs left */
+				};
+#endif
+			};
+			/* Double-word boundary */
+			void *freelist;		/* first free object */
+			union {
+				unsigned long counters;
+				struct {
+					unsigned inuse:16;
+					unsigned objects:15;
+					unsigned frozen:1;
+				};
+			};
 		};
+		struct rcu_head rcu_head;
 	};
+
 	unsigned int __unused;
 
 #elif defined(CONFIG_SLOB)
@@ -66,9 +74,13 @@ struct slab {
 #define SLAB_MATCH(pg, sl)						\
 	static_assert(offsetof(struct page, pg) == offsetof(struct slab, sl))
 SLAB_MATCH(flags, __page_flags);
+#ifdef CONFIG_SLUB
+SLAB_MATCH(compound_head, slab_cache);	/* Ensure bit 0 is clear */
+#else
 SLAB_MATCH(compound_head, slab_list);	/* Ensure bit 0 is clear */
+#endif
 #ifndef CONFIG_SLOB
-SLAB_MATCH(rcu_head, rcu_head);
+// SLAB_MATCH(rcu_head, rcu_head); /* not necessary, hopefully? */
 #endif
 SLAB_MATCH(_refcount, __page_refcount);
 #ifdef CONFIG_MEMCG


