Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F70153BD9
	for <rcu@vger.kernel.org>; Tue,  6 May 2025 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552780; cv=none; b=HH2czpA7zGsKlGInVeCAggiyyPsvDf5GylU6XE3XcynlcOckfKh2OwrDMjh6iLgLsJid0mS50a+MHKLuByKGcdXuz4SMzWNB9itYQeJRi1p7CJdNS8yEdhQO8AJR0nJNUCmV26ylPO8vB4D3V/zZlwixyNyEZgCm1iERn2x9Ipw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552780; c=relaxed/simple;
	bh=LalzK4CX9LfkUFa4w5FknR7IbwVA8GYrWliRe1t3UQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQVKtSyg/kXfeqX3BRKFsO/uknEalTY+qlkAMsIMi/K7UgnnRjlVEG+ST7+I8NIKF9pUFqqzHiV3RSdq0Q/zY81qmg98EGtdZj5JYFEEyuiuI7TWPCFDzjTSdY/00vUGEkx9ktkixyrL0I4infxrSThErFVGwxW5zLSlCXjc1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IMxLx5Ug; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IMxLx5Ug"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47666573242so15711cf.0
        for <rcu@vger.kernel.org>; Tue, 06 May 2025 10:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746552777; x=1747157577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3MSIo5Nl0iHVat7aILeomKDUxy2gPnZ7VSQWasqUek=;
        b=IMxLx5UgXDlZXRRj8mKa0GIu3j8hcvfh4oDY2n8sXeebT2wcPQc5qcfxYWY6i8JPqC
         sHYBsK5UdZAT92lRz65+MNQVZMp5Ml/t5yeF60ron/rskcxb6HfSLj6evwvOJo+6J+3q
         tlDCR9aIspykVMEmRYsOaV16tMCWZKcH0yU4uqAMg3CbA/rW8zjd//9DtE/1MMrCL8zZ
         Hip3kXRqClRhjWEXIAIGGtyddMt0Tgj/oaVIh/8G7aba0kk1TxCFK/YU7tZctzXLXUie
         e1poTMW8Mr3Rbz9euHbhgRlhbiTgTm3u7fFdwmqibHcUvDB046quyff1G6Ndp57lAlPB
         x1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746552777; x=1747157577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3MSIo5Nl0iHVat7aILeomKDUxy2gPnZ7VSQWasqUek=;
        b=N+6uGJZVm8/UAqvQ0wDiEWLBF/I128doVgSsropUX6zft1sl5iw5KmgdIe5dF/QAIR
         lhrmO5SWTpMdkH2aa1FoEH2qdTUKvPjXX4ZN0Cit8R4Sn9NeDxxNpB9fG4OGl9fXBOIY
         2qMdLqiRNZ26m6qosvYIBLidiZ1wnr5Muxxv0oR0vp5ZS6cKijsfsk6VQeaNrQR+6bwq
         a2buGh4wdRyXFrQBCji/7VlPYReiZEHgpQqObxv+LSuvgjnajkXFivuBoG6eic/tXbf0
         g9iB0rDSW8s0cdVsHBpBjKgnfZpZFByNcx3+SAvFFiC9vldxnNhGrePEM+GJh1jp41T+
         13Hg==
X-Forwarded-Encrypted: i=1; AJvYcCV8BZ/ttmR6uxtBknucvCvOhXtX2Ft5zB9VNQtCakZV1lpzDXDSfuujbwH+SBqIi1pFisk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo++0Cn0+eJtKavg4c61g5TmpJ63sKQ8zhVmRRCxIdX7VcZeYF
	qzdsbD1uZtrLZw0zCusl/97EVTfaPFWDmlpBOw9XwvYrF/rGg0z8BvliYvV4MFgEh7McW2UyCZu
	c3FilSp3hAV6272Qq8PBN6Tn9f7ZN3ld7/Rek
X-Gm-Gg: ASbGncvKCdfE9hKs0mU4/dxTGM7BYPTZ+gfLPBb95iXhSeGpjzyNldcp5mO+auCKypl
	9Oh/kSW9dVR/6+VEUeu0jPANOiJOerW9PBIZaQyYONS+YSPoORrCLZhNNpA10qPyKMd1GznrRJs
	9sXm9IlZDXLE5+aLGLzz/f56aHWmYQW3Ny1lNaz7pEPulgB746DyuOALBk7MvCHA==
X-Google-Smtp-Source: AGHT+IG98g81WgMXXkuAILhcqwl2dPFyZHQOV/uqvjQbRfFtgeXEIDp4J9+Lt9m0P4v6pl5tN+tZqWKjP+Q0giH6IS4=
X-Received: by 2002:a05:622a:316:b0:48d:8f6e:ece7 with SMTP id
 d75a77b69052e-491ff65fdeamr987151cf.3.1746552776442; Tue, 06 May 2025
 10:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
 <20250425-slub-percpu-caches-v4-1-8a636982b4a4@suse.cz> <142aeeb5-d6d8-84ca-e7a2-ba564185c565@gentwo.org>
 <4fa1f4fb-4148-45e8-930c-1175ce212cab@suse.cz>
In-Reply-To: <4fa1f4fb-4148-45e8-930c-1175ce212cab@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 6 May 2025 10:32:43 -0700
X-Gm-Features: ATxdqUH4PjzoYVBacL_EtNXCAZRGtR6y5A7WTiVQvBIg3V1k_Yt6rSRk1bOT3XE
Message-ID: <CAJuCfpFe3SeY1EX=X4+wAm33Z3a0d_SoynK-86s5JWjsK80t_A@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] slab: add opt-in caching layer of percpu sheaves
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 12:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 4/25/25 19:31, Christoph Lameter (Ampere) wrote:
> > On Fri, 25 Apr 2025, Vlastimil Babka wrote:
> >
> >> @@ -4195,7 +4793,11 @@ static __fastpath_inline void *slab_alloc_node(=
struct kmem_cache *s, struct list
> >>      if (unlikely(object))
> >>              goto out;
> >>
> >> -    object =3D __slab_alloc_node(s, gfpflags, node, addr, orig_size);
> >> +    if (s->cpu_sheaves && node =3D=3D NUMA_NO_NODE)
> >> +            object =3D alloc_from_pcs(s, gfpflags);
> >
> > The node to use is determined in __slab_alloc_node() only based on the
> > memory policy etc. NUMA_NO_NODE allocations can be redirected by memory
> > policies and this check disables it.
>
> To handle that, alloc_from_pcs() contains this:
>
> #ifdef CONFIG_NUMA
>         if (static_branch_unlikely(&strict_numa)) {
>                 if (current->mempolicy)
>                         return NULL;
>         }
> #endif
>
> And so there will be a fallback. It doesn't (currently) try to evaluate i=
f
> the local node is compatible as this is before taking the local lock (and
> thus preventing migration).
>
>
> >> @@ -4653,7 +5483,10 @@ void slab_free(struct kmem_cache *s, struct sla=
b *slab, void *object,
> >>      memcg_slab_free_hook(s, slab, &object, 1);
> >>      alloc_tagging_slab_free_hook(s, slab, &object, 1);
> >>
> >> -    if (likely(slab_free_hook(s, object, slab_want_init_on_free(s), f=
alse)))
> >> +    if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s)=
, false)))
> >> +            return;
> >> +
> >> +    if (!s->cpu_sheaves || !free_to_pcs(s, object))
> >>              do_slab_free(s, slab, object, object, 1, addr);
> >>  }
> >
> > We free to pcs even if the object is remote?

Overall the patch LGTM but I would like to hear the answer to this
question too, please.

> >
>
