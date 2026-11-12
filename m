Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794453510;
	b=4dgxAi6BYVtpvYQWPVREheJ0jLls8XQv9rr2ph2pziliAl0whcus1ktII3whnOxd2T7F
	 LoOT3lCw+NAy3F9Nj8Q/4XbWbf/7CcjdUcm+iOWqvHx34/7ife9rmOdPzA3b10SGW5Sig
	 9aJokUdlYLhkj7+Ayk7LVSmkFxRqoofBemfpklVClokp+IegaoWgmE5YS6FPd5yy2vpCV
	 DLomiOUJw+pZMubXuxnfnagOAW/JFhfYzY9Zmw9O7x3W+YoIeRcSDYkHR0SObo4o+qJyR
	 yCA/FqsSJVOGjqGYHvAot1pIlT/MAQH1U05hEbKQyPxrFWw32Iowb+0LYh/x3OZFuYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=e11ulRIZTd7AnqEMnZCDfVZRKHml1W7lUrz+Qj7x20Y=;
	b=LsIulV6NJYyPykNq0e03eQVIgOxVNoZaeKgyDLhIXto5LHXjpNAIFNUJSjjNAo1aJ3d/
	 belUA5ixwPhA9bozs5TPeIcL5KWBNHinLiFxZg1ZggTSPGl57peyMo9WM7mAnj4sSp1bE
	 EJF7iKI/B0YmkzCTJ/CALbUctMsH81eHO/PVkeNnMIxVzTIfGyiT6kroGt0Es4f176306
	 WQh6UXIDohpiypBf5RbYVMvPy1G2pdfsGlNaThjQQ0JzXgKXoON8kvEPUA5qh4aoo1nQn
	 9/lx8ricqKWaOHTGQRPE43+kTjjiDM/+W/9CPAt0cZEqE51Eby5l4cPsOBTD/U2AiYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W4ZUKfXL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F036606A884
	for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 03:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F036606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W4ZUKfXL
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso39684955e9.1
        for <rcu@vger.kernel.org>; Wed, 11 Nov 2026 19:18:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794453508; cv=none;
        d=google.com; s=arc-20260327;
        b=dM+AZJYiv1ZZz9KKMwz4DlOgqGfia9aR9GEuAW1UFNXGzpvYfE5J2eINSd0LMWkfrI
         uXR7EN0nBktryBobHzAOjYSCmV8L093hqfLZCdhGRn/iA47j8QA/kOZHktzut6C9dFnQ
         BXvk0ZghWnexYuSDXZGQqCio6hWYEZPR5s+jgf7c1AagG8Y1A9BQ6yqCR/R6Sr3Cwx+b
         qk+m/CAhBmzf8wEuk/nXeJwsAj8f+yX76hqQO/uwrUR0SXub9HwOnwWVjkL/CDJnZQF4
         g1Wb6KUZKwCE25suNToEo3JZbc4/fgGIWlg9s9hdexHqUeXZWeDY9xF8F33l0uoc5hJZ
         prmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e11ulRIZTd7AnqEMnZCDfVZRKHml1W7lUrz+Qj7x20Y=;
        fh=Sdh3+aMmEkrZg51My0GM0ZD30CnvLfJK0kwNltzlcEc=;
        b=ghO2hoygCSLaw1jLXVLgSEiWSzEkQdCD/UJJljN1ksx8/60SGxfQ5o+CjiS7EBNQmd
         cXpwYVS1Hye2yX7CDp+Zq+ezWopcfpmuicRTJCfQ88UrCGPaKba3ARFGTsSna6Ue6Nsu
         9fk1vgwHoiMzMdwzrWKVMwrbVbSuWTvTZfkgc+xyWUBF7m9/STaVmJHUOSgVCp9HETjf
         uoM29WveD1XK+BBNG6fG7fZA5S58Cn7VE5Gl15pdbA1qufa3mHn3RmPViLb8KSPGW9ZQ
         1CBplOjJlK4zxo7dj/iOuz9aP8mOytv/W0iwaqhqautZER/GgnQojUf5mvxJ3pXpSE6F
         eV/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794453508; x=1795058308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e11ulRIZTd7AnqEMnZCDfVZRKHml1W7lUrz+Qj7x20Y=;
        b=W4ZUKfXLiVZIP2ANHPab7imstX2KgvDOh1kFOzCNr1Zo86jzYm6QH3ANN9q3moOhMh
         fm8eBWItodHd/zmYi0WhGv4OIh3XWtF3HzlY87fPEdWUvH2W7R8vDcKE5bI0Ro9X9tmQ
         Vx1xj20+KYeIXLy263U5yRDkMHzLK3mAVA3l40ygujtSi855ExxdLKr5og+Eyae8NHvM
         gxQCkNfZqS2YYftPBLPM+NGEIKuy6DHRytdIe5piwgCTkRjxs88we6+5DXUiI/vFchF1
         lqdWP5iTJIqPC9oElOPWZaGqM7uDF4OGJu1snPEYyNyl/o3z3n4ttDFu/MwAH8HpAvlQ
         RXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794453508; x=1795058308;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e11ulRIZTd7AnqEMnZCDfVZRKHml1W7lUrz+Qj7x20Y=;
        b=QqqSVq0WtMhvp72S36KmMgScxY4NGE4agweXkxTYoVGuS04+cUg2g9yuAThPTpC79G
         xxNfWP9y7Glx0aVnwRcG1Q4bVr10IyYIUZzDvz7DwV95kUitfOyU2GedfV43L5O0OMQp
         SEtu+hM0shPdZvZ19NuStN5U2alE+WY94vKCgnXBvvxcDhlVp7K9pzidFtW9MdmAW8kG
         f3ztGWhGOkUsZdYbb1VG4hoYw4blSSw9i8dLlTRMydYUUuPWLzXxb9PBKEWDEJlwmQu9
         e2VrKxCkE6GAoMTB6oilonMXHSmnK3ctkO/H5+FHhght9UlUOBQLfzgKJMkpYPLv5Zk4
         GdjQ==
