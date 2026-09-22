Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41864A014F
	for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790104199; cv=pass; b=QcYUvb8MkMh1bVJi2qNSlI0+zTynxGPUbptw0mqsJZ0dkTBwh9s+RgqfHal9DxstRxhmdBYlOIXvaDhWVevUEmpdccAbyZEr1KmTjG97a1mwJu/2ts+UgWETeptep72NFOCAwVgX7wPQbzBzrUFyaMzA+f+36TvEs0iHkwMlsrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790104199; c=relaxed/simple;
	bh=HRjLYOJSekKmScBq0Hs/Y+bO8oSzKItDYuuVYeVZwtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9gEkLQqqEobtbBIyc+KtBTC2GobZJSUML2AuytWEwrjHmg5Ib+gykRCTZplAv5symwY1qepYNc/3KA0HF/wzGp9AMwtOgxvtQrViyFYj9qo9lpHJZ1e7/ocUafdlMW9k5VYmEryxM921ns4mBqHGjZtk+7m0RgA4cRULobVDlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EouxBJkg; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EouxBJkg"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c293c683202so20659166b.3
        for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 12:09:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790104196; cv=none;
        d=google.com; s=arc-20260327;
        b=Eg3947JGrjjtiBm+Ic6+f9LHCWFsRd+WmeKfaUluLd/h8bO/kKWSzvOVoCUDMDub6Z
         Dvz2Bc9YYckShYspJTvpwu4XboA00AbE3nFqVb+1DRPA3vXac2bs42tfxVPBnoyygbZl
         +iBee+d4Siew7FJQH35QbKV9R/2TCCsLacUkdfZFP6dKJjDfh8wlGmJlxLeZ4fzeNwLq
         s1vrHbnK13Kx9/qtTAFsQxkQcloRTskbL8x11vTbTHXyVwB8mgiWJUynqOnXBcwEiQOr
         0ILLDYAQI3NhcQz0UFBm28NGIJYAK+3g6W4yznIoMD6FHoslZzAN8c2YQIMMIWvC+eK4
         qYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lK/yFq614ap/r/WmvWFumoINA4i+Bww9N4pHbrRhbvQ=;
        fh=NN9fprm8icpB95jywl33gjmbv3udQQLXzhxUALSMN7E=;
        b=YUrMgsfzIuNHMAhPVhFtM0cI0Css6mBPppvd3W3SgJdJ0h8p68NC5Gu2tDd44zYZS/
         TI8uyi/EFMvlVBBPuLpJJ8UqmGXuQ5cgwMuhbeDWr89b5ar39W5pZ2zwA4N+rs1dOSQM
         aZv6OZFNaIQhatdwiGW2IueNiOF6Pje4k4Ofzmydd7EdnlIsiLEOQZ6ZGF8mj8/BcIky
         ZNaOSxWWaTA/Fh6zdWAALS+RzEWr1oNfGn12piBJjwLSdl/Q1R6WY5ioJAhDl3JqR2U0
         2/Y6vdyeGMvH7ivxDNrqyO+owue2iuYYbS1UNvsVCxUlBlwATdFYpOEVH11uQCNvfoi3
         D3IA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790104196; x=1790708996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lK/yFq614ap/r/WmvWFumoINA4i+Bww9N4pHbrRhbvQ=;
        b=EouxBJkgm//8igosy1bj0J15eJx3MbxEu1M18kmy9WWWyRcgUKOAzyOTL9A65kQEG4
         j3EvMwoZZmRk85/Lw0j7wAM8KMo8xWK+wW+uJ1k6oeep7eyhezOvSAhCNii0q6qaZqN4
         ncPZ4VzP4auZas+ZneZhSX68NP4tSXIoDjbnt0GLeRSBGKbWn+9+2OslGNedI7El6Cap
         WjAbYTevVFzAwNlrZRsy+3qTd1LUVXkWUISYMjIraD/hgcq5dScUUfzQuvzaB2c8JwDH
         umRUXBLhwv2JPWPvTpqyc3ghxhmR50MLvtUXvf9asFBhys2pCUjkZrls7HjfEcMQnR2p
         1kaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790104196; x=1790708996;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lK/yFq614ap/r/WmvWFumoINA4i+Bww9N4pHbrRhbvQ=;
        b=1UkVTKwO/TPYqghrHNZaUPypfsO+vf6SPyobOihw0AbjiatZNw38D2aNPIEgToFUKK
         BnQ1U0/C7/qL0gGlyVV38+CYOMM10wCBWpM/oxUhfVbK6Phz5oOJq1qXOjfM+mWuOM3f
         T82CVPptPtD+sl1dOTIQc77nUdCgDeQLZDiIwDTF8yAiI8Xh1LrldO29d8TlAmfyFRcV
         AvijRiNFYlRoUT6KTX1w6E/0OV+N+DC/48phz4L8hB0xxwvqR1aE44NxcFogKC+Qsy14
         2B2JE+PX4pO1nPfwbD2zXgLjheq7TP2N+HvdaOte78ABWEtMCwcNUaUG67RMjhP78hCy
         hPMQ==
