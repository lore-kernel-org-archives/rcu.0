Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53480329E6C
	for <rcu@vger.kernel.org>; Mon, 27 Apr 2026 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302717; cv=pass; b=MUcQAGGZyct03P5DuD4o/Ml9MGqyd1MBRISKDcL25N+THnWhkbZmFmpXYmhWY+jVWFpiQ7Zqf7kyAjCy8mD3fXAug+M0nt0whCGozYLO1TC9MnLP4tN/7CagC9BpYRpYQ2cfNbDOC6hFGBCo+9gwwMstD9ZPqAD3vi/Rf1oSig0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302717; c=relaxed/simple;
	bh=ajWWbHC1y6nyyYJ3M9567CAI1JG7ZlKR+korEqk1EKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2VnOC1FVsAqMTht+lBnwrtCAwouuaiupYOaBKnzt9+mXfNS1f8GWIF4YCOt7DGTN5jwxolp5oEN7XKfOyrnHVf2tyg3YkLhY10Ffib/gdImxyxtDbuWAXms0+y5D1K9ySUH9PEb14BIgcK3+cCdNIzN/AgeN5rYs8Uhfrx7CY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kX9Mcsv4; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX9Mcsv4"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4411e1eba51so7079122f8f.3
        for <rcu@vger.kernel.org>; Mon, 27 Apr 2026 08:11:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777302715; cv=none;
        d=google.com; s=arc-20240605;
        b=RyO10r8wrBr2amIX1tVZn7zZTZtXN8+lYdxqgZQn5yg20Otr4ZjAxB/JsNt0EdRAgL
         LsLXjM4RNU4ExcfZdLSknQqGh7Q3RMVtqniy/427p7XABD1nalJ4PofpiH0XpZ71aWfb
         aiV2lBoC1FBZe1x7nZL0a5dhMj5PHorTbwIpShJZdgD9ogOOK5YZErbt7LbVZiZ64Byk
         o9wrG9U6gfNXs3Hm8Ba69AeaK8ZLR+7mJILQRcORQkVZDE9xGtG1Nf6HFHWyv40yfRLN
         /Lcj35g6gz/xQWdruSQEhL3vL1sEi6Nk9TdRUXs1etI5p1Chn7w1vtUjhzW5HMw1BtDf
         up5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=64F0YnLb4HojWEGkjdb+tg09M6nzYeUGvBR151P6gwc=;
        fh=zj2BkhK89nNs6czolMXUQq489aHE9xQ2IkfKeAtmlEg=;
        b=jmBW+EFebHThWgljfdi2ZUvEbZs3gYOJ2bAb54pV5rCJz1vw2Vx6TglHiPpfoTvtoh
         hl9LJ3FecntAONvz8NnDVEmg2DpMIlrGBhx9fcdHdlPcaChfewDvxbV1bAxdRMQK1o+w
         M3pRae+proXbp+izS9IPrEp7sWtngZuHzsXWadRcGprAu+hqgHVPvhDbOzM/5+UEnJij
         wLRCsjKKoBOp0QEC5h/kOcmcKJjOSYIcVB7vNLDQUqL6hOGYtkP2wQDin/7WttqXgY/d
         Cx6Mgteq74QvvA9TUMYwIOO+8qrEHhzO+CgdzDNurmwPmsy9Jm0cg4mqm8wvjBDoNn6f
         l45g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777302715; x=1777907515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64F0YnLb4HojWEGkjdb+tg09M6nzYeUGvBR151P6gwc=;
        b=kX9Mcsv4qd3JjGNoQ6PaVLEaaW1+DHc/LUQyp4tjctckdPSWRWMg0k7nvmBMTwoYYc
         eLrJDiCS7c4lypWoG0OQz8yPTUZGsduu33OpuISFzQ7bcB2zHftAyx/F1aQt7QrSMGxE
         0LA2O5XrzGsTokx4Rs2VbFe9xVKsPznc82UD555ExJf3tlUVI+JjrypK9A3t+xnnsj8S
         Tsc5rJwCZA9cAr4mCS44yugf+zA4CL0HslTaoT5k2eFb9D/jV1JoxTHS+u5chTenmQbn
         imO1JshFVdWUdpF1sSeASPcT8/GmKimHhRJesj5ppoIsuETJQlkZEe/X4bgBoQLkwFo7
         oudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777302715; x=1777907515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=64F0YnLb4HojWEGkjdb+tg09M6nzYeUGvBR151P6gwc=;
        b=Ff2+2FrIXpODpbaVvPokPnXCpgbekS9Z6eR9wdtOBZYsV6meLwNe/yuoghkvFpJUv6
         ufjeapVYV3Ve/pidwEcwM0BKlsAfTXFiexNsE/2DWqDzqVqSJSeLmsUgC3/ZyY9R6/Z1
         fsiCbdIEuLjHZrA44ZR92RKnYBZw7peQyVp00EjVK/ocLdphMGrOQs/jfpwMnaLVWKXg
         3W1wb+xToM8fNmWA1UMMDU7VG79XkZ+IvsNv5IOiRXR3yYMIPx5D3Wpq81lovRJT+03P
         NvxQKW5scBJ2WqeyGMrSYu2RS0inxU3XyCxbpbzyOGbFcWTaHovWPAc2g0+TkcDwkQIx
         PVQw==
