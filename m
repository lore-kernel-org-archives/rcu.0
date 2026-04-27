Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B92C3BE65F
	for <rcu@vger.kernel.org>; Mon, 27 Apr 2026 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301171; cv=pass; b=duAUF216J+e4Bo4T4s+NqvN/jrAcKBv5/lZWZbqtrt1E6nwwR1Y0c9WsoqzfuQ8FPr6//Nj9q6g+acKXgR4nHr8H1CwQCf1Ca+/7Ugg+NlDfvPdZdA7U7LhDm31Wc6xlfTBKxUvimhkNsbT7iI8RJZL2qqSVVwlPTBrABCPOhW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301171; c=relaxed/simple;
	bh=D75zqyGwtYMJ/Ka/ZdCru2+Rt7Y3OJzVSxSHMVEMky4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFvpspO4A+4hXvT51VUNz0xXLlmHVoTv0OJBb6lYiZ6dM/EqL3ZPc9C4PL3CZthiJA2YcettMTD3DxqOafyx86V3nAPJzMzsip/xKhn3NoXoxK8A2A8reTVngKG9J8b/wmPMx+NmBaT+aLxafEFB4cMvYHCZHN2kPTHvUbNyYl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwLSkmic; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwLSkmic"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso145183855e9.3
        for <rcu@vger.kernel.org>; Mon, 27 Apr 2026 07:46:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777301165; cv=none;
        d=google.com; s=arc-20240605;
        b=dymgSVi/Ow/pdUP3cMw66N1QnLb4PLlsp9tTBK/2ChOyEboSfJFUd+R1maVbl6xVz0
         eZ8PCJSL3xQTOY8m0jn1dmqrX8W93E8y8Qv1iXvuyxa4UKcd3bax+MybjLMMxfsSCF2L
         MsXvBtWj4dA5l/q00SGYx04gx7Y4326qHSrotkQRYTU9xDVFXuyoFgu+2DAdkKFdJR8T
         /UTzG/wvTx3hJAClOX2Ok9lfGAvpKOSzMOFUnUqN2uhxuRK0HsMaL1dMjZ2J9kSjkgrI
         q+Rc2lPKuCsPiepVtP6vUZTmkp0YXcBp73RPw7+GnRHW1GVSUukIzu5Iu84NtqEgP97S
         nVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iY7rfihtjlRuTjfO46wdna0FPFvKE5ldiB/zsCx9cHg=;
        fh=oqDVNnsVzWd9wexlvP2Kv202tN1tLdTWVYKmiNSLCQ8=;
        b=fcquQd8ChLlV2Y/syVajTBjrYaZt9oWZmYf0rEYeH+oCEt/vmZG1bO4j13Ke6SzrfO
         7iIKzNwIlrji5e3GDh+jwAJ0qgOGC7BXQ1KkImh0/G+KBJvxZLe0ziSndpc5O4he+Huo
         tPtCiOWJ3bA1ejhzSh8k1SSexQXeJEvBw3MLGsU4WlRjayZg7DmwZSWL2A5G5jnIlbUU
         5X4PYyxSpRiezk8N08cPR4m97fcVKSZ0UEtQ0sqFEjx5g4R42BzDcyukExIICYCIQA+/
         OcJK1ll0hCVRuk/5TIeWSkCvkzyfIf7zw6iJ/Jxfw7celpf1q+sJ8WUQHsZwyAARlwew
         yccg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777301165; x=1777905965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iY7rfihtjlRuTjfO46wdna0FPFvKE5ldiB/zsCx9cHg=;
        b=FwLSkmicvOllydU3v45sAMDXXyOFvZcfBRdJuI9MI0miUeik/mW2lA98FasYHWZVUe
         vpPAGBoCoGcxr78cZo2FSQeUl3aevf0b3S5vM8y7juo4OeNlugfXnDpB04BwCusAKS4a
         wQVELa59izNOuGTG7gmcSI5JixmtrnmaP4wv2BB9gouG7C0hOWCV6GWRnbEzKRFJfsEy
         kKkMLmYiVEMBKgrUxoxtUHWhqe5BAagUFOlR2fwtEWaKlABSHgrrDNp/QCgKjvt7Mft0
         12u/L0c+pw9LjVzGEOvRR+/BQYCGVMWlIdu8zlNf20TglBkG4TDH/A0S6r2TBtYBf3KC
         qfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777301165; x=1777905965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iY7rfihtjlRuTjfO46wdna0FPFvKE5ldiB/zsCx9cHg=;
        b=Izd9Rd0vtSo5Ufz6K0Msol6A51Q2L7KbaIlELp/0a6ePqGdH3xv4eMBqO1Kh0zfO6v
         brFLhfGBMNzajymXZ8dDzOR6xLPle92xS7m4Nh80TobfS3VictwHqoUaddaZ4FmOmTW8
         46mLw5hlbeQEzaj1OZN3aJx/I3zVvaAbsfScpIqi2XMtg6IHG1OcvbTsXeCVXuCFVUww
         Wem5nK2nKaGNcLe1WVzGa7lUbMxada8XMGdbcdWMJ0nvy/HCguSRRk6T0ZUoROUccrsF
         SPTYlp5PMXDyZi7oX5N7FthPUxnz8/JH7QhBGbmcGrTJ1buvoz+HuPx4jfWdOZCOAWdZ
         /VUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2csTV85c7YVZEnZUAuaJsU2huyLSTAq1sckPJ1+3IlUKacouGE0g+GA5UYtnDSeSUaP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfZKWIVFXQ1bc8USc6nON/oFfXWzv930rVObvaD8huYDQKCgKZ
	dxmNroK3BPzrCyc6vybFVUFIqum9FRhvuwL2DL1Du7MHopNH4TktcJkaF7A+C719qaTXLbJKHb+
	ss+oysS/MgpetbAiHkzmttSvXmmB8u4c=
