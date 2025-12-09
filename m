Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367E328DF07
	for <rcu@vger.kernel.org>; Tue,  9 Dec 2025 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765273432; cv=none; b=LmlVtB9RuC/htgPmTGwVz1QlFwJhMbsSA0s0gMbWZoAGmjKMvTOJvDTuhNmNjdA/wVHGImqqAq7XnK/gqCDUZZ3Itk99YhT1asgbnMBdg9bWb+DVGe6Zi7+YyJ3gze/93hTdrh52uqJM27HNYI6y6vBg6wnfiI9dFhWv4wJAs7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765273432; c=relaxed/simple;
	bh=GXeFfsg6aDnwkDC+YGYjpSF8fRge0qX3w/eLIiAlsB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlnrHKpjezKObCbzmz4k7dgIJIQdJQLkMAtJxzLnfZ8wcFQtRjv515WjrWWDaAc2SH/m6VWmmDm1j+qCf3poeRjWM7MnDrAwDpfxttsAsC2vYs42FDqpw3uXvn6iswir5ixGOHfIFKICJNJ5pctWO4ZGax33G+17VZjcmta7t/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv19qi4k; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv19qi4k"
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7c75a5cb752so3947946a34.2
        for <rcu@vger.kernel.org>; Tue, 09 Dec 2025 01:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765273429; x=1765878229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUmGYBiGWNpLts2NDyHiFgi5lTJLsPjA/UugWflgesU=;
        b=Hv19qi4k1RuG6oBve6Is8GEJW0E/bWrfk9jNotmSu3XVQTOkxmnz0NaWJvXu9n224M
         OrA7n5N3aktPM9yjVsFxmQYihY1c8IqvRP3E5R/T5HLxg3FjPPlVrbWts7RwnQqZu6rW
         p9fsMHpZh4awPSBCv1wIwKxxo7EjB1pPKnhAeG6bDXKsjXkO066ZVoeDezB/RpJJk6tE
         LhKdbBqJcoY6KHTgPchJk2zO70g/h22uiFYajNn5/jtSY06T3Mzv8dItGD8QLxYPJHWj
         +S6Y/WIoqZlryQQvfL6No2q7QEt1AwSsNTokbNBe2+cYZmCEURw+Zy/G7PDrGt0YGLte
         hxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765273429; x=1765878229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MUmGYBiGWNpLts2NDyHiFgi5lTJLsPjA/UugWflgesU=;
        b=NFkUwqVkl7ea/l0dximaHeUj7MmjVSP0iDAPhMCjMNqEiB8fuvjCQnHtwODerJBzmt
         znutIrPMv26fcj37rpitCjjxpnc8MXNKR7T7QAXwDlQS+/BJEoNxwvfUzTHQdMtbUKKn
         otf/fAEMxDnXR+nPcXVS2S4OcJ07ZJP8QXDA6N6l5TblDWJmpwnSBNnS+LsGCFl0GOSI
         MMDQ6v8WgPlGwsYoJl2utCPCsxDek0eQm5/SPsik7T+JaUAU38gAJhcm9SmmU5axIjbZ
         ftklQDAzp70b3QNgwFx7dKRMTHvV/xKszDXZRipdEPrh7UQAO20KCRRcwkebr+d+hEu0
         x+HQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4la2Ek9+J9b8OvWS4O5c8Bc1u9n6DDbB5llxlBFJXRxPu2R/8tFra9g+TG/p/sEEmnSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE9Px/XmLee/Srk+x7FsUspSDXIuq4bM74YnN/RDrV+y3IL6dI
	9V04HDVKzHrytHnK4ndjhEJlkX9y3rlqYYFKiYmnPUyLVwgZl6ZRk50cwnamdr2+dRNyk5UvMG1
	V6ESL4qIypvQlvK5V6pnO2sJEJ16LsTY=
X-Gm-Gg: ASbGnctO/uFYVLfx0AN2vPE8sjirzRUDmqBAFiGkr7PG4scANGsr81L+CSpI65wViLV
	6bWIi6k27P21eP464EgL9qIWnUjJCiSz9wDmLZyLA1nL7D8eoVVOo7C1iH6OFytkoW4ctam69HG
	wCFb5JO+6snPWV+/p9FB/NvOZQOT7KYjHcOiRWL8F0GzoNaG6NNfCE2o2fF23hL6OtW0Ko05xbV
	Ic65LV7A1AxGc2W+c35yjT7f2krBhG9PWACEivcwTNe4whP5Rzt4tRBdUvRQpMgII+f5VZq6w==
