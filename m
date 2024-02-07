Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F5F81AD8
	for <rcu@vger.kernel.org>; Wed,  7 Feb 2024 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324772; cv=none; b=c8/i4r5SWMhz3P6vWYy8c0XVQKfKF2W9r90sqQKOfx20pgcfOk+RwcmcRgLBsAW0PaZd71NeOzvl+CmlMVZbuV37j4HjTfoqmeWg3XPstGMR+gWhaJpq9hKJcj4tioC2235/bjjp08vqql/gkYfQB89TstrK3G2HSni0qRfRSfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324772; c=relaxed/simple;
	bh=SEehHHumToBxM4DyU5qjpqj9AmZLP/hoHwSD//XqtR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYXA5wcAV+b6bATDwEQ1DOZO9Y0MkD2jn1i1rHaM1BMU0HRb/Z1hfFEO2FnAJSSJbovp/h1Nca3Du9G+CWNUfj9r4BugQ7BAINFxmnRPBkfh2N0qGleAYRyrR7g5MI4u/9B3J29oxb749m1m34DSsh3it7fPW9YTcozLZ9JqHww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=SE31KxAt; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="SE31KxAt"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso9808081fa.3
        for <rcu@vger.kernel.org>; Wed, 07 Feb 2024 08:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1707324768; x=1707929568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4mYpIsFlUCDwyt9IWw/LMjqkte+0YIju30SiZEJiBE=;
        b=SE31KxAt0xjqsGmyfwqKpIaXRUbup3BubC9ZOFNGbJ4kPxJn9ZiXaUKI/TK9lH64mB
         vT9jPbLuDN0ZU+RuZgmcGknHniSM/3qCcoqzgNz0wd6JUMfg79blGi2bpG3wt4VCmT0Y
         1kqzcArjCGHV5SKvbvZwsNXgj42vKT90W+Dpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324768; x=1707929568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4mYpIsFlUCDwyt9IWw/LMjqkte+0YIju30SiZEJiBE=;
        b=Ztg5FZNGKL2xJdA2+gg2ASSo96TxZNQV0/rxQVEk8lGYLi2J2hh0QZQnsvuBtCpSVX
         mArFXChOoROXy0Jsm1EVxzu+yOozLeQ5LCPqRrqY1MDpWtEUnWSwFUm3fHfDwP6tSsyP
         5cJ1JTrPh6U1SHMDn6DWJbuoWRyymltsxN2fcUlauQGMcHKj9zgdPTDbXzE5CSutOTVM
         rT4vpqV2x4n94seMpftkdSy/vd2VNPOhjZD0ScaFd+Cq8yZq9LlkRmydEmi8EGvPIBL9
         06S0dNvLAL5q3gRhSlE/CcGvXt94bW1LoEs7Jo6gUjXL1hMkEI3z4bHTD7zgcdE8rzBA
         DIGA==
X-Gm-Message-State: AOJu0YzEzx1wKidHJZpW/OblWorivbBWDMD+OdiuuE7hw92n3axz2IPj
	pJwrxe3Cabf3nVI0Ik9fFIGUyhqExHxttJQna2RKK4sN/XEBaQ5sJJE6dUnZZbh1X7CkPmBn5CS
	tpXC40+Ij63ir0hBbMlogvaNSIwPm+Zi8DxVbHQ==
X-Google-Smtp-Source: AGHT+IFj3nYCTGva9PrGBHkP4pVVvq780a6kbWLxvDz7Q5jblHxbLN5Jd8GYBjuV4NK9lYGoqHMWZqRBEHtAHQRCM5A=
X-Received: by 2002:a2e:920d:0:b0:2d0:99e5:84b with SMTP id
 k13-20020a2e920d000000b002d099e5084bmr4940705ljg.9.1707324768014; Wed, 07 Feb
 2024 08:52:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
 <6a2b6857-57e7-4321-adae-132ba69a4fff@paulmck-laptop> <0e15e91e-da47-45dd-b7de-7f89b7b6002b@joelfernandes.org>
 <ZbieCjYk8cIgZS8L@gpd> <cf1c60fc-6295-402e-b546-6f67cf0955b2@paulmck-laptop>
 <ZbjYSXhIrVyCpRNM@pc636> <ZbjdL04k2Z2ZdUyp@gpd> <b8d80604-18a5-4f82-b846-5c00c6aeae6f@paulmck-laptop>
 <ZcJxhoNpkTM7LnOr@gpd> <9f9b6885-6d9d-4f30-9635-49443e1615e9@joelfernandes.org>
 <ZcOwRsEhbQhGv9X2@gpd>
In-Reply-To: <ZcOwRsEhbQhGv9X2@gpd>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 7 Feb 2024 11:52:35 -0500
Message-ID: <CAEXW_YQN=Dm4TXv+F=Q4bfnKWn1Tv52=8hz50JLkbufcM5hUpQ@mail.gmail.com>
Subject: Re: Observation on NOHZ_FULL
To: Andrea Righi <andrea.righi@canonical.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org, 
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 11:31=E2=80=AFAM Andrea Righi <andrea.righi@canonica=
l.com> wrote:

> > The actual number of callbacks should not be causing specifically the
> > hrtimer_interrupt() to take too long to run, AFAICS. But RCU's lazy fea=
ture does
> > increase the number of timer interrupts.
> >
> > Further still, it depends on how much hrtimer_interrupt() takes with la=
zy RCU to
> > call it a problem IMO. Some numbers with units will be nice.
>
> This is what I see (this is a single run, but the other runs are
> similar), unit is nanosec, with lazy RCU enabled hrtimer_interrupt()
> takes around 4K-16K ns, with lazy RCU off most of the times it takes
> 2K-4K ns:
>
>  - lazy rcu off:
>
> [1K, 2K)         88307 |@@@@@@@@@@@@                                     =
       |
> [2K, 4K)        380695 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@    |
> [4K, 8K)           194 |                                                 =
       |
>
>  - lazy rcu on:
>
> [2K, 4K)          3094 |                                                 =
         |
> [4K, 8K)        265763 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
> [8K, 16K)       182341 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@              =
         |
> [16K, 32K)        3422 |                                                 =
         |
>
> Again, I'm not sure if this is really a problem or not, or if it is even
> a relevant metric for the overall performance, I was just curious to
> understand why it is different.

This is an interesting find, the number of timer interrupt executions
looks roughly the same in this histogram so it might not be missed
cancellations or such, so it is not clear to me. But it is worth
debugging and we'll try to reproduce your results.

Some more theories from our internal RCU discussion:
- Could it be another user of RCU (call_rcu) from an unrelated hrtimer
interrupt callback that is causing a "flush" of lazy callbacks?
- What does the distribution look like for
do_nocb_deferred_wakeup_timer ? That will have to probably be made
non-static to be picked up by bpftrace (If you could try that real
quick, appreciate!).

Slightly related, but one of the things we are wondering also is how
much of the overhead for your nohz-full and lazy-RCU test (on top of
baseline - that is just CONFIG_HZ=3D1000 without nohz-full or nocbs) is
because of just using NOCB. Uladsizlau mentioned he might run a test
for comparing along those lines as well.

Frederic, looking forward to any thoughts from you as well on this
behavior. Thanks,

 - Joel
