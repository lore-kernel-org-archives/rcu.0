Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47F52848A9
	for <rcu@vger.kernel.org>; Wed, 24 Sep 2025 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758732576; cv=none; b=r3MacqF6mHO6FSJtV0fr4vRj+m9P8ZteMenCEokmOYmqrtW0P2z77ck4k8rB6KXk9rO4mw0/ZzLW9uvy9aBD8ckRf0KiTlj4St+TAH6C5uN61BjHljYHim5OY/hVftm7R7SYL6NdTicPgUaKohFnn1i25xkA/MPw1LgqJ4WyW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758732576; c=relaxed/simple;
	bh=i631qAijwETG12yrH4H3BbU91qlt5cJOWY9XMqxvPAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qbvt8SxuZcH6/fq0Q8Jr2DtSHKAqqc9uwpx0NI7wKLir/irpTf1TqD3fSPAxU6YOwEU6104XzQPCj1anUvnLDny4vbcWy0E6SXCViryff5nlh0kWfu3rACQFcMV0EMoQ4WfmeVgANw85KRKZLNABS/uXF8XNy4llvdR3Id/zaJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XtUBN6jZ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XtUBN6jZ"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4bb7209ec97so613041cf.1
        for <rcu@vger.kernel.org>; Wed, 24 Sep 2025 09:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758732574; x=1759337374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JvFELxPCxwY74AcuaB/2r4NripPELBrPEQdEr+31uM=;
        b=XtUBN6jZfbf5FeCOa72rCsBPZSJaylqONMQNErCwCclqllIWubI66NJQ5wKn+F8H6j
         i3W//Bpkt3rRZAe1+XcA850XfLQR59UwRiyUPAVyATCvAES6HYUluuyugFr0DSMMoZrW
         UUIKbXIU0g5bnlJ6dxrECHyxHGOMu5Xe2bs6ZiO1Iy9BRZ4WItauhTODS7laMkjh8+Td
         1ZWBbXAYVBWZep8AxT7RpafpXmNfWGUEGUH+2pcT9jHWhozh2ue0BU92KBl/jPWfav/7
         xdxo7+Z6ciriEHdWAQ30rZMnVgInxc1U2antwdq2WG4CQ6RyaJb9Ce12MLTE6jPJGk1J
         tLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758732574; x=1759337374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JvFELxPCxwY74AcuaB/2r4NripPELBrPEQdEr+31uM=;
        b=LwQ1+KDVxDasfKjU0dMmLc52Cna/kRGWPTQ58NU2H2IIvP8ARak+GUHSdsMzwDglST
         DtFLPOBtfRtyJu4CkyZ70J/rOyerBFdYo1UCR3254epzYpVKAwFg85NAaNfwu7ynYQyC
         IrO+j7vMJ19NH17lPzm9qQo7JS+I/cxosz1IKih3+gTzAhs/YjfudWbfsxQ3I8rPSeIz
         lhprz7mz/nXxTb8fOryYY7YBpBGXqRRnLU8NwNDnmX6EWfmKTyAj7yJmjPOI8XLXEtWI
         Iz0ODLZ86NeiYwm884nLu1Srq5Bafr1i9HxB3alWvVRuNlLRGLEmD4TbZf7q/anXL/m8
         o+kA==
X-Forwarded-Encrypted: i=1; AJvYcCVDrinMOhI7uhVFFVSOZbH33VDbmUb40+WposOnbhbJewH3u0qqZWaXBFoQq+JHO2eda+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyKipPvRZvSz8CtLqEGpVLk788xT3+jC+fYXcZUm1IxjDH9E9K
	bnqOoGppdc8Fv66FbRToleBCjt/MG8daufSh/1Pm9h3REyOIJQ+gqLHxFciGp9dVz1QXd6bPyRu
	Av5JKUDKTHL9vM77deErybXjZNXG+pyiB67e2qPOP
X-Gm-Gg: ASbGncs1w6WdCgvN0XtHWn8QTaLNH5f6yEVk2vLmJtaHKEB9D0WZbcwVVLRqFcB5r7j
	wIyLyKmCw5hRTvMmtsjRW35YtdEH1L4kjP22GJ4Qz+oPkk2+eTzcUo9PCCYdJ+bfYH9IzhIHu5R
	SWpeFATWezJajRSYDbj5EC7SDyNfj/vJhAghdA9xRc5t1BVE0Z2eHuaTtuWmEeS1Je4tihrXgjA
	okerdC74LAC4Qn49mMRlSWkRIfEd6MA2HYtWRlP9Q==
X-Google-Smtp-Source: AGHT+IGMhOROnHAHwCWHqP41TFW4SwH3fT102kMQ13CWu7KInQWNKqQYfl3q0oAPFRaFbRuo/IaOLBDDK9OLZu1oDik=
X-Received: by 2002:ac8:5996:0:b0:4b6:2d44:13c4 with SMTP id
 d75a77b69052e-4da2f12a974mr1030921cf.10.1758732573085; Wed, 24 Sep 2025
 09:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz> <20250910-slub-percpu-caches-v8-1-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-1-ca3099d8352c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 24 Sep 2025 09:49:22 -0700
X-Gm-Features: AS18NWCIXTS-bjNMv6stOKe8Aj5QIFYPyCiaTgRjLhznKLAkt4P5WJ5syBfmC9U
Message-ID: <CAJuCfpE0AQ+59=PLb0xWK28NVAn_BxG-X=EPxy+dcRn2xWb6=g@mail.gmail.com>
Subject: Re: [PATCH v8 01/23] locking/local_lock: Expose dep_map in local_trylock_t.
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> lockdep_is_held() macro assumes that "struct lockdep_map dep_map;"
> is a top level field of any lock that participates in LOCKDEP.
> Make it so for local_trylock_t.
>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/local_lock_internal.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lo=
ck_internal.h
> index d80b5306a2c0ccf95a3405b6b947b5f1f9a3bd38..949de37700dbc10feafc06d0b=
52382cf2e00c694 100644
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -17,7 +17,10 @@ typedef struct {
>
>  /* local_trylock() and local_trylock_irqsave() only work with local_tryl=
ock_t */
>  typedef struct {
> -       local_lock_t    llock;
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +       struct lockdep_map      dep_map;
> +       struct task_struct      *owner;
> +#endif
>         u8              acquired;
>  } local_trylock_t;
>
> @@ -31,7 +34,7 @@ typedef struct {
>         .owner =3D NULL,
>
>  # define LOCAL_TRYLOCK_DEBUG_INIT(lockname)            \
> -       .llock =3D { LOCAL_LOCK_DEBUG_INIT((lockname).llock) },
> +       LOCAL_LOCK_DEBUG_INIT(lockname)
>
>  static inline void local_lock_acquire(local_lock_t *l)
>  {
> @@ -81,7 +84,7 @@ do {                                                   =
       \
>         local_lock_debug_init(lock);                            \
>  } while (0)
>
> -#define __local_trylock_init(lock) __local_lock_init(lock.llock)
> +#define __local_trylock_init(lock) __local_lock_init((local_lock_t *)loc=
k)
>
>  #define __spinlock_nested_bh_init(lock)                                \
>  do {                                                           \
>
> --
> 2.51.0
>
