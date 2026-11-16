Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794816466;
	b=D6+bspeiYCnL4O+Hv0Qu8pg6pnEP5aHuxrvNEj8QK4JB6XWt0Yitygksm3f0M2t3Texb
	 F0LfY+aYY9gYTLTXCPKdJ398L6KAAZtlnnOhw/YlpQAnti/LBFJ2nF1uw+htWqCg22/j7
	 PYjEYmljm4iIK4RqBhI+SUbr1f8psTqayj0aJ8QfG9+AkhgGr7AOanJfWLQuwmdMi+7R8
	 bviW+8RiCHX1lcmkEx++wu0CU363rkp/rzHWu4ai315/SU1Nst5Hvw4l6bbeV0p7dhRqj
	 MXB5f7xJaXFaH+6wsGH0IWQwqinShAmnZQdUU83fJb8bGe7FDbRVl2lJ0RxwbekfXRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0Pb6xr6a8f5h8gb6JGzQgb39t7gGon62SuzmS0+FGP8=;
	b=tMzS/l9oAjoj0tyTwJQHNhRqKdYDZ16Q/7ohhNU2ZHt42bXQkh1HV48Lf6dbs1Ey7YIh
	 34dz1HOcWLELZKCoR99PZL8bnZbSfHnqU3cNJ1qhqP7JKST5K7C+ojGaDInw47Jua878K
	 NSYISHEcYEyy04xfebqnV/RAmD7zOUqw6xntXzeNP87g3ML8AWHUlk7Tqa08bIbzHXRKu
	 hOa/h2fSEAwIvFttl1TWIZ76evKlnq7rh4x/Pht8qboyu8Ro6ZCVK8y/aezuK0hby5XC4
	 BxSkPwtzlYe+0Y9kjFdZjlyNM6rqWvxjQNrxZeh0jjmt2V+8OVhuUEHFjrq8+U64AhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=fkMft+mt;
	arc=fail smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B77F606A323
	for <rcu@vger.kernel.org>; Mon, 16 Nov 2026 08:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B77F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=fkMft+mt
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c40f29667e6so554439866b.0
        for <rcu@vger.kernel.org>; Mon, 16 Nov 2026 00:07:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794816464; cv=none;
        d=google.com; s=arc-20260327;
        b=LH2oprAuLvp24Isaf0FH9EbWSi82/JFgRqeJpC39bL8QvfCrzh5Rx36z4Xb7RCY4Iu
         xhbPuqfqmcNXKsymsXLEMyz+dlGE7uYXEv7IuLhqVQJhV1O5aKTe2hmp/3m/GITvksiL
         /umh/dkQk+17FhXWv3xCe332kAxSRkxnfrZ2oUOqUhDCQ6H7ark/gFXhao58ib6HdZON
         uC2JLPHch2rNposm9jwQggtSSqe0SFbrxTykRMegOH5YFZDVWm08LnYzzOUp236U3Gn2
         Z+BxTerB7SZ7huMXtEQplc4gwJ/AGbm+Fl7f+/Uo0L1Jfl41NGutDpvKaKzgEe/jGlOT
         VsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0Pb6xr6a8f5h8gb6JGzQgb39t7gGon62SuzmS0+FGP8=;
        fh=rMh74u2ej3GdvNOtBPfJ0ZRaJ9Gm6quc7WbUgI62dQE=;
        b=GTk1LZ/iSRrrQr6R2Cz9QiEo9yvswCKsMLrP47M7KHvPefqisJ1s19C0jNgiFS0Zdg
         6If2dts7kt9axEP+oQ+GFI3DW7CBDpJZZtaCJqwf5N/PJRqUm9rM/r51yE1reBcaXj9m
         W87NxQfJfhP2Ft3zKW8j5HLs0mj9Td0XEwvnQFlGW/0SvwCnuYUOVIMOBStzWe4ByGZT
         3ADw/1+Nn+kv0o3zLbP4BHj0yK0NGJuj6bzt201XYtZhzM7OFEp/jtzaFerovukFYvzR
         6Lt4yR+E2wIvcOileNmGYFnqz7NNjcdIVj/O0aPE4gN9kXmvwtxCYgM7CGnzbf0zs/tX
         moRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794816464; x=1795421264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Pb6xr6a8f5h8gb6JGzQgb39t7gGon62SuzmS0+FGP8=;
        b=fkMft+mtE1J8XMiTvZ73WrQNp+eXjncIfS8lhhso7HiskD77N92NpIzFpZmq4yZyWI
         wY1Im0FiRgMjfaHeBi+oxhIuGSWWVh0czmiuRPcOD8PuuRWaXqq619Wjj5h3iZJgQkkt
         T5RuSBGDIBfLEcF651z/zCD2xrunovPKvsHr6ADNRQPtIZjYFeKeOsvd00OyqisxffE/
         mi6tbmZVOBHA+tH/jopAE79JDSzYg+HxavS5dITmeh4apHaqofLismWxCfIJ7nGTDfou
         zgSYjZgbtKsqT7jozbTAUp+QUy04hHx6AlVotuU7LKtObQZMLzd5y3eRtQzS0yEVpKrt
         xcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794816464; x=1795421264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Pb6xr6a8f5h8gb6JGzQgb39t7gGon62SuzmS0+FGP8=;
        b=mOS8QSTaCG9hLzFELP3Y8x1/rnex2nLVrTc/yR0yiOG1yh+SWsLTMpyBN3xnGcLiSj
         FKD28Hd8S2vKBUmX2xkD8FijTh/ELEt2Yl/o/e0XEoJMClwM1hccHbNHPAO+yBHzFqg5
         oEhLJ1RpQVgWhEhcQrYEzFVHEEgV4qUXJvOVzkrceyJrtedOwMr3G4guLwJfe1+Y84LN
         1zSNUnob1Wwt/X3C6dP6n+z0aB7X8yXiAwezetawagLNQVJXduiWSPgIfsNEaIJLQ1JY
         DBYtbiczc8+TJlguF+gOZnzG7LOKD4xlFutzssRgMLGEGtPi2bHnple3T1hWO8wWeRkJ
         wEKQ==
