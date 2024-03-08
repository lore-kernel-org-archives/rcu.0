Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B08210D
	for <rcu@vger.kernel.org>; Fri,  8 Mar 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909868; cv=none; b=n3GSfI2PHZVHJ4bV5wBo2so9h3v8K5eYrq4duIfDD0XH1Se8mKBHEC41yx0aSnCKbwVnSPLLf8z4IYU0KB5Fet90y5rkbCIDdjRqGZUDhYhyoWgCAeKKbphaniturfyjmN34u2rygE2wBxGSE75VJfzfd6+7ZiJ04E9/HRk9NoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909868; c=relaxed/simple;
	bh=nOGmeeP+S2YSHfBnNQyo6hO5u9KbbN1gVrn38SWkjnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbSb0NNrcaqSfQi2MU0eRILWM8uskgeOqwGYt0/3j5FdGo+D2emCcYGCOSCfDGrAob8r2pF+narPhzVMi+g6Y//IyKBipnlGAuKGNDD9o8oPc05vBuExhqoq60l6DCMBh03gKI+KHsDk4Se5W+VjW6YkiSxnoG8fMIxW43/uA/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=N4RJhAQR; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="N4RJhAQR"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68f9c01a148so8475976d6.3
        for <rcu@vger.kernel.org>; Fri, 08 Mar 2024 06:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709909865; x=1710514665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zHs25ksJpqEeOp1pNTzGqltTuGv83hVjOZuwqlpctzQ=;
        b=N4RJhAQRNYjprM5Oc/LTMkhucHpItkaaL3kdHBw/ASALJjUMcpIP8S1YjCfTV3jj2f
         FXfe5D6VRNEgt2MyVANgmZn0WGN/7qdUNme9KAnUixDA8hKDd5An7/dz1ksJCkP5kJDi
         Y/f4akqndp09xzE8xC5GWUc33S5m+BEPeR7Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709909865; x=1710514665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zHs25ksJpqEeOp1pNTzGqltTuGv83hVjOZuwqlpctzQ=;
        b=lfd+7BJDDbxSMdZ7o+ZeFa+G2ZVTXJI5H49GQ2LWwzJa2PI/Bt4BAP3hAEjIe/uoTu
         dZjKQFCIm1+ty3DKLuyu/G+FTBs5YsamBsbjHUfRilzPl9iqoh9eBOs6bGBbgpcSq57p
         t0tuwXh5T1GmW8aCZreCnpqJSfKkl42qy31yYOfNU2r8mEqrimkkQTRg2g1UfMBKA2eS
         Mq+CpPbAtZGxL8COrbXM5btBRVlHX9IBvn/S16hR5IEGqcVLZ8s9M3LCKdtGwz7V/3GR
         JMHQgnixUvZSFb8sfHLG3DyYe5jgWWNgUn2FSghqnBh2gOluTX7k/GKwsBLKRzXvNofE
         3ouA==
X-Forwarded-Encrypted: i=1; AJvYcCWrDHIGXf+mxoLRCzgmIcKCP9mNXBFyUbLlRapej99dwDNyntNswEl0Jpnl/7NJmooncfQEbjya/fX+HkytVEWNnSpq
X-Gm-Message-State: AOJu0YzM/+JyzL5aiEeDfmZKPCuWUBVWr+RJTri43V7kJGomN7WrfrE1
	zituVH0WkKa3gn9pkSjHRKHVMEZDAQtp5cIReIEXfxZotehIxoj3k3dshwEeEBo=
X-Google-Smtp-Source: AGHT+IFgMYXjfmNrjnOEWaK0ByL3HTUskDb8AyXDaoxRYm0ZxLkEmiG2mFQnS6LbDZxo9RDmgpMRMQ==
X-Received: by 2002:a05:6214:a63:b0:690:7dc5:a9bc with SMTP id ef3-20020a0562140a6300b006907dc5a9bcmr12454963qvb.29.1709909865438;
        Fri, 08 Mar 2024 06:57:45 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.182])
        by smtp.gmail.com with ESMTPSA id ld8-20020a056214418800b0068fef1264f6sm9765794qvb.101.2024.03.08.06.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 06:57:44 -0800 (PST)
