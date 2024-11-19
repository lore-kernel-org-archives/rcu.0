Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51854C2C9;
	Tue, 19 Nov 2024 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983399; cv=none; b=MkXJnHZWQvHv+Jhyw0lLBTdomCiKy9XDrIgHznu8S8l9So9pfql1o+7urJwERmAtnVZZXjUeE4mnGpAAeMPGEcmJJxr9DCkdluD7xOT6QZ+XLdP4CDF6MJkbLjG9zuuXUmDg62kyxCcw8Q5BEQos1xJvtJFYyQZ9JcIV6FW7jAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983399; c=relaxed/simple;
	bh=wTdw0rpt/RuCXG/3r5/Cbtj8C5tC5pnWt9qxgy+ldso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xv+JJblkpqf+FXKBGGSmKeUJcb9dy7AjSaXtews0lJQZ9xvqxn6rin9T6EtjZCbjGqsv5yP6InqfXaiIhzhPwh9UJAzsQpb9hjAaG3JYQTA9GL+ujluCo12+Pv3a58foUwJYvs0ZqY03r2+k48N3RKqLhNLAsfenFEO9YKsvQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ekh6tG5L; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ekh6tG5L"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb51f39394so4602781fa.2;
        Mon, 18 Nov 2024 18:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731983395; x=1732588195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDu2TDDimIym5HIL4t/Fyx220cmR1Bl82M9X+9neXZA=;
        b=Ekh6tG5LJyNzT5Z9QcJ/YQlx5iZ4lqlrhtTP8fUXOMZbkfpRjwzPXvQZXqPOBhjVeW
         09OISK9Hr/bLnkxx/yv9SGsEhyIiZstcFteeJJf35FIyhY+sK7rTID24O4ouDeXmVuBK
         W6zhFtu4sR7U2GJrkDZs/qmiLjfGIwWo8/tOFbmav7dpsTRB+omBtEaVy/nV9N/7omKf
         HsM4/eoHRK+3qNhmka8TFgTLtdpeUrf0qvKUo2xxLDigYflqZYeDJi9sJOZ7j7Ii1KRP
         kXLIdpPoEkf6+4SPvRQ1Eu2ssoPg9pbnklxQhkz3MLwKlEeRCqwEQmgoiU4vf7rx/usM
         ukyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731983395; x=1732588195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDu2TDDimIym5HIL4t/Fyx220cmR1Bl82M9X+9neXZA=;
        b=iSwzdCv76DzAX6Yl8ZQCCy547OFGs2ZRPXVTtKA+D2U3xykNrxngGOkYQkKItEv6F6
         SrLCvN/Ts23d+78y33t+r7EgtvwJiW931BlwaHRZMAQN/Cgf4hB+X5U5CLUBJXp8zPv7
         PpwoUCZbyrr1La/lke7uoLwcc7BKqEEg6u4xIuK2ELS/rBHZzMbfJRDxBvlYjUuj8hKx
         TRtsj2gbWzkMtflxu0eCKe24/dFRLDxbftUgtPooIDtTQFfh5XfisCX1/nsinv+0sz7z
         LKqmW6sE5dDqIUTlyChgsaNt5dcIIZdW0Qanglu5VOS5xDWS1hY4B7yRZF14gKXrhKRE
         qBGg==
X-Forwarded-Encrypted: i=1; AJvYcCWpq/wLohEz/4sGL0iBPIG1YFwopxbssmOaE9CB1VDDGqsg9viW2YXykp0OsbQ1wHek2rJlfhhokvBhA0g=@vger.kernel.org, AJvYcCXrs3aU80UBqfmbiJMOvhlW/31Bywfi0CMpY4bQstWZlR1ZuvJ/eE3sj0XGprr7/fzCiIJl@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ0qKTHZQoWquj8o3QJ8DKCwRg4fVt+t/ugh2XDo9AH2d48qWf
	Ji6uf4BfAaOgiPaYJjH1fSUVpp3HCsNkH4+wc04w4jwmlTATmoQ4bFLKt+E2z9xWoBMfsOOrLNE
	fl84+i1XhsS1O4cPVyl99+sQswrafOv/q/MM=
