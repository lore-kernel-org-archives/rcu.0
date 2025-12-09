Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42801F63CD
	for <rcu@vger.kernel.org>; Tue,  9 Dec 2025 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765273347; cv=none; b=QrKz6MaJpqJM7kOcdE8VrMFAfhwTdjHBA0/rmfn2sUqMxi1BCFuxSG0HIjDbRK4XH6v/1Dbjx11xgw2aDjuKglD4UtvLRxGGh9xQDgwlsZ/2YdTwJviiB+o6sPSRA48gM0pxEGxZ+Xanl+P3M13Pi81uDsbgxkm1nwP6fo5BY2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765273347; c=relaxed/simple;
	bh=06Dl4BC2o9fA4Wcw9j+FjlC5tZ7z92jShAUVpHh6yg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHFzBXLzpjnztXlgFJm6g0GnlkUQYA7fGJ+xLTSxeLJBa35CSMnAsGzmTFi0fvWw2HExhntuoNAwI7OuaaxCxTMERL7mOdUBsQqu7n/Zm1wuuzcO2E1UbTnq9FS3M8/67RCdCniibm1FDxFZlAQRm6aQPl8Ui3dw5rEcQz1lCws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSBLUvMr; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSBLUvMr"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7c52fa75cd3so5171743a34.3
        for <rcu@vger.kernel.org>; Tue, 09 Dec 2025 01:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765273345; x=1765878145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNvOv5ap80hjiFIY9x8LvAyoNUUxftLagOrd7bJRt5s=;
        b=FSBLUvMrSaFKakDPOyGnp2KSkG1AOx1G6KSQBaRi2tLKy9VbYuNCX47q1Nv8d8QV4O
         mb832h0ea7DjcWMZseiJYT89Wp9ZBulLel1JrBQ9FO2ROqugCCPwWTlQjeMIgIux3PLc
         FtN9qsOb2mGl/M7g80D/sEs3qUIQ5N+4D3QzwlQLWnmBWk38XHcUNI3q/nd4oG37825Q
         WNS6pVqrO79GaGmK4s4rl0Zy1761tTbdIcTQnaLG5XbktAJYzs2vYzV0Nx1bc6WXShi5
         pIs81otmFkOnF5dfbLEgyAe3YKiLFlTrr2X0U7KjCJVoQQXGKBblVUBPuaN+xYzrFWIA
         Rkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765273345; x=1765878145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SNvOv5ap80hjiFIY9x8LvAyoNUUxftLagOrd7bJRt5s=;
        b=VFxzrkqU9BkCLxW8hIMVOe7xJBjm23k94GrMO8G4VD7CTIhtjnLy6RCOLziVQZsdKN
         /5xmHlubDBGOIuzzaRDclr5T14E8TeLtWVs3O227skwB41c/W4QNHTnHwc++Gbosb9Kw
         gj4JQQ+lOBFzLqnjNIri6Flg/A33pvZrUgngI/MTtVJY7mZl42hH6K+lsnjyWRKazogG
         5xUcaafbbdxmV0YW09wFejM9TV8/unhhSzvQ6oV2V5KGBRuOKAt8NUfCVQtq8JeIZixW
         2btXbhoEYD7nf5lHZOLjIKtBMFUb47fTxI1mvolngEj1xm/4dnw8c1YC6k6WUzTdf17v
         g0sg==
X-Forwarded-Encrypted: i=1; AJvYcCXmu3GiQ218GXTkiNyDqswkipCvBzuxVIOkBb7YpRYHYnNaAt8PqGIRtEVW9ABX9RlXs0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNgxtNERgILhVcduIcoQHmtzsmyIFumov8XEYh1+Ib6uIHMqgE
	7by0fBv8dVzBgJyYIYH44vpc5+gpdT90jbv1T03zOAu1167DnY6P4K9niCeX9VC6rlXgA+b6RX7
	sM06uuEuXGU+2QkLqjczSr+U/r+7TyHc=