X-Google-Smtp-Source: AGHT+IFv9IpaqkBeUd86Nr3OuDzklG3yFLqBXbMjhf/Mnoiu1eFqfKKJ8fJymN964DrgEiph0Yx66JMNRrgic7biNC4=
X-Received: by 2002:a05:6830:2115:b0:7b2:aba7:f4e with SMTP id
 46e09a7af769-7c970752562mr5668508a34.10.1765273429418; Tue, 09 Dec 2025
 01:43:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz> <lvagftdnxgpyafafl2ish6x6phno6xstd6r3zxffs652lyxzyc@2pbngufu7wro>
 <aS_OrvHmgyhQzQIj@hyeyoo> <dq67tbm6bbvm7opvuq5vwtjjrcnrponmhfv7xwnvpv6vp3u2lv@bkruq4dtx3rd>
 <aTWIQ0s3EbOa0azX@hyeyoo> <8bbbaa65-2783-4006-97b4-a1628525e7c7@suse.cz> <aTeLzFrc6EA2yTzk@hyeyoo>
In-Reply-To: <aTeLzFrc6EA2yTzk@hyeyoo>
From: Hao Li <haoli.tcs@gmail.com>
Date: Tue, 9 Dec 2025 17:43:38 +0800
X-Gm-Features: AQt7F2qOPq2FORbgnnaGiFBv2DPLqnw1zxgZR0HoDLae5rm3U726fF5yoLqzoqQ
Message-ID: <CAAXMevqBFNO70N9+-ZGSEVmvs3fiF27g9WzP2W4uaXHhDkFFUQ@mail.gmail.com>
Subject: Re: slub: add barn_get_full_sheaf() and refine empty-main sheaf replacement
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Uladzislau Rezki <urezki@gmail.com>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 10:39=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Mon, Dec 08, 2025 at 07:51:40PM +0100, Vlastimil Babka wrote:
> > On 12/7/25 14:59, Harry Yoo wrote:
> > > On Wed, Dec 03, 2025 at 07:15:12PM +0800, Hao Li wrote:
> > >> On Wed, Dec 03, 2025 at 02:46:22PM +0900, Harry Yoo wrote:
> > >> > On Tue, Dec 02, 2025 at 05:00:08PM +0800, Hao Li wrote:
> > >> > > Introduce barn_get_full_sheaf(), a helper that detaches a full s=
heaf from
> > >> > > the per-node barn without requiring an empty sheaf in exchange.
> > >> > >
> > >> > > Use this helper in __pcs_replace_empty_main() to change how an e=
mpty main
> > >> > > per-CPU sheaf is handled:
> > >> > >
> > >> > >   - If pcs->spare is NULL and pcs->main is empty, first try to o=
btain a
> > >> > >     full sheaf from the barn via barn_get_full_sheaf(). On succe=
ss, park
> > >> > >     the empty main sheaf in pcs->spare and install the full shea=
f as the
> > >> > >     new pcs->main.
> > >> > >
> > >> > >   - If pcs->spare already exists and has objects, keep the exist=
ing
> > >> > >     behavior of simply swapping pcs->main and pcs->spare.
> > >> > >
> > >> > >   - Only when both pcs->main and pcs->spare are empty do we fall=
 back to
> > >> > >     barn_replace_empty_sheaf() and trade the empty main sheaf in=
to the
> > >> > >     barn in exchange for a full one.
> > >> >
> > >> > Hi Hao,
> > >> >
> > >> > Yeah this is a very subtle difference between __pcs_replace_full_m=
ain()
> > >> > and __pcs_replace_empty_main(), that the former installs the full =
main
> > >> > sheaf in pcs->spare, while the latter replaces the empty main shea=
f with
> > >> > a full sheaf from the barn without populating pcs->spare.
> > >>
> > >> Exactly.
> > >>
> > >> > Is it intentional, Vlastimil?
> > >
> > > Let's first see if Vlastimil had an intention, and...
> >
> > Hm I don't think I aimed to make this difference on purpose, but I didn=
't
> > also aim to make the alloc/free paths completely symmetric. Rather the =
goal
> > was just to do what seemed the best option in each situation. And proba=
bly
> > getting a full sheaf and populating spare never seemed to be an importa=
nt
> > case to warrant the extra code for a situation that's only transient af=
ter
> > boot (see below).
> >
> > >> > > This makes the empty-main path more symmetric with __pcs_replace=
_full_main(),
> > >> > > which for a full main sheaf parks the full sheaf in pcs->spare a=
nd pulls an
> > >> > > empty sheaf from the barn. It also matches the documented design=
 more closely:
