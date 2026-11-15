Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794731548;
	b=UAFTf+HB/NidSzZgP2SFLuy2JWxkLBuGVgM/f974jUIe5j5C7CL3utZ444rxaXq2tbit
	 1r3TygP/VAx4ShA/nqXBGZMCn57IQNWuo4lv6GV1sw3ocG4WxrAfoUjalnyiLcrcF0RWA
	 lcIRrQ3qi+ecFW5idZD/vQQtUXpkOUjoqILi0FZPQsTGwYk57HjK38l+cMgC587CKH+Ui
	 gHpRH/noVuNnlMX2rNwR2sW/TF5usfHgyzNdwAXeRMVIwTXyAeO4M2OfrFU3l2yJe0P/d
	 FmtyJEYGtPdntk/ZGSn7NKlJ3fAQ4yR5M8wD+ygoj1igvE2ud7IqpfXKuvwH91uv/Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794731548;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GCh8Ifwi9uvxPPglO9UrnRFnfH7l5jkW/d7XdsHHxuw=;
	b=FeTDINiTCeYY8OWQ2Aya2LS/GSrO/A6TwfVJ59IPmRC4AWLfuinyfeZUsg2h2wIog0Gl
	 rAled0t09vSle0x1zdZnueNi4QsdAM8kWNUAUCS2mcHFGw5V8hghLm59ugMo2pOCkUBHR
	 zakxtud9jHJMEmF8kUgM4gevHQMlVaQWeQAVevD1lE0q+oTgvFaGACxNhKdj8GjIgsnEU
	 pfzhABC1vvf3rsNg2o3V0kjIQ1e3d9c/1o+9Z1BS6vaWBmHiELfx7Vx7DLUYI5aOYYYv6
	 mu+Cm7pzudP14kVzRPwx7LULLWb72aUOAPaj5Npb0Gd4ci+n6DELrd5kbxDac5aKBpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBAiMSoh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0703606A31E
	for <rcu@vger.kernel.org>; Sun, 15 Nov 2026 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBAiMSoh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFDF1F000D3
	for <rcu@vger.kernel.org>; Sun, 15 Nov 2026 08:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794731548;
	bh=GCh8Ifwi9uvxPPglO9UrnRFnfH7l5jkW/d7XdsHHxuw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UBAiMSohkM5KfXVEBDBy7CRMSsOwbi1hP3rk3TU9/89oUkVe6UCm24Vb3CmDvF4z/
	 yOY2RgiM29r4sEzCm3ye06DBabOoobyPOBVJdK/ul04D58nDcjm6CSoPQQlwL3m5Wl
	 cMULqRqaEbyaqO5ca8h1WaukMsbfXjTwzBSoBZ6LvdM5fKavmHsNrligN54uDxAUuI
	 2hHStRSpuj80FGStPpW38bJWdVKz4ajq+TfMvojqW7zhOt8LatpTF1QE3lCuDVaj+/
	 LVg1FCcDhsaxf+rveFojuvcmQ5VjVEFROICOciEYtkVmmOOBvFchnHvXia5UB1PoJH
	 RHbGFhep+UAhA==
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91ea16d8072so27245406d6.2
        for <rcu@vger.kernel.org>; Sun, 15 Nov 2026 00:32:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF8mv73KgUEGEcJxO5zGdBw1CQlBpVnHTI9qd/Ktkjs3JBmeC0vRIh0Y8x9W+BDxPptp3A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YSt4q1clASQudmiuB00FJ8irba1PRVpW374otj5e0oTkMU0Mg
	aTvi2q0qrrvxk15NW0I9F5CTmUuyGnU6wjnmW1O91dRKg6+5nXdOQWGQO6R6VCserR+z+rQgm/2
	PWrIBpNE9sFSaOds3dvGXeWdV3hkjDJY=