X-Gm-Gg: ASbGncvIjxBTDRZBR3p7cCj8Adzz9dCyFaX/KdBx2m7dyKdvdjjM5e8tircpS2FygZO
	E1t6QI9DGb69SYQCLPgjhtw4RFD7CxCRRN1HKZ+Q+oxVuHQ6kHp30J0sND0nEQWfIEkT3Hc1Vwp
	F25kc2xDA1AFaeplxSkz7Z1RRrlcx3dkLIne5R7M2f6OrvDfHdCdunA+6ZVZGCpmLGJFGHkhFLN
	8cigXutrQ4Wh3UXQBbGbhtQT7xCxsgcUpwPxfkAbCj+tBxapkNwLYV5lO2kR8V5eYJxgs4w+jAZ
	JOv7Pecw
X-Google-Smtp-Source: AGHT+IEvCNY9PoRZ/psQQR1euYnWnbiylmc1HqAFRj4AQQ4xrjBDyK/srqeNWQZArH075I2Rabspr4sS1Upvcmqv3z0=
X-Received: by 2002:a05:6830:254b:b0:7c9:5b7c:8a33 with SMTP id
 46e09a7af769-7c97080bf92mr6489192a34.19.1765273344774; Tue, 09 Dec 2025
 01:42:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz> <lvagftdnxgpyafafl2ish6x6phno6xstd6r3zxffs652lyxzyc@2pbngufu7wro>
 <aS_OrvHmgyhQzQIj@hyeyoo> <dq67tbm6bbvm7opvuq5vwtjjrcnrponmhfv7xwnvpv6vp3u2lv@bkruq4dtx3rd>
 <aTWIQ0s3EbOa0azX@hyeyoo> <8bbbaa65-2783-4006-97b4-a1628525e7c7@suse.cz>
In-Reply-To: <8bbbaa65-2783-4006-97b4-a1628525e7c7@suse.cz>
From: Hao Li <haoli.tcs@gmail.com>
Date: Tue, 9 Dec 2025 17:42:13 +0800
X-Gm-Features: AQt7F2qROshHCUshL1SmwTV9DvzVb0fD3hVLZ0SdtNuAnPqw8T4UFnSqzZ_WVn8
Message-ID: <CAAXMevrc0Xmza_Zo_zjwgqGSqMFw66cMw_uysX7GWDO2Y4VrMw@mail.gmail.com>
Subject: Re: slub: add barn_get_full_sheaf() and refine empty-main sheaf replacement
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Uladzislau Rezki <urezki@gmail.com>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 2:51=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 12/7/25 14:59, Harry Yoo wrote:
> > On Wed, Dec 03, 2025 at 07:15:12PM +0800, Hao Li wrote:
> >> On Wed, Dec 03, 2025 at 02:46:22PM +0900, Harry Yoo wrote:
> >> > On Tue, Dec 02, 2025 at 05:00:08PM +0800, Hao Li wrote:
> >> > > Introduce barn_get_full_sheaf(), a helper that detaches a full she=
af from
> >> > > the per-node barn without requiring an empty sheaf in exchange.
> >> > >
> >> > > Use this helper in __pcs_replace_empty_main() to change how an emp=
ty main
> >> > > per-CPU sheaf is handled:
> >> > >
> >> > >   - If pcs->spare is NULL and pcs->main is empty, first try to obt=
ain a
> >> > >     full sheaf from the barn via barn_get_full_sheaf(). On success=
, park
> >> > >     the empty main sheaf in pcs->spare and install the full sheaf =
as the
> >> > >     new pcs->main.
> >> > >
> >> > >   - If pcs->spare already exists and has objects, keep the existin=
g
> >> > >     behavior of simply swapping pcs->main and pcs->spare.
> >> > >
> >> > >   - Only when both pcs->main and pcs->spare are empty do we fall b=
ack to
> >> > >     barn_replace_empty_sheaf() and trade the empty main sheaf into=
 the
> >> > >     barn in exchange for a full one.
> >> >
> >> > Hi Hao,
> >> >
> >> > Yeah this is a very subtle difference between __pcs_replace_full_mai=
n()
> >> > and __pcs_replace_empty_main(), that the former installs the full ma=
in
> >> > sheaf in pcs->spare, while the latter replaces the empty main sheaf =
with
> >> > a full sheaf from the barn without populating pcs->spare.
> >>
> >> Exactly.
> >>
> >> > Is it intentional, Vlastimil?
> >
> > Let's first see if Vlastimil had an intention, and...
>
> Hm I don't think I aimed to make this difference on purpose, but I didn't
> also aim to make the alloc/free paths completely symmetric.

