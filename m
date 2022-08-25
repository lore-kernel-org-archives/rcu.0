Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425FBC28D13
	for <rcu@archiver.kernel.org>; Thu, 25 Aug 2022 07:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiHYHN1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 25 Aug 2022 03:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbiHYHN0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 25 Aug 2022 03:13:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85ED18E26
        for <rcu@vger.kernel.org>; Thu, 25 Aug 2022 00:13:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9C02C1FD45;
        Thu, 25 Aug 2022 07:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661411603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Q0BQN9PeDNTGKIZYJb+MBKCVnLgmAIYlCOIYS/xuNc=;
        b=cO1Eoa7l4RqT7OJVr/GXM7Srsni5gEdnmPKi1NAYtzeXksjU5C5A0w2aqq5miuXIyJ+Eiy
        FHDyHUHlAWAL+shy/zD7NoJ8P2Rwge35FqDosQ4WIseS4tOm6Up84N0YXQc+dVRgaI36RG
        Vrxn2qHRMEgYkT2i8JgO9edhnPu+E5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661411603;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Q0BQN9PeDNTGKIZYJb+MBKCVnLgmAIYlCOIYS/xuNc=;
        b=TuKUq7Cww8wI0pfwjllcUNZiUt64az+8nBQ4uKwhxg+LE84xChb/wvDbbxoJo9ZV0TjDYL
        sqJBxtIcXzhdX+BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84E4713A47;
        Thu, 25 Aug 2022 07:13:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 46qDHxMhB2NaSAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 25 Aug 2022 07:13:23 +0000
Message-ID: <be4edb7f-031b-905e-d615-560ac206d82a@suse.cz>
Date:   Thu, 25 Aug 2022 09:13:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: How to increase rcu_head size without breaking -mm ?
To:     Joel Fernandes <joel@joelfernandes.org>, willy@infradead.org,
        paulmck@kernel.org, rcu <rcu@vger.kernel.org>
References: <85afd876-d8bb-0804-b2c5-48ed3055e702@joelfernandes.org>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <85afd876-d8bb-0804-b2c5-48ed3055e702@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 8/25/22 04:56, Joel Fernandes wrote:
> Hi,
> I am trying to add some debug information to rcu_head for some patches, and need
> your help! At least this used to work some time ago (> 1 year).

Hmm, got a patch of how it worked back then? Because what I see (in v5.12)
struct page definition:

	struct rcu_head rcu_head;

is in union with the whole of

	struct {        /* slab, slob and slub */ ... }

which starts with

	union { struct list_head slab_list;  ... }
	struct kmem_cache *slab_cache; /* not slob */

and there's e.g. kmem_rcu_free() in mm/slab.c that does

        page = container_of(head, struct page, rcu_head);
        cachep = page->slab_cache;

and very similar thing in mm/slub.c rcu_free_slab() - we assume that the
rcu_head and slab_cache fields can coexist.

So this looks silently fragile to me? In case rcu_head becomes larger than
list_head, e.g. with your buf[4], it would start overlaping the
page->slab_cache field, no?

AFAICS the way it's structured now in struct slab in mm/slab.h, it makes the
overlap impossible, thus the struct slab will grow as rcu_head grows, and
offsets of the later fields stop matching struct page counterparts, which
doesn't grow. Hmm.

> I get various SLAB_MATCH() errors with a change like this:
> 
> diff --git a/include/linux/types.h b/include/linux/types.h
> index ea8cf60a8a79..daf7682a7a3b 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -220,6 +220,7 @@ struct ustat {
>  struct callback_head {
>         struct callback_head *next;
>         void (*func)(struct callback_head *head);
> +       char buf[4];
>  } __attribute__((aligned(sizeof(void *))));
>  #define rcu_head callback_head
> ---
> 
> Errors:
> mm/slab.h:67:9: note: in expansion of macro ‘static_assert’
>    67 |         static_assert(offsetof(struct page, pg) == offsetof(struct slab,
> sl))
>       |         ^~~~~~~~~~~~~
> mm/slab.h:73:1: note: in expansion of macro ‘SLAB_MATCH’
>    73 | SLAB_MATCH(_refcount, __page_refcount);
>       | ^~~~~~~~~~
> 
> ----------
> 
> I tried various things like increasing the struct slab or struct page size using
> dummy variables, but nothing gives.
> 
> I tried to print the offsets of the struct using the compiler, but that requires
> compilation to actually succeed. The same exercise with a pre-processor also
> does not help because nested structures could also including rcu_heads.
> 
> If I at least knew how the offsets were off, I could hack it for my needs (of
> course upstreaming such a change is a different story, but I do want to upstream
> some variant of rcu_head debug info).
> 
> Any thoughts on how we can accomplish this?
> 
> Thanks!
> 
>  - Joel

