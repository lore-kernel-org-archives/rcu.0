Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE7350D7D
	for <rcu@vger.kernel.org>; Sat, 12 Sep 2026 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789257555; cv=pass; b=IrhGwxqCJVCP49euEZjUojXxuZ1yeHaU0UsH8xgzcaADD0mp1sIhWssQ4r8sElKdzW0DjUTEwW7jtKRuISaETVM+whb/XwpAeXjo3tAphocyOzbHpqvajVgdUPE7VwpRsVMG+yCT1RmUxt1t1NDVo+J2W6uGs/bdwVwH2FiaUJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789257555; c=relaxed/simple;
	bh=dt+UOPr8bzn5MsHDJfwrcRsGr6ZoVZ8m7l97MMZFyLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5jENxwjlR6YgU+OsICipFd7YsiJSLgi3E05vqu4DABmofAyQKhITGKL979JMaOcg2RKWNzPxpbypQvR8FxCnTZQvkXuLAwPTXndVJA/fQIz2g3Mslkg3QI8+0DoFKM99Tar0CL8qo8J0PZS33VPDuiIHmvnkNpCH7oKw5wxjSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlQwZYyE; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlQwZYyE"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d91ded8174so19219795ad.1
        for <rcu@vger.kernel.org>; Sat, 12 Sep 2026 16:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789257554; cv=none;
        d=google.com; s=arc-20260327;
        b=Uj1/+CVA8hULsnUhPmyts7hCfvKWvthVT05pZ2QlgD3YrwxgEzMS0XUGkq/4HDH25o
         VwwLdbNq2z8r4x1PdQ5geQyx5j2O97C0x4+zrta3n81HPRxYvRQiyh/vPSLAS/E2XDWa
         D+z1Yg4KtbsKJDdegJeP31iT59AK1ZZUPHK4DBUfqdN/FgxVuKB6ShE6e0kEtIvGJP5a
         N+3Z4Md+by4su+U9JpwEXosScZDyUci0HQBpWy3mQJMdXtgrwDsJfP4C/rjDK2JCrCL2
         fpxk2EXdKmBO9YiAsKAIw5hnNlH3MTTFMkSmAJOZZ/W16uSfuOgO8Rv93mkPrpsnZCQH
         1enw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5whm1ZGtSD6d9UTQoSVGX4pAamqW3MhbLVJJEUPVUGg=;
        fh=CtfS2wUEp+RMB3+azASP0/L68zqnR9v5SzOgj9ixOkM=;
        b=NBuPDO7Yl37304U6MTn0OxRuP74F6yqsqS+aBTUCVWntYM7H5mKaKJoo/S681u3dzF
         shzPcZam0Llf1Fmr2U+zOEfmJwQewxSGWm0Xv9QgcHdO9bhf6/sm4zt/oQ8VV9aEleFk
         XET+C8NryojjRY6d+riUACrFI5MpdvFH94k62xcFE8suSkCkNESJj1cy3dBK4rtwMQWM
         gCb+oruTDmykjIQCqrtNHc0cmDs1JGN6r7ZhuZaz3OfykzKnmhj50YsYVGdY6CROjb5n
         ecApMu5T1Yna7k+TzDrU+ngyNBy/DBTEbNOrPrzJpgWggU6sMTG7C03Y/vYJuPcSg7ay
         5BiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789257554; x=1789862354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5whm1ZGtSD6d9UTQoSVGX4pAamqW3MhbLVJJEUPVUGg=;
        b=IlQwZYyE/8yZzLZtyPkuaMtWb6HkEiD6XnatVU8c83PI8R9DX8iLQUoHnZsBbe6djx
         E1k07ys8/Z3jFjiHc/K4EK6Cn1mxl5op8ZFLFT7B2tLSktYtwjrbc8aDt7tCPfys6OgM
         /SYBleTCd/zLzgBnTDSiZ3WaJpZpVqwNXXqsy5gl3z78KNTvfeWI6yI/3lzgkzrmPVxx
         mFGv2FslrofS90KLOHrV6jobrBCBfKwa3KQpRAi5LPtzlQ6bN9jz5m4/B8MXjHcwdSKg
         uE+5gY30FI2BTWO0/iQyy4u07F3d1fOWih8iAnVdmhqtO26vfLegZUHnj4BgYg2vJuvp
         +7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789257554; x=1789862354;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5whm1ZGtSD6d9UTQoSVGX4pAamqW3MhbLVJJEUPVUGg=;
        b=XSOWr6B1WKzW3ZyqEWSy1lFAwSKQiucL8riuIl4xLZHqCJBValvVyJsmj0W1f1eMSh
         gOHJukRBY7iK+8F0aO3/O445LqmXOdozYAAqbbHsYbgV8q/5DY69hRvwIF48xKebR1zz
         ZoGi6i7CyjHEnQUz1G6jUZ1hmYUQz1L1NxTfXU2dcIYqyO+Y7rcqo8nLyTVEbFO8z3rK
         CYxLAnnu1/1zPlA/XFX2oYJID99bEV6xjTQ5KLQpVCORlhrehLYBrPW4EeIYot4M8t75
         8vbvISrB2YvhwuBxLdSqJKTFMNmPX8HoMfh2b5lsdMC+6VRt2J5j5U6c4SADT2e7Z/sK
         9leg==
