Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B383ECAAD3
	for <rcu@archiver.kernel.org>; Fri,  9 Sep 2022 13:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiIINpp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 9 Sep 2022 09:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiIINpk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 9 Sep 2022 09:45:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320E1C59F1
        for <rcu@vger.kernel.org>; Fri,  9 Sep 2022 06:45:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CB9CF22D68;
        Fri,  9 Sep 2022 13:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662731059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vSOdhKUrHQ9LIqag2uWL5uO2UbjS9tu9yDpmAjxeiF4=;
        b=f+yVDyqDS5clixgRZrvzf4nkKu3KoNcfpOxuYKYwHP9IQYfnLUS6FM50d1C+Lf/5AbePoa
        QNphEoMXJpT3pX5QU9US8ruVER2Rvfv0DHXbfW1Xv7DjsPeQDxJ6vmzjZfSPMCh9cMi5XA
        eT61v1UnIx5DdkAZaRNUtUldRXJpot4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662731059;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vSOdhKUrHQ9LIqag2uWL5uO2UbjS9tu9yDpmAjxeiF4=;
        b=JF0qrBcgGXugAFcvN1+lStGwYl6Pm1j5faoen2YWo1fN2wT5Jx9NSR8J/14IEPOq51IbwZ
        EpNgd/1rmvd6pXCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A969F13A93;
        Fri,  9 Sep 2022 13:44:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QVnNKDNDG2MRSgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 09 Sep 2022 13:44:19 +0000
Message-ID: <3d178109-5981-f4ee-8fe5-4f1d0c557ed2@suse.cz>
Date:   Fri, 9 Sep 2022 15:44:19 +0200
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
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Yxsd625lvTS6IWc+@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 9/9/22 13:05, Hyeonggon Yoo wrote:
>> ----8<----
>> From d6f9fbb33b908eb8162cc1f6ce7f7c970d0f285f Mon Sep 17 00:00:00 2001
>> From: Vlastimil Babka <vbabka@suse.cz>
>> Date: Fri, 9 Sep 2022 12:03:10 +0200
>> Subject: [PATCH 2/3] mm/migrate: make isolate_movable_page() skip slab pages
>> 
>> In the next commit we want to rearrange struct slab fields to allow a
>> larger rcu_head. Afterwards, the page->mapping field will overlap
>> with SLUB's "struct list_head slab_list", where the value of prev
>> pointer can become LIST_POISON2, which is 0x122 + POISON_POINTER_DELTA.
>> Unfortunately the bit 1 being set can confuse PageMovable() to be a
>> false positive and cause a GPF as reported by lkp [1].
>> 
>> To fix this, make isolate_movable_page() skip pages with the PageSlab
>> flag set. This is a bit tricky as we need to add memory barriers to SLAB
>> and SLUB's page allocation and freeing, and their counterparts to
>> isolate_movable_page().
> 
> Hello, I just took a quick grasp,
> Is this approach okay with folio_test_anon()?

Not if used on a completely random page as compaction scanners can, but
relies on those being first tested for PageLRU or coming from a page table
lookup etc.
Not ideal huh. Well I could improve also by switching 'next' and 'slabs'
field and relying on the fact that the value of LIST_POISON2 doesn't include
0x1, just 0x2.

