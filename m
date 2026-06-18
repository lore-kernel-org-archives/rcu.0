Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7D30566E
	for <rcu@vger.kernel.org>; Thu, 18 Jun 2026 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796670; cv=none; b=f8TTLqDBkFQio/C+Q/dkVUzY8YNvM4v/pxRGy4IUY4XQq6SomNOq5kIXYOpILTVPJSIQSGRTTinEfT5RV/gwpTM+yQlAijvOHw2anztcA1SgAbhTAlwCieTlp0wXgZRxtti7tMRf1GB4b2a/7e95uSoZ074r78TsF+68dc7TpKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796670; c=relaxed/simple;
	bh=lmL2zYR980yrJS1ltrlXxX2VzOlEVivhv1mIjQR68EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aetaRZTMry3o7qELKwNusE9KR3x1PCtOmJ0nhYcEcms6TCkdglBYGB3P4WgBsxObe2EracdEt0wJ/gCiGFryC5pAnWrQz0D1e4x2gxWv5g7Iwk1XXCUWVcXpPULxOOhfHLa0GH6mPIdoui9uMhJxeVj3mUERYmVjZpP1qtMSDoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eB345sEQ; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eB345sEQ"
Message-ID: <7b03df79-f7ff-4ea1-8a2a-f4e504bfa6da@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781796656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ScbQDuuD0+8DiWDa7SmPYsEcU8Tz9wqZKnVoZG2oW4=;
	b=eB345sEQbAfANDq7jwgROYMV1UkKEU0WUVyHT7fv1kj/ZjfYCIuCw5TOV6cTjzO5an+zan
	TLe/ZBuvESUH0oWq6Rzmestrw44pMF/HYEB19G+GdaOlD6STJVuTZ3r1d0shEzsdX5nxJ9
	F+uL03+K0f7Sme058YzxX9w/0vg1u94=
Date: Thu, 18 Jun 2026 16:30:51 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] smp: Use release stores for csd_lock_record() state
To: paulmck@kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Alan Stern <stern@rowland.harvard.edu>, lkmm@lists.linux.dev,
 joelagnelf@nvidia.com, linux-kernel@vger.kernel.org,
 marco.crivellari@suse.com, rafael.j.wysocki@intel.com, riel@surriel.com,
 sshegde@linux.ibm.com, tglx@kernel.org, ulfh@kernel.org,
 yury.norov@gmail.com, rcu@vger.kernel.org, shakeel.butt@linux.dev,
 hannes@cmpxchg.org, kernel-team@meta.com
References: <20260617212001.3658605-1-usama.arif@linux.dev>
 <831f9fb1-82a5-46ba-9541-b82c94e43639@rowland.harvard.edu>
 <2d4034d5-fa7c-463b-89c3-2725e4dbd137@infradead.org>
 <01437928-ff79-4d8e-823b-7f20146946f6@linux.dev>
 <cf092a63-a9bd-4ecd-8276-d4736a37d3ee@paulmck-laptop>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <cf092a63-a9bd-4ecd-8276-d4736a37d3ee@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 18/06/2026 15:57, Paul E. McKenney wrote:
