Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E8113DB8A
	for <rcu@vger.kernel.org>; Tue, 23 Apr 2024 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893183; cv=none; b=GlHNE++b7qJbB6k29sRnJ7rjYrNUD4XwSE9zNfnHtzcbXtZRsqy4BbajMjdqDFBUx9XlGk0lVNdietulG+bGULw3RK8K2We00sMiYaTQRMUhCc423M6cykXzuhZZPgAXFgSQoiMWtbJLDKlWj/XzWqJ3cwDy7kdtgktPVOxO4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893183; c=relaxed/simple;
	bh=y/gWDRg5azMor/2Aofxe6N4fri0YGxkZz2pXkN9ffwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtomoJKXqx1JC1k1S4lQlaPu68PEhTPkYY6ULQBFKiJ+YhO5bFd0p8l3PS5EWArhd4VIO1l3J7S0VYvO3z+ItJPiX6CPv5IL0+T8lxxstceo/t1UcXrd1Vcepcd/53syZRfSzsQjg4fpWMj2IraIhoSnN7P8EcFQCpqvjxOGLdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=hhPWfmTr; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hhPWfmTr"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so7311158e87.2
        for <rcu@vger.kernel.org>; Tue, 23 Apr 2024 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1713893179; x=1714497979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wSZEGJVi5OGysNr5Q/Szri9RMljTd9jL++xzWo19os=;
        b=hhPWfmTrdLmwQ+mNgHGLcmO0qZwLEMcU3OZR228YDS5sQbWNJx8KKAZ1/XAsDx+QP6
         FRnl8Kwh7e/DPDTfhbpirfaBGkSiWuiUU+6QqzJeQgNpXXzQECKg6bGPoWb4xxVjrRtZ
         xY+4uw5zrj8r4qkv5PBSfK00+TO6wucF01c0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713893179; x=1714497979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wSZEGJVi5OGysNr5Q/Szri9RMljTd9jL++xzWo19os=;
        b=AeNx0jE0HlZIF88HCXEJxJuyFzF9ObZM8/E3Ms3LZinue141h8qC+h39R232IAu+sv
         QcpQtfCepTZpjJU+6i1JU9z52WfWvaKmFB7WNb0+hncAtVrMvNPhWC4RYUy+RChi8vUv
         4NRX36FR3On99izAdwfh01fLg3/wIupa+RU4yn7f+XPOeP2rfpMZhnDvUmUaYCPjWUJt
         //CUDkx9uY/M2kBVlCViXyTFJLH5hedave+lfLyQuulb/WqUZ2QvfUauu1hupo+xg/aL
         rNfzTEfET5RPWZpCs2WOunhDnYdh8a+YJyQym2meMQMz/g07988ytre7W5b3O6bYsH53
         9ZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzjZWy/MNz+0LHr9+wtyXUX3ORCzZJEKf9qssK5ZuwJ5h1M0pqFHz4a3ZTGkygPm6wZ++NsJ9CEl8XlFXcyZddUcms
X-Gm-Message-State: AOJu0YyOr6XIjXGv6pFdVq8+ON1IfY8UxmXfuWl8fFwghP5qAQv/vDXc
	Vrn04jpRgdJMH8WLRCbVRNhpJxKQB9OPLO0DU948yYmZIiPAgQhLiK9Bj/00MMW7xDEwM4r4hZz
	CMTAEVY2eX0CX15YGP68rLI7RBMRJ88r2tpdPHg==
X-Google-Smtp-Source: AGHT+IFTjidO0k5EKPLIvs7WXJ7O7CNHELrOpC1ZJHG/CmlX8aqmFH/VYBuhcZc+PhjgSlzjogvyqemcBD41ZPsrb/0=
X-Received: by 2002:a2e:9546:0:b0:2dd:74d3:7ca8 with SMTP id
 t6-20020a2e9546000000b002dd74d37ca8mr5055038ljh.27.1713893179140; Tue, 23 Apr
 2024 10:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407090558.3395-1-jiangshanlai@gmail.com> <20240407090558.3395-12-jiangshanlai@gmail.com>
In-Reply-To: <20240407090558.3395-12-jiangshanlai@gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 23 Apr 2024 13:26:06 -0400
Message-ID: <CAEXW_YTin=EgjoypCD=eYh-NLRwxbhdr+B-jBO5TpC4qcef2_Q@mail.gmail.com>
Subject: Re: [PATCH V2 11/11] x86/rcu: Add THUNK rcu_read_unlock_special_thunk
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, x86@kernel.org, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Lai,

On Sun, Apr 7, 2024 at 5:07=E2=80=AFAM Lai Jiangshan <jiangshanlai@gmail.co=
m> wrote:
>
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>
> Add rcu_read_unlock_special_thunk(), so that the inlined rcu_read_unlock(=
)
> doesn't need any code to save the caller-saved registers.
>
> Make rcu_read_unlock() only two instructions in the slow path at the
> caller site.
>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  arch/x86/entry/thunk.S             | 5 +++++
>  arch/x86/include/asm/rcu_preempt.h | 4 +++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/entry/thunk.S b/arch/x86/entry/thunk.S
> index 119ebdc3d362..10c60369a67c 100644
> --- a/arch/x86/entry/thunk.S
> +++ b/arch/x86/entry/thunk.S
> @@ -13,3 +13,8 @@ THUNK preempt_schedule_thunk, preempt_schedule
>  THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
>  EXPORT_SYMBOL(preempt_schedule_thunk)
>  EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
> +
> +#ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
> +THUNK rcu_read_unlock_special_thunk, rcu_read_unlock_special
> +EXPORT_SYMBOL_GPL(rcu_read_unlock_special_thunk)
> +#endif /* #ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT */
> diff --git a/arch/x86/include/asm/rcu_preempt.h b/arch/x86/include/asm/rc=
u_preempt.h
> index cb25ebe038a5..acdd73b74c05 100644
> --- a/arch/x86/include/asm/rcu_preempt.h
> +++ b/arch/x86/include/asm/rcu_preempt.h
> @@ -97,9 +97,11 @@ static __always_inline bool pcpu_rcu_preempt_count_dec=
_and_test(void)
>                                __percpu_arg([var]));
>  }
>
> +extern asmlinkage void rcu_read_unlock_special_thunk(void);
> +
>  #define pcpu_rcu_read_unlock_special()                                  =
       \
>  do {                                                                    =
       \
> -       rcu_read_unlock_special();

Instead, can you not use __no_caller_saved_registers attribute for
definition of rcu_read_unlock_special() or does that not work for what
you're trying to do here?

Thanks,

 - Joel
