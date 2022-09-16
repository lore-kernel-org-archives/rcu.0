Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E35C54EE9
	for <rcu@archiver.kernel.org>; Fri, 16 Sep 2022 17:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiIPRH7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 16 Sep 2022 13:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIPRH6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 16 Sep 2022 13:07:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFF2B6574
        for <rcu@vger.kernel.org>; Fri, 16 Sep 2022 10:07:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 63078203A2;
        Fri, 16 Sep 2022 17:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663348075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+YNc6LicI/+TyEo7NrKdAKuZgXu+oxmwoGmOrxjg+s=;
        b=go+jM6U0ZD/Eqw/1KXZ9v0IqPzX3TowTKQHDgXKNhACSx7cDYnC/zSbKRVhjvAmzu70rzb
        9AVCw13OeZ+wArjZmgQm5dN8vSyoomsX9SnlIW6UBnRn9qrqONu7mfsZ7gxF7hNakxySyI
        DyqPHTYtgnOJ6pzUBKq63FPFxyrR9F8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663348075;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+YNc6LicI/+TyEo7NrKdAKuZgXu+oxmwoGmOrxjg+s=;
        b=hjTlzHrs23atZWWD5G2KfCG7TcmDxC3IZvczwIH/8kX94BV4jMn48xJVHInTH1+WVcSZMh
        DJeGaxncSYhAn2BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2BCD21332E;
        Fri, 16 Sep 2022 17:07:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +0v+CGutJGP/EQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 16 Sep 2022 17:07:55 +0000
Message-ID: <9bc52296-6467-9da9-823a-0484e571654d@suse.cz>
Date:   Fri, 16 Sep 2022 19:06:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [mm/sl[au]b] 3c4cafa313: canonical_address#:#[##]
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Cc:     kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Joel Fernandes <joel@joelfernandes.org>,
        linux-mm@kvack.org, rcu@vger.kernel.org, paulmck@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
References: <20220906074548.GA72649@inn2.lkp.intel.com>
 <208c1757-5edd-fd42-67d4-1940cc43b50f@intel.com> <YxdfpTDdfBt6VIpo@hyeyoo>
 <416149c0-1e18-0e00-d116-dd3738957556@suse.cz>
 <aec59f53-0e53-1736-5932-25407125d4d4@suse.cz> <Yxsd625lvTS6IWc+@hyeyoo>
 <3d178109-5981-f4ee-8fe5-4f1d0c557ed2@suse.cz> <YxtOjYB9DvR4Fkdp@hyeyoo>
 <cf7404ac-0838-7985-cdd0-524d540ad42a@suse.cz> <YyF1zgAC2GBdW3Bk@hyeyoo>
 <YyGF7rHetCp0mWhV@casper.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YyGF7rHetCp0mWhV@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 9/14/22 09:42, Matthew Wilcox wrote:
> On Wed, Sep 14, 2022 at 03:33:50PM +0900, Hyeonggon Yoo wrote:
>> On Fri, Sep 09, 2022 at 11:16:51PM +0200, Vlastimil Babka wrote:
>>> On 9/9/22 16:32, Hyeonggon Yoo wrote:
>>>> On Fri, Sep 09, 2022 at 03:44:19PM +0200, Vlastimil Babka wrote:
>>>>> On 9/9/22 13:05, Hyeonggon Yoo wrote:
>>>>>>> ----8<----
>>>>>>> From d6f9fbb33b908eb8162cc1f6ce7f7c970d0f285f Mon Sep 17 00:00:00 2001
>>>>>>> From: Vlastimil Babka <vbabka@suse.cz>
>>>>>>> Date: Fri, 9 Sep 2022 12:03:10 +0200
>>>>>>> Subject: [PATCH 2/3] mm/migrate: make isolate_movable_page() skip slab pages
>>>>>>>
>>>>>>> In the next commit we want to rearrange struct slab fields to allow a
>>>>>>> larger rcu_head. Afterwards, the page->mapping field will overlap
>>>>>>> with SLUB's "struct list_head slab_list", where the value of prev
>>>>>>> pointer can become LIST_POISON2, which is 0x122 + POISON_POINTER_DELTA.
>>>>>>> Unfortunately the bit 1 being set can confuse PageMovable() to be a
>>>>>>> false positive and cause a GPF as reported by lkp [1].
>>>>>>>
>>>>>>> To fix this, make isolate_movable_page() skip pages with the PageSlab
>>>>>>> flag set. This is a bit tricky as we need to add memory barriers to SLAB
>>>>>>> and SLUB's page allocation and freeing, and their counterparts to
>>>>>>> isolate_movable_page().
>>>>>>
>>>>>> Hello, I just took a quick grasp,
>>>>>> Is this approach okay with folio_test_anon()?
>>>>>
>>>>> Not if used on a completely random page as compaction scanners can, but
>>>>> relies on those being first tested for PageLRU or coming from a page table
>>>>> lookup etc.
>>>>> Not ideal huh. Well I could improve also by switching 'next' and 'slabs'
>>>>> field and relying on the fact that the value of LIST_POISON2 doesn't include
>>>>> 0x1, just 0x2.
>>>>
>>>> What about swapping counters and freelist?
>>>> freelist should be always aligned.  
>>>
>>> Great suggestion, thanks!
>>>
>>> Had to deal with SLAB too as there was list_head.prev also aliasing
>>> page->mapping. Wanted to use freelist as well, but turns out it's not
>>> aligned, so had to use s_mem instead.
>>>
>>> The patch that isolate_movable_page() skip slab pages was thus dropped. The
>>> result is in slab.git below and if nothing blows up, will restore it to -next
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=for-6.1/fit_rcu_head
>>
>> I realized that there is also relevant comment in
>> include/linux/mm_types.h:
>>
>>>  62  * SLUB uses cmpxchg_double() to atomically update its freelist and counters.
>>>  63  * That requires that freelist & counters in struct slab be adjacent and
>>>  64  * double-word aligned. Because struct slab currently just reinterprets the
>>>  65  * bits of struct page, we align all struct pages to double-word boundaries,
>>>  66  * and ensure that 'freelist' is aligned within struct slab.
>>>  67  */
>>
>> Also we may add a comment,
>> something like this?
>>
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -79,6 +79,9 @@ struct page {
>>          * WARNING: bit 0 of the first word is used for PageTail(). That
>>          * means the other users of this union MUST NOT use the bit to
>>          * avoid collision and false-positive PageTail().
>> +        *
>> +        * WARNING: lower two bits of third word is used for PAGE_MAPPING_FLAGS.
>> +        * using those bits can lead compaction code to general protection fault.
> 
> I'm really not comfortable with adding that documentation.  I feel the
> compaction code should be fixed.

Any suggestions how exactly, as using a true page flag for __PageMovable
is off limits? :)