> On Thu, Jun 18, 2026 at 03:44:36PM +0100, Usama Arif wrote:
>> On 18/06/2026 04:30, Randy Dunlap wrote:
>>> On 6/17/26 6:44 PM, Alan Stern wrote:
>>>> On Wed, Jun 17, 2026 at 02:20:01PM -0700, Usama Arif wrote:
>>>>> __csd_lock_record() publishes per-CPU CSD debug state that is read by
>>>>> csd_lock_wait_toolong() on another CPU.  The remote side first reads
>>>>> cur_csd with smp_load_acquire() and, when non-NULL, may then read the
>>>>> matching cur_csd_func and cur_csd_info fields.
>>>>>
>>>>> Use smp_store_release() when publishing cur_csd so that the preceding
>>>>> cur_csd_func and cur_csd_info stores are ordered before the pointer
>>>>> that csd_lock_wait_toolong() acquires.  This replaces the open-coded
>>>>> smp_wmb() plus plain cur_csd store with the release operation that
>>>>> matches the smp_load_acquire() in csd_lock_wait_toolong().
>>>>>
>>>>> For the clear path, use smp_store_release(&cur_csd, NULL) so that
>>>>> clearing the diagnostic state remains ordered after the preceding
>>>>> callback/unlock work, without requiring a full barrier before the
>>>>> store.  On x86 this removes the locked full barrier from the clear
>>>>> path; on weaker memory models it uses the release operation needed by
>>>>> the smp_load_acquire() in csd_lock_wait_toolong().
>>>>>
>>>>> The old code also had smp_mb() calls around cur_csd updates. Those would
>>>>> only be needed if cur_csd were treated as an exact live-state marker whose
>>>>> publication had to be observed before callback execution or CSD unlock.
>>>>> CSD stall warnings do not currently have RCU-style stall-ended checks, so
>>>>> they already allow the stall to end while diagnostics are being assembled.
>>>>> The cur_csd record is therefore best-effort diagnostic context, not a
>>>>> precise completion/stall boundary.
>>>>>
>>>>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
>>>>> ---
>>>>>  kernel/smp.c | 8 ++------
>>>>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/kernel/smp.c b/kernel/smp.c
>>>>> index a0bb56bd8dda..5ba4a20ba77d 100644
>>>>> --- a/kernel/smp.c
>>>>> +++ b/kernel/smp.c
>>>>> @@ -182,16 +182,12 @@ static atomic_t csd_bug_count = ATOMIC_INIT(0);
>>>>>  static void __csd_lock_record(call_single_data_t *csd)
>>>>>  {
>>>>>  	if (!csd) {
>>>>> -		smp_mb(); /* NULL cur_csd after unlock. */
>>>>> -		__this_cpu_write(cur_csd, NULL);
>>>>> +		smp_store_release(this_cpu_ptr(&cur_csd), NULL);
>>>>>  		return;
>>>>>  	}
>>>>>  	__this_cpu_write(cur_csd_func, csd->func);
>>>>>  	__this_cpu_write(cur_csd_info, csd->info);
>>>>> -	smp_wmb(); /* func and info before csd. */
>>>>> -	__this_cpu_write(cur_csd, csd);
>>>>> -	smp_mb(); /* Update cur_csd before function call. */
>>>>> -		  /* Or before unlock, as the case may be. */
>>>>> +	smp_store_release(this_cpu_ptr(&cur_csd), csd);
>>>>
>>>> Isn't there a general policy in the kernel that memory barriers should 
>>>> be accompanied by a comment explaining what other memory barriers they 
>>>> synchronize with?  Including such comments is a good idea in any case.
>>>
>>> in Documentation/process/submit-checklist.rst:
>>>
>>> 3) All memory barriers {e.g., ``barrier()``, ``rmb()``, ``wmb()``} need a
>>>    comment in the source code that explains the logic of what they are doing
>>>    and why.
>>>
>>> in Documentation/process/4.Coding.rst:
>>>
>>> Certain things should always be commented.  Uses of memory barriers should
>>> be accompanied by a line explaining why the barrier is necessary.
>>>
>>> but looking in the 3000+ lines of Documentation/memory-barriers.txt won't tell
>>> anyone about that.
>>>
>>>
>>
>> Thanks!
>> I will send a v2 with the below diff if there are no objections?
>>
>> diff --git a/kernel/smp.c b/kernel/smp.c
>> index 5ba4a20ba77d..685829875a3e 100644
>> --- a/kernel/smp.c
>> +++ b/kernel/smp.c
>> @@ -182,11 +182,21 @@ static atomic_t csd_bug_count = ATOMIC_INIT(0);
>>  static void __csd_lock_record(call_single_data_t *csd)
>>  {
>>         if (!csd) {
>> +               /*
>> +                * Pairs with smp_load_acquire() of cur_csd in
>> +                * csd_lock_wait_toolong(): orders any preceding CSD
>> +                * callback/unlock before a remote reader observes NULL.
>> +                */
> 
> Please replace the spaces with tabs.  (Probably a copy-pasta issue.)

Yes, its tabs in my commit, looks like the email client messed it up.
> 
>>                 smp_store_release(this_cpu_ptr(&cur_csd), NULL);
> 
> 		smp_store_release(this_cpu_ptr(&cur_csd), NULL); /* ^^^ */
> 
> Adding the comment as show above will satisfy tools such as checkpatch.

Will do, Thanks!

> 
>>                 return;
>>         }
>>         __this_cpu_write(cur_csd_func, csd->func);
>>         __this_cpu_write(cur_csd_info, csd->info);
>> +       /*
>> +        * Pairs with smp_load_acquire() of cur_csd in
>> +        * csd_lock_wait_toolong(): publishes cur_csd_func and
>> +        * cur_csd_info before the non-NULL pointer becomes visible.
>> +        */
>>         smp_store_release(this_cpu_ptr(&cur_csd), csd);
>>  }
> 
> The comments look good to me, but I must defer to Alan and Randy

Thanks!
> 
> 						Thanx, Paul