> > >> > >
> > >> > >   "When both percpu sheaves are found empty during an allocation=
, an empty
> > >> > >    sheaf may be replaced with a full one from the per-node barn.=
"
> > >> >
> > >> > I'm not convinced that this change is worthwhile by adding more co=
de;
> > >> > you probably need to make a stronger argument for why it should be=
 done.
> > >>
> > >> Hi Harry,
> > >>
> > >> Let me explain my intuition in more detail.
> > >>
> > >> Previously, when pcs->main was empty and pcs->spare was NULL, we use=
d
> > >> barn_replace_empty_sheaf() to trade the empty main sheaf into the ba=
rn
> > >> in exchange for a full one. As a result, pcs->main became full, but
> > >> pcs->spare remained NULL. Later, when frees filled pcs->main again,
> > >> __pcs_replace_full_main() had to call into the barn to obtain an emp=
ty
> > >> sheaf, because there was still no local spare to use.
> >
> > As Harry suggests, that assumes a specific pattern where we exhaust mai=
n
> > sheaf first and then we fill it fully back.
>
> Right.
>
> > But even then this can only
> > happen once per cpu and then we have populated the spare and are very
> > unlikely to run into this situation again.
>
> Good point!
>
> > Also it's unlikely that full sheaves even exist in the barn during this
> > early stage when we would request them. That assumes cpus behave differ=
ently
> > and some have returned full sheaves to the barn before other cpus have
> > consumed their first full sheaf and request another.
>
> Right.
>
> > More likely both barn_replace_empty_sheaf() and barn_get_empty_sheaf() =
will
> > fail and we do alloc_full_sheaf().
> >
> > And then... I think I can see an issue in
> > __pcs_replace_empty_main() that's more likely to be suboptimal than the=
 lack
> > of symmetry you point out.
>
> > When we reach the last part below "we can reach
> > here only when gfpflags_allow_blocking..." and we have empty pcs->main,=
 a
> > full sheaf from alloc_full_sheaf() and no spare, we should be doing
> > "pcs->spare =3D pcs->main" and not barn_put_empty_sheaf(). Right? This =
is what
> > can delay populating the spare more likely I think.
>
> That makes sense to me.
>
> > >> With this patch, when pcs->main is empty and pcs->spare is NULL,
> > >> __pcs_replace_empty_main() instead uses barn_get_full_sheaf() to pul=
l a
> > >> full sheaf from the barn while keeping the now=E2=80=91empty main sh=
eaf locally
> > >> as pcs->spare. The next time pcs->main becomes full,
> > >> __pcs_replace_full_main() can simply swap main and spare, with no ba=
rn
> > >> operations and no need to allocate a new empty sheaf.
> > >
> > > I'm not still sure that either way is superior, as it really depends =
on
> > > the alloc/free pattern. If the CPU keeps allocating more objects, kee=
ping
> > > the empty sheaf is unnecessary, but we don't know what the alloc/free
> > > pattern will be.
> >
> > Yeah.
> >
> > > So strong opinion from me, but I think it'd be better make
> > > __pcs_replace_{full,empty}_main() handle it consistently,
> > > if there is no special intention.
> >
> > I'd rather see some numbers. But the suboptimality pointed out above is=
 more
> > obvious to me. Do you agree and want to send a patch? :)
>
> I agree and would like Hao Li to try this path as he raised this topic,
> if he's interested ;)

Thanks Harry for reviewing and letting me work on this as a newcomer to SLU=
B.

>
> > >> In other words, although we still need one barn operation when main
> > >> first becomes empty in __pcs_replace_empty_main(), we avoid a future
> > >> barn operation on the subsequent =E2=80=9Cmain full=E2=80=9D path in
> > >> __pcs_replace_full_main.
> > >>
> > >> Thanks.
> > >>
> > >> >
> > >> > > Signed-off-by: Hao Li <haoli.tcs@gmail.com>
>
> --
> Cheers,
> Harry / Hyeonggon
