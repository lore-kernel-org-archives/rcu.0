Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792732788;
	b=K7Xlcsci9YimNdwfEKVq5814j/nzFiBEZPXApVhWTxF2ycHfQx3bgXw6rw/Kw6fyDwVV
	 SF++nRDFpxCsA9STEKk8ADot4zX9nlo/pFpHMhPIxULZBqtb4XAuPCI9MhxkdVOdCoZpC
	 3OiRqimjShZWFc0YOeHLBajjCt7S7Q0C7M+XjfWMq2XYU7MkENanmXTh3IEfSTnZG3Jd/
	 sU5jKkrN4cXtg++k14iWkAnQRm6oSS8YK+VMNtrLOduyx/MKCo7Aez1MzZ9YdDBRSbwLb
	 qFYYhrXUHP161zdenaNvae8Qz0VpeLQJ+lzT80/i8TknZcU1dpAGaa4QZs+XhV41fCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792732788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/NaKMAAGxxDgzyHN/M6S08Zb78X5Vhy8kShaURHSxac=;
	b=QImdpoTZOKOiNGbO9AT4fFhJxIMGW8QLVJ1pPYzTy0FTzkVs4rCBYhTBctPVzAaZwV3Y
	 44OnFvnf99F5+EDKzEPintq34QAaYI6R4GpgSrYjTyicENgVrjIuxD3hqlq3dRFripMIw
	 AkYpnw5OgLXc7teFVG7+12hVJNw3g6NqKw7KRzMQlDL2uhL8KWuirY3J9FyUdTOGPyNTh
	 HkYXGxqh2QE2y6THxVuRl7Mj1eXYLtGK/7w49RoPiJmqeNjUG6yBGShLltRAaZPWdxI6j
	 Jzgefu5syGZRg4incqlVVIGjJpHVgXilXpdBxAcigfFnqUE45HEEKQQLb+Y9VyEJo0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dhN+jjhY;
	arc=fail smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47C5606A31A
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 05:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A47C5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dhN+jjhY
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5337c7b9937so181031cf.0
        for <rcu@vger.kernel.org>; Thu, 22 Oct 2026 22:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792732786; cv=none;
        d=google.com; s=arc-20260327;
        b=czbOHeWWQKwQyVVUmkGueEbQoY1DXlb5ojAoC6XoJ5DC1jA6Q4ltn3jYb75xSgPTij
         6x9timWd4ftGtw8Kah4tZRROXzBA0MpMr9Y6hMUW8Yjb+oa/xYASeE5YK5xxAJDW5xdP
         UPgVvj2tLg1IO1Yat5hqIk4gh6WOFIexqP4tHZOWiaM6s3I5B+f67UgqYo9R+x7xm637
         gPzBSxmVKMDkOC5D2rhTLFKaWptF3X5DOCMMLQGq3/yWIlxWquZM0WpmCQdjAcXGlf8K
         +odbZDOtIoeKOpS4TpTW1Y5MA3ek4LMDKm2jxv6+jqrWJ7WQFeWbz3eI1jnifBNi/Can
         JhHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/NaKMAAGxxDgzyHN/M6S08Zb78X5Vhy8kShaURHSxac=;
        fh=ztBodWjo0Kx6GmVqaz/7fJa0eQ2RpHaORs4P1ZkKWAM=;
        b=k/AWvH7bEnlTrzfJCf/XA/qXuNI1HwOARlmKmVaLRvSda69Glu6X/wYAv6z+853dGJ
         5gRsU/CYbdnMYeeCZgOGbScllsb9Cfh8z7YarJrcXrG+/wJc79WWg16ot8Vfyik2c0ic
         LA4f8WhiVZ+7P1KjCG1wSNHXYJ/K3aLRwNHgSIvfRRboCUjj+WDPNaVMzEyof89fo9SA
         NQE0ejdRV/JFDosYDBj+EWB+J0hRn5PnhBWZMH3eSgeiMYrr8KsqwtBZ8uZazGweVgOg
         Rsd6UKGqJiIkQ20er6+VtHr6baAHdbFwHwACuWpB9It7wwzgfnFh61MyBwNEQxTUIiKe
         JIwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792732786; x=1793337586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/NaKMAAGxxDgzyHN/M6S08Zb78X5Vhy8kShaURHSxac=;
        b=dhN+jjhYDCzHhvHbn33fmDcad2jwo/QdsisYORyUbFD9+SyQfN1B+U21BPynozdCik
         pJRzP91kzKB8uV0dCvorOtfJwoFvPDN1KJ1jFQmtJ7boJ9/GFh+VdTe+LSaszIikyc1k
         +a6ZtlBhP9Gcz6qOLkBWf9KiF1z15aO4Cke0EzKemwnQlqR37Andcj0CmLkwSur/vQXr
         2EyTIJ4ScuMh4Edk0uXxn1CtMI/0roJu+bUbfgXXYGcYq0A8Vdm9fGjm+ZOwJSgjHSc0
         uqEcKEpuDUmFmPjcrYC5WEq90+naPV9OgYcG0qIXPmCEUc31AMRTbOCMXUX+SCjLIvWF
         1c6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792732786; x=1793337586;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/NaKMAAGxxDgzyHN/M6S08Zb78X5Vhy8kShaURHSxac=;
        b=QgW50yuoLHfvDw+xrFcvjHS8AGhPJNjV/XoGu1RjbqUDk5WygmhgGa+rhor7JyAnc9
         MtpcLBWbrLLK4DltgEZf26VX5+jy/kv5N8LUneQukA+POAa1nlsBUB2oLJ8aiIm9vI9P
         9/7WQTLOE5GCmLTopFPaEdKXRmDPy8eDj1vrwoEnqlQv7eGhvgq1D4Lqo6qWY0iz9Xy9
         blvVo9gx2LmCZ82Z002qaacePLueECY4/AIKlQ3FtOIFHfpFqXzfojNJjGscHgFbGyFb
         LJT81N4uisWLigL3pAMO0nHa8UHWs3xMnIj9FLhfb7UXiuCVrAJluWSxQUsAgxrtZeUI
         hbuw==
