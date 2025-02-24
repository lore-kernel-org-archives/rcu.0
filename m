Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53240154C1D
	for <rcu@vger.kernel.org>; Mon, 24 Feb 2025 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431569; cv=none; b=PlGo04dbPE0uuxuTWnFbLiemD29+bgAv0G2ToUTpYOx5pFZcIDFcsbSJX4YkOwwuPNCDo7qRoYw3nqvVbkb31K3tSWy7KW3gOBuXmFanP8fDXl2n54gCT13WiwxCph2AsYX19pzJ5BF2eL1nKwNGius3ewpOZItlDqYqFsM+HtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431569; c=relaxed/simple;
	bh=HTq1hTvR1SQPty2QVXi0IUMu6jl4EXews0MAm7AL4uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPQ1fE2GQkefLCkWbAlNI3ad/RgVqZ7dnzlNjSw0rssqpwOsNTQN9HIX60ApW0HPV8ULiWWZQ6NoV6iV3J/bS8dFu27d9pB08ZwL3SlQnlaH7OBqp7qUmpI3gLSRV9wloNKut9S0G0roAnWCQ+iqclkedKA4MTH+WOghts3NusA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W7UGBN1L; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W7UGBN1L"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-471f1dd5b80so12831cf.1
        for <rcu@vger.kernel.org>; Mon, 24 Feb 2025 13:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740431567; x=1741036367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptHrpv1FgW+eRVlXRG/z+3/zll41m0KxvzIOfrCzOzc=;
        b=W7UGBN1Lp5GuwwaW83TS6t+YwuquTSu2Ba9N/Glz74DG7y6KwqEEpLXI78bxerhhIF
         k1blIAzbhXF+e6nP/PBfuSc94DyoK/yp+Xih6I3VRiQPxkk6dI2NjCInHeOD/LZR+Crv
         OA07e7XDWv+TSbA9jTRAa4PS5geC2Vm9OjKLifaN18LQwWqF47dVsP6R4O16pFdt5hg5
         FGd6VpkMcbV0AGpReHCyadolKyBJx1Edls7Ps20u92bSTgq/l0ecAFh7rPOP9uyIK3xO
         HVy3t8izF5zUKXJmNK+UkddaEKXxHEvBV5UzIt+Cc0XAjBRj5YKHBrFHKiuas3da62CW
         Kgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740431567; x=1741036367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptHrpv1FgW+eRVlXRG/z+3/zll41m0KxvzIOfrCzOzc=;
        b=Q1KKeJGPULwgIRPuawX2vdc1ACC/v7WaANBqSMqReHSrD5ii2zEURUeIgX/FVPLOK0
         38hMzttwhuoSi+fDoe8cAJdDrhQFtcpvUZG2xR1R7RX9E5J7N4Hk91yz7KUVhS/DCHL8
         kuZal2SmrRgxCTDg1DeZ9FErg9KceDTPSysJMTFw+PFqhJ4NAIS1JLDyNcvGa2WqHoGc
         5Zq+BSI6bo7e21/Uso2RmQdawgd4aTCJuikEL0OFNIMqfkMgwF3KRD40gfS6oq5p5CCF
         JHgy6g064fUP41GJ3+0pTGwPdbcQ98IgqJ0pcKJfNDXKDTwNVjpB4Ub1+KH+i/MtU3L1
         pDYw==
X-Forwarded-Encrypted: i=1; AJvYcCVIDfPBI5UAdxh13jRx6NT7UxgE8S1D4rGk8LHaoPofIHer3anfdL579ARlcDCQ36iz6pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxkpK4eLQmpVg/ABUxn0uqnGXXA9gDI+5AWF1JVUhHYjN/3sSK
	4Q48Vjj65Oc4MBZuQWDQYVy6GbZLv3XEEuiCW7ry/sAXVAyUj3QmtmAo7hLTNoOPacZFQ34w9R2
	cad+eW69Zd7NjcoArzHkkMEVur55LAWg30PQx
X-Gm-Gg: ASbGncsGv5/X6C7Gt6DXZqFmPuqcypfKH0CALNc28Ui/4KD81cDnVJHzGHgcYkhD6yL
	S//vts5GcqjPoXKhv2y+euSHbDzBODuxNfotj8RYrRWTnFTKitqIwH834SKJNUzJvLpDisCKOJI
	rscTTisGg=
