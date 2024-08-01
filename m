Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6CE14A093
	for <rcu@vger.kernel.org>; Thu,  1 Aug 2024 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522641; cv=none; b=J0VRzVAyAvdwO9/JeJiVRhfsDPDQMCV4AZbTHH5ro9nipeB64sjTpBrur5UynifnWFP/uTluZM9p/ihvIEx0aUGzIZSvavgQ8iRHHoeIIDp+HYGJgjoTM78SlPli0DaapYaAOjCS9dspWX3ow/Mg3aKQOWaf24RyNTvM+hijCVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522641; c=relaxed/simple;
	bh=pVWro9SwxTAzSS71nbjLiJZOfIBAzEey/g+V27QOz+c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TYvPgef2h3PGxRIReQMjbMmwvC7nY/qrsv/ojmEU4rEfCfF3dqKxJ/cV6E9VszKRiIzNsz6a2RSyRFmLW+lIG/iMyAAU26knPf7gcKFIj3//lZpAdN8gaiMtQmpCoh0ip90vSsFol4jPe+VgC7aXiD898JShCO4Vzi7SDJI+SXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S75r/VNq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WvlXLgs6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S75r/VNq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WvlXLgs6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S75r/VNq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WvlXLgs6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S75r/VNq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WvlXLgs6"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7153B219CE;
	Thu,  1 Aug 2024 14:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722522636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3xSkxIND5QSpeqYbO0xkWQI/7BFgNMNskqLEYKb2Z1k=;
	b=S75r/VNq/b/WEMd1c4N4y8JtsPgt2zdQn91bX5fkK2tOAXriV+KkZPheBkA3bwPJSwq5Nu
	urM5GQc+kaf2PGKDVU5Om8yscNInA1Izh+V+EHKvOr7EV2L+MotGlm1n9BzVlQZowSyq3x
	83oyTC5KDXcs2yndts9tbJ6dX/IzlfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722522636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3xSkxIND5QSpeqYbO0xkWQI/7BFgNMNskqLEYKb2Z1k=;
	b=WvlXLgs6k0vAxWl+xk1vkFzhNw+VUiB8jT7/Xt2OB+F/EA3mmFAgxFK9kRDMP1LH1CA2fO
	rpg3wjtFZKk+YcCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="S75r/VNq";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WvlXLgs6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722522636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3xSkxIND5QSpeqYbO0xkWQI/7BFgNMNskqLEYKb2Z1k=;
	b=S75r/VNq/b/WEMd1c4N4y8JtsPgt2zdQn91bX5fkK2tOAXriV+KkZPheBkA3bwPJSwq5Nu
	urM5GQc+kaf2PGKDVU5Om8yscNInA1Izh+V+EHKvOr7EV2L+MotGlm1n9BzVlQZowSyq3x
	83oyTC5KDXcs2yndts9tbJ6dX/IzlfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722522636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3xSkxIND5QSpeqYbO0xkWQI/7BFgNMNskqLEYKb2Z1k=;
	b=WvlXLgs6k0vAxWl+xk1vkFzhNw+VUiB8jT7/Xt2OB+F/EA3mmFAgxFK9kRDMP1LH1CA2fO
	rpg3wjtFZKk+YcCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6204F13946;
	Thu,  1 Aug 2024 14:30:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T/OfFwycq2bWAwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 01 Aug 2024 14:30:36 +0000
Message-ID: <7895689e-9854-4cda-b132-4e8c45f8017a@suse.cz>
Date: Thu, 1 Aug 2024 16:30:36 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [vbabka:slab-kfree_rcu-destroy-v1r0] [mm, slab] df00e211c9:
 WARNING:at_mm/slab_common.c:#kmem_cache_kfree_rcu_destroy_workfn
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-mm@kvack.org,
 RCU <rcu@vger.kernel.org>
References: <202407251313.32e55498-oliver.sang@intel.com>
 <4b31f1be-fbc5-404b-8a4e-1eb2ad4111e3@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <4b31f1be-fbc5-404b-8a4e-1eb2ad4111e3@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7153B219CE
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,intel.com:email];
	DKIM_TRACE(0.00)[suse.cz:+]