X-Forwarded-Encrypted: i=1; AL+hErHLtgQeAuHKv1DNZdrQyp/nlJ/kPGXYK+y1ECpgm+mhg7OFJoe8s0OO5Sp8jW1SjN0A+Mo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+n3pEkgC7F9vDgRp3yxXic5q7Qu96pW/IM9aKbHsmkXeD6Xtv/
	ySC4rFWK1lS4ennNnl/sw0c5PGRt1rQn9/Pp+J7S4Vgh0w+vqasvn6ePKLp21cqBmcOZJJhYjXp
	XCxY50pyCf9ACGjLQpY97lh9gk6IOsUY=
X-Gm-Gg: AYBFou3KfzYy6vEHJWq2a8GqGNSbcDsO9JXUonTqGf9cyOH6Gr309fjWbyd2J7G5nZg
	kOQpXER/MNN4aDGS+c7E3jPsrTw6GAG58+olrmK5Ky77NcacGqXR+sHu/ydIah7wkwcpPtIhTSX
	QzRzCh9xJvuUzwuWUZZJz2boxYQZfKdpGImNASa3IRljoNDY7wl1O++/jkOTHjNHQg9h4w/jVg7
	2nS1/UAqGQXIiNvRldc0AfvaDaVIpAuP+IEv4PC+2oLMCQe0OYvQKgTnPewLFPc3IfOASNkPIOD
	jCdY5+d99yim0j//cW/iohKop0pcdRiArL+nMhHTniE+7UBbLpcHWaPryrD4cm2bdAtFQDu6s81
	3qyRyDupZgi5iAt4+xXNxDHZf7T3zr+5wZJUN0g==
X-Received: by 2002:a05:600c:6214:b0:4a2:729:f7ce with SMTP id
 5b1f17b1804b1-4ba0939d249mr70056595e9.8.1794453507969; Wed, 11 Nov 2026
 19:18:27 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com> <20261111145949.70845-3-mathieu.desnoyers@efficios.com>
In-Reply-To: <20261111145949.70845-3-mathieu.desnoyers@efficios.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 12 Nov 2026 11:18:16 +0800
X-Gm-Features: AclHuK8kRUbb0XfDsi-OcC6bHXCHjf7ur8t09H78RcYqBXtt4_ZcpJT_BYnC6ds
Message-ID: <CAN_Opa-se6qK2R1CvYeWVY=+js9O0u_rc_WAR34hfYDkR8vVEg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] srcu: Rule for using synchronize_srcu_atomic()
 from interrupt handlers
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Davidlohr Bueso <dave@stgolabs.net>, Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Mathieu.

