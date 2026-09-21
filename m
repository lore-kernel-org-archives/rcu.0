Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0668542E8C8
	for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022098; cv=pass; b=gEnmv74+Yp3HPdqX3Gm7vKPjh/GBtWLzo1Un3zlE7iqNynXzYSnyED4+Oa/2BvFMOqxR4zwpVQ+7nMSveFEWhyNNMuEpWDRN8Vav/oSX8T31W9E8mi3NoYcGr64d2dWZiG6LnqYoC+JZ+0o8gMZVcwf2yg8CMmn4SbZ7apmcXFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022098; c=relaxed/simple;
	bh=HL0EylvTbIIIOAHary5gB77Cp4l7ZXs2o2z9aqarAwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VO8+Xkkdibpi+q7IrGUx64k8SLzejP2PvgxFtOx+Pjft7EyTK4K0fFSesNwYRG21Zi4Fe/onpt0U/T4GEPDFFSZHyp3hi1A5UJrVfoJ3Njb0j6+N/wc2pujknJPjcdP6im1aWk1UjtTOyAnGK4v1Ugdy95NR3ouhUKlcJy6bUJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2cPv2MP; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2cPv2MP"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a605844571so4127151a12.3
        for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 13:21:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790022095; cv=none;
        d=google.com; s=arc-20260327;
        b=a3xnx8jEIXbI3+AW7TnB/wIkCj2lB8Y34fxyXzsWgLKCk4JA3nQlNqKae14IXBDHQi
         calddHMrwgjvoD6/amNvjazQsLIK70GM2A5e5c5lws82hrFG588MkogA6eJKryeqSKFz
         x2v3Y7inYqn+r9OqaNoaWdCWlrARVtAP6GjzpFJSfJDSSHADyb4NpHU18u0PtbKFvsDE
         78KlIW2eVCbhP27D/uWWvZhacHBChfIOkrzAngfRze9drr44cwCfUePEJxkRAq5a7JHw
         ygrRl2NgXSihn+D/waRYG0XKEP+UkqQi6mM+iDxrwJvs0bpO53hNuX5dbgFuVckgoikv
         44/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U+5XYYOAqVDSxwqETI3n8kHqel13Z3MatM6vyfeBUH8=;
        fh=qhPv6uiMdwWrVGcjmCUUWy9c7Iwy2hdfDqhUl3TWsPo=;
        b=JljRMV3zWWEiRYoL4w0U0hdXSF5v2mBLTPgrBS4QftXHRbZwYvgBixBc2gKR9D19/h
         plTkl1mxvJzJt+rN+fBe6BfBwcKrabvx0rB/9wpZb9Y9pXK/qCtxDU/3oBSGFBkMq3+P
         4uYZh2iP712+ZhdSjSRqXaRT29Sb30FZIEtitbZ6QXVEiqj634woOa7YITBjavmyaqQV
         KSzBfaxYhQC3OeaQ9xSvTPAjL3L+6PcipX23+Z0fMUdHozH5WYtdKE9F4JFHQAhSZ/ma
         KNQykca7YpAzohaUq5u58ILRYX1uGWcU6VgnoG1+ddwLK5NJCN5f+5umG+lwoXqWLme8
         ZGTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790022095; x=1790626895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U+5XYYOAqVDSxwqETI3n8kHqel13Z3MatM6vyfeBUH8=;
        b=Q2cPv2MPpIG00WN3pYPNgVdxPPTXsHF178Vgvkri5Oe3j+7XSLEjbTRLz1eKjhL36s
         sYJQJAwb0pofVuuwhCFvYZyXsDRWwuvy82hB6jvFdAqchH3HRQZQmFTImNONyiSbXSWa
         xjT4ECFLwM4i+nbXiwtc/IT1PgBp8N+k/5xMBNlqrfGfSZfSK4JH0zYvMifAo9HdV9gl
         s3aCSQYkSjwBkwkGjNK2yngf/424fDmAs7hNPRXwF023zB+I7d7qlirOaM3a++BaYOUQ
         SdEwyUtc5rQs26+0+jn3+T/oscO/QRS8yH1BZSXFXHk0ahfNcxuNHvjNI85lZq2MxjjY
         tFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790022095; x=1790626895;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+5XYYOAqVDSxwqETI3n8kHqel13Z3MatM6vyfeBUH8=;
        b=z6rL97ouEhXuFk2VwhMqahTXKx9hCe6x63+ZGXWQhshEjqzD4wqL5jVTUd8tmtDBSV
         A2XJxPx18+6yiNqkwel5GyV2GQHJ4Dv+syxWq+ihxyRkKepGpVkfoskmBi5VwwExuPay
         9PhPsumprCQhXhLFhuU/1PypT4YhORDg7HfqaeCH01dp3Y3xpcwhhjuMbF255Y0SsjlF
         SWg5Sj01uD2N6UdxR71wj+6VqiOapu1IRFoVJ8on5BpPoU9CfbmYqITO+L2EG4YXtmip
         HvBgI8iis/LmBggDP/xxQV6/FP9dp3+tzL3j9NIG6ZgHvzC3EFg30wsHtvh90WiS2G9b
         864w==
X-Forwarded-Encrypted: i=1; AKwUvBwyDnOPlASXmof7pWyNwmJTVgyXoivAOy2jMGC7F5RS3wY7/2k3kIccH6sxYpVC+SVrVdg=@vger.kernel.org
X-Gm-Message-State: AFuF++kSUd/RR0E4O120hsJoKkRDcX9aIHkONrZzyx/R2o/U0AIPv7yV
	7o+4NtLGsbHmNiWhjLG9LiBfsaW+zH4919vMeBiFqPu8xEAM2bRFNeSBpHPheKzJqLynrQ5YT1a
	61sKGlXl7q8dEthUG5m6OmV9/ZnFPnMk=
