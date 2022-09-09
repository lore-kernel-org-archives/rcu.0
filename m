Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E706ECAAA1
	for <rcu@archiver.kernel.org>; Fri,  9 Sep 2022 21:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiIIVQz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 9 Sep 2022 17:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiIIVQy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 9 Sep 2022 17:16:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12611177B5
        for <rcu@vger.kernel.org>; Fri,  9 Sep 2022 14:16:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 81D471F8DA;
        Fri,  9 Sep 2022 21:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662758211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WIv6YUOZ4IobLDob7fseZQlh5wCZ0wisJ742CqXLiGc=;
        b=yKKe5ubPVj2STvDYkh282N7R+zNQY5og3WQoxDTswcuO8Xvak3L15SeToVnzE0IV5g44nT
        X8L4jCvdhg7TydhLZ30fDSnriOgaPylEXqNtqYL8k9kmAWOQXvgMt/1DJ5L0hSLb0O16rs
        sEHqv8E5oHzsRsjSQzadU/VnCLMGvAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662758211;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WIv6YUOZ4IobLDob7fseZQlh5wCZ0wisJ742CqXLiGc=;
        b=75MiA48VW/YbFqNU6ixMphcd9uWz7E9yc2Gd5ZxrPBC+c5uaeA0C3WwshJN0oITy4abUQX
        F/+eMHr68KZ/gXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5742B13A93;
        Fri,  9 Sep 2022 21:16:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LYacFEOtG2P3VgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 09 Sep 2022 21:16:51 +0000
Message-ID: <cf7404ac-0838-7985-cdd0-524d540ad42a@suse.cz>
Date:   Fri, 9 Sep 2022 23:16:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [mm/sl[au]b] 3c4cafa313: canonical_address#:#[##]
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Joel Fernandes <joel@joelfernandes.org>,
        linux-mm@kvack.org, rcu@vger.kernel.org, paulmck@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20220906074548.GA72649@inn2.lkp.intel.com>
 <208c1757-5edd-fd42-67d4-1940cc43b50f@intel.com> <YxdfpTDdfBt6VIpo@hyeyoo>
 <416149c0-1e18-0e00-d116-dd3738957556@suse.cz>
 <aec59f53-0e53-1736-5932-25407125d4d4@suse.cz> <Yxsd625lvTS6IWc+@hyeyoo>
 <3d178109-5981-f4ee-8fe5-4f1d0c557ed2@suse.cz> <YxtOjYB9DvR4Fkdp@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YxtOjYB9DvR4Fkdp@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 9/9/22 16:32, Hyeonggon Yoo wrote:
> On Fri, Sep 09, 2022 at 03:44:19PM +0200, Vlastimil Babka wrote:
>> On 9/9/22 13:05, Hyeonggon Yoo wrote:
>> >> ----8<----
>> >> From d6f9fbb33b908eb8162cc1f6ce7f7c970d0f285f Mon Sep 17 00:00:00 2001
>> >> From: Vlastimil Babka <vbabka@suse.cz>
>> >> Date: Fri, 9 Sep 2022 12:03:10 +0200
>> >> Subject: [PATCH 2/3] mm/migrate: make isolate_movable_page() skip slab pages
>> >> 
>> >> In the next commit we want to rearrange struct slab fields to allow a
>> >> larger rcu_head. Afterwards, the page->mapping field will overlap
>> >> with SLUB's "struct list_head slab_list", where the value of prev
>> >> pointer can become LIST_POISON2, which is 0x122 + POISON_POINTER_DELTA.
>> >> Unfortunately the bit 1 being set can confuse PageMovable() to be a
>> >> false positive and cause a GPF as reported by lkp [1].
>> >> 
>> >> To fix this, make isolate_movable_page() skip pages with the PageSlab
>> >> flag set. This is a bit tricky as we need to add memory barriers to SLAB
>> >> and SLUB's page allocation and freeing, and their counterparts to
>> >> isolate_movable_page().
>> > 
>> > Hello, I just took a quick grasp,
>> > Is this approach okay with folio_test_anon()?
>> 
>> Not if used on a completely random page as compaction scanners can, but
>> relies on those being first tested for PageLRU or coming from a page table
>> lookup etc.
>> Not ideal huh. Well I could improve also by switching 'next' and 'slabs'
>> field and relying on the fact that the value of LIST_POISON2 doesn't include
>> 0x1, just 0x2.
> 
> What about swapping counters and freelist?
> freelist should be always aligned.  

Great suggestion, thanks!

Had to deal with SLAB too as there was list_head.prev also aliasing
page->mapping. Wanted to use freelist as well, but turns out it's not
aligned, so had to use s_mem instead.

The patch that isolate_movable_page() skip slab pages was thus dropped. The
result is in slab.git below and if nothing blows up, will restore it to -next

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=for-6.1/fit_rcu_head