X-Forwarded-Encrypted: i=1; AKwUvBypavKdOAEkermLRfjdRM5nOTd3mz9AmFb2yrXVI8T3ijYdVVv1xTPMk6ynK3PRXIJGK8A=@vger.kernel.org
X-Gm-Message-State: AFuF++mWXVlQ9HQWSHQ64z/0ELpZ419mklMWM/uECC5XFPqYUExh2OoK
	Ld4RqkVOf1kE63sGljYUI5tQVehkv4/i1DFygVTKnu4RFJHY4TX2i4ez5sJM8DSZud5iOgq28i2
	5cYn4vWyDBRcIl2nQIB9bjUbudh0xrmQ=
X-Gm-Gg: AYBFou0aEJ05J/2cwxf/HBc0XsdjBPUfm0rYFWqtYdiCfyeRN2JdMCzcKN7/nabGDb3
	BTSniXu4RZIrz1bSk/UCv+2lkXlLb2xEMPwlHGgPiZIgQh2OEc6aC3OTgZsB8C1eP4P5of4zNg4
	iHRPgfE7lxBkhh3J4YKRpXWO89pHbHr39XyfE8WPw9PrDujRPkMWqO0TCnBT9naju9M0HZtG8jj
	PAXhNcJ4fXRwqbaKqedcXXSGTy4zNpzId8fzBhGcgaKKm1a6fxr9vSN0HpbG7929GudVPLgoMrz
	tHvTKy4a2LpxRKaTIUYD4evqcQHY6bmZSmcEL2wtRADyhnY3F/gC10p0SV3rIw3Kxbt4xVFjsbt
	y4BhaSDyS6yKmNgnVE2TCPow=
X-Received: by 2002:a17:906:618a:b0:c26:19de:9ad1 with SMTP id
 a640c23a62f3a-c2aae134f94mr14378466b.41.1790104195855; Tue, 22 Sep 2026
 12:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921191407.1742386-1-puranjay@kernel.org> <20260921191407.1742386-2-puranjay@kernel.org>
 <DLLGX9F9UG4Q.2YJWNSO4FXT1P@gmail.com> <CANk7y0hpi+vjXCR1oZBoeL8XLDss-HoufJfYkqNwRUXghFYCMg@mail.gmail.com>
 <DLM296AAASVA.3IGQUR5NOALQ6@gmail.com>
In-Reply-To: <DLM296AAASVA.3IGQUR5NOALQ6@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 22 Sep 2026 20:09:44 +0100
X-Gm-Features: AclHuK9KOsB4l2WJ4Vd0mx_mdmwCNUfYrasYFeY_Zw-DTBgioYS2HRptlswmhJs
Message-ID: <CANk7y0g7ZiF5x2j9hZxc4OqFBOFRSWGj6Y9zj5NrX3M1+L3mQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: Add bpf_call_rcu() kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, rcu@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 7:35=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue Sep 22, 2026 at 2:17 PM UTC, Puranjay Mohan wrote:
> >> > +     prog =3D bpf_prog_inc_not_zero(aux->prog);
> >> > +     if (IS_ERR(prog)) {
> >> > +             WRITE_ONCE(rhk->armed, 0);
> >> > +             return -EBADF;
> >> > +     }
> >>
> >> can we drop prog_inc and remove prog pointer from rhk ?
> >> with something like if (prog->has_call_rcu) rcu_barrier() during prog =
unload?
> >
> > That could work but we would need more than just the calls to
> > rcu_barrier_tasks_trace() and/or  rcu_barrier(). As the rcu_barrier
> > only waits for callbacks enqueued before it was called, the registered
> > callback and re-queue itself and cause problems. So, we would need a
> > flag that is set before the call to rcu_barrier() which stops further
> > queueing of callbacks from that program. Also, assuming we add these
> > barrier calls in bpf_prog_free_deferred() which is runs from
> > system_percpu_wq, it could make this run for much longer than
> > expected. What is the motivation for using rcu_barrier() instead of
> > bpf_prog_inc_not_zero()? is it the 8B pointer in rhk or the atomic
> > operation in bpf_prog_inc_not_zero()?
>
> ok. fair enough. let's keep prog inc.
>
> >> > That avoids an allocation and a state machine on the arming path at =
the
> >> > cost of 64 bytes per element, 48 of which are used today.
>
> What was the thinking here? Why ask all progs to waste 16 bytes
> for future extensibility that may never happen?

My broken thought process, rcu_head won't grow anytime soon, I will
fix it in the next version.
