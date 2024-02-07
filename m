Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD95C7F46D
	for <rcu@vger.kernel.org>; Wed,  7 Feb 2024 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320896; cv=none; b=Xhuv9Idb+fIad5rwvqfOAzD/6TjvhqKDU5kJPViSJnd2x1Q/WmsjNB/W2RSsJ+X0pPA7tkdq0xjp/Cei7l2uTYu59+BCPN26ZrYCXpSrKE0WR7wC2D4NIoC5VHTyRCKWDChFnDi3EQgzCMzqvTkULNY/mC/gfgzV4CrBqnd+q2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320896; c=relaxed/simple;
	bh=uUtbqRDQkz7unFxIjJvzxHnEbsbF+GUwWq1Ocik1Rsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5t1Qn578tFIXqE4/0mKTT0C7eL8INJJUsK3Sor4+5PStexAt6HFis9MJBAYFKpIB1HOvvmtIFUVk4qj8oVcugRtmR94AsfAxoCdGDXNCHDSHsvUnYMcR54h2o1BxCSR3V/r1ZxK2qpghiERf8vA4jgzzFM6IakgUHH+kkA4FMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=bvJs7viY; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bvJs7viY"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc7319a07a2so857256276.2
        for <rcu@vger.kernel.org>; Wed, 07 Feb 2024 07:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1707320893; x=1707925693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qf2xuVM2oWFjAcPfq8bHEbSuqYu+wH7+JnmgM4G2pkg=;
        b=bvJs7viYnUccIiqNZ7UalqpJ3CNseIPeFE624yxkZTWFFQOO+42rEubJ0DwPLZ3x/A
         GiqJHYfTrKcVo34yZj4B5SbebwvaEqaNCwC+4DoSxGVMrGyJRKpLN3n8+tUB6et0cLp0
         lSr6Ssc9Fb6K3FXKVYEzGU/lIAhd9z3yr4mxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707320893; x=1707925693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qf2xuVM2oWFjAcPfq8bHEbSuqYu+wH7+JnmgM4G2pkg=;
        b=hr1z0MRQtEjPavjcLCAmxs5UNBXI19L3IlhRKNhhTnjjNsyi9c1Ay1exrJ9sHLLdW+
         oVOfOkLZDyoRU7mZRC7mmOhKJA2Olhyu19b+6H/c+P/nVe8qwaV5TyhsVtdZqDKVNvyf
         0U2sbaSYv2bVFGhKd4oeRS5TVx9+I7KCsJg3R4DL5E4HP407BjElZhw+KYJHtzaza/dz
         XsrcR5/GqtwfqpFDb94WdstANg+nnTeV2dXfwhd9lCLTGX3on8Ryyrn315+u+putOSZk
         xrPaZRsXinStVh/5rHPfflj7Xu2gYnUcI/hkSRI22vFOfCCwZWtdhllBE//ADBG3SjF7
         CuwQ==
X-Gm-Message-State: AOJu0YzI1tdeag3FXta5/Xn3tSZLnvmif6H4p5QPqADLcUPXH8n4cysu
	DiRMdOJDngaX/ZBMtQpv7TiFVcoRKZnlOeSHeYoY2LuPmmUhGiVEhWuFu+N3ZLlptJYxlkRIUsh
	R
X-Google-Smtp-Source: AGHT+IHdrWsHyAnfyhil4C1zE9O0ZiJulOOMjamytRU8HdfFjKvtNXYmAxRbtu6HcbqOg5V81CujPA==
X-Received: by 2002:a25:81c3:0:b0:dc2:4397:6ad3 with SMTP id n3-20020a2581c3000000b00dc243976ad3mr4948187ybm.44.1707320893563;
        Wed, 07 Feb 2024 07:48:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULWKCaDBTsconwMNj/Z70CLcBJAM75f6mlcA9ChzbB6pNUYLtoAqPWTwkNlDI9jEs9JvPgGxxU72gYjrvKDrBfGhlq9bYvnFi8SgVxVUnQJQYJ4sPMqw07HRjmyHVG+C2m17owCSHTrwamgEjDvrQ/XmyyJEC1F08e+4ex+DA=