On 7/26/24 11:34, Vlastimil Babka wrote:
> On 7/25/24 7:59 AM, kernel test robot wrote:
>> 
>> hi, Vlastimil Babka,
>> 
>> we noticed by this commit:
>> 
>> 7fd4dfd0d38db6f3 df00e211c9c11e8d20f2ea7b4ab
>> ---------------- ---------------------------
>>        fail:runs  %reproduction    fail:runs
>>            |             |             |
>>           6:6         -100%            :6     dmesg.WARNING:at_mm/slab_common.c:#kmem_cache_destroy
>>            :6          100%           6:6     dmesg.WARNING:at_mm/slab_common.c:#kmem_cache_kfree_rcu_destroy_workfn
>> 
>> below formal report just FYI what we observed in our tests. not sure if it's
>> valuable to supply any hints.
>> 
>> 
>> Hello,
>> 
>> kernel test robot noticed "WARNING:at_mm/slab_common.c:#kmem_cache_kfree_rcu_destroy_workfn" on:
>> 
>> commit: df00e211c9c11e8d20f2ea7b4ab1d7c9760fe822 ("mm, slab: asynchronously destroy caches with outstanding objects")
>> https://git.kernel.org/cgit/linux/kernel/git/vbabka/linux.git slab-kfree_rcu-destroy-v1r0
> 
> Yes, that's expected proves we need the proper barrier added from the RCU
> folks :)

I've pushed a new branch

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git
slab-kfree_rcu-destroy-v2r0

With the new barrier from Ulad so I'll be curious to hear if there are no
more of these warnings (or any issues). Thanks!