X-Forwarded-Encrypted: i=1; AL+hErGQuHh5Xuhw2cuyrOcHtFm5lhGhvR8AgvUjJbyA81YAyegHTLt4RpsvWh/55PDT0i3I2eI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/I2hs0uIRbdAuuu4x10zWpekdZ7Vsr94fyWforna5oXL2/Vzoy
	FdOipLo/xGRxY99HrJaRcZp0qytVnN9u20y5dOMlcFVFG6AaA1RLfHVBOfghwntaRA3PJOUXJ1+
	t/8L14YwEVMug+oh0GMEanwz6GsUj/s/SdJO5ckgrLQ==
X-Gm-Gg: AYBFou2mAPEfDRLEYaFSeB+7tMSVBFBAcOQs+RMHgLMHF7wa7k2MnfsqJIiPCvpBl0y
	8AdEyf7sA/C7PA35KhghKPzi/bYmHrjpFM7nLppmveUHMS3QWKNkP7HdDOfWPgt/w2igVSy+NvV
	PAomBt+SWS7boYn7lnAr0yz4ORq5Ljy6BqU+McDm4iq2hMRLzN8FAAl0MWUSBvjQggZz60Y7HVb
	Kae95023tG7qTmgnF9QVxQ4UTqbTQg22NIW6L94VIcsuCVj6dvnl5CFE9anU4Trz5VI808XDods
	ZTKl1SIojS6rxI3mEvUh8LNHUqX+6HbGMu+vdKj0OEcVM00Sp6nXbZyXQcZZkKoPvwjCAy3foi1
	xs8hQBCht3ea6BXG1pL+7BDXVKH+esTtBYiIxHdI3kpsI+JGIwdnJ1MWYwNHLM1H6DA==
X-Received: by 2002:a17:907:c06:b0:c50:8d2b:4392 with SMTP id
 a640c23a62f3a-c509674081amr685735166b.49.1794816463797; Mon, 16 Nov 2026
 00:07:43 -0800 (PST)
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
 <CAKPOu+9XP8CP-EiLqd_Q-F6EWUQPgi4Ysz7wu8LZijR+j0_uyQ@mail.gmail.com> <CAGsJ_4zp8WJosxkVwRtfEvySBwp38bLd-0g6cV0G1BPb2V=hPg@mail.gmail.com>
In-Reply-To: <CAGsJ_4zp8WJosxkVwRtfEvySBwp38bLd-0g6cV0G1BPb2V=hPg@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 16 Nov 2026 09:07:32 +0100
X-Gm-Features: AclHuK8pcuLrqZJfU1rZDi9Fc8JwweuaSuc_E2UFqy4M0KZNmfZJEbG9gBYu1Ng
Message-ID: <CAKPOu+9+NuwfDr4ii2nD2Uk2DWFLqJsDro_O=FW073oEF-eBew@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm/mglru: cache the last memcg node, make tail
 insertion constant time
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 9:32=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
> > For me, it is not entirely clear if a stable backport is really
> > necessary (thus I did not Cc stable).  It's not a bug; just awful
> > performance when you have thousands of memcgs, but few people have
> > that.  But that's up for you to decide.
>
> Okay, thanks!
>
> I guess we can only reproduce the soft lockup with thousands of
> memcgs being rapidly rotated by artificial test scripts? In real-world
> scenarios, would this be more likely to manifest as a performance issue
> rather than a soft lockup?
>
> If so, let's focus on upstream mainline development first.

I did have soft lockups / RCU stalls on a production server; real
workload, no artificial test script.  The workload is ten thousands of
containers - it's web hosting, and each Apache/PHP/... process lives
in a separate container (cgroup).

> > > > +       if (at_head || !last)
> > > >                 hlist_nulls_add_head_rcu(&lrugen->list, head);
> > >
> > > Do we still need at_head now that MEMCG_LRU_OLD has been removed?
> >
> > Yes, for the "!last" case.  This is, unfortunately, a special case.
> > If you prefer, we could move this special-casing to the hlist_nulls
> > API so callers need not be aware of it.
>
> I mean, you might not need `at_head` at all if you rebase your code
> onto either mm-new or mm-unstable.

True.  I did already rebase, but did not post v3 yet - `at_head` is
indeed gone, but as I said, the "!last" check remains and means the
code doesn't get any simpler by the `at_head` removal.

I'll post the rebased v3 today.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