X-Google-Smtp-Source: AGHT+IFy5lkphk9aK6cggXXVbFQ6uyJCO+DUGGn0PWKuSmR1qT/KwV3OZ+DadA63L8nDA133ubA4cCo/H77/xMgqUcI=
X-Received: by 2002:a05:622a:4a:b0:466:8f39:fc93 with SMTP id
 d75a77b69052e-47376e5e3aamr1083211cf.3.1740431566920; Mon, 24 Feb 2025
 13:12:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <ztssad52ikws3a2dwodju4o73h6rsutxnvzj5i6vyjjkudkiel@g7c7g5i3l7jd>
 <CAJuCfpHi4Od4K2xQEUFWuG=a4zCKecWBMwBiy_7mVn6QgsTSvA@mail.gmail.com>
 <CAJuCfpEq8P4cz7HXaRVqaagONPBKrFgOSqdigEYU60sGAE4-rg@mail.gmail.com> <173d4dbe-399d-4330-944c-9689588f18e8@suse.cz>
In-Reply-To: <173d4dbe-399d-4330-944c-9689588f18e8@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 24 Feb 2025 13:12:35 -0800
X-Gm-Features: AWEUYZmqQ_oMQj1qN6J1ZfJrxg2kX6Ja6mVP58QLqJ3DeU8D3DiCKPbvDksnOuo
Message-ID: <CAJuCfpHHXYKGjaOxHcuJcuQbUVO7YqLMpcYeF3HM5Ayxy1fE+g@mail.gmail.com>
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

On Mon, Feb 24, 2025 at 12:53=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 2/24/25 02:36, Suren Baghdasaryan wrote:
> > On Sat, Feb 22, 2025 at 8:44=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> >>
> >> Don't know about this particular part but testing sheaves with maple
> >> node cache and stress testing mmap/munmap syscalls shows performance
> >> benefits as long as there is some delay to let kfree_rcu() do its job.
> >> I'm still gathering results and will most likely post them tomorrow.
>
> Without such delay, the perf is same or worse?

The perf is about the same if there is no delay.

>
> > Here are the promised test results:
> >
> > First I ran an Android app cycle test comparing the baseline against sh=
eaves
> > used for maple tree nodes (as this patchset implements). I registered a=
bout
> > 3% improvement in app launch times, indicating improvement in mmap sysc=
all
> > performance.
>
> There was no artificial 500us delay added for this test, right?

Correct. No artificial changes in this test.

>
> > Next I ran an mmap stress test which maps 5 1-page readable file-backed
> > areas, faults them in and finally unmaps them, timing mmap syscalls.
> > Repeats that 200000 cycles and reports the total time. Average of 10 su=
ch
> > runs is used as the final result.
> > 3 configurations were tested:
> >
> > 1. Sheaves used for maple tree nodes only (this patchset).
> >
> > 2. Sheaves used for maple tree nodes with vm_lock to vm_refcnt conversi=
on [1].
> > This patchset avoids allocating additional vm_lock structure on each mm=
ap
> > syscall and uses TYPESAFE_BY_RCU for vm_area_struct cache.
> >
> > 3. Sheaves used for maple tree nodes and for vm_area_struct cache with =
vm_lock
> > to vm_refcnt conversion [1]. For the vm_area_struct cache I had to repl=
ace
> > TYPESAFE_BY_RCU with sheaves, as we can't use both for the same cache.
>
> Hm why we can't use both? I don't think any kmem_cache_create check makes
> them exclusive? TYPESAFE_BY_RCU only affects how slab pages are freed, it
> doesn't e.g. delay reuse of individual objects, and caching in a sheaf
> doesn't write to the object. Am I missing something?

Ah, I was under impression that to use sheaves I would have to ensure
the freeing happens via kfree_rcu()->kfree_rcu_sheaf() path but now
that you mentioned that, I guess I could keep using kmem_cache_free()
and that would use free_to_pcs() internally... When time comes to free
the page, TYPESAFE_BY_RCU will free it after the grace period.
I can try that combination as well and see if anything breaks.

>
> > The values represent the total time it took to perform mmap syscalls, l=
ess is
> > better.
> >
> > (1)                  baseline       control
> > Little core       7.58327       6.614939 (-12.77%)
> > Medium core  2.125315     1.428702 (-32.78%)
> > Big core          0.514673     0.422948 (-17.82%)
> >
> > (2)                  baseline      control
> > Little core       7.58327       5.141478 (-32.20%)
> > Medium core  2.125315     0.427692 (-79.88%)
> > Big core          0.514673    0.046642 (-90.94%)
> >
> > (3)                   baseline      control
> > Little core        7.58327      4.779624 (-36.97%)
> > Medium core   2.125315    0.450368 (-78.81%)
> > Big core           0.514673    0.037776 (-92.66%)
> >
> > Results in (3) vs (2) indicate that using sheaves for vm_area_struct
> > yields slightly better averages and I noticed that this was mostly due
> > to sheaves results missing occasional spikes that worsened
> > TYPESAFE_BY_RCU averages (the results seemed more stable with
> > sheaves).
>
> Thanks a lot, that looks promising!

Indeed, that looks better than I expected :)
Cheers!

>
> > [1] https://lore.kernel.org/all/20250213224655.1680278-1-surenb@google.=
com/
> >
>
