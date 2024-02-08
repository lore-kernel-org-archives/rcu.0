Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCEC67C60
	for <rcu@vger.kernel.org>; Thu,  8 Feb 2024 05:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707371707; cv=none; b=u2LCIfVbnLomUCDJy79RkzWumhjzVruyWFpCsWmj6LTYfVH3dNg0fjOxtKPaSwrKa8bPxk6OUkEouB/XvSDLohMUpLjaFwIv2VdOqkUSppp05ic9DF/bAjukRHrbIjDoijX2FffNlpKmKHCFzFXDRJ/kRhurdofYIPEy75Px8dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707371707; c=relaxed/simple;
	bh=k8+cGaqihN3OXuh+YvfNKe4/B+4W0v26vc+f+6/n82E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYz14b1ns5qI/w5tg+TLZyMKJ6nTl+U/93jnbYCTPI46dwI79+Rg6CnzzMGsAT9zunDz0JqBCw75tUlap/8ei8ZaRxvwdVen3FCY+YR1k2V9HxEdkwJ9TmPIJnd1Sgx6opxRxC5ozWIq3arMOtCicx3qVu5Q2FY/T9kyuBKcMlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=u4scTBHx; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="u4scTBHx"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68cc9061c78so1185896d6.3
        for <rcu@vger.kernel.org>; Wed, 07 Feb 2024 21:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1707371704; x=1707976504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eTihZ0R6gdUnoysEN7c3jPAGR9r9sB6p9caiGUkDR5E=;
        b=u4scTBHxSGCkpWWrsGfqENTllrQyP22SwpoTIcPNUSRkLWrKbTX0JnkXzpUCuolOYO
         T1m+Cdvl+JpiNyeY7Sih0iG/i4g2fpKe5FGSOfjo2r6YLLoPa7/rUwHQiGrQ6nbAGaVW
         rPf+9KBwuOkv7NLsfNuwf5PdX0kXDIIEuifdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707371704; x=1707976504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eTihZ0R6gdUnoysEN7c3jPAGR9r9sB6p9caiGUkDR5E=;
        b=tpRSR23ZznJQCzi/IJ0zn+W/yVlIg54x+DaHYwX0wc3eUNJGj5P+/j4KjJ6HvnYotu
         9obpCcei2bScRV0QFaTjIaa4ArqKQvWBmQ9dnLVCUNTDdxpF0Ti/RSY/G3zPHUxFS8va
         jfFplW8vjNaDg7TUBOox3SiblaAIFfzYsf2VJEiAAiYS6v1hb9JIuUzrINbKGse92tMu
         B8TJZ5JnZQd7qRJQOg+FgJ3DHC4BH5pHmJVVYE+eayR+0V/8iePxeiNg71cCvas6DAQX
         l2PtJFtWW23WNi+zY6i4nfTwVks30rR/B2JxToydNBNd/TRsL6yRRAPREd1kPSnf86TM
         Dm8g==
X-Forwarded-Encrypted: i=1; AJvYcCWun+Fw5ma9fEso84b24NcdW2krfnrjSmrxd5L+HS3azs1Ii5DIkQAFsw7D9AmipgpHrNkcGR9mmGJrYZ+TvjS/1bty
X-Gm-Message-State: AOJu0YyzwwISCrTKQiXb4OYjrsJk32W4pFtzHaxcb+WXxEYWxhkmYxyb
	OEU+NkxZYCK1q1M+bLcs+Vm7FKHExCDRs5gM052Y4AfhwZYXAmxuePdFCAyFtAQ=
X-Google-Smtp-Source: AGHT+IEA6tDI5ibUivwfUjZa/hhdXn8rVOgGrVD2alIHLdrmgVDMdaq18dlSZDh9aM+MhPVQwlaV+Q==
X-Received: by 2002:a05:6214:1bcf:b0:68c:8742:5929 with SMTP id m15-20020a0562141bcf00b0068c87425929mr9803295qvc.6.1707371703923;
        Wed, 07 Feb 2024 21:55:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWap98/KkUis6FltvulEudvIOP7tKEaw+v4rBkfWC0p/oafHILDM/J3fDzx72w0MYnzTG3YOgbpPmvU7JqL5WrfpjZzVSdizN93Cq8bHHQ6i9DelvfliXWdK6xKqv7Ulh35Pw4Rb4Ej7sSvwvecxhb1QU/fWu6JE9nSano
Received: from [192.168.0.226] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id mg10-20020a056214560a00b00681785c95e0sm1299010qvb.46.2024.02.07.21.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 21:55:03 -0800 (PST)
Message-ID: <1fcf7e8a-c245-4c5c-ac86-7f0a1531032d@joelfernandes.org>
Date: Thu, 8 Feb 2024 00:54:58 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Observation on NOHZ_FULL
To: Andrea Righi <andrea.righi@canonical.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Joel Fernandes <joelaf@google.com>,
 rcu@vger.kernel.org, "Cc: Frederic Weisbecker" <fweisbec@gmail.com>
