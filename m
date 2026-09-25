Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC65C4E66A2;
	Fri, 25 Sep 2026 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366247; cv=none; b=Utl0hzMbSJ0AdVqN5AYSsXoUd2QmOuPtB1f+3qnxKzT9szkPY64MiwFxFCoFph8pHJqHmRa3tsMWzkuzxkgfG9M7UEKYLWbBxASbCCha7Wlkm09ZUq0nrLJEaDrVeBQB5wMyrNYu+Xvahp40w4gwg5MfLJKFIL5IlMbHcsx0/8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366247; c=relaxed/simple;
	bh=N0xruGUsIbHFFCMukw0dpXNfjh6pFTvxl9ZgQcrHMW8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JcoE2ZqDlTG1Y0POsd4/Q5DOLfnaBCRrz+H5p7cBgJiU5E1hkLTysFrnjELEGWcWDO+Lq0HM2DPWakmOVDmBFve1nNZp2eAGZ5CHQdhCTMjjufwyr/LOweatiZ2rzla2whqafIubiCy3gtWEgF4aFYtcX/hqqg6B8DYulsf9wqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=YhO9Udmk; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=bc1u2Mna; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="YhO9Udmk";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="bc1u2Mna"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790366233; bh=OxN57ehpdPJriPOogHg1njM
	HuBtNxfHf7Rhyb05GJ/k=; b=YhO9UdmkZ4nE0f41RCLT395Nt6EfrjSFMT+371EAD1TYvRWbuQ
	v6Sw2FNAUBHdQq0wSIgQlHVxBcsnO+fL2SSWockcwH537Gxivkb+PD+iDjywmhBPtvd5F2WF+au
	nEhSjJnw4sui5YEMzPCOxWC5nUqerBdEN+o4Ar0Tnn1vbjKedXJUdwyRaB12tCFd4i1zxOSXN8l
	QiOp1GAwewfo6JwGANuOXoIxTY/8u47QeNCyxKl5EZU5z0vJXukspDVjxGqz/wFJ2mmhLBLFrUu
	A7nxDrpjCtQ2MB9o8kZEqmXM+ipHdpb6DTvvUiwbFYo/meZzLKeQQLYm8MLWlUu2g/A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790366233; bh=OxN57ehpdPJriPOogHg1njM
	HuBtNxfHf7Rhyb05GJ/k=; b=bc1u2Mna6k8fE6/ZvnqpX0CQabQWIBCCvJ/V4EJInJZvYdPtgg
	GDWxRqenEb5GMDesekAdzP6nU4ikKzRywrAA==;
Date: Fri, 25 Sep 2026 20:57:10 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
CC: linux-kernel@vger.kernel.org, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, rcu@vger.kernel.org, lkmm@lists.linux.dev
Subject: Re: [PATCH] hazptr: Fix two-phase hazptr_synchronize race with detach
In-Reply-To: <0836f8af-30cf-43d6-8e1d-7886a5de9bc9@efficios.com>
References: <20260925194952.4704-1-mathieu.desnoyers@efficios.com> <0836f8af-30cf-43d6-8e1d-7886a5de9bc9@efficios.com>
Message-ID: <D90079D7-ED94-4945-BA81-31EC9127295A@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 25 September 2026 20:52:45 BST, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>On 2026-09-25 15:49, Mathieu Desnoyers wrote:
>> Boqun Feng pointed out that a detach happening concurrently with
>> hazptr_synchronize can miss a slot. Indeed, scanning the per-CPU
>> slots needs to be done *before* scanning the overflow lists. Fix the
>> implementation accordingly.
>> 
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
>Self-NACK. I did not migrate the detach code to move it to the new
>hazptr_overflow_list_phase. Sorry about the noise. I'll prepare an
>updated version.
>
>Thanks,
>
>Mathieu

1: Didn't know you could self nak
2: I must've been dumb during review then, in respin I'll think heavier about it.