X-Forwarded-Encrypted: i=1; AFNElJ/TwMpsXW1ip2w8GfY9Zx9HE+bCZ11vfIvbdYGYezz+0dF1svH8WJmvcSiRywdmUFwNH+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSb3Re8JRkiwKBIZGi520/rwMQu+lp7n9CfE9PiypexZo36I46
	EY+W7LfIM/nDn44FM36zjV30wedUvFIZ+Cr533NbpqqnEoxB7o48mcVtWgBAAj5J9du/SEgL45O
	xKbDNsj0AyPPzAAagbSfiU6kdsVOOEcs=
X-Gm-Gg: AeBDietAIJKJO/ndOZvCrEJIHSdkDvYn9ZOlJmHm8PSMfp6ThgRx4NQvA2gb3qoKNsC
	0EUnmAX9P9VJsol7W+AlQ//KwIs3a65gjaDDxaGLTuyzCvQ38Y+hgxSM/VmxJ2bpfrXZ0Darl8J
	1bC3vprtsDG+lyp/9243FoOQVGigLoJVtHTu43tjBOR1rRdMEZr5zVncGkNsRKE1tpZUZRqDArD
	KcD4Ob2wMA4NJdkFNBWQhvbkMOtzJvoB7ZkAT8ExlmroLqwssE7alaDifYR8QtsbGDkioetLGLd
	YWAFRNRDCNcdmvZuFnIBI6swU98g/QBWYgAyDuUIT5QCXlP5j38Dg1ZmrFP7b/rupDUGAafvR0I
	vKBs=
X-Received: by 2002:a05:6000:1889:b0:43d:7508:c9c6 with SMTP id
 ffacd0b85a97d-43fe3e0b305mr66814525f8f.28.1777302714370; Mon, 27 Apr 2026
 08:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416091022.36823-1-harry@kernel.org> <20260416091022.36823-6-harry@kernel.org>
 <56381493-214b-406d-9121-f80be7658445@kernel.org> <7101d55e-ba43-4df9-a345-2af579f8e940@kernel.org>
 <CAADnVQL6iajm6L+VzqRB4b-u8OPhQSnUASnfciKGeRR4EDOutA@mail.gmail.com> <6811cc17-8ee4-48c8-8cbf-6bf4d9f98162@kernel.org>
In-Reply-To: <6811cc17-8ee4-48c8-8cbf-6bf4d9f98162@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 27 Apr 2026 16:11:42 +0100
X-Gm-Features: AVHnY4KWrDsFBq2kyftO3HGnQXYhzZBBgffaQkMzD3NuOqLTN8McEDAm5pDHVOE
Message-ID: <CAADnVQLLp0bdsu0xOcR+ZPsfq3M_sB4bB8LBq1op0wr+D+yRgA@mail.gmail.com>
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

On Mon, Apr 27, 2026 at 4:08=E2=80=AFPM Vlastimil Babka (SUSE)
<vbabka@kernel.org> wrote:
>
> On 4/27/26 16:45, Alexei Starovoitov wrote:
> > On Mon, Apr 27, 2026 at 2:53=E2=80=AFPM Vlastimil Babka (SUSE)
> > <vbabka@kernel.org> wrote:
> >> >> @@ -5973,6 +5977,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s,=
 void *obj)
> >> >>      if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
> >> >>              rcu_sheaf =3D NULL;
> >> >>      } else {
> >> >> +            if (unlikely(!allow_spin)) {
> >> >> +                    /* call_rcu() cannot be called in an unknown c=
ontext */
> >> >> +                    rcu_sheaf->size--;
> >> >> +                    local_unlock(&s->cpu_sheaves->lock);
> >> >> +                    goto fail;
> >> >> +            }
> >>
> >> ... this part, so an unconditional allow_spin=3Dfalse on RT would only=
 fill
> >> the rcu_sheaf once and then stop working.
> >>
> >> However, can we condition this on in_nmi() or something, and pretend t=
he
> >> other cases of "unknown context" exist? Installing BPF hooks
> >> allocating/freeing memory into call_rcu() internals sounds crazy, no?
> >
> > Unfortunately no. People attach to tracepoint lock contention
> > which can be inside call_rcu.
> > As discussed call_rcu_nolock() is only way forward.
>
> Alright. But we assume those tracepoint-attached callers know to use
> kfree_rcu_nolock(), while kfree_rcu() callers under PREEMPT_RT can still
> assume it's not called in NMI or tracepoint-attached context, right?

right. I see what you mean.

> So I think what __kfree_rcu_sheaf() could do is
> - with CONFIG_PREEMPT_RT, treat allow_spin =3D=3D true as allow_spin =3D=
=3D false
> for purposes of barn_get_empty_sheaf() and to bail out before trying
> alloc_empty_sheaf() - this is to avoid any lock activity that's not a try=
lock.
> - allow_spin controls ability to do call_rcu() as above, regardless of
> PREEMPT_RT, to avoid it from kfree_rcu_nolock()

makes sense.
