Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6BD3815CF
	for <rcu@vger.kernel.org>; Tue,  7 Jul 2026 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438590; cv=none; b=CxmQ+3rUziVAVWzqUkfBaptG4ETVml/SQnbLSfFkWKtqhMRWxJcO+jCNN5tC12U0qfGRbRRjwAbzKPIiBdYLAmNX8PnU/sT9tZYv6Jav72wPwMeblL9BH2hj3fsyC1lSGc81tfKIHZ/JlXSdJUuz/7pxKE2077/kFpK98m++mZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438590; c=relaxed/simple;
	bh=my95Fmcmesd2Y5ksKXg/vIpLCrJUuBr+NEnXGVkAhGU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RUctk1zczIQHII9kW7L9MNS0/rFOu53xnAfsDPscI+8RJ/qCHw7Ek68Ht5thjGkQygGgOkwAzTYSkmqrDO7s8BaWoqlvp5CwDJKTl9zuxTHMg3Do7g0Z0Dz2yCCeh5zN7P6+EzUYcB+ENmDvtOce2u8JQnlhiJy5zqh0W5chtAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcCl/TZb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcCl/TZb"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ca7aaa4b85so41336655ad.3
        for <rcu@vger.kernel.org>; Tue, 07 Jul 2026 08:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783438588; x=1784043388; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gAe/B0lmumdTAGULSnGeQVNe6lJ30++GdugJC4/lK/8=;
        b=bcCl/TZbSVhUvJ5jtze4oHVXIl5CH0QaZBX8Zg0XrYFK5Pn1hrAB4Wrt4WXAsxEgUR
         DyapMqoTcHYZbmdWd+AznW90ubWBAFa4KtzEYP8xA9jVSq3xKJmLPWdZ2Mbj+Lsn95f6
         u0E4mBo7tID0xZbg2EL5bdVvNNF1LN7qYSF3fBhJr3Zj1PBLmfle6tsOz1FfKGzGc78J
         nF+S44v76F2rTjrYqKSS71ze94A+RPcFAcmEL+JR8QO8GQdygml1EwtCLceieG7rB94K
         qI33m1vLjmRGmwwODkDMkkG/jVwblmjGXnstSlY/f+pa1rsL2sekqkjGuOb1XarAiV3Q
         51MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438588; x=1784043388;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gAe/B0lmumdTAGULSnGeQVNe6lJ30++GdugJC4/lK/8=;
        b=PmP3mQhtIDMzvHV0ttZOMi+FnsMbIRU2Dns1zZjir3LCUkSwi8GdxWl9SeNk9k0ZJc
         oRRWADZjBu2Prqk0BSKqkK/rrwKBOqlKkysIaKh9Q3ZW3rAYaegWqVRkf/9WmDlBTWpR
         Jjk4/s4Bricdnpy6h054zV/B1rXi8+YxNhmTWaA50pacM/McieQOaFW+y37h3Ne2/5H0
         tlmDMMnoNb8KbUqc97hBkwNKwx1NgTdKidDmODtEhJDMBgYGN/2nADszQMFuWCj6HFh5
         0EsQrtqEy4W7XpZtfoi49sIoIlsbkXsMnzyHkrLqzeJE4RsCX1Wa9RYBA1NEV2bxO71m
         58BA==
X-Forwarded-Encrypted: i=1; AHgh+RqpnSglFmh72+tX3EAUEkXUQwFuSUzab5rOdBp42R9Iaun9EcCFIGssuZxkANAjQYNkg2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvW+1rlye/JgXDqThAbNwHNQtpozAqXfDw+O7YIRTpcBd9Hdd6
	SAcSgKO6NWbjrYhVMbhtuIhvA7FbcV1yryz0fuwocxJhqslhu2QCIVU0
X-Gm-Gg: AfdE7cl0ayzb+UBlOG99mpWHAvCO13TmF8p3zRaLJwHZp2XYizCUGEDpBecA0LbtZio
	AXiz0MUxtaEB1lCLlxvrJjkqVZthsRLPjUG0WKcJ2zrq7Swg0fjBTGY+yDoHCbGp6ftDIrYVIWy
	Zk8YQ1ZDjvRnbGHIQ94y56RpIH/OXaoe7Oy6il9/+z6VXGlJZ6dqbM2LcH3GmncFvb67RDlrYe5
	OpGya/bbLnxn9m3C2WDabZS7TmH2GOdCNBBgqyLN7TBqfDI5YquT2NqdrpAEsDvQfnbOnAgh2fs
	d6Yblbm2HXDbs+DFoPy1m/JH3xASx36vONTYdMqVRbcKm6uIzZNCeA1NevRH006rer2KjJX1v4w
	QvODrOJCq3GTqQ52XqsGjuoThpXdDWmowGR5j/YzQYDa5jMbpXI2/aLFzMaUkQfcnBDwOSPiJfF
	7RhxuHmg==
