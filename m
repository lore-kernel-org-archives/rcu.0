Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BCC143C45
	for <rcu@vger.kernel.org>; Wed,  7 Aug 2024 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057955; cv=none; b=c4UnRICp9p6wmtRXGz3nsuZixGwepetKnspJsIIMJGw3RNM7+pIDSiKNdvDetdvD707SYrVx5lF0uMIfvy38KmPd8nafKPy72yap74EssJsSQR4iE3LxmoCz2DVwUGmNvl0idyKnD9rCRyDOufuU+W1cZJPo9czVs3CWTVJmhj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057955; c=relaxed/simple;
	bh=TZmc//vzgWXo1JCuuQnsejz5TEP5eZApTnDweP28nSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFpm80Bf8cN+A2jT1IpjW6aZo+EbPP0rLDig4qe4LtM4GELZ6stL+r2UISnsLGfU8cdFNcK6bv/w7FumBlt66R07njtFJzg+eUsIYx43dc2vtAxf6qNTW6VrPtFz76U2zzAA212Y3mWu7dfaCdK6BaS2Uor4j+nWziG84IHMXPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHf92pUD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHf92pUD"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so104a12.1
        for <rcu@vger.kernel.org>; Wed, 07 Aug 2024 12:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723057952; x=1723662752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZmc//vzgWXo1JCuuQnsejz5TEP5eZApTnDweP28nSI=;
        b=MHf92pUDes+JismALbCqlNH50RJcmj4isqGP+zAdSn2RKv+xyCBcJ1kbdrb8zcXbZ/
         x63+SbcnFaWUAno8v4ZmUXUZeyluG0dM9JnkF8WRWZy/PhEq6MKEO4kgjiKm1pkMVG6g
         tSvt9B9mHnA/URvLlXA4b/DjWsNinSfxo+V31MeTQA5n7fjPPywjG9VZhY59qIpja/Bh
         SkypbhXBJLnd9QZir09qucOwq8eNkDplkkg0732/NENCGveVFL8o7VepP/khm76Do2wj
         dGEHjx2LYx7RXdU0h9s3cm1oE+IIsTUgaDd8SmL+HGMaBUihP9oRg7UfG2+0sGmOhFpz
         9yYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723057952; x=1723662752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZmc//vzgWXo1JCuuQnsejz5TEP5eZApTnDweP28nSI=;
        b=U/f/zNeEjEA7nux/1/JenlI8Wr+YERNbsyrDypJ5DP+yCM6lry8Nd0VmFmn1sea6iH
         MlkM6+wDWEUQUbQ6hPWEOmWS6hH/Fradr9WDm5Sf6bGmtjpyIOPuLfQKfRybwsxTIHHt
         hXgOsSohZOfhWxD84LJ0mgDu1A7KdsltOJS5ii24LysVvBsTXlFdBhaCtKWPdJulelmk
         vRkm6HlvBrgbIDbFkYYYM2RMADByz4RUGVvWg6qbz47yItR3TnjSSozJSVG0KWvI686R
         FUE4EdghN+7YtFZi52XlAvTLGpw51zbZNKc+fKEWDy1dwhyh93cKozwi0I2ZDGA6TYLW
         Z2vg==
X-Forwarded-Encrypted: i=1; AJvYcCU/zPbgfEExVHLPf0OBsPstCA18mVXTgJNpe/vmKSun/GRUIvT3TNU9i2XKU5qlXnboJOQ0jIvdPCuUtwDIoxb+P8Kj
X-Gm-Message-State: AOJu0Yx6fzbxOIzztbpuI5iwUd/JUBli3Elk6eU+YC84ZOg5pKlcy/2g
	RVU6ZoGC2zBfAK8oeQh3lOUFSZUWZT9QLiYhC2ImyjRQIxgX+Bvik/on6hDm6138MH4A2sxVGaG
	O9FkK06MmmA3P9x2eJNVDyIVggAOENkXjhGFU
X-Google-Smtp-Source: AGHT+IEWsir3HEKnOjK+rBAIzUOG5Z3eD6jzI+A9vec1Y+JEUjH8OsnE80fEMcreoSJa6HiGM0YfubeWsAYKupDvuRU=
X-Received: by 2002:a05:6402:254b:b0:59f:9f59:9b07 with SMTP id
 4fb4d7f45d1cf-5bbaff955fbmr27180a12.4.1723057951910; Wed, 07 Aug 2024
 12:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz> <20240807-b4-slab-kfree_rcu-destroy-v2-4-ea79102f428c@suse.cz>
In-Reply-To: <20240807-b4-slab-kfree_rcu-destroy-v2-4-ea79102f428c@suse.cz>
From: Jann Horn <jannh@google.com>
Date: Wed, 7 Aug 2024 21:11:55 +0200
Message-ID: <CAG48ez2jKFXxkMhq-Q7-WNHp_FTYL7yOpCQa8e_yFDm05e3Few@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] mm, slab: reintroduce rcu_barrier() into kmem_cache_destroy()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Jakub Kicinski <kuba@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 12:31=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> There used to be a rcu_barrier() for SLAB_TYPESAFE_BY_RCU caches in
> kmem_cache_destroy() until commit 657dc2f97220 ("slab: remove
> synchronous rcu_barrier() call in memcg cache release path") moved it to
> an asynchronous work that finishes the destroying of such caches.
>
> The motivation for that commit was the MEMCG_KMEM integration that at
> the time created and removed clones of the global slab caches together
> with their cgroups, and blocking cgroups removal was unwelcome. The
> implementation later changed to per-object memcg tracking using a single
> cache, so there should be no more need for a fast non-blocking
> kmem_cache_destroy(), which is typically only done when a module is
> unloaded etc.
>
> Going back to synchronous barrier has the following advantages:
>
> - simpler implementation
> - it's easier to test the result of kmem_cache_destroy() in a kunit test
>
> Thus effectively revert commit 657dc2f97220. It is not a 1:1 revert as
> the code has changed since. The main part is that kmem_cache_release(s)
> is always called from kmem_cache_destroy(), but for SLAB_TYPESAFE_BY_RCU
> caches there's a rcu_barrier() first.
>
> Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Jann Horn <jannh@google.com>
