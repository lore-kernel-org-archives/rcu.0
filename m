Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E215224D6;
	Thu, 18 Jun 2026 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781753438; cv=none; b=TT46gxWNZJjwH8YirgmDMWteX2ABqL9Wg07m/invwwxkd4GXVj4+6RwDJ0fcUUrhdbXdC9oblkHntN8sNKgTLVai6BcXsU+PcCZ6oOqQZHSf5MbWpJl6bESSo5uFHXjIRD8GymM+bD3cDxSVyrmCeie2HYkWHEWSuhZ9TzA7q2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781753438; c=relaxed/simple;
	bh=VjxA754U0M4WR53OPgcKdfd93h24Zv/gfF+x18PT+hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuHdt24x0uYDtlb3cPrsyKFJuIX7Fcr14OoqR1ig30QGs/YuhR48INo8Yf85wc904SbSjrUAVJEzghHwi6hTwEFAmYJJhEe9KzaWEqiJ0d2BBqcsPuPLm+K8QERNuPzwcxDJUy7CGaDjKhYpcid629oWxgMKx72zbiVNbNjm5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hONQDTHD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hONQDTHD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=11Ir82OG3ZuDJ3g6H/UXY3YnUQulR1W5403hsz+8txI=; b=hONQDTHDssNMorkbJNrsJX16Lp
	xqAQaufjQZQeIrU9LvOhkwFDIAi3RdioirZRcGVMwiePFjHjxksJcLT9VgLM3fBKzy+/okqTxT5li
	1d3Md/8lroDHsCRVo5oJh0TakcrK2VCbpgt0xaUdJup5dGI/w/pmOg4zDTs+AJ3KxMkmZxLFdiUUc
	ZSYW/DzAoLVi/oZb5frM/zwkAiFOQyl//cN5KQkQ0WoCaq6C6pgi1dsgF68Srn0VPwQLyPCNM23To
	vbgKiQad1P99Xt/WDmXhVvPNjQLgRupbWML9LyL+myV8FtHINrbPEgnSRO4kOV7wOSs/BBggiu/fR
	cGoPCrLw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa3Sc-00000000ZVM-24BI;
	Thu, 18 Jun 2026 03:30:34 +0000
Message-ID: <2d4034d5-fa7c-463b-89c3-2725e4dbd137@infradead.org>
Date: Wed, 17 Jun 2026 20:30:32 -0700
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smp: Use release stores for csd_lock_record() state
To: Alan Stern <stern@rowland.harvard.edu>, Usama Arif <usama.arif@linux.dev>
Cc: lkmm@lists.linux.dev, joelagnelf@nvidia.com,
 linux-kernel@vger.kernel.org, marco.crivellari@suse.com, paulmck@kernel.org,
 rafael.j.wysocki@intel.com, riel@surriel.com, sshegde@linux.ibm.com,
 tglx@kernel.org, ulfh@kernel.org, yury.norov@gmail.com, rcu@vger.kernel.org,
 shakeel.butt@linux.dev, hannes@cmpxchg.org, kernel-team@meta.com
References: <20260617212001.3658605-1-usama.arif@linux.dev>
 <831f9fb1-82a5-46ba-9541-b82c94e43639@rowland.harvard.edu>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <831f9fb1-82a5-46ba-9541-b82c94e43639@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/17/26 6:44 PM, Alan Stern wrote:
> On Wed, Jun 17, 2026 at 02:20:01PM -0700, Usama Arif wrote:
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
>>  kernel/smp.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/smp.c b/kernel/smp.c
>> index a0bb56bd8dda..5ba4a20ba77d 100644
>> --- a/kernel/smp.c
>> +++ b/kernel/smp.c
>> @@ -182,16 +182,12 @@ static atomic_t csd_bug_count = ATOMIC_INIT(0);
>>  static void __csd_lock_record(call_single_data_t *csd)
>>  {
>>  	if (!csd) {
>> -		smp_mb(); /* NULL cur_csd after unlock. */
>> -		__this_cpu_write(cur_csd, NULL);
>> +		smp_store_release(this_cpu_ptr(&cur_csd), NULL);
>>  		return;
>>  	}
>>  	__this_cpu_write(cur_csd_func, csd->func);
>>  	__this_cpu_write(cur_csd_info, csd->info);
>> -	smp_wmb(); /* func and info before csd. */
>> -	__this_cpu_write(cur_csd, csd);
>> -	smp_mb(); /* Update cur_csd before function call. */
>> -		  /* Or before unlock, as the case may be. */
>> +	smp_store_release(this_cpu_ptr(&cur_csd), csd);
> 
> Isn't there a general policy in the kernel that memory barriers should 
> be accompanied by a comment explaining what other memory barriers they 
> synchronize with?  Including such comments is a good idea in any case.

in Documentation/process/submit-checklist.rst:

3) All memory barriers {e.g., ``barrier()``, ``rmb()``, ``wmb()``} need a
   comment in the source code that explains the logic of what they are doing
   and why.

in Documentation/process/4.Coding.rst:

Certain things should always be commented.  Uses of memory barriers should
be accompanied by a line explaining why the barrier is necessary.

but looking in the 3000+ lines of Documentation/memory-barriers.txt won't tell
anyone about that.


-- 
~Randy

