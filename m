Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5332E3FBEC9
	for <rcu@vger.kernel.org>; Fri, 26 Jun 2026 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491442; cv=none; b=rl3F9QLo28/eLCKbhIElu96Oa0Be7T4MCF5EbgWqaSvkeTURZvSL0n+3+iTSH3/z+06aIMkF0lQGcdCJjHQ4y3oMhIIOogxwS5fTk2AcSfaOeKsaL2pwwYmj64r/1wPiHL+25zJ/n7y7vWpeVgvkiuR1bfkx+XaMid8KI3xIDgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491442; c=relaxed/simple;
	bh=rWOiwxCoRgiJZKsYjqvfKpfnDCTlg7NhP9vkLRgydlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLutQdbY13XIThkFpq7rwmhUnYp9JKKKiG+DcX/Dd4g+ipvNyoK9bzDswboBpPCFEnoRY/K1QYCuydJQpJtq2SC7vZSbeg6zsoS9V+pMeqyYPK0eys12UnfUFk9JlfO/tlTHdXnpzMrrs6RO5iZbO/g1VuWDbthZZl8EiTR/DCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jFiVDpoL; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jFiVDpoL"
Message-ID: <19ad0544-7401-4050-b991-1cc374921e49@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782491429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HMHQixL/BAkUs2Zzi8nL/MwEPIi7gF2NyGowzygA1Vg=;
	b=jFiVDpoLlKB2GxTGCukGcmlksLPZOLbXXpRLZEOirkHkCnym+0PFsrScirkySSncxPrhpj
	z9mS/1wKSLeICjU3xkhtj+naVi9FZ3LvqEY1hC527rEvLC/fJLCMBUNLW3SUNMQPJo7CWK
	QlnpsTUe2UcgMGnHGzEdvrFzZf0+PZo=
Date: Fri, 26 Jun 2026 17:30:21 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] smp: Use release stores for csd_lock_record() state
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: lkmm@lists.linux.dev, joelagnelf@nvidia.com,
 linux-kernel@vger.kernel.org, marco.crivellari@suse.com, paulmck@kernel.org,
 rafael.j.wysocki@intel.com, rdunlap@infradead.org, riel@surriel.com,
 sshegde@linux.ibm.com, tglx@kernel.org, ulfh@kernel.org,
 yury.norov@gmail.com, rcu@vger.kernel.org, shakeel.butt@linux.dev,
 hannes@cmpxchg.org, kernel-team@meta.com
References: <20260622163807.4187558-1-usama.arif@linux.dev>
 <aj0-SYJJdDzf56Ex@shell.ilvokhin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <aj0-SYJJdDzf56Ex@shell.ilvokhin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 25/06/2026 15:42, Dmitry Ilvokhin wrote:
> On Mon, Jun 22, 2026 at 09:38:07AM -0700, Usama Arif wrote:
>> __csd_lock_record() publishes per-CPU CSD debug state that is read by
>> csd_lock_wait_toolong() on another CPU.  The remote side first reads
>> cur_csd with smp_load_acquire() and, when non-NULL, may then read the
>> matching cur_csd_func and cur_csd_info fields.
>>
>> Use smp_store_release() when publishing cur_csd so that the preceding
>> cur_csd_func and cur_csd_info stores are ordered before the pointer
>> that csd_lock_wait_toolong() acquires.  This replaces the open-coded
>> smp_wmb() plus plain cur_csd store with the release operation that
>> matches the smp_load_acquire() in csd_lock_wait_toolong().
>>
>> For the clear path, use smp_store_release(&cur_csd, NULL) so that
>> clearing the diagnostic state remains ordered after the preceding
>> callback/unlock work, without requiring a full barrier before the
>> store.  On x86 this removes the locked full barrier from the clear
>> path; on weaker memory models it uses the release operation needed by
>> the smp_load_acquire() in csd_lock_wait_toolong().
> 
> The changelog only calls out the clear path here, but the publish path
> also drops its trailing smp_mb() (plus the smp_wmb()), so on x86 both
> paths lose a locked full barrier. Worth describing symmetrically.

Do you mean whats written in the next paragraph? The paragraph above
is for clear, the paragraph just below is for publish. The reason for removing
smp_wmb() is in 2nd paragraph. I think all the information regarding the changes
is in the commit message.> 
>>
>> The old code also had smp_mb() calls around cur_csd updates. Those would
>> only be needed if cur_csd were treated as an exact live-state marker whose
>> publication had to be observed before callback execution or CSD unlock.
>> CSD stall warnings do not currently have RCU-style stall-ended checks, so
>> they already allow the stall to end while diagnostics are being assembled.
>> The cur_csd record is therefore best-effort diagnostic context, not a
>> precise completion/stall boundary.
>>
>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
>> ---
>> v1 -> v2: https://lore.kernel.org/all/01437928-ff79-4d8e-823b-7f20146946f6@linux.dev/
>> - Document where the smp_store_release() synchronizes with (Alan Stern,
>>   Randy Dunlap and Paul McKenney).
>> ---
>>  kernel/smp.c | 18 ++++++++++++------
>>  1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/smp.c b/kernel/smp.c
>> index a0bb56bd8dda..685829875a3e 100644
>> --- a/kernel/smp.c
>> +++ b/kernel/smp.c
>> @@ -182,16 +182,22 @@ static atomic_t csd_bug_count = ATOMIC_INIT(0);
>>  static void __csd_lock_record(call_single_data_t *csd)
>>  {
>>  	if (!csd) {
>> -		smp_mb(); /* NULL cur_csd after unlock. */
>> -		__this_cpu_write(cur_csd, NULL);
>> +		/*
>> +		 * Pairs with smp_load_acquire() of cur_csd in
>> +		 * csd_lock_wait_toolong(): orders any preceding CSD
>> +		 * callback/unlock before a remote reader observes NULL.
>> +		 */
>> +		smp_store_release(this_cpu_ptr(&cur_csd), NULL);
>>  		return;
>>  	}
>>  	__this_cpu_write(cur_csd_func, csd->func);
>>  	__this_cpu_write(cur_csd_info, csd->info);
>> -	smp_wmb(); /* func and info before csd. */
>> -	__this_cpu_write(cur_csd, csd);
>> -	smp_mb(); /* Update cur_csd before function call. */
>> -		  /* Or before unlock, as the case may be. */
>> +	/*
>> +	 * Pairs with smp_load_acquire() of cur_csd in
>> +	 * csd_lock_wait_toolong(): publishes cur_csd_func and
>> +	 * cur_csd_info before the non-NULL pointer becomes visible.
>> +	 */
>> +	smp_store_release(this_cpu_ptr(&cur_csd), csd);
>>  }
> 
> Since v2 is specifically about documenting the pairing, it would be good
> to make it symmetric and add the comment on the acquire side in
> csd_lock_wait_toolong().
> 

Its already documented [1]

[1] https://elixir.bootlin.com/linux/v7.1.1/source/kernel/smp.c#L275

>>  
>>  static __always_inline void csd_lock_record(call_single_data_t *csd)
>> -- 
>> 2.53.0-Meta
>>

