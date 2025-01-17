Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB33B9443;
	Fri, 17 Jan 2025 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127204; cv=none; b=Ot4fLY83jagPOfdPIhKFuOnJofrhb0aiRPjwffGfmTUh26GpYsAdTDzoNn0R0KMQu2gy9huL2SIK1FAmNfIk/Ixo/Kgbr2Ilw6BMWbDLAtkTcvevZFsG10dME0FbJUh6iyTlHW61r0D3sewq3zasoqHfubRWuXyFOqoOd/PWYq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127204; c=relaxed/simple;
	bh=RIKbx/tVMfmlGzmV3GPlcLDJf8dF9I1I73i8HM4kPEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tOKdTn819nw2lNPmDPq8/Nay1QMevmvps3KeIGOukRLbAj5xwIhaJCUslVH5XwE77G8T/b0grsFD8khKLYalm14fMNRdtBO4ZGTa/UdmnlQmSQUMGowC+JNxsjMq4eAlzB5o851/PAxTQGAhXcCt9IUsFmyV/EvTgui4Uh6WVks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=njTt0Lmr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6P6fPDXJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="njTt0Lmr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6P6fPDXJ"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737127200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y71FQ3ma4TZ18quMFWIJPZSfF92S2xZIwyBBJO20TJ8=;
	b=njTt0LmrTEH2itvJhSBBJoNRhbpnvf2l4jw4yFX1DeDJSQPDWid/dY6V8d1S/SAECGHM8v
	c735mfUpz1WeC4VdetL0MQGp+Dp5a5sMOYQuJdxCwG4RfBDk2CZgnKfIqBjJMrc8pRqhGg
	4/AB3tPWDwODkilGPZbJ3rKDic+4ccjDtskLVrzH+AD5lwGv3fn0GAf9Jll1HybOqPGWdB
	BXnnLD5tdbmZyz2R/m52VqJWEIZNSyHlF5o8zVCMLrm+UCSwKIaD9yXL1h0kWj2Q1/At0e
	NAxyFtaoXAO+CXE3ce1w7Bjsc9MzhSlfZ5AD2PjBJFStdtXuNpY1jn+pawjCJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737127200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y71FQ3ma4TZ18quMFWIJPZSfF92S2xZIwyBBJO20TJ8=;
	b=6P6fPDXJuRL/g4ywp5ofb2w50dhPxgFfYgaru0qPVgKnAl5rlxE07/Lug8xdxVKsbomMke
	s/kpi5ilJpcWB7Cg==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, vlad.wing@gmail.com,
 rcu@vger.kernel.org, boqun.feng@gmail.com, joel@joelfernandes.org,
 neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com,
 Cheng-Jui.Wang@mediatek.com, leitao@debian.org, kernel-team@meta.com,
 Usama Arif <usamaarif642@gmail.com>, paulmck@kernel.org, Anna-Maria
 Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 1/3 v3] hrtimers: Force migrate away hrtimers queued
 after CPUHP_AP_HRTIMERS_DYING
In-Reply-To: <Z4plCGNJddH-BDWE@localhost.localdomain>
References: <20241231170712.149394-1-frederic@kernel.org>
 <20241231170712.149394-2-frederic@kernel.org> <8734hjausb.ffs@tglx>
 <Z4plCGNJddH-BDWE@localhost.localdomain>
Date: Fri, 17 Jan 2025 16:20:00 +0100
Message-ID: <87ikqda2n3.ffs@tglx>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17 2025 at 15:11, Frederic Weisbecker wrote:
> Le Thu, Jan 16, 2025 at 11:59:48AM +0100, Thomas Gleixner a =C3=A9crit :
>> > +	if (enqueue_hrtimer(timer, new_base, mode))
>> > +		smp_call_function_single_async(cpu, &new_cpu_base->csd);
>>=20
>> Duh. This reimplementation of switch_hrtimer_base() is really aweful. We
>> can be smarter than that. Untested patch below.
>
> Indeed, and I tried to "fix" switch_hrtimer_base() but didn't managed to =
do
> it properly. Looks like you did :-)
>
> But I have a few comments:
>
>> @@ -208,6 +211,13 @@ struct hrtimer_cpu_base *get_target_base
>>  	if (static_branch_likely(&timers_migration_enabled) && !pinned)
>>  		return &per_cpu(hrtimer_bases, get_nohz_timer_target());
>>  #endif
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +	if (unlikely(!base->online)) {
>> +		int cpu =3D cpumask_any_and(cpu_online_mask, housekeeping_cpumask(HK_=
TYPE_TIMER));
>> +
>> +		return &per_cpu(hrtimer_bases, cpu);
>> +	}
>> +#endif
>
> This should be at the beginning of get_target_base(), otherwise the targe=
t may
> end up being the local one.

Indeed. As I said, it's untested.

>> -		if (new_cpu_base !=3D this_cpu_base &&
>> +		if (new_cpu_base !=3D this_cpu_base && this_cpu_base->online &&
>>  		    hrtimer_check_target(timer, new_base)) {
>>  			raw_spin_unlock(&new_base->cpu_base->lock);
>>  			raw_spin_lock(&base->cpu_base->lock);
>
> This forget the case where the elected remote target is the same as the o=
ld one,
> but its next event is after the timer. In that case this default to local=
, even
> if it is offline.

*blink*

> How about this? (untested yet)
> -static int
> -hrtimer_check_target(struct hrtimer *timer, struct hrtimer_clock_base *n=
ew_base)
> +static bool
> +hrtimer_suitable_target(struct hrtimer *timer,
> +			struct hrtimer_clock_base *new_base,
> +			struct hrtimer_cpu_base *new_cpu_base,
> +			struct hrtimer_cpu_base *this_cpu_base)
>  {
>  	ktime_t expires;
>=20=20
> +	/* The local CPU clockevent can be reprogrammed */
> +	if (new_cpu_base =3D=3D this_cpu_base)
> +		return true;

That needs a comment explaining that @new_cpu_base is guaranteed not to
be @this_cpu_base if @this_cpu_base->online =3D=3D false due to the magic in
get_target_base(). That's far from obvious.

I had to stare at it 5 times to convince myself that this is correct.

Other than that, this looks about right.

Thanks,

        tglx
