Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A78C28D13
	for <rcu@archiver.kernel.org>; Thu, 25 Aug 2022 07:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiHYHu0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 25 Aug 2022 03:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238574AbiHYHuV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 25 Aug 2022 03:50:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9686384
        for <rcu@vger.kernel.org>; Thu, 25 Aug 2022 00:50:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C8FD72042A;
        Thu, 25 Aug 2022 07:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661413818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9cxpdJAuDeokqd61sapMvghUPU0zsQN3NjXGo6VNW/4=;
        b=ucoEoCZg6lSuK71dYw1mAPtxIVanrhmIiqD4EZ6qNCYr3y72zuAkbGY2dKOiiwPQxJJKnu
        2Vj9dcqshXl8HHaKf633ENiSjSlhBFWcFm6jmdkS9XAobmgKIo3LJE2G+X9oRrk/KiUxYx
        tsyx7GrMiUL+pvtYRLnAViqI49z4K+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661413818;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9cxpdJAuDeokqd61sapMvghUPU0zsQN3NjXGo6VNW/4=;
        b=oGNMfeQlZJHwqZgIiPJJ9QjtrIA5XcGu2cZkQuy3bZaU+wMipUnQpO+nEu0UTlmnq+4MQG
        WQLkNZLioyu6vDBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B23C213A8E;
        Thu, 25 Aug 2022 07:50:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TYqmKropB2PqGwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 25 Aug 2022 07:50:18 +0000
Message-ID: <ed9ebc8e-0ea8-4e5b-45fc-38f2538e7d36@suse.cz>
Date:   Thu, 25 Aug 2022 09:50:18 +0200
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
In-Reply-To: <be4edb7f-031b-905e-d615-560ac206d82a@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


On 8/25/22 09:13, Vlastimil Babka wrote:
> On 8/25/22 04:56, Joel Fernandes wrote:
>> Hi,
>> I am trying to add some debug information to rcu_head for some patches, and need
>> your help! At least this used to work some time ago (> 1 year).
> 
> Hmm, got a patch of how it worked back then? Because what I see (in v5.12)
> struct page definition:
> 
> 	struct rcu_head rcu_head;
> 
> is in union with the whole of
> 
> 	struct {        /* slab, slob and slub */ ... }
> 
> which starts with
> 
> 	union { struct list_head slab_list;  ... }
> 	struct kmem_cache *slab_cache; /* not slob */
> 
> and there's e.g. kmem_rcu_free() in mm/slab.c that does
> 
>         page = container_of(head, struct page, rcu_head);
>         cachep = page->slab_cache;
> 
> and very similar thing in mm/slub.c rcu_free_slab() - we assume that the
> rcu_head and slab_cache fields can coexist.
> 
> So this looks silently fragile to me? In case rcu_head becomes larger than
> list_head, e.g. with your buf[4], it would start overlaping the
> page->slab_cache field, no?
> 
> AFAICS the way it's structured now in struct slab in mm/slab.h, it makes the
> overlap impossible, thus the struct slab will grow as rcu_head grows, and
> offsets of the later fields stop matching struct page counterparts, which
> doesn't grow. Hmm.

The following has made things compile for both SLUB and SLAB (didn't adjust
SLOB), the idea is to define more explicitly that everything can overlap
with rcu_head except slab_cache. So the structures don't even grow in the
end. Which requires moving slab_cache field around. Which would be fine
except for SLUB and its cmpxchg_double usage, which requires the
freelist+counter fields to be 128bit aligned, which means we can't fit it
all with these constraints. So that's broken with the patch and I don't see
an easy way to fix this. But maybe it can unblock your current debugging
efforts if you use SLAB, or disable the cmpxchg_double in SLUB (at some perf
cost).

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
index 4ec82bec15ec..9fdbfcc401c0 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -12,37 +12,42 @@ struct slab {
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
 
 	union {
-		struct list_head slab_list;
-		struct rcu_head rcu_head;
-#ifdef CONFIG_SLUB_CPU_PARTIAL
 		struct {
-			struct slab *next;
-			int slabs;	/* Nr of slabs left */
-		};
+			union {
+				struct list_head slab_list;
+#ifdef CONFIG_SLUB_CPU_PARTIAL
+				struct {
+					struct slab *next;
+					int slabs;	/* Nr of slabs left */
+				};
 #endif
-	};
-	struct kmem_cache *slab_cache;
-	/* Double-word boundary */
-	void *freelist;		/* first free object */
-	union {
-		unsigned long counters;
-		struct {
-			unsigned inuse:16;
-			unsigned objects:15;
-			unsigned frozen:1;
+			};
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
+	struct kmem_cache *slab_cache;
 	unsigned int __unused;
 
 #elif defined(CONFIG_SLOB)

