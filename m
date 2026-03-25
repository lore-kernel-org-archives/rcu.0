Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC22BEC2E
	for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 03:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774407604; cv=none; b=uXk67okLM4AFSA+E8QtShvWuZKTeTzW8qUDDH+GlK3zOkHMJE4FafanF3ddiH7jI87HilQhJCEuoOkEO+bLQwrkPQj1YU5dWENRbFQSf3I3Z5VUA3UNT1aJSxxXySg1jo5sG9q1lFSJVa63/BlMT5ZZbeWcrPsn3GrN9DY6CuPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774407604; c=relaxed/simple;
	bh=0SO1ezB5xqF/jDhtcvBmzZdac5PSbbdtiGl6pp7jGto=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XNaKYfkI+NmBupIGFBFs7g2gmxoI7xq8AtksRsAmGrduvmv6sqzwRa5/9pY9vlGEtyxR/SsYjDXN8idngDJecBGBfrwPBTYBp9BAjmCxGYmAYg6adjlno31553G3RyLdl6u0z8XsKGpvWOkMXOPu4PyG7XcvTii1Ck9yQ2M8FQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v6/cH9K/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v6/cH9K/"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aeab6ff148so33545ad.1
        for <rcu@vger.kernel.org>; Tue, 24 Mar 2026 20:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774407602; x=1775012402; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GLCYT1BBJZAVEfo2dGruLL5s+wMzYpDGhybdNbcCskE=;
        b=v6/cH9K/KJV8k+4pbK2EYKQvhHvuuLNsE3PuKZC0PL8gGbLmqQNLq+x1nqXbTX5ANM
         OkA+RKSliwucjd7lVS5gA30n7emjb4BK5lGcPa4u2eA80OTbKaSLRzDzIfLP+pjI8Kff
         DRGvu8ou+/OL7C0DcX+6eftFAJRSkXVAjUqKdVo8tSyaBLHQBZc32Lv+6gjQlNViJU6s
         C1Fy4weN6dsDqFCFenAJM6OsYQ9upgipfdCPHtMbhh1nMDQHH8V8A4s9hk01URwW6kdW
         YkaGuNhCFx5F714acjSIrqtx7DfuJKAUTeQer18LD0yDzl/48BLxjrH/6Mlv1tSAiZ58
         NOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774407602; x=1775012402;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLCYT1BBJZAVEfo2dGruLL5s+wMzYpDGhybdNbcCskE=;
        b=MVuqVhN37F7zz/hlFL3WGruUZl4r0QfVFV7vfIFX44Vqc6uwX4HRj5kgGDIRG6eua2
         51kKiIpNX4NHilxtDqOv+WOsvXnLY1RJd5fRkNv/yO/15jxacLLikuHDiRfLgvdgC7aX
         iH5MLrN29A+Jn2Kai9S+OjyakdPoUarue6wAVCxyN4g+yORK6KyFQZFCzEvliLtFjMWa
         +WQj96d1olT9kXAUTZiczMF0YEmEiMkMEhFz9d8sm3oxYBFvA0/40zlrb7PCj318hQsI
         xLE2Qx0YGNjxBLGW8hsXEeBdMVr6uaM1LhZlsRwXJmOu7R+X+/a/98GJrOMVclLhq7TM
         qGVg==
X-Forwarded-Encrypted: i=1; AJvYcCUsHtIR+CAY5xupuZApVEj/Uzdb67RS1DfQKrsn6DqmkRJzhmFTIc7PeIImEuXMz0AgSpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwClMk844MF8IuCSpz72LdTnDx1eaXvX8RDOjt8VKh0WXdaAH9x
	cw+OuO+BT4evxDhq316fzMrXCwexZFPwAUfCuZA7fS+FvGP5NA1t8pAQrt1VcyJJWQ==
