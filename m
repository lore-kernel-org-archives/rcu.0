Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12D621B1AC
	for <rcu@vger.kernel.org>; Tue, 25 Feb 2025 20:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515233; cv=none; b=qOwtQXQcnYdbi4E8rA6JZjSIRFyM1ap9ooT+jMHGQp5qdrlKDIT2zPws21hFFLpeN3VYZFbIgBWXs3JH4/9T4cHpL70kjhoORTNro+z1z4cfijgOtYxVJLUFE8y1b8ONbtaH+YACoXTKZw4v+hGLIpQXbtQIOCJYMpX5OOkJXoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515233; c=relaxed/simple;
	bh=jOV9DB5WPTaZrpMDKS5aIFTdsLbmUkjQend9KEGp9DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1Lkj/PVtBAzrF59AUaA9OdxFOHeQoOMEjkL4Cl3Zkx9cZdLXexRlMqY1Z4XazOuoV+caQ1eGxf1YHyE5iA/J5C8MYSUQ/0WDYVUW+8cdZfHg+6WX/K8/4bXU6oHL+iNTD39sjFck61YDJtInqp9mGKfBB5fepC9b6IPcxkAEvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/dhDZh/; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/dhDZh/"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-472098e6e75so3441cf.1
        for <rcu@vger.kernel.org>; Tue, 25 Feb 2025 12:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740515230; x=1741120030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+xN7AiTJrC0ynsK4hEQTFSzLqDnqccgLdu8kvgFfMA=;
        b=N/dhDZh/e+SwQug83Gzli7nf7ImrCT00j8jiB9ymdafOOaKyDV1NEtpIuPJU6mzPgg
         BHJWUK2oI3uClBq8Z2tXAJwTKMP1GzTMqZdosbBqqfnb7XyVODaVqsBwvZYC2mJOJJ7P
         pq1Sb9x+76nS/kb9sGkLAm+aLFNRlx+CyFG8f5lyQQH8KRfzztcBp0+EpPNWKE+G0goa
         oT/n4wskg2+b1tJiO9F9qC2XdVtqw6ly4MfFMA3MHBO79mkuv7yMbVXBTWNAyWm4B/r2
         8wxWe4ep3jcvl8AuV9l9lT/JQoaRManldKNQUIi/PCMjijgKjcYQ7vh5DL21WSxjfXax
         W0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740515230; x=1741120030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+xN7AiTJrC0ynsK4hEQTFSzLqDnqccgLdu8kvgFfMA=;
        b=oW147NGl/rstDzUwk1f2GfLAmc246DKljzoyLY06AZm/ZymUfcBJDxFYoAh8O0je6M
         GQSD6cgXpf8/RLzEPVtntFUEEDVwkYsCP4tgpDeFauHnJxGDnnJ6CPLqdmaa4A8/knXL
         X4H5PlNrt8wPcsP5f6PzszLimlfsJFpfinVFSdm7k97RaxL7hSn5OpVNn9ZWpzj0QB/k
         tGSbMgMbJ+w0+RpB8+Dk7f7tOko320b2ZKOwZVGR3T4h41GQnywDl2tSBYJSRxC3lptA
         u55FkmPc6JdwukLRXifE0me0XfSYQIisjfrhn8wJvKTlBEScTbjrOe5bLZVjY7cj6GcQ
         /x7g==
X-Forwarded-Encrypted: i=1; AJvYcCVDdDHTvMUrjRyO4WTXfOM2V+QKgVjgdI8DKP7vqDx7W89Z3K01+hN1lZ4OxRKMCp66ChQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwatJDy/sTIrGSHKI5G4FcMq33yB1gAlI/qGqce/tqC+PpKYvd2
	oFj6LNqk2M+FRBnGHT7O6LPMzuB1qOpqE5Q4HTus66PLVRFZAr65HkomXZH2jUP1V4DiphkhiYw
	74uFK/GmTxcEiMNjWNFRnDQoOxLDOj2O1dzIG
X-Gm-Gg: ASbGncus8aylcpE/CZ89ksVELnRm14z3dWmN+qjENpWL60keXJI5coHQBOpz8XNPjxu
	Zmt6y69xc/hAAAjec1loViH6/On7wHX2TbmCcyL4i93CJgEj8mhMURX+Or7hU1g3MbFfG+KBGL0
	byoUZJH0Y=
X-Google-Smtp-Source: AGHT+IGCPRUl7EyfMG5UNOKIzDP+flI/Kvq0Te1XG5ifn6l5XLiP/ay3uq/Wy8cM0LsrEbECRUyyFMnrwQptEMRROk4=
X-Received: by 2002:a05:622a:1a95:b0:471:f34d:1d83 with SMTP id
 d75a77b69052e-47376e6f153mr5771291cf.7.1740515230157; Tue, 25 Feb 2025
 12:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <ztssad52ikws3a2dwodju4o73h6rsutxnvzj5i6vyjjkudkiel@g7c7g5i3l7jd>
 <CAJuCfpHi4Od4K2xQEUFWuG=a4zCKecWBMwBiy_7mVn6QgsTSvA@mail.gmail.com>
 <CAJuCfpEq8P4cz7HXaRVqaagONPBKrFgOSqdigEYU60sGAE4-rg@mail.gmail.com>
 <173d4dbe-399d-4330-944c-9689588f18e8@suse.cz> <CAJuCfpHHXYKGjaOxHcuJcuQbUVO7YqLMpcYeF3HM5Ayxy1fE+g@mail.gmail.com>
