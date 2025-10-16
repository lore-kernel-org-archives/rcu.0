Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C01B76026
	for <rcu@vger.kernel.org>; Thu, 16 Oct 2025 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631335; cv=none; b=n/geTWSvSl/IJ5lt9THu2xE2SSaGFfd76IavhTBEYU4fFJweBZUEnKg8az72WGMyPzO/2vkk7/unRk7wBgpq3v38B+oybyFC/2YYaynIHYIOOse6PiBuf1rLjKPH0rIDHdGhuChbYSJ2yqH0wXExB0lVXdFac9DMHoHJbyk7cKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631335; c=relaxed/simple;
	bh=4ZxTZZXsgOLqYFoZIM1ZSN6IzMBJOcAY6gp2VCdLK30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUxR/xBXdG+SJwlwkz3tczfJbL8VkjZ+oczaO5bMF6bJmm9tLbMtNdkzUklqH+N3R0vxjIBIELdwIPDpBFyvyBEYeFrWKW3ddPVgJ/Z/IXiMgvEETxvQwtRK8kMoJcBYmvYzwxnKEnHZnWBuK7wdRxmRBDhQLYGovU9SPW62Gpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qVuEo+l9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5+wqPiVD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qVuEo+l9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5+wqPiVD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qVuEo+l9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5+wqPiVD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qVuEo+l9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5+wqPiVD"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C46A21B2E;
	Thu, 16 Oct 2025 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760631331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Uz/Ghx4FHi2vcXr5rnmAHNkktOBn1Zpc/YuwEV6tR7E=;
	b=qVuEo+l9XL8knKBUcMrbHu3Qnt2Ya4jJGdyykHRDM1veCaywo8UErcmfRmZZxWYgCga0yd
	F4WBu7/nX30YdMORpcGS1Yfe8V1YcvsolIb4gwYeUTqtD2bbqwDoSgyId+0tbZgOVsSrxt
	uMIew4+P4a4FAA6ibTwddKXLmqQ/iQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760631331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Uz/Ghx4FHi2vcXr5rnmAHNkktOBn1Zpc/YuwEV6tR7E=;
	b=5+wqPiVD4LQto9VFMKpADBXaLhebDVW5DbLUVRsx1YSD6cDQ9XUBWE/Q7DG3WK9VLFjCvH
	Vffft9PSx5FAsMAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760631331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Uz/Ghx4FHi2vcXr5rnmAHNkktOBn1Zpc/YuwEV6tR7E=;
	b=qVuEo+l9XL8knKBUcMrbHu3Qnt2Ya4jJGdyykHRDM1veCaywo8UErcmfRmZZxWYgCga0yd
	F4WBu7/nX30YdMORpcGS1Yfe8V1YcvsolIb4gwYeUTqtD2bbqwDoSgyId+0tbZgOVsSrxt
	uMIew4+P4a4FAA6ibTwddKXLmqQ/iQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760631331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Uz/Ghx4FHi2vcXr5rnmAHNkktOBn1Zpc/YuwEV6tR7E=;
	b=5+wqPiVD4LQto9VFMKpADBXaLhebDVW5DbLUVRsx1YSD6cDQ9XUBWE/Q7DG3WK9VLFjCvH
	Vffft9PSx5FAsMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDC7C1376E;
	Thu, 16 Oct 2025 16:15:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FwK6OSIa8Wh2agAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 16 Oct 2025 16:15:30 +0000
Message-ID: <ad9864db-a297-44d9-ab1a-61e0285eac5f@suse.cz>
Date: Thu, 16 Oct 2025 18:15:30 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 15/23] maple_tree: use percpu sheaves for
 maple_node_cache