The IRQ-context rule and owner-CPU check LGTM.

Reviewed-by: Kunwu Chan <chentao@kylinos.cn>

On Wed, Nov 11, 2026 at 10:59=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> This is about the update side.  A user that calls
> synchronize_srcu_atomic() from an interrupt handler must disable
> interrupts around all its calls on that srcu_struct, task context
> included.  Document this rule, and warn when it is broken.  The rules
> for readers are unchanged.
>
> synchronize_srcu_atomic() spins rather than sleeps, so it may be called
> from atomic context, interrupt handlers included.  Its callers on one
> srcu_struct exclude each other with ->srcu_atomic_gp_flag.  One of them
> drives the grace period.  The others spin until a grace period ends.
>
> The flag owner disables only preemption.  So an interrupt can arrive on
> its CPU while it holds the flag.  If that interrupt handler calls
> synchronize_srcu_atomic() on the same srcu_struct, it spins forever:
>
>   CPU 0, task                        CPU 0, hardirq
>   synchronize_srcu_atomic()
>     takes ->srcu_atomic_gp_flag
>                                      synchronize_srcu_atomic()
>                                        spins until a grace period ends
>                                        it never ends: its driver is the
>                                        task this interrupt interrupted
>
> Nothing reports it.  lockdep cannot, because lock_sync() records no
> interrupt state.
>
> synchronize_srcu_atomic() cannot disable interrupts itself.  A reader
> that disables only preemption may wait for an IPI to the waiter's CPU.
> That IPI never runs while the waiter spins with interrupts disabled.
> The kernel-doc already lets the caller choose the waiter's context.
> It then asks the readers to run in that context, or a stricter one.
>
> So the caller disables interrupts.  The existing reader rule then
> requires the readers of that srcu_struct to disable interrupts too.
>
> Also store the owner's CPU number plus one in the flag, instead of 1.
> A waiter that finds its own CPU as the owner warns once, rather than
> hanging silently.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  kernel/rcu/srcutree.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 2b0e2b2d2c18..8075da4b1bb5 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -2108,6 +2108,13 @@ static void srcu_advance_state(struct srcu_struct =
*ssp, bool is_atomic)
>   * and srcu_read_unlock_atomic() must be invoked from that same context,
>   * or one that is even more strict.
>   *
> + * If synchronize_srcu_atomic() is invoked from an interrupt handler for
> + * a given srcu_struct structure, then for that structure, all calls to
> + * synchronize_srcu_atomic() must be invoked with interrupts disabled,
> + * including those from task context.  Its callers take turns to drive a
> + * grace period, and the others spin until it ends.  An interrupt handle=
r
> + * that calls it on the CPU of an interrupted caller would spin forever.
> + *
>   * If synchronize_srcu_atomic() is invoked on a given srcu_struct
>   * structure, then none of call_srcu(), synchronize_srcu(),
>   * synchronize_srcu_expedited(), start_poll_synchronize_srcu(),
> @@ -2144,7 +2151,13 @@ void synchronize_srcu_atomic(struct srcu_struct *s=
sp)
>         srcu_state =3D get_state_synchronize_srcu(ssp);
>         preempt_disable();
>         while (atomic_read(&sup->srcu_atomic_gp_flag) ||
> -              atomic_xchg(&sup->srcu_atomic_gp_flag, 1)) {
> +              atomic_cmpxchg(&sup->srcu_atomic_gp_flag, 0,
> +                             smp_processor_id() + 1)) {
> +               // The flag holds its owner's CPU number plus one.  An ow=
ner on
> +               // this CPU is a caller that this one interrupted.  It ca=
nnot
> +               // release the flag, so this caller would spin forever.
> +               WARN_ON_ONCE(atomic_read(&sup->srcu_atomic_gp_flag) =3D=
=3D
> +                            smp_processor_id() + 1);
>                 preempt_enable();
>                 if (poll_state_synchronize_srcu(ssp, srcu_state))
>                         return;
> --
> 2.47.3
>