X-Forwarded-Encrypted: i=1; AKwUvBwHp33GnTNJEHu1B8wqI4zXZ9npmpUy7sDZ9/ss9MlrKKs/3eNimVvDeImkG+Z8HTmYyzw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnKxrh2K4n33jtK5eZwo1qNZGZetx7V4Vdp//DpWFhOURjpGej
	bizFBhc47yqgSFcrpTK2aIBCkJAeQEPI9E0koYAm1IzGJVL3YojWHqU8Gfk92xRhExuWGPGNzai
	b7bGVXefwzRlIVUL8fkB1kTSt4hBq7cyrJ4mhVBWv
X-Gm-Gg: AYBFou2JnQcv/jMPWFMYXu8ugn0heHU2Y3oAiSAfw/VZ8PxMmoc4y0QWdACl0HVHDPo
	ZHsAVSdfk22JPhsd7Q8cTH/r4HWjx7xTco38id9GkhmO4zR0Yld17qFr+YvQ31X65eFCIJIk3qb
	qMq4uZVqkFuL433WjiA/eG5u3ZIGuXC6nrWy6y3h7kNA/XAXZssZZsh4eGRolGzYsXg6O1oNnQU
	bN6FfgMFdbqOmb9l6uDg2I0oTfFPe3tgdU242WHu8PLgIYQDxUk2LBwHprjbWgLaTaoMqs1ZOmC
	Zgj7BT1cS0v3LpEcbU+L/9+EYAHMIuI0W6t+OzudOYBNstitbkoG1PaLE5o4ILHUlJPK+iEHxIf
	tKG0HWnJF46oNI0gScHIDZbORXgN5WdmIArFGyA==