X-Google-Smtp-Source: AGHT+IElFgWUK61PKPPQAD8gSlLf9PUekbFJYHZdgq5RuTaHPZtmenazC7fFM2ZO4hhOfG7tmksbTAYcNrxOP3bXovk=
X-Received: by 2002:a05:651c:2110:b0:2fb:584a:8ea6 with SMTP id
 38308e7fff4ca-2ff6098d59cmr63348961fa.27.1731983395060; Mon, 18 Nov 2024
 18:29:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112-slub-percpu-caches-v1-0-ddc0bdc27e05@suse.cz>
 <20241112-slub-percpu-caches-v1-6-ddc0bdc27e05@suse.cz> <CAB=+i9QoavVWZ6HxiOb8ypqov0rM+HAK4ge7nKHdQRPUaNPmkw@mail.gmail.com>
 <9dc33d5f-fc04-4780-80ae-3c5f80a8b891@suse.cz>
In-Reply-To: <9dc33d5f-fc04-4780-80ae-3c5f80a8b891@suse.cz>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Tue, 19 Nov 2024 11:29:43 +0900
Message-ID: <CAB=+i9RZra587ik+A-hZtVwzppAt9CsA7oiuVg9QhgEHT=-daQ@mail.gmail.com>
Subject: Re: [PATCH RFC 6/6] mm, slub: sheaf prefilling for guaranteed allocations
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 11:26=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 11/18/24 14:13, Hyeonggon Yoo wrote:
> > On Wed, Nov 13, 2024 at 1:39=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >> +
> >> +/*
> >> + * Allocate from a sheaf obtained by kmem_cache_prefill_sheaf()
> >> + *
> >> + * Guaranteed not to fail as many allocations as was the requested co=
unt.
> >> + * After the sheaf is emptied, it fails - no fallback to the slab cac=
he itself.
> >> + *
> >> + * The gfp parameter is meant only to specify __GFP_ZERO or __GFP_ACC=
OUNT
> >> + * memcg charging is forced over limit if necessary, to avoid failure=
.
> >> + */
> >> +void *
> >> +kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
> >> +                                  struct slab_sheaf *sheaf)
> >> +{
> >> +       void *ret =3D NULL;
> >> +       bool init;
> >> +
> >> +       if (sheaf->size =3D=3D 0)
> >> +               goto out;
> >> +
> >> +       ret =3D sheaf->objects[--sheaf->size];
> >> +
> >> +       init =3D slab_want_init_on_alloc(gfp, s);
> >> +
> >> +       /* add __GFP_NOFAIL to force successful memcg charging */
> >> +       slab_post_alloc_hook(s, NULL, gfp | __GFP_NOFAIL, 1, &ret, ini=
t, s->object_size);
> >
> > Maybe I'm missing something, but how can this be used for non-sleepable=
 contexts
> > if __GFP_NOFAIL is used? I think we have to charge them when the sheaf
>
> AFAIK it forces memcg to simply charge even if allocated memory goes over
> the memcg limit. So there's no issue with a non-sleepable context, there
> shouldn't be memcg reclaim happening in that case.

Ok, but I am still worried about mem alloc profiling/memcg trying to
allocate some memory
with __GFP_NOFAIL flag and eventually passing it to the buddy allocator,
which does not want __GFP_NOFAIL without __GFP_DIRECT_RECLAIM?
e.g.) memcg hook calls
alloc_slab_obj_exts()->kcalloc_node()->....->alloc_pages()

> > is returned
> > via kmem_cache_prefill_sheaf(), just like users of bulk alloc/free?
>
> That would be very costly to charge/uncharge if most of the objects are n=
ot
> actually used - it's what we want to avoid here.
> Going over the memcgs limit a bit in a very rare case isn't considered su=
ch
> an issue, for example Linus advocated such approach too in another contex=
t.

Thanks for the explanation! That was a point I was missing.

> > Best,
> > Hyeonggon
> >
> >> +out:
> >> +       trace_kmem_cache_alloc(_RET_IP_, ret, s, gfp, NUMA_NO_NODE);
> >> +
> >> +       return ret;
> >> +}
> >> +
> >>  /*
> >>   * To avoid unnecessary overhead, we pass through large allocation re=
quests
> >>   * directly to the page allocator. We use __GFP_COMP, because we will=
 need to
> >>
> >> --
> >> 2.47.0
> >>
>
