Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6864ECAAA1
	for <rcu@archiver.kernel.org>; Tue,  6 Sep 2022 15:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiIFPza (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Sep 2022 11:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238981AbiIFPxy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Sep 2022 11:53:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1271008
        for <rcu@vger.kernel.org>; Tue,  6 Sep 2022 08:11:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 866D6338D0;
        Tue,  6 Sep 2022 15:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662477063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LPaHQ3M5+5/BONmV+6B5JimVTvwkYKLaJSJYL4MX8Kg=;
        b=CUkBu/Jb6RNdsqplMUQmsWy7gbwV3GnTXDfWCqVGQTaxv8NYXIWeQnfeE1cKj21BfsvR1u
        8yQY2ECMeuhlajw0JS3OzGm2G1zgnrpZSz1/z+RDwl3qAilNzbetEkTJzQyKzkLOoPKv/8
        vsIm2Ww7Ua91V7bnXPJsTjvVAA0xhKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662477063;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LPaHQ3M5+5/BONmV+6B5JimVTvwkYKLaJSJYL4MX8Kg=;
        b=7U/RrsKInh/2JYqsgZgrgpsU4M19oMb9JhTtm/oXBuIg8C+MFo7yVwIXbRgP2Ju4x6fqqA
        iZZmKLJc0qnb+rAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53AEE13A7A;
        Tue,  6 Sep 2022 15:11:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wIaCEwdjF2OcEwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 06 Sep 2022 15:11:03 +0000
Message-ID: <416149c0-1e18-0e00-d116-dd3738957556@suse.cz>
Date:   Tue, 6 Sep 2022 17:11:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [mm/sl[au]b] 3c4cafa313: canonical_address#:#[##]
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kernel test robot <yujie.liu@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com,
        Joel Fernandes <joel@joelfernandes.org>, linux-mm@kvack.org,
        rcu@vger.kernel.org, paulmck@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20220906074548.GA72649@inn2.lkp.intel.com>
 <208c1757-5edd-fd42-67d4-1940cc43b50f@intel.com> <YxdfpTDdfBt6VIpo@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YxdfpTDdfBt6VIpo@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 9/6/22 16:56, Hyeonggon Yoo wrote:
> On Tue, Sep 06, 2022 at 03:51:01PM +0800, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed the following commit (built with gcc-11):
>>
>> commit: 3c4cafa313d978b31a1d5dc17c323074b19a1d63 ("mm/sl[au]b: rearrange struct slab fields to allow larger rcu_head")
>> git://git.kernel.org/cgit/linux/kernel/git/vbabka/slab.git for-6.1/fit_rcu_head
>>
>> in testcase: fio-basic
>> version: fio-x86_64-3.15-1_20220903
>> with following parameters:
>>
>> 	disk: 2pmem
>> 	fs: xfs
>> 	runtime: 200s
>> 	nr_task: 50%
>> 	time_based: tb
>> 	rw: randrw
>> 	bs: 2M
>> 	ioengine: mmap
>> 	test_size: 200G
>> 	cpufreq_governor: performance
>>
>> test-description: Fio is a tool that will spawn a number of threads or processes doing a particular type of I/O action as specified by the user.
>> test-url:https://github.com/axboe/fio
>>
>>
>> on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>> [  304.700893][   C40] perf: interrupt took too long (12747 > 12477), lowering kernel.perf_event_max_sample_rate to 15000
>> [  305.015834][   C40] perf: interrupt took too long (15947 > 15933), lowering kernel.perf_event_max_sample_rate to 12000
>> [  305.954702][   C40] perf: interrupt took too long (19968 > 19933), lowering kernel.perf_event_max_sample_rate to 10000
>> [  309.554949][   C31] perf: interrupt took too long (25118 > 24960), lowering kernel.perf_event_max_sample_rate to 7000
>> [  315.068744][   C95] sched: RT throttling activated
>> [  317.121806][  T590] general protection fault, probably for non-canonical address 0xdead000000000120: 0000 [#1] SMP NOPTI
>> [  317.133291][  T590] CPU: 61 PID: 590 Comm: kcompactd0 Tainted: G S                 6.0.0-rc2-00002-g3c4cafa313d9 #1
>> [  317.144084][  T590] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
>> [ 317.155668][ T590] RIP: 0010:isolate_movable_page (mm/migrate.c:103)
>> [ 317.162016][ T590] Code: ba 28 00 0f 82 88 00 00 00 48 89 ef e8 e2 3a f8 ff 84 c0 74 74 48 8b 45 00 a9 00 00 04 00 75 69 48 8b 45 18 44 89 e6 48 89 ef <48> 8b 40 fe ff d0 0f 1f 00 84 c0 74 52 48 8b 45 00 a9 00 00 04 00
>> All code
>> ========
>>     0:	ba 28 00 0f 82       	mov    $0x820f0028,%edx
>>     5:	88 00                	mov    %al,(%rax)
>>     7:	00 00                	add    %al,(%rax)
>>     9:	48 89 ef             	mov    %rbp,%rdi
>>     c:	e8 e2 3a f8 ff       	callq  0xfffffffffff83af3
>>    11:	84 c0                	test   %al,%al
>>    13:	74 74                	je     0x89
>>    15:	48 8b 45 00          	mov    0x0(%rbp),%rax
>>    19:	a9 00 00 04 00       	test   $0x40000,%eax
>>    1e:	75 69                	jne    0x89
>>    20:	48 8b 45 18          	mov    0x18(%rbp),%rax
>>    24:	44 89 e6             	mov    %r12d,%esi
>>    27:	48 89 ef             	mov    %rbp,%rdi
>>    2a:*	48 8b 40 fe          	mov    -0x2(%rax),%rax		<-- trapping instruction
>>    2e:	ff d0                	callq  *%rax
>>    30:	0f 1f 00             	nopl   (%rax)
>>    33:	84 c0                	test   %al,%al
>>    35:	74 52                	je     0x89
>>    37:	48 8b 45 00          	mov    0x0(%rbp),%rax
>>    3b:	a9 00 00 04 00       	test   $0x40000,%eax
>>
>> Code starting with the faulting instruction
>> ===========================================
>>     0:	48 8b 40 fe          	mov    -0x2(%rax),%rax
>>     4:	ff d0                	callq  *%rax
>>     6:	0f 1f 00             	nopl   (%rax)
>>     9:	84 c0                	test   %al,%al
>>     b:	74 52                	je     0x5f
>>     d:	48 8b 45 00          	mov    0x0(%rbp),%rax
>>    11:	a9 00 00 04 00       	test   $0x40000,%eax
>> [  317.182354][  T590] RSP: 0018:ffffc9000e1d3c78 EFLAGS: 00010246
>> [  317.188668][  T590] RAX: dead000000000122 RBX: ffffea0004031034 RCX: 000000000000000c
>> [  317.196890][  T590] RDX: dead000000000101 RSI: 000000000000000c RDI: ffffea0004031000
>> [  317.205273][  T590] RBP: ffffea0004031000 R08: 0000000004031000 R09: 0000000000000004
>> [  317.213752][  T590] R10: 00000000000066b6 R11: 0000000000000004 R12: 000000000000000c
>> [  317.222384][  T590] R13: ffffea0004031000 R14: 0000000000100c40 R15: ffffc9000e1d3df0
>> [  317.230679][  T590] FS:  0000000000000000(0000) GS:ffff88c04ff40000(0000) knlGS:0000000000000000
>> [  317.239896][  T590] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  317.247098][  T590] CR2: 0000000000451c00 CR3: 0000008064ca4002 CR4: 00000000007706e0
>> [  317.255788][  T590] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  317.264256][  T590] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [  317.272772][  T590] PKRU: 55555554
>> [  317.276783][  T590] Call Trace:
>> [  317.280932][  T590]  <TASK>
>> [ 317.284315][ T590] isolate_migratepages_block (mm/compaction.c:982)
>> [ 317.290702][ T590] isolate_migratepages (mm/compaction.c:1960)
>> [ 317.296278][ T590] compact_zone (mm/compaction.c:2393)
>> [ 317.301202][ T590] proactive_compact_node (mm/compaction.c:2661 (discriminator 2))
> Hmm... Let's debug.
> 
> FYI, simply echo 1 > /proc/sys/vm/compact_memory invokes same bug on my test
> environment.
> 
> the 'mops' is invalid address in mm/migrate.c:103.
> 
> Hmm, why is this slab page confused as movable page?
> -> Because page->'mapping' and slab->slabs field has same offset.
> 
> I think this is invoked because lowest two bits of slab->slabs is not 0.
> 
> Vlastimil, any thoughts?

Yeah, slabs->slabs could do that, and the remedy would be to exchange it 
with the slab->next field.
However the report points to the value dead000000000122 which is 
LIST_POISON2, which unfortunately contains the lower bit after 
4c6080cd6f8b ("lib/list: tweak LIST_POISON2 for better code generation 
on x86_64")

Probably the simplest fix would be to check for PageSlab() before 
__PageMovable().

But heads up for Joel - if your rcu_head debugging info series (didn't 
check) has something like a counter in the 3rd 64bit word, where bit 1 
can thus be set, it can cause the same issue fooling the __PageMovable() 
check.

>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot<yujie.liu@intel.com>
>>
>>
>> To reproduce:
>>
>>          git clonehttps://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          sudo bin/lkp install job.yaml           # job file is attached in this email
>>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>>          sudo bin/lkp run generated-yaml-file
>>
>>          # if come across any failure that blocks the test,
>>          # please remove ~/.lkp and /lkp dir to run from a clean state.
>>
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://01.org/lkp