> Thanks,
> Vlastimil
> 
>> in testcase: rcutorture
>> version: 
>> with following parameters:
>> 
>> 	runtime: 300s
>> 	test: default
>> 	torture_type: tasks-tracing
>> 
>> 
>> 
>> compiler: clang-18
>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>> 
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>> 
>> 
>> 
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>> | Closes: https://lore.kernel.org/oe-lkp/202407251313.32e55498-oliver.sang@intel.com
>> 
>> 
>> [  339.985807][   T98] ------------[ cut here ]------------
>> [  339.986460][   T98] kmem_cache_destroy rcuscale: Slab cache still has objects
>> [ 339.986476][ T98] WARNING: CPU: 1 PID: 98 at mm/slab_common.c:562 kmem_cache_kfree_rcu_destroy_workfn (mm/slab_common.c:561) 
>> [  339.988490][   T98] Modules linked in: rcutorture(-) torture crc32c_intel serio_raw stm_p_basic
>> [  339.989490][   T98] CPU: 1 PID: 98 Comm: kworker/1:3 Not tainted 6.10.0-rc6-00022-gdf00e211c9c1 #1
>> [  339.990127][   T98] Workqueue: events kmem_cache_kfree_rcu_destroy_workfn
>> [ 339.990888][ T98] EIP: kmem_cache_kfree_rcu_destroy_workfn (mm/slab_common.c:561) 
>> [ 339.991546][ T98] Code: 74 d3 e8 d8 f1 72 00 e8 63 31 e7 ff 83 c4 04 5e 5f 5b 5d 31 c0 31 c9 31 d2 c3 ff 76 f4 68 05 a9 2a d3 e8 38 28 e7 ff 83 c4 08 <0f> 0b eb cf 90 3e 8d 74 26 00 55 89 e5 53 57 56 83 ec 0c 64 a1 30
>> All code
>> ========
>>    0:	74 d3                	je     0xffffffffffffffd5
>>    2:	e8 d8 f1 72 00       	call   0x72f1df
>>    7:	e8 63 31 e7 ff       	call   0xffffffffffe7316f
>>    c:	83 c4 04             	add    $0x4,%esp
>>    f:	5e                   	pop    %rsi
>>   10:	5f                   	pop    %rdi
>>   11:	5b                   	pop    %rbx
>>   12:	5d                   	pop    %rbp
>>   13:	31 c0                	xor    %eax,%eax
>>   15:	31 c9                	xor    %ecx,%ecx
>>   17:	31 d2                	xor    %edx,%edx
>>   19:	c3                   	ret
>>   1a:	ff 76 f4             	push   -0xc(%rsi)
>>   1d:	68 05 a9 2a d3       	push   $0xffffffffd32aa905
>>   22:	e8 38 28 e7 ff       	call   0xffffffffffe7285f
>>   27:	83 c4 08             	add    $0x8,%esp
>>   2a:*	0f 0b                	ud2		<-- trapping instruction
>>   2c:	eb cf                	jmp    0xfffffffffffffffd
>>   2e:	90                   	nop
>>   2f:	3e 8d 74 26 00       	ds lea 0x0(%rsi,%riz,1),%esi
>>   34:	55                   	push   %rbp
>>   35:	89 e5                	mov    %esp,%ebp
>>   37:	53                   	push   %rbx
>>   38:	57                   	push   %rdi
>>   39:	56                   	push   %rsi
>>   3a:	83 ec 0c             	sub    $0xc,%esp
>>   3d:	64                   	fs
>>   3e:	a1                   	.byte 0xa1
>>   3f:	30                   	.byte 0x30
>> 
>> Code starting with the faulting instruction
>> ===========================================
>>    0:	0f 0b                	ud2
>>    2:	eb cf                	jmp    0xffffffffffffffd3
>>    4:	90                   	nop
>>    5:	3e 8d 74 26 00       	ds lea 0x0(%rsi,%riz,1),%esi
>>    a:	55                   	push   %rbp
>>    b:	89 e5                	mov    %esp,%ebp
>>    d:	53                   	push   %rbx
>>    e:	57                   	push   %rdi
>>    f:	56                   	push   %rsi
>>   10:	83 ec 0c             	sub    $0xc,%esp
>>   13:	64                   	fs
>>   14:	a1                   	.byte 0xa1
>>   15:	30                   	.byte 0x30
>> [  339.993706][   T98] EAX: 00000000 EBX: ed3f3000 ECX: 00000000 EDX: 00000000
>> [  339.994569][   T98] ESI: ed3f3048 EDI: 00010000 EBP: eda63f00 ESP: eda63ef0
>> [  339.994972][   T98] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010296
>> [  339.995835][   T98] CR0: 80050033 CR2: b7296028 CR3: 2e17c000 CR4: 000406d0
>> [  339.996669][   T98] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
>> [  339.997563][   T98] DR6: fffe0ff0 DR7: 00000400
>> [  339.998168][   T98] Call Trace:
>> [ 339.998550][ T98] ? show_regs (arch/x86/kernel/dumpstack.c:478) 
>> [ 339.999044][ T98] ? kmem_cache_kfree_rcu_destroy_workfn (mm/slab_common.c:561) 
>> [ 339.999854][ T98] ? __warn (kernel/panic.c:239 kernel/panic.c:693) 
>> [ 340.000309][ T98] ? kmem_cache_kfree_rcu_destroy_workfn (mm/slab_common.c:561) 
>> [ 340.001084][ T98] ? kmem_cache_kfree_rcu_destroy_workfn (mm/slab_common.c:561) 
>> [ 340.001837][ T98] ? report_bug (lib/bug.c:199) 
>> [ 340.002138][ T98] ? exc_overflow (arch/x86/kernel/traps.c:252) 
>> [ 340.002374][ T98] ? handle_bug (arch/x86/kernel/traps.c:?) 
>> [ 340.002602][ T98] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
>> [ 340.003063][ T98] ? handle_exception (arch/x86/entry/entry_32.S:1054) 
>> [ 340.003641][ T98] ? exc_overflow (arch/x86/kernel/traps.c:252) 
>> [ 340.004094][ T98] ? kmem_cache_kfree_rcu_destroy_workfn (mm/slab_common.c:561) 
>> [ 340.004932][ T98] ? exc_overflow (arch/x86/kernel/traps.c:252) 
>> [ 340.005201][ T98] ? kmem_cache_kfree_rcu_destroy_workfn (mm/slab_common.c:561) 
>> [ 340.005814][ T98] process_one_work (kernel/workqueue.c:3253) 
>> [ 340.006385][ T98] worker_thread (kernel/workqueue.c:3323 kernel/workqueue.c:3409) 
>> [ 340.006870][ T98] kthread (kernel/kthread.c:391) 
>> [ 340.007165][ T98] ? pr_cont_work (kernel/workqueue.c:3356) 
>> [ 340.007508][ T98] ? kthread_unuse_mm (kernel/kthread.c:342) 
>> [ 340.007852][ T98] ? kthread_unuse_mm (kernel/kthread.c:342) 
>> [ 340.008205][ T98] ret_from_fork (arch/x86/kernel/process.c:153) 
>> [ 340.008546][ T98] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
>> [ 340.008966][ T98] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
>> [  340.009348][   T98] irq event stamp: 13099
>> [ 340.009686][ T98] hardirqs last enabled at (13107): console_unlock (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:341 kernel/printk/printk.c:2731 kernel/printk/printk.c:3050) 
>> [ 340.015799][ T98] hardirqs last disabled at (13122): console_unlock (kernel/printk/printk.c:339) 
>> [ 340.016806][ T98] softirqs last enabled at (13120): __do_softirq (kernel/softirq.c:589) 
>> [ 340.017976][ T98] softirqs last disabled at (13115): __do_softirq (kernel/softirq.c:589) 
>> [  340.019062][   T98] ---[ end trace 0000000000000000 ]---
>> 
>> 
>> 
>> The kernel config and materials to reproduce are available at:
>> https://download.01.org/0day-ci/archive/20240725/202407251313.32e55498-oliver.sang@intel.com
>> 
>> 
>> 
> 