Content-Language: en-US
To: "D, Suneeth" <Suneeth.D@amd.com>, Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-15-ca3099d8352c@suse.cz>
 <262c742f-dc0c-4adc-b23c-047cd3298a5e@amd.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <262c742f-dc0c-4adc-b23c-047cd3298a5e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[oracle.com:email,suse.cz:mid,suse.cz:email,runtest.py:url,perf.data:url,imap1.dmz-prg2.suse.org:helo];
	DBL_BLOCKED_OPENRESOLVER(0.00)[perf.data:url,runtest.py:url,suse.cz:mid,suse.cz:email,oracle.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 10/16/25 17:16, D, Suneeth wrote:
> Hi Vlastimil Babka,
> 
> On 9/10/2025 1:31 PM, Vlastimil Babka wrote:
>> Setup the maple_node_cache with percpu sheaves of size 32 to hopefully
>> improve its performance. Note this will not immediately take advantage
>> of sheaf batching of kfree_rcu() operations due to the maple tree using
>> call_rcu with custom callbacks. The followup changes to maple tree will
>> change that and also make use of the prefilled sheaves functionality.
>> 
> 
> 
> We run will-it-scale-process-mmap2 micro-benchmark as part of our weekly 
> CI for Kernel Performance Regression testing between a stable vs rc 
> kernel. In this week's run we were able to observe severe regression on 
> AMD platforms (Turin and Bergamo) with running the micro-benchmark 
> between the kernels v6.17 and v6.18-rc1 in the range of 12-13% (Turin) 
> and 22-26% (Bergamo). Bisecting further landed me onto this commit 
> (59faa4da7cd4565cbce25358495556b75bb37022) as first bad commit. The 
> following were the machines' configuration and test parameters used:-
> 
> Model name:           AMD EPYC 128-Core Processor [Bergamo]
> Thread(s) per core:   2
> Core(s) per socket:   128
> Socket(s):            1
> Total online memory:  258G
> 
> Model name:           AMD EPYC 64-Core Processor [Turin]
> Thread(s) per core:   2
> Core(s) per socket:   64
> Socket(s):            1
> Total online memory:  258G
> 
> Test params:
> 
>      nr_task: [1 8 64 128 192 256]
>      mode: process
>      test: mmap2
>      kpi: per_process_ops
>      cpufreq_governor: performance
> 
> The following are the stats after bisection:-
> (the KPI used here is per_process_ops)
> 
> kernel_versions      					 per_process_ops
> ---------------      					 ---------------
> v6.17.0 	                                       - 258291
> v6.18.0-rc1 	                                       - 225839
> v6.17.0-rc3-59faa4da7                                  - 212152
> v6.17.0-rc3-3accabda4da1(one commit before bad commit) - 265054

Thanks for the info. Is there any difference if you increase the
sheaf_capacity in the commit from 32 to a higher value? For example 120 to
match what the automatically calculated cpu partial slabs target would be.
I think there's a lock contention on the barn lock causing the regression.
By matching the cpu partial slabs value we should have same batching factor
for the barn lock as there would be on the node list_lock before sheaves.

Thanks.

> Recreation steps:
> 
> 1) git clone https://github.com/antonblanchard/will-it-scale.git
> 2) git clone https://github.com/intel/lkp-tests.git
> 3) cd will-it-scale && git apply 
> lkp-tests/programs/will-it-scale/pkg/will-it-scale.patch
> 4) make
> 5) python3 runtest.py mmap2 25 process 0 0 1 8 64 128 192 256
> 
> NOTE: [5] is specific to machine's architecture. starting from 1 is the 
> array of no.of tasks that you'd wish to run the testcase which here is 
> no.cores per CCX, per NUMA node/ per Socket, nr_threads.
> 
> I also ran the micro-benchmark with tools/testing/perf record and 
> following is the collected data:-
> 
> # perf diff perf.data.old perf.data
> No kallsyms or vmlinux with build-id 
> 0fc9c7b62ade1502af5d6a060914732523f367ef was found
> Warning:
> 43 out of order events recorded.
> Warning:
> 54 out of order events recorded.
> # Event 'cycles:P'
> #
> # Baseline  Delta Abs  Shared Object           Symbol
> # ........  .........  ...................... 
> ..............................................
> #
>                +51.51%  [kernel.kallsyms]       [k] 
> native_queued_spin_lock_slowpath
>                +14.39%  [kernel.kallsyms]       [k] perf_iterate_ctx
>                 +2.52%  [kernel.kallsyms]       [k] unmap_page_range
>                 +1.75%  [kernel.kallsyms]       [k] mas_wr_node_store
>                 +1.47%  [kernel.kallsyms]       [k] __pi_memset
>                 +1.38%  [kernel.kallsyms]       [k] mt_free_rcu
>                 +1.36%  [kernel.kallsyms]       [k] free_pgd_range
>                 +1.10%  [kernel.kallsyms]       [k] __pi_memcpy
>                 +0.96%  [kernel.kallsyms]       [k] __kmem_cache_alloc_bulk
>                 +0.92%  [kernel.kallsyms]       [k] __mmap_region
>                 +0.79%  [kernel.kallsyms]       [k] mas_empty_area_rev
>                 +0.74%  [kernel.kallsyms]       [k] __cond_resched
>                 +0.73%  [kernel.kallsyms]       [k] mas_walk
>                 +0.59%  [kernel.kallsyms]       [k] mas_pop_node
>                 +0.57%  [kernel.kallsyms]       [k] perf_event_mmap_output
>                 +0.49%  [kernel.kallsyms]       [k] mas_find
>                 +0.48%  [kernel.kallsyms]       [k] mas_next_slot
>                 +0.46%  [kernel.kallsyms]       [k] kmem_cache_free
>                 +0.42%  [kernel.kallsyms]       [k] mas_leaf_max_gap
>                 +0.42%  [kernel.kallsyms]       [k] 
> __call_rcu_common.constprop.0
>                 +0.39%  [kernel.kallsyms]       [k] entry_SYSCALL_64
>                 +0.38%  [kernel.kallsyms]       [k] mas_prev_slot
>                 +0.38%  [kernel.kallsyms]       [k] kmem_cache_alloc_noprof
>                 +0.37%  [kernel.kallsyms]       [k] mas_store_gfp
> 
> 
>> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>   lib/maple_tree.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>> 
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 4f0e30b57b0cef9e5cf791f3f64f5898752db402..d034f170ac897341b40cfd050b6aee86b6d2cf60 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -6040,9 +6040,14 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
>>   
>>   void __init maple_tree_init(void)
>>   {
>> +	struct kmem_cache_args args = {
>> +		.align  = sizeof(struct maple_node),
>> +		.sheaf_capacity = 32,
>> +	};
>> +
>>   	maple_node_cache = kmem_cache_create("maple_node",
>> -			sizeof(struct maple_node), sizeof(struct maple_node),
>> -			SLAB_PANIC, NULL);
>> +			sizeof(struct maple_node), &args,
>> +			SLAB_PANIC);
>>   }
>>   
>>   /**
>> 
> 
> ---
> Thanks and Regards
> Suneeth D
> 

