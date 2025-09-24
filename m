Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADFE2D97BA
	for <rcu@vger.kernel.org>; Wed, 24 Sep 2025 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758732789; cv=none; b=Pv/vifVOJKKAjVWEepuI8CI/j/Gi9oF87FcTBALSvnYcLG+RB0qBXSjEmK/a4wv4EiCL4+lJHUp8gebtYGb05OxV+RxLA+QSd32Y0ZdPsNhDLhpJvhD7v6XcOPkVmYWAh8ppD1vTBUfWj41+Apk9q2nHNRGL2FFg+zepVnOu4Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758732789; c=relaxed/simple;
	bh=nMKNSlgd+7V+f9mWKnNERKzzRCQYc2/BYVK3sw3Dg48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1A9CuBsxJ1qLhC3WuW9L583x2nsjQcd0cTvSLxkJ0QEd8yZxFi6khkgTKyg+l253V8JNmf85rAxxsiyctpDZk4ddvaSiyVrtvL/hkar2lghirNZyenn3ZMtFkVrcX4Fwdrim8GUXyJ2l6oryM3RL5mMnEnZjzaQcXzZ2YFfccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DPW1E8Yw; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPW1E8Yw"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b78657a35aso697611cf.0
        for <rcu@vger.kernel.org>; Wed, 24 Sep 2025 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758732787; x=1759337587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAL5Cu+UfMQz37OQN1YYrMC/83wElraN+KKVT4FmBP0=;
        b=DPW1E8Yw3QdSPQvHnYln+GZgMDUMuVvYyWbSMfcRif/ZD3NBnWpfLzwVZlr+ThLc5/
         cHmevYxRB/NhIA4Yuc6C0SH9QZ6eibastWiHkUItYXocXRUs4uTrAevZXUGlbqgQW6pR
         LwQYrXMAk2KizIQCxoQj+AU8NmrCelMyRszZFrTWO2LcsKHxFNlRcCpsK7qDtlROrpNF
         Gwd/Et9s7PsEppE3vW2DH2HsqQ/toK4tIsMKl8NpExdimxH4Fa1TwgnN+n3t+3jL7Ek7
         VDmG6MICHvUgHZ7iz+jPghKBF7b6JjtRBmuBKJZakmN6P+AArSI7xy3YUkBNMDiynsu6
         zUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758732787; x=1759337587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAL5Cu+UfMQz37OQN1YYrMC/83wElraN+KKVT4FmBP0=;
        b=aY4G1UPleSX37WeT0T5bG9kACGY6SUFQCnEOXPq1pBfo6Qns9exttwXg0elzLBVP+J
         BsxdsPxruLlZA52L7fZ9ICKJRxXchXdPGPTdctezjgsmTOO5WOhfZekkRJU6AsiFqK9D
         ifZT+q+tgOSRzztrc0Z4XjTv8nU6kQ1jr8TeLjgI1Yj6rdJn64HACf9+qYQse/mDVra/
         ClpKcFQ9Mvh0MTcUULYoRLtvCSpawCvjNeT6ByR5TZw3kRMu/xF1osXZd5alaa1eEgSg
         oTRd1UDsYfDGVefoFmVFfHtBtqAavtguvGGPTTse0PQX0hQa/UZB/eBqv2Gq7PE6U+Bp
         6AdA==
X-Forwarded-Encrypted: i=1; AJvYcCVXUhHc7+ZUCgExZXxq9DPTagRS9tVuMSRWM7745nIdobHgynC9nbb/JFr6y8jG/mPL/N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwymohCYRtnyx02F2lnI8W3kOUhfPogADN0HV/jAmsVGHwrG6OU
	jrn70XMx+8yy00F9c9hnCoaMhn6il2SlU6mHJlgdQeOZtDsLPFcUgCAhZX+8qbgeMFrji/sgpJ4
	C4a3hzHxbGWR1CL8Vn/44PdagqazR+B1fzSIeDXx3
X-Gm-Gg: ASbGncv8LtSWZyCLUn2HIibFvCAtjXZgNtnEfi9pEywE9CkSFw3cTl/pWCxD5jtJvAc
	Z+O5P6BQWSkysZ3hIPX30TWr0nUVVVcrGvNoQrQE6wvtGd1peeBAOIL8F+1h37I+73j3ATacnwF
	V9aIoWL+WtzFVARTWU0Km7PruFkrevGwf0Kscl95wGqRqkPDUCC0mZCgwH1vmmXcKeWqV9bzHPG
	EJWuxAaj+MMS3qjYH5TN5WxP8Cz/aLY7nX4qAPM3XFgzyp1SHwc
X-Google-Smtp-Source: AGHT+IFM4bC1CM0lReVKUj4FdqmsLyiIGG5AgB26WGF7py0Fxnl1epvOibVW8GFjcF4KFlPv5Uc4yba9NX1j26NP/mY=
X-Received: by 2002:a05:622a:1819:b0:4b3:8ee:521b with SMTP id
 d75a77b69052e-4da23acea56mr1381191cf.0.1758732786627; Wed, 24 Sep 2025
 09:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz> <20250910-slub-percpu-caches-v8-2-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-2-ca3099d8352c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 24 Sep 2025 09:52:55 -0700
X-Gm-Features: AS18NWAeKekoZw_EZc6GYInUxqn2E30S29JpUuV_6-vLoJBFCrPesQlPq9v554g
Message-ID: <CAJuCfpHzNyQw6N5CjfNXsMLyUQem2noSm+_A3O2gm+skA7qDsA@mail.gmail.com>
Subject: Re: [PATCH v8 02/23] slab: simplify init_kmem_cache_nodes() error handling
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> We don't need to call free_kmem_cache_nodes() immediately when failing
> to allocate a kmem_cache_node, because when we return 0,
> do_kmem_cache_create() calls __kmem_cache_release() which also performs
> free_kmem_cache_nodes().
>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slub.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 30003763d224c2704a4b93082b8b47af12dcffc5..9f671ec76131c4b0b28d5d568=
aa45842b5efb6d4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5669,10 +5669,8 @@ static int init_kmem_cache_nodes(struct kmem_cache=
 *s)
>                 n =3D kmem_cache_alloc_node(kmem_cache_node,
>                                                 GFP_KERNEL, node);
>
> -               if (!n) {
> -                       free_kmem_cache_nodes(s);
> +               if (!n)
>                         return 0;
> -               }
>
>                 init_kmem_cache_node(n);
>                 s->node[node] =3D n;
>
> --
> 2.51.0
>