>
>
>> Reported-by: Boqun Feng <boqun@kernel.org>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Boqun Feng <boqun@kernel.org>
>> Cc: Bradley Morgan <brads@mainlining.org>
>> Cc: Gary Guo <gary@garyguo.net>
>> Cc: <rcu@vger.kernel.org>
>> Cc: <lkmm@lists.linux.dev>
>> ---
>>   kernel/hazptr.c | 43 ++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 36 insertions(+), 7 deletions(-)
>> 
>> diff --git a/kernel/hazptr.c b/kernel/hazptr.c
>> index d3d1050d92cf..ccc19843edbd 100644
>> --- a/kernel/hazptr.c
>> +++ b/kernel/hazptr.c
>> @@ -24,6 +24,9 @@ static DEFINE_MUTEX(hazptr_wildcard_lock);	/* Protect the wildcard flip. */
>>   void *hazptr_wildcard = (void *) 1UL;
>>   EXPORT_SYMBOL_GPL(hazptr_wildcard);
>>   +/* The current overflow list phase. */
>> +static unsigned int hazptr_overflow_list_phase;
>> +
>>   struct hazptr_overflow_list {
>>   	raw_spinlock_t lock;		/* Lock protecting overflow list and list generation. */
>>   	struct hlist_head head;		/* Overflow list head. */
>> @@ -53,6 +56,12 @@ void *flip_wildcard(void *wildcard)
>>   	return ((unsigned long) wildcard == 1UL) ? (void *) 2UL : (void *) 1UL;
>>   }
>>   +static
>> +unsigned int flip_list_phase(unsigned int phase)
>> +{
>> +	return 1 - phase;
>> +}
>> +
>>   static
>>   bool is_wildcard(void *addr)
>>   {
>> @@ -178,15 +187,12 @@ void hazptr_synchronize_cpu_slots(int cpu, void
>*addr, void *scan_wildcard)
>>   }
>>     static
>> -void hazptr_scan_period(void *addr, void *scan_wildcard)
>> +void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
>>   {
>> -	unsigned int scan_idx = (unsigned long) scan_wildcard - 1;
>>   	int cpu;
>>     	/* Scan all CPUs slots. */
>>   	for_each_possible_cpu(cpu) {
>> -		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
>> -
>>   		/*
>>   		 * Scan CPU slots.
>>   		 * Forward progress against recurring wildcards is guaranteed
>> @@ -199,6 +205,17 @@ void hazptr_scan_period(void *addr, void
>*scan_wildcard)
>>   		 * to acquire that same hazard pointer value.
>>   		 */
>>   		hazptr_synchronize_cpu_slots(cpu, addr, scan_wildcard);
>> +	}
>> +}
>> +
>> +static
>> +void hazptr_scan_overflow_list_period(void *addr, unsigned int
>scan_idx)
>> +{
>> +	int cpu;
>> +
>> +	/* Scan all CPUs overflow lists. */
>> +	for_each_possible_cpu(cpu) {
>> +		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
>>     		/*
>>   		 * Scan backup slots in percpu overflow lists.
>> @@ -218,6 +235,7 @@ void hazptr_scan_period(void *addr, void
>*scan_wildcard)
>>    */
>>   void hazptr_synchronize(void *addr)
>>   {
>> +	unsigned int scan_list_phase;
>>   	void *scan_wildcard;
>>     	/*
>> @@ -236,10 +254,21 @@ void hazptr_synchronize(void *addr)
>>   	smp_mb();
>>     	guard(mutex)(&hazptr_wildcard_lock);
>> +
>> +	/* Scan per-CPU slots. */
>>   	scan_wildcard = flip_wildcard(hazptr_wildcard);
>> -	hazptr_scan_period(addr, scan_wildcard);
>> -	WRITE_ONCE(hazptr_wildcard, scan_wildcard);	/* Flip the current wildcard. */
>> -	hazptr_scan_period(addr, flip_wildcard(scan_wildcard));
>> +	hazptr_scan_cpu_slots_period(addr, scan_wildcard);
>> +	WRITE_ONCE(hazptr_wildcard, scan_wildcard);			/* Flip the current wildcard. */
>> +	hazptr_scan_cpu_slots_period(addr, flip_wildcard(scan_wildcard));
>> +
>> +	/*
>> +	 * Scan overflow lists *after* scanning per-CPU slots. See
>> +	 * hazptr_promote_to_backup_slot() for scan ordering requirement.
>> +	 */
>> +	scan_list_phase = flip_list_phase(hazptr_overflow_list_phase);
>> +	hazptr_scan_overflow_list_period(addr, scan_list_phase);
>> +	WRITE_ONCE(hazptr_overflow_list_phase, scan_list_phase);	/* Flip the current list phase. */
>> +	hazptr_scan_overflow_list_period(addr, flip_list_phase(scan_list_phase));
>>   }
>>   EXPORT_SYMBOL_GPL(hazptr_synchronize);
>>   
>
>
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