X-Gm-Gg: AeBDieshaT5Oh/gr9empNFWqUUjrCfqrNo4UjK1XWtdrUcEQacy/3JUvOPTrb9jaD38
	ji7ac8E4E7YcqP3erBcmh0aUluxL9f/emmPXGNlygVW/wLg634wR3U36817HGU7r4z87N2XOH+d
	UHGYMa8y76RaJ5zsqTLq/MOO7kNbE9rB4uUcIq0WjLq2tEiRWFivULdIjOKFS6ACEouGq/ak80B
	xG5mlE23oAkZNQsDJNm0B4QhPfEwciclxCjrt2nPWOWIBxtNQVxcZ4bYQuHoPn+dNp8jVpz6Ujl
	uuCzxgo7dt/CgzT7NSrpc0vcjB5bId5YnP+BtvCRhomz2PxnMhYuNDoR7xF6+hp3rACWqeCTzLJ
	ezy8=
X-Received: by 2002:a05:600c:c10e:b0:488:8185:e672 with SMTP id
 5b1f17b1804b1-488fb792e84mr495623225e9.30.1777301165238; Mon, 27 Apr 2026
 07:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416091022.36823-1-harry@kernel.org> <20260416091022.36823-6-harry@kernel.org>
 <56381493-214b-406d-9121-f80be7658445@kernel.org> <7101d55e-ba43-4df9-a345-2af579f8e940@kernel.org>