X-Forwarded-Encrypted: i=1; AKwUvBwqiaBXtBKL8RvK/amGVnvwVSOBVSD4Njp1UrZzQbuEI2QRJOnYgPQLfSiRD16lge8WRkE=@vger.kernel.org
X-Gm-Message-State: AFuF++kv3MDUVEkEUSDbk08YZtEtHBpOrfTXLeQ8yb5U1ER4oyQsBIno
	IE59tZdz7cGO8KJ052vMWVv5Z2g0FMdHSEeRaTahWyENR9YLei4N+n3BRjke8AmfnJkBAv44uXn
	GwqEx2uEEEw0HKey1M9T5BdAil4t/F4E=
X-Gm-Gg: AYBFou0KbM+dDkq9GO+evUce0cHcjUJI9TQjlwVn5nJSsu7wAec64nWO7HlsIM4GbpM
	4GUV1noJG9XUyi6g75Ax7P1eiw3MUVY73l+DRscDcJkbEWnBOc0pMIoEXU58oINYDX8eIBrZq9E
	R3X8sQGbQhular1k3kDvrPtmd+ShDyfpgCGp4M7NIBNZCSQPfgVsNQY0yOneiCYU3TEKimkN/4y
	tWhZ8l0tuNTfXIdlv4s4u242vaLqN+jieFE29HAGDjdkqlKG49UuQnfeKNuitbXw5lykCFHGP/n
	KNX3++I8BblWv1ot3FTWcw5wR6772J/BjwtzKYAvmQ1JRt6xaW8j9EAZHHd0AMdaBnN/wNIGuJV
	HWuA0JUXayuFXImLrUCy1LLx5ylbCy/SEDZYAtEo=
X-Received: by 2002:a17:903:1ac6:b0:2db:331b:e187 with SMTP id
 d9443c01a7336-2dd2a1e0a15mr200200855ad.8.1789257553733; Sat, 12 Sep 2026
 16:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
 <20260911-b4-rcu-tasks-preempt-qs-v2-8-eaaa61ed2da4@toxicpanda.com>
 <DLD0OHX8C4ME.VNR49VC2UYH4@gmail.com> <14cb8a91-497d-49f5-aa20-c6cb8b9a27fc@paulmck-laptop>
 <DLDICNLENSRI.2R6EJ0ZFJE45T@gmail.com> <8c51a669-eb6b-455b-a829-b537da5209f8@paulmck-laptop>
 <DLDLDGTSBHA0.32TYNBSKKPFXH@gmail.com> <8fbfb3fc-cf5d-4dfb-b144-bc021faa13ff@paulmck-laptop>
In-Reply-To: <8fbfb3fc-cf5d-4dfb-b144-bc021faa13ff@paulmck-laptop>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 12 Sep 2026 16:59:02 -0700
X-Gm-Features: AcwNN1V04v_YLyVyvshDjEX_boeHQmR-dgrTXGEZk0Tlq9YUUBiA7_5E2kzlt5Y
Message-ID: <CAADnVQLQs-+-cu2R3QrHppcxOQt9m7Hi+grr4fOnw8m73kQn0Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 08/15] bpf, x86: Maintain Tasks RCU trampoline
 nesting in the BPF trampoline
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Boqun Feng <boqun@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, X86 ML <x86@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Andy Lutomirski <luto@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	rcu@vger.kernel.org, linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 3:28=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Sat, Sep 12, 2026 at 12:40:55PM -0700, Alexei Starovoitov wrote:
> > On Sat Sep 12, 2026 at 11:03 AM PDT, Paul E. McKenney wrote:
> > >
> > > In the old kernels, yes, we have current->trc_reader_nesting++.
> > > In the newer kernels, Tasks Trace RCU is instead implemented in terms
> > > of SRCU-fast, which instead increments per-CPU counters.  Which among
> > > other thins is a bit faster and does not need to hook into the schedu=
ler.
> >
> > old kernels? I'm confused.
> > rcu_read_lock_trace() in bpf-next is doing t->trc_reader_nesting++
> > and then calls __srcu_read_lock_fast().
> >
> > Are you talking about some RCU branch that you target for next merge wi=
ndow?
>
> No, I was thinking of rcu_read_lock_tasks_trace(), forgetting that
> rcu_read_lock_trace() is still used.  (For good reason, just be clear.)
> Your comments are quite correct for rcu_read_lock_trace().
>
> Hmmm...  Josep's using t->trc_reader_nesting would break for
> partially overlapping RCU Tasks and rcu_read_lock_trace() readers.
>
> But yes, your #5 makes sense:  Deprecate RCU Tasks, upgrade RCU Tasks
> Trace to check for preemption from within trampolines, and move RCU
> Tasks users over to the rcu_read_lock_trace() variant of RCU Tasks Trace.
> (Or am I still missing your point?)

Pretty much. This way bpf trampoline stays as-is. No extra overhead there.
rcu tasks users (faultable tracepoints and what else ? )
switch to rcu_read_lock_trace().
The only difference for faultable tracepoints is
extra t->trc_reader_nesting++.

I have studied the rest of the patches in the series,
so this proposal can be completely off the mark.