Got it.

> Rather the goal
> was just to do what seemed the best option in each situation. And probabl=
y
> getting a full sheaf and populating spare never seemed to be an important
> case to warrant the extra code for a situation that's only transient afte=
r
> boot (see below).
>
> >> > > This makes the empty-main path more symmetric with __pcs_replace_f=
ull_main(),
> >> > > which for a full main sheaf parks the full sheaf in pcs->spare and=
 pulls an
> >> > > empty sheaf from the barn. It also matches the documented design m=
ore closely:
> >> > >
> >> > >   "When both percpu sheaves are found empty during an allocation, =
an empty
> >> > >    sheaf may be replaced with a full one from the per-node barn."
> >> >
> >> > I'm not convinced that this change is worthwhile by adding more code=
;
> >> > you probably need to make a stronger argument for why it should be d=
one.
> >>
> >> Hi Harry,
> >>
> >> Let me explain my intuition in more detail.
> >>
> >> Previously, when pcs->main was empty and pcs->spare was NULL, we used
> >> barn_replace_empty_sheaf() to trade the empty main sheaf into the barn
> >> in exchange for a full one. As a result, pcs->main became full, but
> >> pcs->spare remained NULL. Later, when frees filled pcs->main again,
> >> __pcs_replace_full_main() had to call into the barn to obtain an empty
> >> sheaf, because there was still no local spare to use.
>
> As Harry suggests, that assumes a specific pattern where we exhaust main
> sheaf first and then we fill it fully back. But even then this can only
> happen once per cpu and then we have populated the spare and are very
> unlikely to run into this situation again.

I agree that my original patch was trying to optimize a rare pattern and
added more code than is justified.

>
> Also it's unlikely that full sheaves even exist in the barn during this
> early stage when we would request them. That assumes cpus behave differen=
tly
> and some have returned full sheaves to the barn before other cpus have
> consumed their first full sheaf and request another.
>
> More likely both barn_replace_empty_sheaf() and barn_get_empty_sheaf() wi=
ll
> fail and we do alloc_full_sheaf(). And then... I think I can see an issue=
 in
> __pcs_replace_empty_main() that's more likely to be suboptimal than the l=
ack
> of symmetry you point out. When we reach the last part below "we can reac=
h
> here only when gfpflags_allow_blocking..." and we have empty pcs->main, a
> full sheaf from alloc_full_sheaf() and no spare, we should be doing
> "pcs->spare =3D pcs->main" and not barn_put_empty_sheaf(). Right? This is=
 what
> can delay populating the spare more likely I think.

Thanks, this suboptimal case makes sense to me.

>
> >> With this patch, when pcs->main is empty and pcs->spare is NULL,
> >> __pcs_replace_empty_main() instead uses barn_get_full_sheaf() to pull =
a
> >> full sheaf from the barn while keeping the now=E2=80=91empty main shea=
f locally
> >> as pcs->spare. The next time pcs->main becomes full,
> >> __pcs_replace_full_main() can simply swap main and spare, with no barn
> >> operations and no need to allocate a new empty sheaf.
> >
> > I'm not still sure that either way is superior, as it really depends on
> > the alloc/free pattern. If the CPU keeps allocating more objects, keepi=
ng
> > the empty sheaf is unnecessary, but we don't know what the alloc/free
> > pattern will be.
>
> Yeah.
>
> > So strong opinion from me, but I think it'd be better make
> > __pcs_replace_{full,empty}_main() handle it consistently,
> > if there is no special intention.
>
> I'd rather see some numbers. But the suboptimality pointed out above is m=
ore
> obvious to me. Do you agree and want to send a patch? :)

Sure! I=E2=80=99ve prepared a smaller patch and will send it as v2.

>
> >> In other words, although we still need one barn operation when main
> >> first becomes empty in __pcs_replace_empty_main(), we avoid a future
> >> barn operation on the subsequent =E2=80=9Cmain full=E2=80=9D path in
> >> __pcs_replace_full_main.
> >>
> >> Thanks.
> >>
> >> >
> >> > > Signed-off-by: Hao Li <haoli.tcs@gmail.com>
> >
>
