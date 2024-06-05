Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F05715E5A2
	for <rcu@vger.kernel.org>; Wed,  5 Jun 2024 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574240; cv=none; b=eNQmPAtSpzxwq6bArHRK4TUOK4zP3S9EbS4lbKFWDZI/At6mw837qdDTmIa6/JjrkGeEnKaNbY33inca3uAE1JxKEfD+Z2atKwqlSJsGzAhIlPbNXUFKzAm5mBLqdIPITtvNEfCiGbwcui6gAUVFm8+2aqFVQUjRE7CDP1z81lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574240; c=relaxed/simple;
	bh=MEB3T134sg1+5ITkh0MrNcrAbFTCgwOkdrrL0VU1wg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kp9IyHHqiwDTrlJs2uTeTY313nrpAOJeRz5Qtaeec8i2Z4z1058DHPRWVSL/ESu9kcZFGajmA4TjFyYoEIjplRMX+R5lRvJlirYR76K3JNWN76mb7TELY7oW436HfoN9pRPDlXNKXvlTWCS3ZOJ+tp0vCo5zMmpuz0x9uol0INQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SzZBjnR+; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SzZBjnR+"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4eb0ae42c7bso340796e0c.1
        for <rcu@vger.kernel.org>; Wed, 05 Jun 2024 00:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717574237; x=1718179037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K7HNwq80CUl9euhXBEKTrmHO/OrgPhpji/JBSWvl19w=;
        b=SzZBjnR+NuSqO+SsDVfRqkgYkJXYxOxQ47+5e9WEJ/+YQdMW8E7i+I3CKcOlK39+E8
         mi/TNHxzj0d7xot/NDSHny/qJAlPjz6nZT8hgwvAylNAAX6CcwqDP+intqdGGgsOqSZM
         a/sxitBS3D4t81z3pL13XfJCiigJscynBq9uY5tYPrgqJTeXfEkLNlfRUesoiEuY8xrU
         dX2vFLNI+HITy7LmD5jCIganqGV0AuB06UAhkolKAFlq75rrAArIsampWkQ2KkRjejcb
         sShS5poanwKr1ARuvBfyEpDfFQmZ++oFplJ048m06jSZDdNKkYFeiR25blLTHSkzI2MJ
         DMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717574237; x=1718179037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7HNwq80CUl9euhXBEKTrmHO/OrgPhpji/JBSWvl19w=;
        b=WO6AyPwYwv2XAYWOvCudNEP1H12zcwInU5UrU7DuqmN8wsYCoy59gzqpR1ZkqTBsEJ
         6BFa2v/kc0CZWyr9dquxdArvUJ/mgeprdfKo7PDPlrbbChHK/tECAGFGxfVoLaHdb+QS
         xCFnY9WrudYewVYmOSqGnJZa1Vv/yhZ9EVGzJb+wQOZZ+VeDfXZXxOe4JmYi2QV6wrxe
         rBw7UWPhYbJYhscoT7bZzswG3CvzUaDmWRJkj+oDRwlqSqBrp/7FqksMRTWE0Vfs75Xp
         g0wOBr4yIunWG0LqzXG9NC4awOuhcotSwvNTr7+m4LvzbIo6hovVch7D9PbpBNpth4kb
         8HSA==
X-Gm-Message-State: AOJu0YwkbklMCE6CVzlzSGda3GbmActN20EJBXv2zSwrMoLE5HNQvW1u
	TXvVp2wot9mF/Kc5DjiWY8RAmge5jMKvkyhvIP3Et7YMeuh05bEIpEMwLhNicCMTEaIzfsLoGFP
	RB3hHoxt4FvvbUNj7X8hpIi8ClG3N+oaXHHdT
X-Google-Smtp-Source: AGHT+IHi0oAGYU+C8I6R5jqwLD86we4SP7ouy4HmrcjU04r0ssA25UPb9AuN2gw0FUMDNyuY4qxZjssACgjbQ8m5+YA=
X-Received: by 2002:a05:6122:a18:b0:4eb:e37:2d19 with SMTP id
 71dfb90a1353d-4eb2bc01ecfmr4739547e0c.1.1717574237255; Wed, 05 Jun 2024
 00:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e14ba19e-53aa-4ec1-b58d-6444ffec07c6@paulmck-laptop> <20240604223633.2371664-2-paulmck@kernel.org>
In-Reply-To: <20240604223633.2371664-2-paulmck@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 5 Jun 2024 09:56:41 +0200
Message-ID: <CANpmjNOLuAZfjiNZqZ8zUrziOUiXw-7zOxRpOrwqYP_rgrEgJw@mail.gmail.com>
Subject: Re: [PATCH rcu 2/4] rcutorture: Fix rcu_torture_fwd_cb_cr() data race
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, Andrey Konovalov <andreyknvl@gmail.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Jun 2024 at 00:36, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On powerpc systems, spinlock acquisition does not order prior stores
> against later loads.  This means that this statement:
>
>         rfcp->rfc_next = NULL;
>
> Can be reordered to follow this statement:
>
>         WRITE_ONCE(*rfcpp, rfcp);
>
> Which is then a data race with rcu_torture_fwd_prog_cr(), specifically,
> this statement:
>
>         rfcpn = READ_ONCE(rfcp->rfc_next)
>
> KCSAN located this data race, which represents a real failure on powerpc.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: <kasan-dev@googlegroups.com>

Nice find - was this found by KCSAN's weak memory modeling, i.e. the
report showed you that a reordered access resulted in a data race?

Acked-by: Marco Elver <elver@google.com>

> ---
>  kernel/rcu/rcutorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 44cc455e1b615..cafe047d046e8 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -2630,7 +2630,7 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
>         spin_lock_irqsave(&rfp->rcu_fwd_lock, flags);
>         rfcpp = rfp->rcu_fwd_cb_tail;
>         rfp->rcu_fwd_cb_tail = &rfcp->rfc_next;
> -       WRITE_ONCE(*rfcpp, rfcp);
> +       smp_store_release(rfcpp, rfcp);
>         WRITE_ONCE(rfp->n_launders_cb, rfp->n_launders_cb + 1);
>         i = ((jiffies - rfp->rcu_fwd_startat) / (HZ / FWD_CBS_HIST_DIV));
>         if (i >= ARRAY_SIZE(rfp->n_launders_hist))
> --
> 2.40.1
>
