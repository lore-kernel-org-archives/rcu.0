Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37888129E6E
	for <rcu@vger.kernel.org>; Sun, 11 May 2025 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746955651; cv=none; b=WJMYhgmxOThkXAkBWUboz8Ypq3gPnDvLYNAmSodZJMoESMJ1z5HaDvTOSpyL74y7KJlaPeJZHw9rqv2xAQ4G7ufLSmyo6jxPltdR1TYHhf1sW1RMSKBhpjhOyUG1v37GZnFeGtgcwNcHQ53vyQIyI8t+PO42RYuXhoFq51k1TAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746955651; c=relaxed/simple;
	bh=7ve7vvEjWFFsuymugJF/BFMMePJj/tWS5LQtXjjDs7A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=KNw0mB7XyHX/oN1xgRZDgPTkggPiX+T2WC/uXOJtJNvxQi9xYK7yzZtQmKImcM0WAo2IPFyVwUxLWBzlHZTyZNF0NH0iP4V5hQZI/gxQtVuLEMWoYxAs/u6ZJHufQ+qHTy4ZZgQ0WGKvxqbHLoKIfZauUg48z7A94Y84tG0Oja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/X0EfD6; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/X0EfD6"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b239763eeddso1801805a12.1
        for <rcu@vger.kernel.org>; Sun, 11 May 2025 02:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746955648; x=1747560448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyAiNnMOrIioC6p/UmA/c+LNz4Q9PNKySRKuQwH7/1w=;
        b=J/X0EfD68wSP2GUpTo+rckxQCnBJ24icgvfLSkXr++EY7Bs8DH4WL3hGRg5pBWuk9r
         mN1W7DIXOHNoPhS32c6iF6MuxKFiYXp5h6alPusxJCe4eVmtaWyFM2sHz1VraVrsoTIB
         /f5fHZvtU5deogxMQAr6Knn2r0c/ImaPN4RT/Ja08Lpy0/DrbNZs5QG1vSFZSGY0V1SB
         ZLj04aBH0F/0CGWnRxUzSm4Znuh6z6PDm87vvCsW5O2HxIdjeoi8e1UxFo0sGvkwCRHM
         oLpLXBEUcbhB29N+uCCQ7GDrdawZcmYmVAc2VR9LP0DEn5iYLXJE9DfpVb1+0i6ks6ZP
         KzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746955648; x=1747560448;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyAiNnMOrIioC6p/UmA/c+LNz4Q9PNKySRKuQwH7/1w=;
        b=RrvWQKs9A6iDU8jfAZC0QpB886xl7m2xLwGJXjMm4bCP3fMl05s+U7xw8fWHQoSXyu
         IB+JOJn7BQNtqg+wDx8MIPaEES8jOntfyC8H7u8X4fWtZM0djhsm1/MHtpY5JBImeHEE
         ue5E7Fe/fau/mnrhUEpBkHjsl8Ez97zx6HlrUlBKKe3FrqSJ0TCgFFE27Gr4drIzELDW
         Lafwf1WxXyTV0Ykj1+54bDOxrXcOWL+KIhFYtKWGlMAOjLC/ZP/46DfngcW/a3uiE4Mt
         Os3ctp95U3wwWYDh5+xz4JoGLWgz1/nEH2yH/2SQNDw58wub4SA+9suQDFl+fmN2Xete
         MNFw==
X-Forwarded-Encrypted: i=1; AJvYcCWIitendVCIqQ5vjmQ/7HujTQGpf3+/pCx3iAcFLdvw8W7qOz8CYPMYEDGnfnwIH4HpYKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF4yx06P442NfPuGHIvqNrOUWunG89Jsm4aTgdt3OzFi+SrDVx
	eEa9HnqnUk8zjkjXJV8pdyz/aLWlpZA/WiKhgyin3jR61j8Ys9lBqMbJzVpJ
X-Gm-Gg: ASbGncv6P45LR3M3U95sqhlGdlvik5pF75GpEx6X4JBG+zO8tKUt/OomH0f2FxgcKZ8
	qXFO+Wi+QtBeCGsw9XUcVKZREeKAz4r5m30DAXdq5Zmm17NyHQjrWkFqG7TRpZtDiPARS2MzIY/
	6Owf54g5vtqpro2qjdmlta5gyqCTN3wNWU29dHqd0+FntrfQFzJoULZH6x7RVyR277UDQP2SDst
	d6ct6wKgw6jDkgbeK4vPrZsTOdIHLkiUEQ1y/f7ddsGy5x7o/3HJXU+10IPRw/2gpZj+YHCU/sn
	Sxv/dpNTlSUSSQ8Ayn92hmnaawPdOu5p2qLgUGL2G+6Ugu37XlKcSJSJhvAWWBPaazlNX411NMt
	mj8CoIam08468BnmqEybUrQ==
X-Google-Smtp-Source: AGHT+IFTkKc0EJOqq3324YCZx0Wa/pE0Hw9GyYcI6Uegn10B6GMQBLtdcjcPDStYbZEGUfF8Ap7QBQ==
X-Received: by 2002:a17:903:1b6d:b0:225:adf8:8634 with SMTP id d9443c01a7336-22fc91a72b9mr131377085ad.51.1746955648196;
        Sun, 11 May 2025 02:27:28 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc753fe13sm43549615ad.14.2025.05.11.02.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 May 2025 02:27:27 -0700 (PDT)
Message-ID: <24beb2bb-b168-4849-804b-033c20ca352e@gmail.com>
Date: Sun, 11 May 2025 18:27:26 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: joelagnelf@nvidia.com
Cc: paulmck@kernel.org, rcu@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20250421174717.3332525-1-joelagnelf@nvidia.com>
Subject: Re: [PATCH v5] rcutorture: Perform more frequent testing of ->gpwrap
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250421174717.3332525-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[Trimmed most CCs]

Hi Joel,

I've got a warning from "make htmldocs" on top of rcu/next:

[...]/kernel/rcu/tree.c:775: warning: cannot understand function prototype: 'unsigned long seq_gpwrap_lag = ULONG_MAX / 4; '

On Mon, 21 Apr 2025 13:47:15 -0400, Joel Fernandes wrote:
[...]

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 659f83e71048..6ec30d07759d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
[...]

> @@ -757,6 +766,25 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
>  	smp_store_release(per_cpu_ptr(&rcu_data.rcu_urgent_qs, cpu), true);
>  }
>  
> +/**
> + * rcu_set_gpwrap_lag - Set RCU GP sequence overflow lag value.
> + * @lag_gps: Set overflow lag to this many grace period worth of counters
> + * which is used by rcutorture to quickly force a gpwrap situation.
> + * @lag_gps = 0 means we reset it back to the boot-time value.
> + */

This kernel-doc comment should be in front of its corresponding function
prototype so that it is recognized as such.

> +static unsigned long seq_gpwrap_lag = ULONG_MAX / 4;
> +

, so this static variable needs to go above the kernel-doc comment.

> +void rcu_set_gpwrap_lag(unsigned long lag_gps)
> +{
> +	unsigned long lag_seq_count;
> +
> +	lag_seq_count = (lag_gps == 0)
> +			? ULONG_MAX / 4
> +			: lag_gps << RCU_SEQ_CTR_SHIFT;
> +	WRITE_ONCE(seq_gpwrap_lag, lag_seq_count);
> +}
> +EXPORT_SYMBOL_GPL(rcu_set_gpwrap_lag);
> +

You can test it by saying:

    ./scripts/kernel-doc -none kernel/rcu/tree.c

Thanks,
Akira

