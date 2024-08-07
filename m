Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB4F1448E4
	for <rcu@vger.kernel.org>; Wed,  7 Aug 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057949; cv=none; b=I1xQyJawuN5VUIJLnuJm70F4u0H648IyFdnub4gGRn98lGay8jV5bwxT8TM2+iCfdZuw++dQpz+21RxylYwqrltJYFjA38B2/H+H+IlwUbT+jItsn07a2Uclzq7bu7Hs4YYN1lsqNsuRHkxiSoczc7O2chEQ22Hzodfne88KQHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057949; c=relaxed/simple;
	bh=1WLs4U4pJAgrGVVsxUErTGOk4QX7JD1FuPYUe1vFarI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jkj08VXJ6SypGrtoq9Pgwkt8D+uimLriULHPj3jt4DomlfThSf4Tg/xKAMkTy92vV8cBn4PegbvDXBYlgz8N5NvWBgcJ/65FCOx6sp0f40QL/xc9tzcPK1r0Vh9Ce0MAtnw2yweRaJDkPQLvf01lCpUGZvGxa90DIMHoZlWbULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LBqlN6n1; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LBqlN6n1"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so94a12.1
        for <rcu@vger.kernel.org>; Wed, 07 Aug 2024 12:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723057946; x=1723662746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WLs4U4pJAgrGVVsxUErTGOk4QX7JD1FuPYUe1vFarI=;
        b=LBqlN6n1DqSOctvYRJoWMxJAr+IIzgSg2GsXGsXMEeeeIih8p3o+O1ASWlomnJr/F6
         BO10+tQSqfAKSQ4jX4iAbYJXXUWstdm9OUwSy+3O2chKLgugbKQvoIUCwEOCJPg5b6jS
         iplPvG4FjH/IBetkUNFfGXjHeOnY7SjIqCj1prI8APLcrdrzC0fj5XztYAGhpXgqXSar
         /4X9avdzDb2nnVjpn8jzXjQMhJN6reya+xVrWyBMkA9II8RMWBwPQpR9roxZ7xUJbS/l
         dQRaa0ToAgL1S4jIRYwYzsozWQD4uOUAyUKCyw2HkiE2ugj3LpW0AchOknSXExEPwXr1
         jOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723057946; x=1723662746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WLs4U4pJAgrGVVsxUErTGOk4QX7JD1FuPYUe1vFarI=;
        b=lQttOxEFxcqbGCryWUk/7dbWtHJ1TCwHc+H+LwK18hWJX2JTdQn02+yscYVx3k6mSB
         Oabjj3EBFbvwpxxZaVMUY/UL5H8rv5JL8Px+x9jIvB3hcIihXMmGM98PTdS0p4nTY8ON
         Yz/al0DSGPnlMKbgNEUC0XCvl1hDAlThKbhHZir9LHWKTsPLEqbcI550orcfiqBCiclj
         KViZRa1dE2+lAG3OyL74dNtBOwmkQ4XNbyd6robT96xV6F7eVjzCJf6F2zc+oadIF5Tz
         jNokYueDM83qBycrwUcVx2ds0S9J+juUp+wN+4tyy6dW/mGpCpt2lx6kd7i1PmpRGkNt
         dwxw==
X-Forwarded-Encrypted: i=1; AJvYcCUiNapfCkA6ZXCj+gLfH2qjQ0A9Kbw+dfgAO498azdU0W4XsjrRwHXq6pAk6Me+HIh8qV6YUjPLzEkeOo/10WAAqWh4
X-Gm-Message-State: AOJu0YxG9L+HofeRx+OlV4vDNdH/vxrH46LoCwPQYd+r4nGIxrhQBRJZ
	XfGzsLNbD7b/Z/0v9xKqAqf1OP7+bRhEaNPKEozTK2uRfGOWUT+8YL0zjknG0BYmdDILNs9Gfx2
	FRwOD4JHHYRnlzDMVzm+EdzKzQoH1x5ef1fzS
X-Google-Smtp-Source: AGHT+IHRb+iO/7Xu5LY8bZHYmwguSiyhvHwFPfxn7/tf+k+CbGWx+HjOCccF59nCcoHPtrOSEg81/FkkH0bbTysKMGU=
X-Received: by 2002:a05:6402:40d2:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-5bbb004ab49mr17751a12.7.1723057945956; Wed, 07 Aug 2024
 12:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz> <20240807-b4-slab-kfree_rcu-destroy-v2-3-ea79102f428c@suse.cz>
In-Reply-To: <20240807-b4-slab-kfree_rcu-destroy-v2-3-ea79102f428c@suse.cz>
From: Jann Horn <jannh@google.com>
Date: Wed, 7 Aug 2024 21:11:50 +0200
Message-ID: <CAG48ez0j7qx3mCtQwq-KfkG+nj_k7w9mmwL=FDx_sMSVphhncg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] mm, slab: move kfence_shutdown_cache() outside slab_mutex
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
> kfence_shutdown_cache() is called under slab_mutex when the cache is
> destroyed synchronously, and outside slab_mutex during the delayed
> destruction of SLAB_TYPESAFE_BY_RCU caches.
>
> It seems it should always be safe to call it outside of slab_mutex so we
> can just move the call to kmem_cache_release(), which is called outside.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Jann Horn <jannh@google.com>
