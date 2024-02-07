Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864957F46D
	for <rcu@vger.kernel.org>; Wed,  7 Feb 2024 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320957; cv=none; b=C9nfQ6hKbzvXC8xKumaZOgCC1JnJ4L7apR5UhNSs1xZfxaj/qRfsZmgmpw9anQCOgPFYSLKyWxSnFJazoAM+P3nC6MHceXAwnf+VDdiaBj2htU1P13MsBPi8NjMnMT0uxB6Q62Wv1rtARgpCK3oz+o61lOSabrIWdgrb9PKocZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320957; c=relaxed/simple;
	bh=+YGIw3XqG20Kt0kgj9xdcdq/KN9PMQy+QP1fjdmRv18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSyccZED2JJg1x8HO6m4ghz/+g6WN0llVjcl5RoVhIBnhH208uSwxm1eo3BKvjVNcYlHTxFc+NoR5Yl7lhVGnSDYoivbDztrH5D1kq9MKwBm4kz14EyEi/kHGH/OKin9cKtQh/oG6ERTz34CM/uGRzjoeAz0spg6h8ZuV/xMN+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=lV3UmJIc; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="lV3UmJIc"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-686a92a8661so3316136d6.0
        for <rcu@vger.kernel.org>; Wed, 07 Feb 2024 07:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1707320954; x=1707925754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9QsLuRSi2IfpM/qD4kZRclHfEIHJnlznVQCgUMnTin8=;
        b=lV3UmJIcc0e5ebIDKn76iKhex8yaJ0bVi/qumHpjSHXtg1IdgS/eO8/zXVUzGO3Osk
         kYUF05zjmYGhO3shILTlSCoGmh/V+CEST41IkCrx6NNwWVrULHC9em2n7eKwCTaJqQur
         gxEcWTkNU+1m0QbCSKp3U2PTJ+KWr3SYpkCdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707320954; x=1707925754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9QsLuRSi2IfpM/qD4kZRclHfEIHJnlznVQCgUMnTin8=;
        b=c6EHKr9uRqmaS/aYM/qGER+d3U7LiwjhFLBeMLCGBz1o5pxCRyi+JlSWsVJJ7rbOst
         qmLJOJQORDNWHK3vOgQsoBnDRJQ55lUKo8Yi5y/MB9GmJ09gcGquyG3Sw2lxjp6H+JYx
         63tfkKScWVAtDsW7ecDyn6ghlUe05Kd86N73bTKdO7K33KtpFgq6dQJH+zD0JLzcps6p
         yo3dSAOcF7r9nh4DuqxrxsEf/J/Rbf/Rlrs2hh0fZdmZTxQkrTBjt4S1AB1CZU84iamL
         vqTwafxgiJ6TJ5rwzQKCB/YZRdDA0ZqpxVzRGOo7xAyHDZYf0+Dbppa+VkYwDTNt/7Oy
         px5A==
X-Forwarded-Encrypted: i=1; AJvYcCVNOlq8fMGMgjpWKrY229osAOzH/4r1cNVrKtxfccZiWVCXh30k+ZXZS8kIqxiIu+9rsO0AkBtlorZcd21/xQOXMRoI
X-Gm-Message-State: AOJu0YzaztrhrcU/vkIJ7M3iKr+HIiwbDyNelbXK05erCoLYAU6qTCAM
	NEYTLZCDf8xW0asrKabmR1xCE8nFf7lpVkeqSmAj0/h+znM2BVT82STeEokDHuw=
X-Google-Smtp-Source: AGHT+IE32/2O+PVwPYL9nPGXpJ+kNK1aHWWRN34Vnt5gs3y73qUk/ImrKVQi3Ef7L5PoLddjX39EDg==
X-Received: by 2002:a05:6214:1bcc:b0:68c:7f6f:2c6 with SMTP id m12-20020a0562141bcc00b0068c7f6f02c6mr6400513qvc.36.1707320954297;
        Wed, 07 Feb 2024 07:49:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6ninf5LDvDM34U3TUPTIM2MPeBtf/rs9z37b92+52sWZ/4OVK26K0NwhOkjtzy2QGpHPP1b2suaOQtzd22fmwbp11e67ZXg5linalbeOis8iiIygU1AkNKg2C3rXvnjIBoglIJM1+stO2hBkQrir3TDBp5iUwKqnuVosl
Received: from [192.168.0.226] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id df9-20020a056214080900b0068c964c3c4fsm686583qvb.127.2024.02.07.07.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 07:49:13 -0800 (PST)
Message-ID: <b11fa42f-9f84-4ded-a6f1-729fb3fceedd@joelfernandes.org>
Date: Wed, 7 Feb 2024 10:49:12 -0500
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
 Uladzislau Rezki <urezki@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org,
 "Cc: Frederic Weisbecker" <fweisbec@gmail.com>
References: <6a2b6857-57e7-4321-adae-132ba69a4fff@paulmck-laptop>
 <0e15e91e-da47-45dd-b7de-7f89b7b6002b@joelfernandes.org>
 <ZbieCjYk8cIgZS8L@gpd> <cf1c60fc-6295-402e-b546-6f67cf0955b2@paulmck-laptop>
 <ZbjYSXhIrVyCpRNM@pc636> <ZbjdL04k2Z2ZdUyp@gpd>
 <b8d80604-18a5-4f82-b846-5c00c6aeae6f@paulmck-laptop> <ZcJxhoNpkTM7LnOr@gpd>
 <92cba6df-01de-4daa-a0cb-5fa92c7374dd@paulmck-laptop>
 <ZcN_zDNXRbbWN_Jc@pc636> <ZcOd849l1at2742K@gpd>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <ZcOd849l1at2742K@gpd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/7/2024 10:12 AM, Andrea Righi wrote:
> On Wed, Feb 07, 2024 at 02:04:12PM +0100, Uladzislau Rezki wrote:
>>>>
>>>> I repeated some tests in a more isolated environment and posted the
>>>> results here:
>>>> https://discourse.ubuntu.com/t/enable-low-latency-features-in-the-generic-ubuntu-kernel-for-24-04/42255
>>>>
>>>> Highlights:
>>>>
>>>>  - stress-ng --matrix seems quite unpredictable to be used a benchmarks
>>>>    in this scenario (the bogo-ops/s are very susceptible to any kind of
>>>>    interference, so even if in the long runs NO_HZ_FULL still seems to
>>>>    provide some benefits looking at the average, we also need to
>>>>    consider that there might be a significant error in the measurements,
>>>>    standard deviation was pretty high)
>>>>
>>>>  - fio doing short writes (in page cache) seems to perform like 2x
>>>>    better in terms of iops with nohz_full, respect to the other cases
>>>>    and it performs 2x slower with large IO writes (not sure why... need
>>>>    to investigate more)
>>>>
>>>>  - with lazy RCU enabled hrtimer_interrupt() takes like 2x more to
>>>>    return, respect to the other cases (is this expected?)
>>>
>>> This last is surprising at first glance, but I could be missing
>>> something.  Joel, Uladzislau, thoughts?
>>>
>> Could you please share the steps how you run "fio" tests?
> 
> For short writes I was running something like this (on a 8 cores system):
> 
>  $ fio --rw=write --bs=1M --size=32M --numjobs=8 --name=worker --time_based --runtime=300
> 
> Larger writes:
> 
>  $ fio --rw=write --bs=1M --size=1G --numjobs=8 --name=worker --time_based --runtime=300

Andrea, Thank you for providing these to us!

 - Joel
