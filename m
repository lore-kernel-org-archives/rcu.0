Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027C6222596;
	Thu,  5 Dec 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418189; cv=none; b=su8ztgAbSxC6rrRJ3UhtCSweDNUOqG5L+5zkwLo6fc3Tvf2E7ZrvjqhgNkQOqm2t1qlBgjvBfg7CYV5+BWm3fzWAgKKuTIPq+JQTnxMm7UQmhCXjCeMv6R6h1mzGFM2ShOkpQhVTUsQJamRkp38tbax/7t6AV+HdLrW3M6rqqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418189; c=relaxed/simple;
	bh=e/tCe9hG6iICc1oeDBRg4JlABdbXt0CyTc4rhDizkmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFVObI9XZQ6yk7dNBMeWI43l4MYv/6/cp7W76S/pqp4nW2ER8mm/WCSM8IkB2CvQB/YRUjOzeI1BhRr4T07Qf2tUzAcYO3UATZRtFlQ836VneYsYZwlLX7nZ3Pfa+dE3pWlRIZTZqDHqWRkCE3w1jTDqk6MVINXCBdLawb+Hruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnQMmTtq; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnQMmTtq"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa5325af6a0so180616766b.2;
        Thu, 05 Dec 2024 09:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418185; x=1734022985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/tCe9hG6iICc1oeDBRg4JlABdbXt0CyTc4rhDizkmM=;
        b=fnQMmTtq8SP78PDSY9UrALMFyrl7xdsaxziN4OQRelQylcZs08PwRsytWafAJhGqLC
         ZniNdfvX7GO5bbgB2Bsy7Jwhkzta+6uuIhcMx/Oav/lsfOU7qNRelR+8gq126tdDZ/A5
         qLeg/cZwKxRMlWnU07c93zgMoHY+TuDEA+Tdi5lpx8FVrc5D0I2VVjvJNa/KhuuGcx4m
         9EQhaeG3wJx4CQ8JgyGqHQywdG5gI0A46vDY+zj5V/SnkWTWGsAw5IjGE4VpOXVmZaib
         xq9xFnLdmf4+PtCjDSdXxd8ce1MhKtY8pW23iXSP1Fq+P2Q7xA7VOU4zYxTP4xQDgXRe
         6oRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418185; x=1734022985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/tCe9hG6iICc1oeDBRg4JlABdbXt0CyTc4rhDizkmM=;
        b=oaHgF9aPdkcKFr8+MHIxPCIBQPD9Gi0DafMUKLa/SLpPFN9wMnOE/860u89vsqpZPV
         zkTjTharDUlig4Vrc16XBrVb2P7JTcQ5aoBsD418nLTpNEg7JlCpyah8O7MGwMcptjb4
         eiQI8YuNVet0WcVWcidblJedRgbMB6IreSlEJgYold93cdupUaOZNKeT1pyNvXR/pgzo
         F1bOH+clS/R/nMMKwyIRZ7j5ViMZIxQ4IDTaR8coavOWDBSqUKJbZIBO7QoGb82qKmY3
         81nUSSg3DzjzheDH8KFahqrZ1KsdbPzhb24PQ3IjMXLzQ1SHglSXyw1k/EQQUfKySuSk
         L37A==
X-Forwarded-Encrypted: i=1; AJvYcCVunj4oa575QKgzCNPfjkpzI79TgNVYAJpwbf/pJ66USrtGjxkIw25oYfjurnWvLY/rwr2MzFjIXGDnjQ==@vger.kernel.org, AJvYcCWZ0wKMDDhacEWgGR0N8REoaI98lLQRGC/kmZSMmyRPwP6OrgdGWxlMOkXSs/yB1GrUIjXy@vger.kernel.org
X-Gm-Message-State: AOJu0YywA5wuobMl8CJ2zYYqrlSs4ytbOXE7HzbR/VpuyNAQREf+Uwee
	vI6ZcjfoTS/4Wu8aV6KRJILW0C22j1vctIWaWMa/tmliqUhH3B9qTggzztSYpBJfkFT2+VbNxpV
	ocQFpcG55TV2cqdTf2TiO8RkqVONyVhqwuDk=
X-Gm-Gg: ASbGncuBZznJ4l28SCf9VprODokdHzCLvnDKSOCcH5ILXqnLFNCW6VC+tk6hXY3pahJ
	Zqes0PiHKn3gwEsLmweE5sLZPnwpZlQbj
X-Google-Smtp-Source: AGHT+IGva2XxsRqhzn54NVJKjdJIlZqWdgsY6soimgsqTPe7Mjxs/4IahkGYXG67W+FgW4SnZ3pjVAV2Aii9pB/8yQQ=
X-Received: by 2002:a17:907:7809:b0:aa5:1b7a:5579 with SMTP id
 a640c23a62f3a-aa5f7d38d78mr1053557466b.21.1733418184808; Thu, 05 Dec 2024
 09:03:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+=Fv5R9NG+1SHU9QV9hjmavycHKpnNyerQ=Ei90G98ukRcRJA@mail.gmail.com>
 <f1561626-fde6-41c0-9d45-87a6a7b13816@paulmck-laptop> <CA+=Fv5TMZ1bckob2VZ1AaNwdU3R+5a8REKg4aZR8novx7+dj-g@mail.gmail.com>
 <8e365392-0e0d-4d78-bae7-69f27c8350f9@paulmck-laptop> <CA+=Fv5RKEC6Vabh3bnJfF7D377qL0PTNkWeqSEWqK9DE5GunrQ@mail.gmail.com>
 <51ce38fe2fa34ec79ad07a96feaea597af07bac7.camel@physik.fu-berlin.de>
In-Reply-To: <51ce38fe2fa34ec79ad07a96feaea597af07bac7.camel@physik.fu-berlin.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Thu, 5 Dec 2024 18:02:53 +0100
Message-ID: <CA+=Fv5RaMF2ohojG+U0MG-dpLHS4x-Tc41+fOLZwrWqu7T0L0A@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> I wonder whether these RCU bugs are related to the SMP issue on alpha that's
> been introduced/uncovered by f2f84b05e02b7710a201f0017b3272ad7ef703d1 [1].
>
> In particular, one suggestion was to run the RCU stress test and see if the
> results will tell anything about issues that might be related to the SMP
> problem.
>

Hi, I'll take a look. I my case the bug is 100% reproducible, that is
every time I unload
the kernel module or boot scripts rename the net interface I hit the
bug. If I mitigate the bug
with the changes to the code the problem goes away, at least to the
extent that I haven't run into
it again. That said, I'm unsure as to the root cause of my problem so
this is interesting.