X-Received: by 2002:a17:903:3550:b0:2c0:b6c7:227e with SMTP id d9443c01a7336-2ccbe3f2606mr55794045ad.5.1783438587925;
        Tue, 07 Jul 2026 08:36:27 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e1aesm14494315ad.39.2026.07.07.08.36.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2026 08:36:26 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] rcutorture: Use __set_current_state() set task state in
 rcu_nocb_toggle()
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <c826b59e-993f-4ff5-ac1a-6898bfaf05cc@paulmck-laptop>
Date: Tue, 7 Jul 2026 23:36:18 +0800
Cc: Zqiang <qiang.zhang@linux.dev>,
 frederic@kernel.org,
 neeraj.upadhyay@kernel.org,
 joelagnelf@nvidia.com,
 urezki@gmail.com,
 boqun@kernel.org,
 rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <80CDCF49-23F7-4CA5-80C4-9295DCE0D5EE@gmail.com>
References: <20260702101125.14100-1-qiang.zhang@linux.dev>
 <c826b59e-993f-4ff5-ac1a-6898bfaf05cc@paulmck-laptop>
To: paulmck@kernel.org
X-Mailer: Apple Mail (2.3864.600.51.1.1)

On Jul 7, 2026, at 02:48, Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> On Thu, Jul 02, 2026 at 06:11:25PM +0800, Zqiang wrote:
>> In the rcu_nocb_toggle(), the schedule_hrtimeout() is called after the
>> state assignment with no condition check. the release-acquire pair from
>> raw_spin_unlock/lock(&cpu_base->lock), guarantee that task->__state is
>> visible to the hrtimer callback:
>> 
>>              CPU0                                                     CPU1
>> __set_current_state(TASK_INTERRUPTIBLE)
>> ->WRITE_ONCE(task->__state, TASK_INTERRUPTIBLE)
>> schedule_hrtimeout
>> ->hrtimer_sleeper_start_expires()
>>  ->raw_spin_lock_irqsave(&cpu_base->lock)
>>    ....
>>  ->raw_spin_unlock_irqrestore(&cpu_base->lock)
>> 
>> hard-irq:
>> raw_spin_lock_irqsave(&cpu_base->lock)
>> __hrtimer_run_queues
>> ->__run_hrtimer
>>  ->raw_spin_unlock_irqrestore(&cpu_base->lock)
>>  ->fn(timer)
>>    ->hrtimer_wakeup
>>      ->wake_up_process
>> ->try_to_wake_up
>>  ->READ task->__state
>> 
>> This commit therefore use the __set_current_state() to replace the
>> set_current_state() in rcu_nocb_toggle().
>> 
>> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> 
> This looks correct, and either drops an smp_mb() or converts an
> xchg() to a WRITE_ONCE(), which does decrease overhead.  Except that
> rcu_nocb_toggle() is invoked very infrequently and has high overhead
> that I would expect to lose this overhead decrease in the noise.  And it
> forces those reading the code to go figure out what is different between

Agreed.  I did end up reading the code.

> set_current_state() and __set_current_state().
> 
> So I am not convinced to take this patch.  But am I missing something here?
> 
> Thanx, Paul
> 
>> ---
>> kernel/rcu/rcutorture.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>> index b1bab59efde5..a0e6901e0f90 100644
>> --- a/kernel/rcu/rcutorture.c
>> +++ b/kernel/rcu/rcutorture.c
>> @@ -2947,7 +2947,7 @@ static int rcu_nocb_toggle(void *arg)
>> atomic_long_inc(&n_nocb_deoffload);
>> }
>> toggle_delay = torture_random(&rand) % toggle_fuzz + toggle_interval;
>> - set_current_state(TASK_INTERRUPTIBLE);
>> + __set_current_state(TASK_INTERRUPTIBLE);
>> schedule_hrtimeout(&toggle_delay, HRTIMER_MODE_REL);
>> if (stutter_wait("rcu_nocb_toggle"))
>> sched_set_normal(current, oldnice);
>> -- 
>> 2.17.1
>> 
> 