In-Reply-To: <7101d55e-ba43-4df9-a345-2af579f8e940@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 27 Apr 2026 15:45:53 +0100
X-Gm-Features: AVHnY4Lx1d3_T5YLZckb2mOZ8lMlfGDMDVMHWOLrPRoWbJYjm0i7T0hWMsHHk3Y
Message-ID: <CAADnVQL6iajm6L+VzqRB4b-u8OPhQSnUASnfciKGeRR4EDOutA@mail.gmail.com>
Subject: Re: [PATCH 5/8] mm/slab: make kfree_rcu_nolock() work with sheaves
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, Zqiang <qiang.zhang@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 2:53=E2=80=AFPM Vlastimil Babka (SUSE)
<vbabka@kernel.org> wrote:
>
> On 4/27/26 15:32, Vlastimil Babka (SUSE) wrote:
> > On 4/16/26 11:10, Harry Yoo (Oracle) wrote:
> >> @@ -2111,8 +2111,7 @@ void kvfree_call_rcu_ptr(struct rcu_ptr *head, v=
oid *ptr, bool allow_spin)
> >>                              IS_ENABLED(CONFIG_DEBUG_KMEMLEAK)))
> >>              goto defer_free;
> >>
> >> -    if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> >> -                    (allow_spin && kfree_rcu_sheaf(ptr)))
> >> +    if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr, allow_=
spin))
> >>              return;
> >
> > I wonder if this patch is enough to drop (or reduce a lot) the PREEMPT_=
RT
> > incompatibility? It IIRC came from Ulad's review point [1] that since R=
T
> > spinlock is in fact a mutex, it's not unsafe to take it with e.g. disab=
led
> > preemption, and it's also why kfree_rcu_cpu uses a raw_spin_lock_t, etc=
.
> >
> > But with kfree_rcu_sheaf now having allow_spin parameter and only doing=
 a
> > trylock at most with that false, it should now be safe to allow it for
> > CONFIG_PREEMPT_RT, only pass allow_spin =3D false unconditionally there=
?
>
> Oh I forgot about...
>
> > [1] https://lore.kernel.org/all/aL_uhPtztx7Ef0T2@pc636/
> >
> >>
> >>      // Queue the object but don't yet schedule the batch.
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index 6f658ec00751..d0db8d070570 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -5895,7 +5895,7 @@ static void rcu_free_sheaf(struct rcu_head *head=
)
> >>   */
> >>  static DEFINE_WAIT_OVERRIDE_MAP(kfree_rcu_sheaf_map, LD_WAIT_CONFIG);
> >>
> >> -bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
> >> +bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_sp=
in)
> >>  {
> >>      struct slub_percpu_sheaves *pcs;
> >>      struct slab_sheaf *rcu_sheaf;
> >> @@ -5933,7 +5933,7 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, voi=
d *obj)
> >>                      goto fail;
> >>              }
> >>
> >> -            empty =3D barn_get_empty_sheaf(barn, true);
> >> +            empty =3D barn_get_empty_sheaf(barn, allow_spin);
> >>
> >>              if (empty) {
> >>                      pcs->rcu_free =3D empty;
> >> @@ -5942,6 +5942,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, vo=
id *obj)
> >>
> >>              local_unlock(&s->cpu_sheaves->lock);
> >>
> >> +            /* It's easier to fall back than trying harder with !allo=
w_spin */
> >> +            if (!allow_spin)
> >> +                    goto fail;
> >> +
> >>              empty =3D alloc_empty_sheaf(s, GFP_NOWAIT);
> >>
> >>              if (!empty)
> >> @@ -5973,6 +5977,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, vo=
id *obj)
> >>      if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
> >>              rcu_sheaf =3D NULL;
> >>      } else {
> >> +            if (unlikely(!allow_spin)) {
> >> +                    /* call_rcu() cannot be called in an unknown cont=
ext */
> >> +                    rcu_sheaf->size--;
> >> +                    local_unlock(&s->cpu_sheaves->lock);
> >> +                    goto fail;
> >> +            }
>
> ... this part, so an unconditional allow_spin=3Dfalse on RT would only fi=
ll
> the rcu_sheaf once and then stop working.
>
> However, can we condition this on in_nmi() or something, and pretend the
> other cases of "unknown context" exist? Installing BPF hooks
> allocating/freeing memory into call_rcu() internals sounds crazy, no?

Unfortunately no. People attach to tracepoint lock contention
which can be inside call_rcu.
As discussed call_rcu_nolock() is only way forward.