Received: from [192.168.0.226] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id df9-20020a056214080900b0068c964c3c4fsm686583qvb.127.2024.02.07.07.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 07:48:12 -0800 (PST)
Message-ID: <9f9b6885-6d9d-4f30-9635-49443e1615e9@joelfernandes.org>
Date: Wed, 7 Feb 2024 10:48:10 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Observation on NOHZ_FULL
Content-Language: en-US
To: Andrea Righi <andrea.righi@canonical.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Joel Fernandes <joelaf@google.com>,
 rcu@vger.kernel.org, "Cc: Frederic Weisbecker" <fweisbec@gmail.com>
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
 <6a2b6857-57e7-4321-adae-132ba69a4fff@paulmck-laptop>
 <0e15e91e-da47-45dd-b7de-7f89b7b6002b@joelfernandes.org>
 <ZbieCjYk8cIgZS8L@gpd> <cf1c60fc-6295-402e-b546-6f67cf0955b2@paulmck-laptop>
 <ZbjYSXhIrVyCpRNM@pc636> <ZbjdL04k2Z2ZdUyp@gpd>
 <b8d80604-18a5-4f82-b846-5c00c6aeae6f@paulmck-laptop> <ZcJxhoNpkTM7LnOr@gpd>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <ZcJxhoNpkTM7LnOr@gpd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/2024 12:51 PM, Andrea Righi wrote:
>  - stress-ng --matrix seems quite unpredictable to be used a benchmarks
>    in this scenario (the bogo-ops/s are very susceptible to any kind of
>    interference, so even if in the long runs NO_HZ_FULL still seems to
>    provide some benefits looking at the average, we also need to
>    consider that there might be a significant error in the measurements,
>    standard deviation was pretty high)
> 

Ack on the bogo-ops disclaimers as also mentioned in the stress-ng docs. Agreed
a better metric for perf is helpful.

I am assuming you also have RCU_NOCB enabled for this test?

>  - fio doing short writes (in page cache) seems to perform like 2x
>    better in terms of iops with nohz_full, respect to the other cases
>    and it performs 2x slower with large IO writes (not sure why... need
>    to investigate more)

This is interesting, it could be worth counting how many kernel entries/exits
occur for large IO vs small IO. I'd imagine for large IO we have fewer syscalls
and hence lower entry/exit overhead. But if there more interrupts for whatever
reason with large IO, then that also implies more kernel entries/exits. As
Frederic was saying, NOHZ_FULL has higher overhead on kernel entry/exit.

> 
>  - with lazy RCU enabled hrtimer_interrupt() takes like 2x more to
>    return, respect to the other cases (is this expected?)

It depends on which hrtimer_interrupt() instance? There must be several in the
trace due to unrelated timers. Are you saying the worst case or it is always 2x
more? We do queue a timer for Lazy RCU to flush the RCU work but it is set to 10
seconds and should be canceled most of the time (Its just a guard rail). It is
possible there is lock contention on ->nocb_gp_lock which is causing the timer
handler execution to be slow. We have several trace_rcu_nocb* trace points,
including for the timer. Perhaps you could enable those and we dig deeper?

Further, it is interesting to see if it is only the hrtimer_interrupt() instance
that also results in a call to do_nocb_deferred_wakeup_timer() via say function
tracing. That will confirm that it is the lazy timer that is slow for you.

The actual number of callbacks should not be causing specifically the
hrtimer_interrupt() to take too long to run, AFAICS. But RCU's lazy feature does
increase the number of timer interrupts.

Further still, it depends on how much hrtimer_interrupt() takes with lazy RCU to
call it a problem IMO. Some numbers with units will be nice.

thanks,

 - Joel