X-Received: by 2002:a05:620a:2614:b0:939:fde0:a71b with SMTP id
 af79cd13be357-9494b86e99fmr1135729085a.0.1794731547421; Sun, 15 Nov 2026
 00:32:27 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103113711.1832834-1-max.kellermann@ionos.com>
 <20261103113711.1832834-4-max.kellermann@ionos.com> <CAGsJ_4y+LX-CSnDJ59VT2nc-i=rB=4iMuBQYawMCktk-_SPykg@mail.gmail.com>
 <CAKPOu+9XP8CP-EiLqd_Q-F6EWUQPgi4Ysz7wu8LZijR+j0_uyQ@mail.gmail.com>
In-Reply-To: <CAKPOu+9XP8CP-EiLqd_Q-F6EWUQPgi4Ysz7wu8LZijR+j0_uyQ@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Sun, 15 Nov 2026 16:32:16 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zp8WJosxkVwRtfEvySBwp38bLd-0g6cV0G1BPb2V=hPg@mail.gmail.com>
X-Gm-Features: AclHuK903Z9BUzVG_q0fBix3SipsrwutJuy-Sym-wmyWv56RpJEBqKKFqIWDC2c
Message-ID: <CAGsJ_4zp8WJosxkVwRtfEvySBwp38bLd-0g6cV0G1BPb2V=hPg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm/mglru: cache the last memcg node, make tail
 insertion constant time
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 3:55=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
>
> On Wed, Nov 4, 2026 at 4:40=E2=80=AFAM Barry Song <baohua@kernel.org> wro=
te:
> >
> > On Tue, Nov 3, 2026 at 7:37=E2=80=AFPM Max Kellermann <max.kellermann@i=
onos.com> wrote:
> > >
> > > Rotating or onlining a memcg currently uses hlist_nulls_add_tail_rcu(=
)
> > > which walks the destination bin to find its tail while holding
> > > `memcg_lru.lock` with interrupts disabled.  With thousands of cgroups=
,
> > > this takes a long time and causes severe lock contention.
> >
> > This is the main cause of the soft lockups and RCU stalls,
> > right? If so, we may want to add a Fixes tag.
>
> Yes. I added (for v3): Fixes: e4dde56cd208 ("mm: multi-gen LRU:
> per-node lru_gen_folio lists")
>
> This commit added lru_gen_rotate_memcg() which calls
> hlist_nulls_add_tail_rcu() (full linked list walk under spinlock).
>
> > The fix itself may not be directly applicable to stable
> > kernels, but based on the logic of this patch, we should
> > be able to work out a backport, right?
>
> The primary copy of these patches lives in our kernel branch that is
> based on 6.18 LTS.  So I already have a set of patches that can be
> backported more easily.  Do you want me to submit these versions, too
> - and if yes, how?
>
> For me, it is not entirely clear if a stable backport is really
> necessary (thus I did not Cc stable).  It's not a bug; just awful
> performance when you have thousands of memcgs, but few people have
> that.  But that's up for you to decide.

Okay, thanks!

I guess we can only reproduce the soft lockup with thousands of
memcgs being rapidly rotated by artificial test scripts? In real-world
scenarios, would this be more likely to manifest as a performance issue
rather than a soft lockup?

If so, let's focus on upstream mainline development first.

>
> > Another option is to leave the cleanups in patches 1 and 2
> > out for now, and make patch 3 self-contained as the first
> > patch in your series, if that makes backporting easier.
>
> I don't think that makes backporting any easier - they are not really
> cleanups, but refactoring to make [3/5] as simple&small as possible.
> I wouldn't squash them; it improves nothing but makes review harder.
>
> > I'd appreciate it if you could also mention Ridong's earlier
> > work in the changelog:
> >
> > https://lore.kernel.org/all/20251119083722.1365680-1-chenridong@huaweic=
loud.com/
>
> Aye.
>
> > > +       if (at_head || !last)
> > >                 hlist_nulls_add_head_rcu(&lrugen->list, head);
> >
> > Do we still need at_head now that MEMCG_LRU_OLD has been removed?
>
> Yes, for the "!last" case.  This is, unfortunately, a special case.
> If you prefer, we could move this special-casing to the hlist_nulls
> API so callers need not be aware of it.

I mean, you might not need `at_head` at all if you rebase your code
onto either mm-new or mm-unstable.

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=3Dmm-new
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=3Dmm-uns=
table

Thanks
Barry