Message-ID: <bce79497-52c5-4241-aaf6-2a95dc459041@joelfernandes.org>
Date: Fri, 8 Mar 2024 09:57:42 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: smp: Avoid false positive CPU hotplug Lockdep-RCU
 splat
To: Stefan Wiehler <stefan.wiehler@nokia.com>,
 Russell King <linux@armlinux.org.uk>, "Paul E. McKenney"
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
Content-Language: en-US
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/2024 11:09 AM, Stefan Wiehler wrote:
> With CONFIG_PROVE_RCU_LIST=y and by executing
> 
>   $ echo 0 > /sys/devices/system/cpu/cpu1/online
> 
> one can trigger the following Lockdep-RCU splat on ARM:
> 
>   =============================
>   WARNING: suspicious RCU usage
>   6.8.0-rc7-00001-g0db1d0ed8958 #10 Not tainted
>   -----------------------------
>   kernel/locking/lockdep.c:3762 RCU-list traversed in non-reader section!!
> 
>   other info that might help us debug this:
> 
>   RCU used illegally from offline CPU!
>   rcu_scheduler_active = 2, debug_locks = 1
>   no locks held by swapper/1/0.
> 
>   stack backtrace:
>   CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.0-rc7-00001-g0db1d0ed8958 #10
>   Hardware name: Allwinner sun8i Family
>    unwind_backtrace from show_stack+0x10/0x14
>    show_stack from dump_stack_lvl+0x60/0x90
>    dump_stack_lvl from lockdep_rcu_suspicious+0x150/0x1a0
>    lockdep_rcu_suspicious from __lock_acquire+0x11fc/0x29f8
>    __lock_acquire from lock_acquire+0x10c/0x348
>    lock_acquire from _raw_spin_lock_irqsave+0x50/0x6c
>    _raw_spin_lock_irqsave from check_and_switch_context+0x7c/0x4a8
>    check_and_switch_context from arch_cpu_idle_dead+0x10/0x7c
>    arch_cpu_idle_dead from do_idle+0xbc/0x138
>    do_idle from cpu_startup_entry+0x28/0x2c
>    cpu_startup_entry from secondary_start_kernel+0x11c/0x124
>    secondary_start_kernel from 0x401018a0
> 
> The CPU is already reported as offline from RCU perspective in
> cpuhp_report_idle_dead() before arch_cpu_idle_dead() is invoked. Above
> RCU-Lockdep splat is then triggered by check_and_switch_context() acquiring the
> ASID spinlock.
> 
> Avoid the false-positive Lockdep-RCU splat by briefly reporting the CPU as
> online again while the spinlock is held.
> 
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
>  arch/arm/kernel/smp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 3431c0553f45..6875e2c5dd50 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -319,7 +319,14 @@ void __noreturn arch_cpu_idle_dead(void)
>  {
>  	unsigned int cpu = smp_processor_id();
>  
> +	/*
> +	 * Briefly report CPU as online again to avoid false positive
> +	 * Lockdep-RCU splat when check_and_switch_context() acquires ASID
> +	 * spinlock.
> +	 */
> +	rcutree_report_cpu_starting(cpu);
>  	idle_task_exit();
> +	rcutree_report_cpu_dead();

I agree with the problem but disagree with the patch because it feels like a
terrible workaround.

Can we just use arch_spin_lock() for the cpu_asid_lock? This might require
acquiring the raw_lock within the raw_spinlock_t, but there is precedent:

arch/powerpc/kvm/book3s_hv_rm_mmu.c:245:
arch_spin_lock(&kvm->mmu_lock.rlock.raw_lock);

IMO, lockdep tracking of this lock is not necessary or possible considering the
hotplug situation.

Or is there a reason you need lockdep working for the cpu_asid_lock?

thanks,

 - Joel