X-Received: by 2002:a05:622a:410e:b0:531:282:6560 with SMTP id
 d75a77b69052e-536c499a845mr5631721cf.15.1792732786055; Thu, 22 Oct 2026
 22:19:46 -0700 (PDT)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020205859.1080743-1-irogers@google.com> <20261022203003.1779152-1-irogers@google.com>
 <20261022203003.1779152-7-irogers@google.com> <atqUsIBhPaxjp3p8@google.com>
In-Reply-To: <atqUsIBhPaxjp3p8@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Oct 2026 22:19:34 -0700
X-Gm-Features: AclHuK8074tTEIi4nbK08SZtgABfkl_zUHjYXnlEC7ftpUdA3DXoCtzUr3SI0rM
Message-ID: <CAP-5=fUZ+=_b_1SL7B=wtab=8foQ6iDKXrxQ_k8wDZaJTd43Pg@mail.gmail.com>
Subject: Re: [PATCH v6 06/11] perf bpf-filter: Extend lock_held() to other
 kernel lock types
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, ddhariwal@google.com, 
	eranian@google.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 3:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 22, 2026 at 01:29:58PM -0700, Ian Rogers wrote:
[snip]
> > +static const struct lock_prog_desc lock_progs[] =3D {
> > +     /* Mutex */
> > +     LOCK_FPROG(fexit_mutex_lock, "mutex_lock", LOCK_PROG_MUTEX),
> > +     LOCK_FPROG(fexit_mutex_lock_nested, "mutex_lock_nested", LOCK_PRO=
G_MUTEX),
> > +     LOCK_FPROG(fexit__mutex_lock_nest_lock, "_mutex_lock_nest_lock", =
LOCK_PROG_MUTEX),
> > +     LOCK_FPROG(fexit_mutex_lock_io, "mutex_lock_io", LOCK_PROG_MUTEX)=
,
> > +     LOCK_FPROG(fexit_mutex_lock_io_nested, "mutex_lock_io_nested", LO=
CK_PROG_MUTEX),
> > +     LOCK_FPROG(fexit_mutex_lock_interruptible, "mutex_lock_interrupti=
ble", LOCK_PROG_MUTEX),
> > +     LOCK_FPROG(fexit_mutex_lock_interruptible_nested, "mutex_lock_int=
erruptible_nested",
> > +                LOCK_PROG_MUTEX),
> > +     LOCK_FPROG(fexit_mutex_lock_killable, "mutex_lock_killable", LOCK=
_PROG_MUTEX),
> > +     LOCK_FPROG(fexit__mutex_lock_killable, "_mutex_lock_killable", LO=
CK_PROG_MUTEX),
> > +     LOCK_FPROG(fexit_mutex_trylock, "mutex_trylock", LOCK_PROG_MUTEX)=
,
> > +     LOCK_FPROG(fexit__mutex_trylock_nest_lock, "_mutex_trylock_nest_l=
ock", LOCK_PROG_MUTEX),
> > +     LOCK_FPROG(fentry_mutex_unlock, "mutex_unlock", LOCK_PROG_MUTEX),
>
> I'm not sure if these are still needed.. it can handle mutexes
> specially, right?

The direct lock->owner check only works when we already know the
mutex's address, i.e. lock_held(<global mutex symbol>). In that case
prescan_one_lock_expr() adds no LOCK_PROG_MUTEX group, and
configure_lock_progs() turns autoload off for all of these programs,
so none of them are loaded.

They're still needed when the address isn't known up front, or the
target matches many mutexes:
 - lock type filters, e.g. lock_held(mutex) or "lock_held(mutex) ||
lock_held(rwsem)" for the direct reclaim use case. There we need to
know whether the current task holds any mutex, which means tracking
acquire/release in held_locks;
 - slab cache filters (lock_held(&<cache>)), where the lock is
embedded in a dynamically allocated object and we match on the
kmem_cache of the address recorded at acquire time;
 - hex addresses and symbols whose type can't be determined, where we
hook every lock family.

So they're only loaded when the filter actually needs them. I'll add a
comment above lock_progs[] in the next version explaining this.

Thanks,
Ian

> Thanks,
> Namhyung
