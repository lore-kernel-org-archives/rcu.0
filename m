Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8AE15956B
	for <rcu@vger.kernel.org>; Mon, 29 Jan 2024 22:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566605; cv=none; b=dklXalsDTtn5NyklRpMasAluTR01wkV+mecAofrYqgNZV82xVzmMXxgd9siTa6L7WttQc7wnCxLBDgB5J/ES/35PJD8SsuiGIjSTYJq+Rs+PWas1acT45rbCyLqwNdc43DuThLYG2Sr9pFTWjqaIkdWmY/qnWDTLFbPQKjHtjjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566605; c=relaxed/simple;
	bh=/rpRGe5uAtWD5Yqxfiq2/227p7gFVYAgN+jbOl+myXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7qk9YAtRndPkPkorgAHxByassgehyysaprLs/F9SMgKS+RHzyol3GQLVwp2/vUnDYSdUEHoWgbaDxQplvhN5RbXaQ/rHGekdeEJ6CXMY2XdyN2F8RppyAPfIgmoJ9esnkrjd5skaQWzdHAqRL/vjvuLYLA/kh27a30owR3PxKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=KXlQZPMt; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KXlQZPMt"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-783f27300b1so169162485a.1
        for <rcu@vger.kernel.org>; Mon, 29 Jan 2024 14:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1706566603; x=1707171403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZFT6XLd8FTGvS7HazmUMwsJRY1TMUKSaocssRKnZCo=;
        b=KXlQZPMtsCpxKW0I2PNxXQGnZX7fNxLyAMrejey9iSLc6ui8FZnP11S9YIY66O7Ip+
         VdBXJ6QZNlUQFM2RsRyLawC0d0wv0fLhQAQcTxfBerlgzUu8hB4zx98ZLhQz6hduGWIK
         fbf/fleze69YdZqykqsRt4CI0zuwf6JYXrTeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706566603; x=1707171403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZFT6XLd8FTGvS7HazmUMwsJRY1TMUKSaocssRKnZCo=;
        b=ThALAGE8Cff0TegMoEV2z6YWI2Mi/pDxiYs+Bc6mw8Dt2MYFnv3gPrznfS7A1E3x1B
         Wr88Zr+cgGicHD1etUi1k4joov7Iz+2IPbIW3rNGKKsAF4pZIrO6PIOK34li2qZk4qta
         7CtXnZ0ISC01AcRnhICKebLRRsSVS2RgEM9xM3rG+eKcC+LCyYuLtkFrgkWmDpC8WMgX
         Cb8m2zUV7ZTp2bDtP51U+/05C/curM4n3nh/b2j0q1ggHvmHwajPIkxG1/tW5zRyzqus
         ibGdprBvMhBYG0cisWBcc4dBB2dk/V3os3NgVwVAxFYJFu6nK8KEIU17b7wjI06XM3Ct
         5bsg==
X-Gm-Message-State: AOJu0YxnugabF2maBZBjpHW2EX8XjMeKhYe+vcGVvpvTKEfd7ifktzjv
	9d6tCFL2U2vOLxuuvWxXbSswiT7JdIctdmUkeaMcVdsWq81+9ydo9mHrwLXW5MY=
X-Google-Smtp-Source: AGHT+IHlgaAfYcPt0KvYlCVTKPwHTs8AxD7kx1KveerSmqMCzOD2khP2/YKQJcu8cbQWCbI1810Jrw==
X-Received: by 2002:a05:6214:5299:b0:68c:5b0b:5ec with SMTP id kj25-20020a056214529900b0068c5b0b05ecmr1387075qvb.38.1706566602796;
        Mon, 29 Jan 2024 14:16:42 -0800 (PST)
Received: from [10.5.0.2] ([45.88.220.198])
        by smtp.gmail.com with ESMTPSA id di3-20020ad458e3000000b0068c4f1da09csm1380534qvb.120.2024.01.29.14.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 14:16:42 -0800 (PST)
Message-ID: <0e15e91e-da47-45dd-b7de-7f89b7b6002b@joelfernandes.org>
Date: Mon, 29 Jan 2024 17:16:38 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Observation on NOHZ_FULL
Content-Language: en-US
To: paulmck@kernel.org, Joel Fernandes <joelaf@google.com>,
 andrea.righi@canonical.com
Cc: rcu@vger.kernel.org, "Cc: Frederic Weisbecker" <fweisbec@gmail.com>
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
 <6a2b6857-57e7-4321-adae-132ba69a4fff@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <6a2b6857-57e7-4321-adae-132ba69a4fff@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paul,

On 1/29/2024 3:41 PM, Paul E. McKenney wrote:
> On Mon, Jan 29, 2024 at 05:47:39PM +0000, Joel Fernandes wrote:
>> Hi Guys,
>> Something caught my eye in [1] which a colleague pointed me to
>>  - CONFIG_HZ=1000 : 14866.05 bogo ops/s
>>  - CONFIG_HZ=1000+nohz_full : 18505.52 bogo ops/s
>>
>> The test in concern is:
>> stress-ng --matrix $(getconf _NPROCESSORS_ONLN) --timeout 5m --metrics-brief
>>
>> which is a CPU intensive test.
>>
>> Any thoughts on what else can attribute a 30% performance increase
>> versus non-nohz_full ? (Confession: No idea if the baseline is
>> nohz_idle or no nohz at all). If it is 30%, I may want to evaluate
>> nohz_full on some of our limited-CPU devices :)
> 
> The usual questions.  ;-)
> 
> Is this repeatable?  Is it under the same conditions of temperature,
> load, and so on?  Was it running on bare metal or on a guest OS?  If on a
> guest OS, what was the load from other guest OSes on the same hypervisor
> or on the hypervisor itself?
> 
> The bug report ad "CONFIG_HZ=250 : 17415.60 bogo ops/s", which makes
> me wonder if someone enabled some heavy debug that is greatly
> increasing the overhead of the scheduling-clock interrupt.
> 
> Now, if that was the case, I would expect the 250HZ number to have
> three-quarters of the improvement of the nohz_full number compared
> to the 1000HZ number:
>> 17415.60-14866.05=2549.55
> 18505.52-14866.05=3639.47
> 
> 2549.55/3639.47=0.70

I wonder if the difference here could possibly also be because of CPU idle
governor. It may behave differently at differently clock rates so perhaps has
different overhead.

I have added trying nohz full to my list as well to evaluate. FWIW, when we
moved from 250HZ to 1000HZ, it actually improved power because the CPUidle
governor could put the CPUs in deeper idle states more quickly!

> OK, 0.70 is not *that* far off of 0.75.  So what debugging does that
> test have enabled?  Also, if you use tracing (or whatever) to measure
> the typical duration of the scheduling-clock interrupt and related things
> like softirq handlers, does it fit with these numbers?  Such a measurment
> would look at how long it took to get back into userspace.

Thanks for your detailed questions. I will add Andrea Righi to this list thread
since he is the author of the bug report. Andrea do you mind clarifying a few
things mentioned above? Also nice to see you are using CONFIG_RCU_LAZY for Ubuntu :)

thanks,

 - Joel


> 
>> Cheers,
>>
>>  - Joel
>>
>> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2051342
> 
