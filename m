Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38765524B1
	for <rcu@vger.kernel.org>; Mon, 29 Jan 2024 22:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568836; cv=none; b=ZkORQda8wZ+mBfjN3d0xzACyz3E+zHBZArxowU8X3G0Tp5Ki3Af1LsdViEuNlWsxCpRIFjKsH5inOgGOjxkYDY3aFdD2QAa3RcT0LvMLLhDAzUV+wSyU88Bv/ECG4ZcID2M0+qmZZL2KrFEIE3jnkw6SecA0JlSEVbbF5IaZUEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568836; c=relaxed/simple;
	bh=E4XYKdOq+Xq3Jha/KaBWVmuT4kZPCNuFBBOqok8C8Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVML28XNVEQllWKOkrEcM+cw4dSrF6ekrTdP2weJTfe+8xklWdZnDy6LsXWLpiXTNu6NLdZJp8Sj320wftOuvfNl2GjF+BgiaIbRquKDzeOksH+wKrRh3oqjdSeheMXfZHrcpED/zrNUy+tYZS+BUXltG/A1VwqovQwGLUVcZIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=q8vu9lHu; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="q8vu9lHu"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42a99cbb4bbso13443961cf.0
        for <rcu@vger.kernel.org>; Mon, 29 Jan 2024 14:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1706568834; x=1707173634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0A4Y6is1iubUBsOkVnR3SIjBCyoO607e7/C+PpXigoA=;
        b=q8vu9lHuc2FtZdh0eEaLisBm6n2cRPe0c8GtyQBfC1nRXRWn+IDsRCsCUifoNn17ch
         uVHay+92P/sQ1yU0Acy/CXZXLf7Q1KO+c7W0G7bafyQy7R4QQOXuc5qvxMRmC06YP5EK
         bbiCy4Ed+9wzgxBmlhjxFmkJWuVzlRJfagV8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706568834; x=1707173634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0A4Y6is1iubUBsOkVnR3SIjBCyoO607e7/C+PpXigoA=;
        b=pD+agBBf6qfvpaf0q9cHewG6RMoACMWWZWGEJh5Tv+UqtyBdkBhwHGpW+riYzgB53i
         SGWl/ZGBzRdiZIFSzEsOhGsIoG6soQkwki4HgyriqiC+84HZQGrG94c155QTNI7b+h1w
         Z5L/eGcnIWWe7tq3G0Wvv4IVb1J3zq2R3kOJMGwF7Yh+zvX1qz2DUf9Y48SDCRhFLc1v
         uMUIRBO58xbWKGrvwMAk8EiFfADBCgUYEr5KJQdP3i1v5yfnwKsf43KdEvzHYMtGhTcI
         r2ziEteQYLwmBFDEbMws8xxelSqVqXmpvqCFH3n/oBj9MDlOxMYzNme3EzL2vY/GZ1/z
         gzLA==
X-Gm-Message-State: AOJu0YyRME+TgHPgsaNeQVIdecb9mckVkLBQd19pKR8h2uFE3HoqxRCG
	4dqGK2LIga1TLKrMaskOAyTUQ08RH5NJVWX7wi+Ys2+0iTZ3V0FU80L6kGv7HmY=
X-Google-Smtp-Source: AGHT+IFWNIECYEEKhzQP8+P0aQepUzWLS1PvDykJHR8T/IDoVBdz0Hofbn83w9XExeDhS3I4Wny/oA==
X-Received: by 2002:ad4:5942:0:b0:68c:4e75:91bf with SMTP id eo2-20020ad45942000000b0068c4e7591bfmr3417397qvb.59.1706568834069;
        Mon, 29 Jan 2024 14:53:54 -0800 (PST)
Received: from [10.5.0.2] ([45.88.220.198])
        by smtp.gmail.com with ESMTPSA id oi8-20020a05621443c800b00685422c9e35sm3851453qvb.84.2024.01.29.14.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 14:53:53 -0800 (PST)
Message-ID: <3753c8ea-f408-4e52-bcb8-9586c483f699@joelfernandes.org>
Date: Mon, 29 Jan 2024 17:53:50 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Observation on NOHZ_FULL
Content-Language: en-US
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Joel Fernandes <joelaf@google.com>,
 rcu@vger.kernel.org, "Cc: Frederic Weisbecker" <fweisbec@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
 <ZbgPL0Rg_on4kOBf@pc636>
 <b6672b7b-fed4-449b-90e5-216f8294c1c3@joelfernandes.org>
 <Zbgp_JJvdczGccV3@pavilion.home>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <Zbgp_JJvdczGccV3@pavilion.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/29/2024 5:43 PM, Frederic Weisbecker wrote:
> Le Mon, Jan 29, 2024 at 05:20:23PM -0500, Joel Fernandes a écrit :
>>> If i do not miss something
>>> the NO_HZ_FULL will disable the timer if there is only one task on CPU
>>> so that running task benefits from not being interrupted thus gets more
>>> CPU time.
>>
>> Yes, that's right. I believe it is well known that HPC-type of workloads benefit
>> from FULL, however it has led to want to try it out for constrained system as
>> well where CPU cycles are a premium, especially if the improvement is like what
>> the report suggests (give or take the concerns/questions Paul raised).
> 
> I'll be unable to suggest anything related to that Bogomips calculation but
> I must add something about HPC.
> 
> I have long believed that HPC would benefit from nohz_full but I actually never
> heard of any user of that. The current known users of nohz_full are workloads
> that don't use the kernel once the application is launched and do their own
> stack of, for example, networking, talking directly to the device from
> userspace. Using DPDK for example. These usecases are for extremely low latency
> expectations (a single interrupt can make you lose).
> 
> HPC looks to me different, making use of syscalls and kernel for I/O. Nohz_full
> may remove timer IRQs but it adds performance loss on kernel entry, making it
> probably unsuitable there. But I might be wrong.
> 

Thanks for the insights!

The kernel entry/exit overhead bit is an interesting point and also tracking
state for RCU observation purposes. I wonder how much is the overhead in
practical cases and curious to measure (especially the tradeoffs between that
and the tick). Added note to my list ;)

thanks,

- Joel



>>
>> Thanks,
>>
>>  - Joel
>>