X-Gm-Gg: ATEYQzwNSCFO4lf6+B6tzwzcjNCCgBoqsU4my3+TZGjF7m2dEAeI8B6y2uisazxCpDN
	nCuAEHCxfu1cCGjnXqjO9prNICtWm4cbS+OjYbeDuQHuiaWu1hdUqi25s1cKgPx6DvzTDJ1oEUc
	gC9I+LWoWdjKihAnCmp/3wF90mm1CW3AbN8bw51W9YktdO//tL4xWLkYlzGU071gIZvRdZypyos
	QywVrU2fkX9SjTf8714BYL6ncVS0i++FP0Frb+go4okhPLOX2guTcVxUbTXAijJregbVrrCaPAS
	zFK7J9p/UZVlzUwkW8aPzj8gQOmb2bO5hrOZotgWsIa3gYJdVwX2n4icmESuZ6aZnpbspQHrVlq
	x+i1uwvi9cF/52Cvmya9tvzxkiAxWsTiqXj+4LeLFk0cej1nmQc+1NJ/fMSmCNS7xFUVHtOmJGt
	K7Y89dZVQkcwbkyUqcNguY4vzCNPyMdAZXsyZfYCUq5njaMsACbXxbLx08nsAscv9aXFVQClbs5
	0iL66t8Ybzsni9dz7rIS9Dnq9xslGgZtAYbr9Yz9RVjrrA68V0=
X-Received: by 2002:a17:902:ea12:b0:2ae:575b:2345 with SMTP id d9443c01a7336-2b0b2a3f61bmr1084935ad.9.1774407601650;
        Tue, 24 Mar 2026 20:00:01 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:5267:b1e5:66fd:936] ([2a00:79e0:2eb0:8:5267:b1e5:66fd:936])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bc6881sm16083424b3a.22.2026.03.24.20.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 20:00:01 -0700 (PDT)
Date: Tue, 24 Mar 2026 20:00:00 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Jann Horn <jannh@google.com>
cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry.yoo@oracle.com>, 
    Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
    Christoph Lameter <cl@gentwo.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    "Paul E. McKenney" <paulmck@kernel.org>, 
    Joel Fernandes <joelagnelf@nvidia.com>, 
    Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
    Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
    Dmitry Vyukov <dvyukov@google.com>, rcu@vger.kernel.org, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab,rcu: disable KVFREE_RCU_BATCHED for strict grace
 period
In-Reply-To: <20260324-kasan-kfree-rcu-v1-1-ac58a7a13d03@google.com>
Message-ID: <a77995fe-4fa0-3b02-6800-3e5a98c800bb@google.com>
References: <20260324-kasan-kfree-rcu-v1-1-ac58a7a13d03@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Mar 2026, Jann Horn wrote:

> Disable CONFIG_KVFREE_RCU_BATCHED in CONFIG_RCU_STRICT_GRACE_PERIOD builds
> so that kernel fuzzers have an easier time finding use-after-free involving
> kfree_rcu().
> 
> The intent behind CONFIG_RCU_STRICT_GRACE_PERIOD is that RCU should invoke
> callbacks and free objects as soon as possible (at a large performance
> cost) so that kernel fuzzers and such have an easier time detecting
> use-after-free bugs in objects with RCU lifetime.
> 
> CONFIG_KVFREE_RCU_BATCHED is a performance optimization that queues
> RCU-freed objects in ways that CONFIG_RCU_STRICT_GRACE_PERIOD can't
> expedite; for example, the following testcase doesn't trigger a KASAN splat
> when CONFIG_KVFREE_RCU_BATCHED is enabled:
> ```
> struct foo_struct {
>   struct rcu_head rcu;
>   int a;
> };
> struct foo_struct *foo = kmalloc(sizeof(*foo),
>     GFP_KERNEL | __GFP_NOFAIL | __GFP_ZERO);
> 
> pr_info("%s: calling kfree_rcu()\n", __func__);
> kfree_rcu(foo, rcu);
> msleep(10);
> pr_info("%s: start UAF access\n", __func__);
> READ_ONCE(foo->a);
> pr_info("%s: end UAF access\n", __func__);
> ```
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: David Rientjes <rientjes@google.com>
