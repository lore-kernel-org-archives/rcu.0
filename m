Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6522F1F1513;
	Thu,  3 Sep 2026 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426853; cv=none; b=a3H/0mUBVLj3/D5PyUaRCttGTjdz/WzgaXTwC1XrjgmAeR1DtpA9B/3qX5fh1QMOelymfqMHFHJMMbRdmkxFoA6mo6lYh+e7p+/9SE0/+F5IpO8+B03GGKv5+xm/pQYdIZwugCbdT1oKwViYy0dHSvDfIele3N9KWSIvaae2nnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426853; c=relaxed/simple;
	bh=pwxCa+02bNBfjuGiRu7O9G/SCnZvL9HS8DRVX7csQqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fly6Bu75u95bQQIlpuj1xSMGjzSo7WDBnVE+2oPp5CwKR8PRWUMKwu+okNiUHQF3yJs7lGNq92LEbzmzAHpcKjr9RdoGe7j+8rwe0Hr0Pftx7IUqfZ+whY8P6a3WUMs96BHVWgOY3rL/O3Ytu+qICNox2Th3vrM437ye0PCgQmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d1mPkZQO; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d1mPkZQO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=6Eb7OOCldREczEc1zP4/rwq++5YqOpKv0/oThiUkNrw=;
	b=d1mPkZQOntVWuJ3jJY+aIT4a0yYdMl2bhSahqBGDPdT3cvnlsYz1PeyUmxmEQL
	TzfaF5/o5YFGlOKwTqW1zgL/NbC522CD3ybxrokwxf284vI9XLNX6Z0g1CG258ij
	wJ8/mKoLu/wKqkRuqRQXW1CT8XnDEciKfuegBGzJhsaHA=
Message-ID: <baa22f03-e553-46cc-8c35-436363546605@163.com>
Date: Thu, 3 Sep 2026 17:13:15 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/slab_common: fix shrink budget underflow in
 kfree_rcu_shrink_scan
To: Harry Yoo <harry@kernel.org>
Cc: vbabka@kernel.org, akpm@linux-foundation.org, hao.li@linux.dev,
 cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
 rcu@vger.kernel.org, xialonglong@kylinos.cn
References: <20260826075653.3304251-1-xialonglong2025@163.com>
 <apQsbGJDPPyXcn8R@dev>
From: Longlong Xia <xialonglong2025@163.com>
In-Reply-To: <apQsbGJDPPyXcn8R@dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnt+wqOplqb5p0AQ--.21702S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFyrAF4ftF13XFyDGw1UAwb_yoWrZr4rpF
	W0ka4UKr4kJry8u3srXw4xXryay3yFkFWxGrWDAr43J3sI9F1rtryIyr1qvrWFyrn3Jw4S
	vr1qgFyDXFyjvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5sqAUUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbC3A2ak2qZOi2XJAAA3P

Thanks for the reply.

在 2026/8/30 22:22, Harry Yoo 写道:
> On Wed, Aug 26, 2026 at 03:56:53PM +0800, Longlong Xia wrote:
>> From: Longlong Xia <xialonglong@kylinos.cn>
> Hi Longlong, I have a few questions.
>
>> The kfree_rcu shrinker decremented sc->nr_to_scan (unsigned long)
>> and then tested the result with <= 0. When a single CPU's object
>> count exceeds the remaining budget, the subtraction wraps to a large
>> positive value and the <= 0 comparison, which is equivalent to == 0
>> for an unsigned type, never fires again.
> Since when (which commit) has it been broken?
> If it has been undiscovered for a very long time, why is that so?

Since the shrinker was first added: 9154244c1ab6 ("rcu/tree: Add a
shrinker to prevent OOM due to kfree_rcu() batching", v5.8);

>
> And how did you discover this?

While reviewing the kvfree_rcu() batching paths with the help of AI
tooling (hence the Assisted-by: tag in the patch), which flagged the
unsigned subtraction feeding a "<= 0" test.

>> The scan loop then iterates
>> through every possible CPU instead of honouring the reclaim budget.
> Did you confirm this actually does happen? If so, how often does the
> kernel end up iterating through every possible CPUs, very rarely or
> almost always?

Yes, in two ways.


Experiment 1 -- deterministic, instrumented loop.  Per-CPU pr_info()
plus a test entry invoking kfree_rcu_shrink_scan() with a controlled
budget; 4-CPU QEMU guest, 400 objects queued on CPU0, budget 50:
   buggy:   cpu=0 count=400 nr_to_scan_after_sub=18446744073709551266
                 visits all 4 CPUs
   patched: cpu=0 count=400 nr_to_scan=50 BREAK

                stops at CPU0


Experiment 2 -- natural trigger, no kernel modification at all
(kprobes only).  Setup: 1 GiB QEMU guest, 4 possible CPUs, no swap.

   1. Observation: three kprobes.  Scan entry/exit record nr_to_scan
      and the return value; each kfree_rcu_monitor() hit inside a
      scan is one CPU the loop processed.

   2. Memory pressure: ~650 MiB of anonymous memory.

   3. krc backlog: loaded the in-tree test_vmalloc module ,

      which repeatedly vmalloc()s one page and frees it via kvfree_rcu();

     10 million iterations over ~70s kept the per-CPU queues populated.


Result within ~70s: 262 natural invocations, all from kswapd0;
171 of the 261 scans that found a backlog (66%) overshot the budget
(nr_to_scan = 128, freed up to 4479) and visited all 4 possible CPUs.


>
> Would this affect the kernel's reclamation behavior in some way?

The break was meant to cap the scan at the reclaim budget; once
the subtraction wraps, the cap is gone and one scan processes
every possible CPU, draining the whole backlog instead of a
budget-sized slice.


Thanks,

Longlong

>> Accumulate into freed and stop once freed >= nr_to_scan. The shrinker
>> core treats nr_to_scan as input-only, so dropping the decrement is
>> safe; freed becomes unsigned long to match the return type.
>>
>> Suggested-by: Hao Li <hao.li@linux.dev>
>> Assisted-by: Codex:gpt-5.6-sol
>> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
>> ---
>> Changes in v2:
>> - Rework per suggestion from Hao Li: accumulate into freed directly,
>>    compare freed >= nr_to_scan instead of decrementing nr_to_scan, and
>>    drop the per-CPU count local; promote freed to unsigned long.
>>
>> Link: https://lore.kernel.org/all/20260824091838.1692153-1-xialonglong2025@163.com/
>> ---
>>   mm/slab_common.c | 13 +++++--------
>>   1 file changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 657fd75776ea..e227c2ef2a4e 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -2162,20 +2162,17 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>>   static unsigned long
>>   kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>>   {
>> -	int cpu, freed = 0;
>> +	int cpu;
>> +	unsigned long freed = 0;
>>   
>>   	for_each_possible_cpu(cpu) {
>> -		int count;
>>   		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>>   
>> -		count = krc_count(krcp);
>> -		count += drain_page_cache(krcp);
>> +		freed += krc_count(krcp);
>> +		freed += drain_page_cache(krcp);
>>   		kfree_rcu_monitor(&krcp->monitor_work.work);
>>   
>> -		sc->nr_to_scan -= count;
>> -		freed += count;
>> -
>> -		if (sc->nr_to_scan <= 0)
>> +		if (freed >= sc->nr_to_scan)
>>   			break;
>>   	}
>>   
>> -- 
>> 2.43.0

