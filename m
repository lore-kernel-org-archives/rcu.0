Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67194A921
	for <rcu@vger.kernel.org>; Sat, 27 Sep 2025 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758931621; cv=none; b=Br/L5OtxjCjY+o5StynCp5Cz9hFDdk9Zn/57SlsjDSV37gSJr+AYH9tklMlmjCpZTwkugeJTtr2G4+fhhPF5286t3YimCpNlPySk7Ro5ufH0ItN88nbhRXnZs/U2nNg60PpbPMZt61C1QxbVFXyGd6jTTlmDY3NWo2jydl/5rcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758931621; c=relaxed/simple;
	bh=036aeQxb7WNVe5QUIlOs/NMHl2lCy8OynAYON6MVBhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2P5sniLaiiWJvMHjryhDShDO2RPD6OzxM17Un6Ebz2AJ5I+kn7mGFN5NVyH70YrpyZU8csLQX6ySIrJJdJg7GE6GDJb+r6d/hAoC60t0lur/0HAiSvaKqniN2d/+a7NwOa0PnAJD8+cwcpZv+MLpGr14WjFIpgmth6hYLS6wlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iAFm10NW; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iAFm10NW"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4de66881569so147061cf.0
        for <rcu@vger.kernel.org>; Fri, 26 Sep 2025 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758931618; x=1759536418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29URIb6wX4cuu5zaywUpqrFkDEdk6T+tY2Shq6upRwU=;
        b=iAFm10NWDG+D0DP1zUtX6acT+eMGOBp9HEnBTw3CDbsPjO9nHeUN84pWFbkV8WDmAs
         NcSBF41JosPbTjagiYkkE8rFDrwOPo/hm6eqprvyTp2/B9ANP/UtmRAoiZcZgW+TMqp8
         uGS3A89NCaXX+MZfQiGGpH+KLKbujaFlQ9YiU4NQCXgQ4HZjAOHm9AtC0AGLnVwpQMAl
         wwo2xWmIFP46pNGtnvK5ZIyEc3y6wzExld2xqZaEo3J/r4Le/U2r8n0cL20URCvswJhb
         f/r4GKiGtviMfoRxKQYKVPnsmB0zpKvVqJHR24/41SoTEy3LCLbCjnjWc6EijxERRchn
         MLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758931618; x=1759536418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29URIb6wX4cuu5zaywUpqrFkDEdk6T+tY2Shq6upRwU=;
        b=l/ecVlG5Un3cFwams+QL/6a8LLOcfVAF2TK9GXK2GgaLasX1B5qnDoHi5JOK1sXuC4
         rgeigVFKat/w5o4bwUH+6PKZkaapbDW78szIsDsXp5SeecBQ+e3weJEFA4pewT4E0ywn
         dQ/KKO1SHqCe2pvCF2Oa4ASYMH91LNItyXrBvBekILPJRFUna7LstKxaKenHyJ+ht++S
         AzgJtoVE/oTkth7e72kn3e38bjWpvkfQKEda6DJM8kNxUcrlIx225LUWLXsqedQX4o5A
         +1RWtPeXN9M2hfVR8l1hintvGLazKYL3t9EUEdBKpfAOkF7ECTyn5jsS/+pw1mTZ6ekB
         tKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8Ou8OjJ/dFdgBpKsbZh8SMtEMSGJvnxDvhKNBqTsG+9bZ4sGqVp6xY1ImmUtirGLLeIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiGPdbF7AdoshLogEYVKEQmyMgHRr+LYLlnlDbLFIqER87Pz6D
	6811b8U/K4g6jlDL+Uor8tSBXWgDTx+iNWuqHYi659+lejDyVYQYwirQ1R3VlTyWBD1CmGrY5mX
	xtiGreg3wzHTZLGNjLM0lwmo9MHoV71t08LWmgL5c
X-Gm-Gg: ASbGncuOVHjlrmYJ2UlSb49CUK+1rQZdlqgRyDkwl5/2GlFwKLOmrq4WMTdu6We6kMQ
	NePrxYAMHq8bX1ynU5YN6bK7t1AnqDN6lkYm+rc0/vLIaZLSDF/eKcYyhWNEW5nuHDQmk/aYKTm
	+BNonEh26v65eroBnvuOXkf1T9CAKeqZrcpRTdLJfakrOvrHSdQmVgRdW0PJ7UD11ud1Po15SYR
	pXqK9bUyYnk
X-Google-Smtp-Source: AGHT+IFLiPgOBV8XSsUKwdgG6fhVNyESUNEXNTrbN+fpy6JAU34fytC+R1DM6IrlpNVPcOxzkPi/LyegQctKAtiDAEI=
X-Received: by 2002:a05:622a:594:b0:4b5:d6bb:f29b with SMTP id
 d75a77b69052e-4dd1814d209mr9393231cf.8.1758931617891; Fri, 26 Sep 2025
 17:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz> <20250910-slub-percpu-caches-v8-19-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-19-ca3099d8352c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Sep 2025 17:06:46 -0700
X-Gm-Features: AS18NWCLx8WOW3heEQMMsOLSgr3nS73twxKZ6ISWcyS9VFRYNVbTzAIxYGqOzSQ
Message-ID: <CAJuCfpEJ=-=NqmbZpQOGKsxfW1DQsn3_gusQxeJG8E6hVthgmQ@mail.gmail.com>
Subject: Re: [PATCH v8 19/23] maple_tree: Replace mt_free_one() with kfree()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> From: Pedro Falcato <pfalcato@suse.de>
>
> kfree() is a little shorter and works with kmem_cache_alloc'd pointers
> too. Also lets us remove one more helper.
>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  lib/maple_tree.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index c706e2e48f884fd156e25be2b17eb5e154774db7..0439aaacf6cb1f39d0d23af2e=
2a5af1d27ab32be 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -177,11 +177,6 @@ static inline int mt_alloc_bulk(gfp_t gfp, size_t si=
ze, void **nodes)
>         return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
>  }
>
> -static inline void mt_free_one(struct maple_node *node)
> -{
> -       kmem_cache_free(maple_node_cache, node);
> -}
> -
>  static inline void mt_free_bulk(size_t size, void __rcu **nodes)
>  {
>         kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
> @@ -5092,7 +5087,7 @@ static void mt_free_walk(struct rcu_head *head)
>         mt_free_bulk(node->slot_len, slots);
>
>  free_leaf:
> -       mt_free_one(node);
> +       kfree(node);
>  }
>
>  static inline void __rcu **mte_destroy_descend(struct maple_enode **enod=
e,
> @@ -5176,7 +5171,7 @@ static void mt_destroy_walk(struct maple_enode *eno=
de, struct maple_tree *mt,
>
>  free_leaf:
>         if (free)
> -               mt_free_one(node);
> +               kfree(node);
>         else
>                 mt_clear_meta(mt, node, node->type);
>  }
> @@ -5385,7 +5380,7 @@ void mas_destroy(struct ma_state *mas)
>                         mt_free_bulk(count, (void __rcu **)&node->slot[1]=
);
>                         total -=3D count;
>                 }
> -               mt_free_one(ma_mnode_ptr(node));
> +               kfree(ma_mnode_ptr(node));
>                 total--;
>         }
>
> @@ -6373,7 +6368,7 @@ static void mas_dup_free(struct ma_state *mas)
>         }
>
>         node =3D mte_to_node(mas->node);
> -       mt_free_one(node);
> +       kfree(node);
>  }
>
>  /*
>
> --
> 2.51.0
>
