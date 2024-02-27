Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4949914C5A4
	for <rcu@vger.kernel.org>; Tue, 27 Feb 2024 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067071; cv=none; b=oeGARt4kfm+smqQ2Wli8renS97/LLI5AUgOOCmUVDSATJCAXghPxy8+Zi0zC1faI2lYinr7qTi/9bpckR/S0z9TzE4dugPkngdoXz0Omd39X9EqCTaHYa18jjUUUzlImsF/EZg5lQOdptXSLiNYXlvu+HtjwGFHniC320vDYCb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067071; c=relaxed/simple;
	bh=m9zPIVoeSliTSn5i4XqY7s/r3APGu/It7dLiXnj96I0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPGePacVM5U3Z9YBp7P10CUs8hFBU9vQsX+vTEhnR1AbUZ1bgUHtTSbMei6Mp5t1meujIhYFGNKD3/n2ypX+XWcaNKxASESpkPkgECAj69eRqbqvq0s/pzZ9wT/3shZyqhDuIL4AzyiDAmZA9HTN5kBk6bRuJ0ZCthDNSV/eqs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=FLvZ8k9x; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FLvZ8k9x"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-787c97deabdso201282085a.3
        for <rcu@vger.kernel.org>; Tue, 27 Feb 2024 12:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709067067; x=1709671867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rU+fdkQu8MLsIRmKzyIneZurqUYjFb/EkRlH23Z1vzU=;
        b=FLvZ8k9xrhTOLp3BmcOynaksbA7d48UosGoE3+mIlg5luySWyyZRPCBOst7LVfW9im
         vhPClJyh8j0XSHz/sNuTnkYchRqRfKNBsokWmCjN7qt2IGErOBuzU8omLbuCJyxYbWZz
         zpegT1dD9QoJd8li5hjmwZCX7QG6jy+kZ1F48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709067067; x=1709671867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rU+fdkQu8MLsIRmKzyIneZurqUYjFb/EkRlH23Z1vzU=;
        b=TossE3KLK432VCBliN5LyXhlFcgUmJ1ySqdhYQJ6IBAzAG+a0IAWGn+mGHgwA2KwUD
         gvSnpJwQZmaEJ3hngDz+PEV2zhoIWAHjCbsvA47MGv6nY/Q3Hom3gUeWCT8WFHRnJ8ge
         2XRFmssRGkNePyfC5NjHj762jBKwQM/9DC4sXNZ42zG8GoOX2ztZ4/MRJGOiYMnJfpgU
         57dcEmxZ26vZuz6NNpMkaUrp2g/f5X4LZ7VRi4pao2SqxQgqCECj1LGCJPzjhiIiNXYL
         pmvyj4IlqVhieq2kNywQzvyPXf8jhX8a3B7ayYiFAM0Xlvozmlu806JoUaLG2IZnv/U1
         Owaw==
X-Gm-Message-State: AOJu0Yz/EltL9UYmSON5u20hB8H68oiA3c7l4tSmP2CmEqxvJGbp908z
	CvBmvlRBk5MktaOFuzgtZ8evLBitMwpFyaz86x+iTU+6unzlBUvfBJnpxo+0naE=
X-Google-Smtp-Source: AGHT+IGguRJShGKlv84Y9Pq/nQnkl94Ofc+6YVurith8AVrXX8xnEY6ch+DYg6xc7AmrNiFo2V29zQ==
X-Received: by 2002:ae9:e71a:0:b0:787:268e:c054 with SMTP id m26-20020ae9e71a000000b00787268ec054mr3117960qka.63.1709067067160;
        Tue, 27 Feb 2024 12:51:07 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.76])
        by smtp.gmail.com with ESMTPSA id c20-20020a37e114000000b007872affb7d9sm3935457qkm.45.2024.02.27.12.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 12:51:06 -0800 (PST)
Message-ID: <c8182a5a-e804-4fcc-a6a5-bb121260e6a6@joelfernandes.org>
Date: Tue, 27 Feb 2024 15:51:03 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
 Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20240220183115.74124-1-urezki@gmail.com>
 <20240220183115.74124-3-urezki@gmail.com>
Content-Language: en-US
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20240220183115.74124-3-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/20/2024 1:31 PM, Uladzislau Rezki (Sony) wrote:
> A call to a synchronize_rcu() can be optimized from a latency
> point of view. Workloads which depend on this can benefit of it.
> 
> The delay of wakeme_after_rcu() callback, which unblocks a waiter,
> depends on several factors:
> 
> - how fast a process of offloading is started. Combination of:
>     - !CONFIG_RCU_NOCB_CPU/CONFIG_RCU_NOCB_CPU;
>     - !CONFIG_RCU_LAZY/CONFIG_RCU_LAZY;
>     - other.
> - when started, invoking path is interrupted due to:
>     - time limit;
>     - need_resched();
>     - if limit is reached.
> - where in a nocb list it is located;
> - how fast previous callbacks completed;
> 
> Example:
> 
> 1. On our embedded devices i can easily trigger the scenario when
> it is a last in the list out of ~3600 callbacks:
> 
> <snip>
>   <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt CBs=3613 bl=28
> ...
>   <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preempt rhp=00000000b2d6dee8 func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preempt rhp=00000000a446f607 func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preempt rhp=00000000a5cab03b func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preempt rhp=0000000013b7e5ee func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preempt rhp=000000000a8ca6f9 func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preempt rhp=000000008f162ca8 func=wakeme_after_rcu.cfi_jt
>   <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs-invoked=3612 idle=....
> <snip>
> 
> 2. We use cpuset/cgroup to classify tasks and assign them into
> different cgroups. For example "backgrond" group which binds tasks
> only to little CPUs or "foreground" which makes use of all CPUs.
> Tasks can be migrated between groups by a request if an acceleration
> is needed.
> 
> See below an example how "surfaceflinger" task gets migrated.
> Initially it is located in the "system-background" cgroup which
> allows to run only on little cores. In order to speed it up it
> can be temporary moved into "foreground" cgroup which allows
> to use big/all CPUs:
> 
> cgroup_attach_task():
>  -> cgroup_migrate_execute()
>    -> cpuset_can_attach()
>      -> percpu_down_write()
>        -> rcu_sync_enter()
>          -> synchronize_rcu()

We should do this patch but I wonder also if cgroup_attach_task() usage of
synchronize_rcu() should actually be using the _expedited() variant (via some
possible flag to the percpu rwsem / rcu_sync).

If the user assumes it a slow path, then usage of _expedited() should probably
be OK. If it is assumed a fast path, then it is probably hurting latency anyway
without the enablement of this patch's rcu_normal_wake_from_gp.

Thoughts?

Then it becomes a matter of how to plumb the expeditedness down the stack.

Also, speaking of percpu rwsem, I noticed that percpu refcounts don't use
rcu_sync. I haven't looked closely why, but something I hope to get time to look
into is if it can be converted over and what benefits would that entail if any.

Also will continue reviewing the patch. Thanks.

 - Joel
