Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B55A15956E
	for <rcu@vger.kernel.org>; Mon, 29 Jan 2024 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566830; cv=none; b=hbUHVOKlRojyLFafUpLdvgctV3VoVGG2lHWSyc91xJY9EIvssXNBekZtBu6Ro7qozya/Zb3I2R63cfMzM1AHSEJ5Q72EFnU4ropBi0yMo3b/RC7Byt3RuIjCeiDFqlQyGvpojEeo23DTdYg94hg2hgLbIW+hFNEMZwVGgBVPmS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566830; c=relaxed/simple;
	bh=jqYScOJGdFNrbrlnIlbguzFMcdwHEgAlYib6OKcFDeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WyIlIZiPY+kEfZ0VrcS1fD7a+bVlY0CgXKkZUSU50MBRwOqhZ5a1YzQHnS76pSsTJppWq6uq1U6DM7B+Emkm4rRNRkD+7kPtRWFRpDKmqwKMxAHhReYd5bT6ajik5rJsN4h9sJe/EOP4mwop+i76Hg6znls0bF68OetTrH2/tOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=nz6XPGeV; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="nz6XPGeV"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42a9199cfd2so17480211cf.0
        for <rcu@vger.kernel.org>; Mon, 29 Jan 2024 14:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1706566827; x=1707171627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ogZKXJhaL0sF2JGgrXXUAUBzrvxhoufBqIT1JYQyqXI=;
        b=nz6XPGeVrtrFZggAAL2EaLq8uRhHbQ8dQUNroytW+QBERrCQ1OchAae6HH0WKhu2eS
         vBBjTZCspIvAFXhDBZ18z+S/e7nKg/vba2uCAUgyPXnRPwRZsLbCCqEd7ikifG1mhHcI
         ktoPGgTuCodkWMaejXQ0pm5AS8A46m5xzkuFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706566827; x=1707171627;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ogZKXJhaL0sF2JGgrXXUAUBzrvxhoufBqIT1JYQyqXI=;
        b=JtJbuzPOfFhrUYnZSCkIGY+bAWnW9iuKvxtuIFdLrlj4/T75vofG7p7x/mO7CZMMfW
         w0hsBqgl/N3AZQi5GG4BRka3b/xEoPBTFCFT2x+g9oYcJvNUWXyXgVgl9frLEUVpN5Pb
         31cJqEUkqulLPtYiUfEeqbV4tWHIK+i6sTNx1PLHM95zGUdwtUyNIcwhjA2bPccwuMF3
         3DjTd1Pz2wvX6vGCR1uVGe1IDUphFzkrx0ceDIX+Y+2wiFFAJVWQba8GSRpBiEvoFCDW
         rJQJHx1DPfQpNAggpzdKurKj/8wVmslUToCwUX75flvBqh2CTosx9Uz3/tqB+1vhXUTy
         GJHw==
X-Gm-Message-State: AOJu0YwIGCyR+fMwc19/86+n8F0oRncqM6rrOphKused5cP98aeCEQ6k
	1UndtWu7Jyi96jFxkvHtWX0nZ96abTjmPwUFOXwkC+ljaScd2K6LvelMDqUr2KM=
X-Google-Smtp-Source: AGHT+IE4PfJ3bPoRoxgNYraMoDc78uaCueA9MSwXyWl5lHaiuDiw2I5gHDq1bqkjUjMmodrPtjAI7A==
X-Received: by 2002:ac8:5bcd:0:b0:42a:aa7a:2f01 with SMTP id b13-20020ac85bcd000000b0042aaa7a2f01mr2410163qtb.48.1706566827208;
        Mon, 29 Jan 2024 14:20:27 -0800 (PST)
Received: from [10.5.0.2] ([45.88.220.198])
        by smtp.gmail.com with ESMTPSA id hx3-20020a05622a668300b0042a0a0d4225sm3877719qtb.38.2024.01.29.14.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 14:20:26 -0800 (PST)
Message-ID: <b6672b7b-fed4-449b-90e5-216f8294c1c3@joelfernandes.org>
Date: Mon, 29 Jan 2024 17:20:23 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Observation on NOHZ_FULL
Content-Language: en-US
To: Uladzislau Rezki <urezki@gmail.com>, Joel Fernandes <joelaf@google.com>
Cc: rcu@vger.kernel.org, "Cc: Frederic Weisbecker" <fweisbec@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
 <ZbgPL0Rg_on4kOBf@pc636>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <ZbgPL0Rg_on4kOBf@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/29/2024 3:48 PM, Uladzislau Rezki wrote:
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
>>
> Timer overhead and its scheduler-callback?

Yes, quite possible.

> If i do not miss something
> the NO_HZ_FULL will disable the timer if there is only one task on CPU
> so that running task benefits from not being interrupted thus gets more
> CPU time.

Yes, that's right. I believe it is well known that HPC-type of workloads benefit
from FULL, however it has led to want to try it out for constrained system as
well where CPU cycles are a premium, especially if the improvement is like what
the report suggests (give or take the concerns/questions Paul raised).

Thanks,

 - Joel

