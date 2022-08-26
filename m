Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606B7ECAAA3
	for <rcu@archiver.kernel.org>; Fri, 26 Aug 2022 08:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245460AbiHZIud (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 26 Aug 2022 04:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245615AbiHZIuT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 26 Aug 2022 04:50:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E51C42AFB
        for <rcu@vger.kernel.org>; Fri, 26 Aug 2022 01:50:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2618B33707;
        Fri, 26 Aug 2022 08:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661503814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Diw3TCLtpjToiUYP1X1W0CQsk7aUnVIs/QEEEr68lRY=;
        b=eXbiNtgdwjPexjMCoxa5yTvj/lYMATlzRcVP4MJpKwxU98MIm2jiFhFEIS/sKxiOBjuqus
        dzO/R083KFptVphvBtcOVj2g4+nmCtO3VWJdJL5WIapU0j8WyA253r3ErkoqDh6dMYhd/V
        ZbNje7Jqwj2DSbdHYv37CoAvBDelAp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661503814;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Diw3TCLtpjToiUYP1X1W0CQsk7aUnVIs/QEEEr68lRY=;
        b=r27ZSGwjIi/ygtVQHfrLx5MKElHPd1ROl+bQKyHmv4HkAv0M5iq5Qh2zKJ//MQJ0NA8HbG
        B0FPfHuVnD5h1LAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FF0113421;
        Fri, 26 Aug 2022 08:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W3pGA0aJCGMDMQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 26 Aug 2022 08:50:14 +0000
Message-ID: <1d364b1c-51fd-0e34-bf25-d5679b797431@suse.cz>
Date:   Fri, 26 Aug 2022 10:50:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: How to increase rcu_head size without breaking -mm ?
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     willy@infradead.org, paulmck@kernel.org, rcu <rcu@vger.kernel.org>
References: <85afd876-d8bb-0804-b2c5-48ed3055e702@joelfernandes.org>
 <be4edb7f-031b-905e-d615-560ac206d82a@suse.cz>
 <ed9ebc8e-0ea8-4e5b-45fc-38f2538e7d36@suse.cz>
 <9ac74328-decf-bf67-d943-121008ed59b8@suse.cz> <YweOepUcoY3Sol8J@google.com>
 <a13be7c9-7b6f-58f9-cf53-f51a8ad0d238@suse.cz> <YwfSsMPqHmHMG6gN@google.com>
 <2837161b-4933-0778-42be-70922c6bd0fe@suse.cz>
In-Reply-To: <2837161b-4933-0778-42be-70922c6bd0fe@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 8/26/22 10:35, Vlastimil Babka wrote:
> On 8/25/22 21:51, Joel Fernandes wrote:
>>> But we need to check the slab freeing functions themselves.
>>> It looks like SLAB is fine, slab_destroy() there takes care to copy the
>>> freelist pointer away before call_rcu() already and then it only works with
>>> the copy. Also nothing should need s_mem either, in case you need more bytes
>>> for the rcu_head debug.
>>> 
>>> SLUB seems also fine as the freeing doesn't try to look at the freelist even
>>> in case of debugging consistency checks being enabled. It could be a problem
>>> in case of a double-free, but that's already a problem anyway.
>>> In case you need more than the 8 bytes of freelist pointer, then overwriting
>>> the next 'counters' union would be a problem for the consistency checks as
>>> it reads slab->objects from there.
>>> But I guess we could do those checks before call_rcu, so the callback would
>>> then only free the slab page. The state expected by those checks doesn't
>>> depend on the grace period expiring.
>> 
>> Ok, sounds good, I can run it for a few days on real hardware and see if
>> something breaks or such. The most I can get with your patch is 12 bytes
>> before the FOLIO checks start complainting. I can stick to 8 bytes, and
>> perhaps we can allocate a separate debug object if we need more or something.
> 
> Weird, it works for me with 16 bytes, both SLAB and SLUB.

Oh, I see, it breaks in some 32bit vdso object, in the struct page's
asserts, not slab's. Likely some false positive due to header creep, I doubt
the vdso really works with 32bit struct pages as those don't exist on 64 bit
kernel. Maybe we should move the asserts from the header to e.g.
page_alloc.c, willy?

> 
>>> >> @@ -66,9 +74,13 @@ struct slab {
>>> >>  #define SLAB_MATCH(pg, sl)						\
>>> >>  	static_assert(offsetof(struct page, pg) == offsetof(struct slab, sl))
>>> >>  SLAB_MATCH(flags, __page_flags);
>>> >> +#ifdef CONFIG_SLUB
>>> >> +SLAB_MATCH(compound_head, slab_cache);	/* Ensure bit 0 is clear */
>>> >> +#else
>>> >>  SLAB_MATCH(compound_head, slab_list);	/* Ensure bit 0 is clear */
>>> >> +#endif
>>> >>  #ifndef CONFIG_SLOB
>>> >> -SLAB_MATCH(rcu_head, rcu_head);
>>> >> +// SLAB_MATCH(rcu_head, rcu_head); /* not necessary, hopefully? */
>>> > 
>>> > I think if it helps, I can make this check as a dependency on a default-off
>>> > debug config option.
>>> 
>>> It wouldn't help as with this patch, for SLUB the rcu_head would start at
>>> different offset regardless of whether you enable the option to increase its
>>> size.
>> 
>> True, unless we maintained 2 versions of the structs based on CONFIGs but
>> that's really ugly.
>> 
>> Thanks so much for this patch, its surely helpful for debugging purposes and
>> I look forward to testing it more and providing you any feedback!
> 
> I'll send a formal RFC soon.
> 