In-Reply-To: <CAJuCfpHHXYKGjaOxHcuJcuQbUVO7YqLMpcYeF3HM5Ayxy1fE+g@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 25 Feb 2025 12:26:59 -0800
X-Gm-Features: AWEUYZmbUvBZYQOEnyJSGvoQZOLqN-tvNLOGbur4IzoQIF06Ruiv7YZpQQ18P-k
Message-ID: <CAJuCfpE7t83PKWw+8XJLE5538kKJnbhirLg2siDSw=F4sw=9uA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/10] SLUB percpu sheaves
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 1:12=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Feb 24, 2025 at 12:53=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz>=
 wrote:
> >
> > On 2/24/25 02:36, Suren Baghdasaryan wrote:
> > > On Sat, Feb 22, 2025 at 8:44=E2=80=AFPM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > >>
> > >> Don't know about this particular part but testing sheaves with maple
> > >> node cache and stress testing mmap/munmap syscalls shows performance
> > >> benefits as long as there is some delay to let kfree_rcu() do its jo=
b.
> > >> I'm still gathering results and will most likely post them tomorrow.
> >
> > Without such delay, the perf is same or worse?
>
> The perf is about the same if there is no delay.
>
> >
> > > Here are the promised test results:
> > >
> > > First I ran an Android app cycle test comparing the baseline against =
sheaves
> > > used for maple tree nodes (as this patchset implements). I registered=
 about
> > > 3% improvement in app launch times, indicating improvement in mmap sy=
scall
> > > performance.
> >
> > There was no artificial 500us delay added for this test, right?
>
> Correct. No artificial changes in this test.
>
> >
> > > Next I ran an mmap stress test which maps 5 1-page readable file-back=
ed
> > > areas, faults them in and finally unmaps them, timing mmap syscalls.
> > > Repeats that 200000 cycles and reports the total time. Average of 10 =
such
> > > runs is used as the final result.
> > > 3 configurations were tested:
> > >
> > > 1. Sheaves used for maple tree nodes only (this patchset).
> > >
> > > 2. Sheaves used for maple tree nodes with vm_lock to vm_refcnt conver=
sion [1].
> > > This patchset avoids allocating additional vm_lock structure on each =
mmap
> > > syscall and uses TYPESAFE_BY_RCU for vm_area_struct cache.
> > >
> > > 3. Sheaves used for maple tree nodes and for vm_area_struct cache wit=
h vm_lock
> > > to vm_refcnt conversion [1]. For the vm_area_struct cache I had to re=
place
> > > TYPESAFE_BY_RCU with sheaves, as we can't use both for the same cache=
.
> >
> > Hm why we can't use both? I don't think any kmem_cache_create check mak=
es
> > them exclusive? TYPESAFE_BY_RCU only affects how slab pages are freed, =
it
> > doesn't e.g. delay reuse of individual objects, and caching in a sheaf
> > doesn't write to the object. Am I missing something?
>
> Ah, I was under impression that to use sheaves I would have to ensure
> the freeing happens via kfree_rcu()->kfree_rcu_sheaf() path but now
> that you mentioned that, I guess I could keep using kmem_cache_free()
> and that would use free_to_pcs() internally... When time comes to free
> the page, TYPESAFE_BY_RCU will free it after the grace period.
> I can try that combination as well and see if anything breaks.

This seems to be working fine. The new configuration is:

4. Sheaves used for maple tree nodes and for vm_area_struct cache with
vm_lock to vm_refcnt conversion [1]. vm_area_struct cache uses both
TYPESAFE_BY_RCU and sheaves (but obviously not kfree_rcu_sheaf()).

>
> >
> > > The values represent the total time it took to perform mmap syscalls,=
 less is
> > > better.
> > >
> > > (1)                  baseline       control
> > > Little core       7.58327       6.614939 (-12.77%)
> > > Medium core  2.125315     1.428702 (-32.78%)
> > > Big core          0.514673     0.422948 (-17.82%)
> > >
> > > (2)                  baseline      control
> > > Little core       7.58327       5.141478 (-32.20%)
> > > Medium core  2.125315     0.427692 (-79.88%)
> > > Big core          0.514673    0.046642 (-90.94%)
> > >
> > > (3)                   baseline      control
> > > Little core        7.58327      4.779624 (-36.97%)
> > > Medium core   2.125315    0.450368 (-78.81%)
> > > Big core           0.514673    0.037776 (-92.66%)

(4)                   baseline      control
Little core        7.58327      4.642977 (-38.77%)
Medium core   2.125315    0.373692 (-82.42%)
Big core           0.514673    0.043613 (-91.53%)

I think the difference between (3) and (4) is noise.
Thanks,
Suren.

> > >
> > > Results in (3) vs (2) indicate that using sheaves for vm_area_struct
> > > yields slightly better averages and I noticed that this was mostly du=
e
> > > to sheaves results missing occasional spikes that worsened
> > > TYPESAFE_BY_RCU averages (the results seemed more stable with
> > > sheaves).
> >
> > Thanks a lot, that looks promising!
>
> Indeed, that looks better than I expected :)
> Cheers!
>
> >
> > > [1] https://lore.kernel.org/all/20250213224655.1680278-1-surenb@googl=
e.com/
> > >
> >