X-Gm-Gg: AYBFou32x9aiPynWv8fu0TEpDNtbub+K4fkDZFwUAsJrBL7esCbM9i7A2ZTyAXE/0pw
	hzP93hgjbjh81+IczPQrVvA2SkkM+ApRxmB+H8MZn6WTy5ELbHvm3docIJkGEb9oq+hq7r1rRTr
	4vz5lftVI3oGqQc1w5AmeM5ZLBkzx17vu+JHxSOHw8iWViXhVrRrhKkVmb7YwlRlVezlIywsbgx
	RdtQ/RCxrlMnnLz3AXtZo9nu1jCkNTZPJ4bSz1XxA27urzE1CdSCNnF18xOECGGms3Y88NIrLRK
	DuvrGFwB3hcU6xlTU8Kw5qUeoRDpPuUZJD3LQ3o+IebHql2i/Ugmc0kMjGJXxb/J/k514A==
X-Received: by 2002:a05:6402:2355:b0:6a9:d93f:2a4c with SMTP id
 4fb4d7f45d1cf-6aa545f836emr9135400a12.3.1790022094908; Mon, 21 Sep 2026
 13:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921191407.1742386-4-puranjay@kernel.org> <41b3ffb9922beb0c24d302a85752d4f82ed168fec13f6b1926e34274d9e31338@mail.kernel.org>
In-Reply-To: <41b3ffb9922beb0c24d302a85752d4f82ed168fec13f6b1926e34274d9e31338@mail.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 21 Sep 2026 21:21:21 +0100
X-Gm-Features: AcwNN1XPjU1fOESZgtZBq0kBMbCasuLeG6oILzP9OmaEMLjg5Ejgd9Ky--3Ydvk
Message-ID: <CANk7y0ijFB95gtQVRdjCb7uXGrKyjOpBnyjL+YZWrvFR4aOxcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/4] bpf: Add bpf_call_rcu_tasks_trace() kfunc
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, rcu@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	harry@kernel.org, paulmck@kernel.org, martin.lau@kernel.org, mason@kernel.org, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 9:18=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 8a01dd4058a03..301b35bd85c8a 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -4838,21 +4838,10 @@ static void bpf_rcu_run_callback(struct rcu_hea=
d *rcu)
> >       bpf_prog_put(prog);
> >  }
> >
> > -/**
> > - * bpf_call_rcu - Invoke a BPF callback after an RCU grace period
> > - * @rh: struct bpf_rcu_head in a BPF map value
> > - * @map__const_map: bpf_map that embeds struct bpf_rcu_head in the val=
ues
> > - * @callback: BPF subprogram, invoked as callback(map, key, value) for=
 the value holding @rh
> > - * @aux: bpf_prog_aux of the caller, implicitly set by the verifier
> > - *
> > - * Return: 0, -EBUSY if @rh is already queued, -EPERM if @map is held =
by neither a process
> > - * nor bpffs, or -EBADF if the calling program is going away.
> > - */
> > -__bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const=
_map,
> > -                          bpf_rcu_callback_t callback, struct bpf_prog=
_aux *aux)
> > +static int __bpf_call_rcu(struct bpf_rcu_head *rh, struct bpf_map *map=
, void *callback,
> > +                       struct bpf_prog_aux *aux, bool trace)
> >  {
> >       struct bpf_rcu_head_kern *rhk =3D (void *)rh;
> > -     struct bpf_map *map =3D map__const_map;
> >       struct bpf_prog *prog;
> >
> >       BUILD_BUG_ON(sizeof(struct bpf_rcu_head_kern) > sizeof(struct bpf=
_rcu_head));
>
> This isn't a bug, but why does __bpf_call_rcu() take 'void *callback'
> instead of keeping 'bpf_rcu_callback_t callback' like the kfunc
> wrappers? The two call sites both receive a typed bpf_rcu_callback_t and
> pass it into the void * parameter, which is an implicit
> function-pointer-to-object-pointer conversion (accepted by gcc/clang only
> because the kernel doesn't build with -Wpedantic). Keeping
> 'bpf_rcu_callback_t callback' would preserve type checking at the two
> call sites and match the cast pattern used elsewhere in this file
> (helpers.c:bpf_timer_set_callback, bpf_wq_set_callback_impl) without
> costing anything.
>
> > @@ -4872,13 +4861,50 @@ __bpf_kfunc int bpf_call_rcu(struct bpf_rcu_hea=
d *rh, void *map__const_map,
> >               return -EBADF;
> >       }
> >
> > -     rhk->callback_fn =3D (bpf_callback_t)(void *)callback;
> > +     rhk->callback_fn =3D (bpf_callback_t)callback;
> >       rhk->map =3D map;
> >       rhk->prog =3D prog;
> > -     call_rcu(&rhk->rcu, bpf_rcu_run_callback);
> > +     if (trace)
> > +             call_rcu_tasks_trace(&rhk->rcu, bpf_rcu_run_callback);
> > +     else
> > +             call_rcu(&rhk->rcu, bpf_rcu_run_callback);
> >       return 0;
> >  }
>
> This isn't a bug, but would passing the call_rcu variant (or naming the
> flag 'tasks_trace') read better than a bare 'bool trace' parameter? The
> only behavioural difference between the two kfuncs is which queueing
> function is used, but it's carried through a 'bool trace' flag that the
> reader has to trace to the bottom of the helper to interpret. The name
> 'trace' is also ambiguous in a BPF file where 'trace' usually means
> tracing programs rather than RCU-tasks-trace.
>

No, I think "trace" is good enough, the readers know what this means
so we don't need to over explain here. Of Course if others think
otherwise I will send another version for this.