References: <0e15e91e-da47-45dd-b7de-7f89b7b6002b@joelfernandes.org>
 <ZbieCjYk8cIgZS8L@gpd> <cf1c60fc-6295-402e-b546-6f67cf0955b2@paulmck-laptop>
 <ZbjYSXhIrVyCpRNM@pc636> <ZbjdL04k2Z2ZdUyp@gpd>
 <b8d80604-18a5-4f82-b846-5c00c6aeae6f@paulmck-laptop> <ZcJxhoNpkTM7LnOr@gpd>
 <9f9b6885-6d9d-4f30-9635-49443e1615e9@joelfernandes.org>
 <ZcOwRsEhbQhGv9X2@gpd>
 <CAEXW_YQN=Dm4TXv+F=Q4bfnKWn1Tv52=8hz50JLkbufcM5hUpQ@mail.gmail.com>
 <ZcO4c6nxemyxRFz3@gpd>
Content-Language: en-US
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <ZcO4c6nxemyxRFz3@gpd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/7/2024 12:05 PM, Andrea Righi wrote:
> On Wed, Feb 07, 2024 at 11:52:35AM -0500, Joel Fernandes wrote:
>> On Wed, Feb 7, 2024 at 11:31 AM Andrea Righi <andrea.righi@canonical.com> wrote:
>>
>>>> The actual number of callbacks should not be causing specifically the
>>>> hrtimer_interrupt() to take too long to run, AFAICS. But RCU's lazy feature does
>>>> increase the number of timer interrupts.
>>>>
>>>> Further still, it depends on how much hrtimer_interrupt() takes with lazy RCU to
>>>> call it a problem IMO. Some numbers with units will be nice.
>>>
>>> This is what I see (this is a single run, but the other runs are
>>> similar), unit is nanosec, with lazy RCU enabled hrtimer_interrupt()
>>> takes around 4K-16K ns, with lazy RCU off most of the times it takes
>>> 2K-4K ns:
>>>
>>>  - lazy rcu off:
>>>
>>> [1K, 2K)         88307 |@@@@@@@@@@@@                                            |
>>> [2K, 4K)        380695 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    |
>>> [4K, 8K)           194 |                                                        |
>>>
>>>  - lazy rcu on:
>>>
>>> [2K, 4K)          3094 |                                                          |
>>> [4K, 8K)        265763 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>>> [8K, 16K)       182341 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                       |
>>> [16K, 32K)        3422 |                                                          |
>>>
>>> Again, I'm not sure if this is really a problem or not, or if it is even
>>> a relevant metric for the overall performance, I was just curious to
>>> understand why it is different.
>>
>> This is an interesting find, the number of timer interrupt executions
>> looks roughly the same in this histogram so it might not be missed
>> cancellations or such, so it is not clear to me. But it is worth
>> debugging and we'll try to reproduce your results.
>>
>> Some more theories from our internal RCU discussion:
>> - Could it be another user of RCU (call_rcu) from an unrelated hrtimer
>> interrupt callback that is causing a "flush" of lazy callbacks?
>> - What does the distribution look like for
>> do_nocb_deferred_wakeup_timer ? That will have to probably be made
>> non-static to be picked up by bpftrace (If you could try that real
>> quick, appreciate!).
> 
> Sure, I'll repeat the test tracing do_nocb_deferred_wakeup_timer.

Thanks, that'll be great.

>> Slightly related, but one of the things we are wondering also is how
>> much of the overhead for your nohz-full and lazy-RCU test (on top of
>> baseline - that is just CONFIG_HZ=1000 without nohz-full or nocbs) is
>> because of just using NOCB. Uladsizlau mentioned he might run a test
>> for comparing along those lines as well.
> 
> Just to clarify, "lazy rcu on" results are just with rcu_nocb=all and
> lazy RCUs enabled (and HZ=1000), so without nohz_full.
> 
> If I enable only nohz_full=all (without rcu_nocb) I see something like
> this:

Ok. I did want to mention nohz_full implies rcu_nocb on the same CPUs as well.

Its also mentioned in the boot param docs on the last line of the description:

        nohz_full=      [KNL,BOOT,SMP,ISOL]
                        The argument is a cpu list, as described above.
                        In kernels built with CONFIG_NO_HZ_FULL=y, set
                        the specified list of CPUs whose tick will be stopped
                        whenever possible. The boot CPU will be forced outside
                        the range to maintain the timekeeping.  Any CPUs
                        in this list will have their RCU callbacks offloaded,
                        just as if they had also been called out in the
                        rcu_nocbs= boot parameter.

(btw, I am a bit slow to respond to email due to being ill).

thanks,

 - Joel
