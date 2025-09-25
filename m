Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3411A944
	for <rcu@vger.kernel.org>; Thu, 25 Sep 2025 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825672; cv=none; b=ckdlk7mSfnBNmbm9MR68slvSJmT7VgRBEi8o4oluxMHOBeOWC9p8lcdF5CZrxl/DocxEJ5IfVgHkGZgCkvRUO88GN2K/4DsdMY72GUw6fBLpH/9WbjkkcCga2uHBitdxW1QnZtaq4xQre4cpmPz2TAzXe1KiDd7sfTbeXHDGI/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825672; c=relaxed/simple;
	bh=4HyO/Omc0vHIbcGIr8eQR588wv9P0GcwZPgiYarPRNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tcj8oaC43uNZZIT2vFRRM1t3k+94JTCrs8oWaqXXjKl0RK+9gCBmz9wVqKVX2i0lGaP2xB4F9O5IDaINwlm4/2ImT5r7N4oT2sy+hAUe/28Soj4/rrmSWTTg7D9s3aT8JqvLl2GgK1LiSTLD9ydvTHw/cuyw2tuR/4u/7ZJrPDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUE9gCqu; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUE9gCqu"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-330b4739538so1403796a91.3
        for <rcu@vger.kernel.org>; Thu, 25 Sep 2025 11:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758825670; x=1759430470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEVxXuxy2iSH4P0+ikQL58PMDB8CgXAp3tIeCVGBulg=;
        b=aUE9gCquWkY78WVnTKFKVQAruEQAmRQoQo/hME6eATizrCtxhHIO7IYiwddQ9VsI/3
         A229sduPkRgv4LfibQDVu9P6E1WJ4hcp+X6H4yjeRdOJgUIN3dJ7VR30Xt7fEtX97OmW
         ikoUJI+CkB6Tr6LMhPmCBmxePi2obhObTjmiJzUXIyGzfjnzz8XSVI4a+lF1IvDuQpkE
         7uFBlYbuHW97pyl2emPLDS48OiTM7uN7O5QUrYVIvukBO4QFjYQzxMzVwEHrFOhZbLMG
         WSTtX7RAijyieeYneTWjA4TwG2jqbr2ftZg3pj87SjI0gp9fLF6LHX1ryuY3zddQPy/s
         auqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825670; x=1759430470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEVxXuxy2iSH4P0+ikQL58PMDB8CgXAp3tIeCVGBulg=;
        b=jzCvL909fGts9uAD+vlMJp82OPdO15tDo+x3KUGBghnkUQCVwXmG8dgqfvSpgSFlQ1
         tuw2jBmnivhf8/xRb6Wa1FQvfyFef5LOrVM22txUBE5BJKfd7Pxzqf9dO1bePhNyFNJH
         DbuYXZI6okZPHXW64EgS4mBcMm685lOYhoRUppf9Crscvo7fyn5QBKRqXU/Hc3FZADkt
         pzVoIEv1oFMGuLUrs1fkpuDsPea58nxJhca9+BiBhKrJVmVgWlOCxpd892fYOz4/PX3Y
         S2D1km4mIAbIqxVxX2Rhecy8C3nLovJND0H8cS9wl+a6ACEkYl+oqJCwC42b6xvWK1aD
         Fkog==
X-Gm-Message-State: AOJu0YzdlIOWCHg4hi/tqbRj1j3J2B3DH0BdrJHy4Pejs84uHpmPJ74M
	LpbNAaefOjErmUrQG9XHWRderh22yFDpn5LQFyNUhL+H2+IcmeyRuTkgl2CLfCMz4tl89miwZ6D
	5xxgncebLsYqVMd0gnC79XJF2HH4RdoQ=
X-Gm-Gg: ASbGncuaqqM3GGntDVvSiC7oFzwnRs4uSKVTcxroIksniYKz33snDcMEr8f3CtZr1me
	Kg2SLrXZ8qdhr+W6HlzZsEno6eUVgrd2Wc8xiTh/lcdQVqLymmZo9RUMUkW8N5qZciiQM+VjwlQ
	WSQEdoepIhCyhAosJPcQWb+mpV4Y+XPdWZ2Mqml7rBAhvf4aguXip1ikvWjTlt0LrzV9UxUblCo
	LJyaV+gcubj5nlEm6s6s+k=
X-Google-Smtp-Source: AGHT+IGif1F0rH2+wJaNW1qXDTLPrW2/+7ZSS24YvD5gYvwrK7txwD5NgoCPK+1mrFy90rRGnvqMUSh5PdeT8seK+mo=
X-Received: by 2002:a17:90a:a783:b0:330:6c5a:4af4 with SMTP id
 98e67ed59e1d1-3342a2df0e7mr3743478a91.35.1758825669903; Thu, 25 Sep 2025
 11:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop> <20250923142036.112290-19-paulmck@kernel.org>
In-Reply-To: <20250923142036.112290-19-paulmck@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 11:40:54 -0700
X-Gm-Features: AS18NWDkeNOIzlcIpXV73ff3DZBfv87h1AghtZqbjYi5a1vEtT0YGqQqdWBwurE
Message-ID: <CAEf4BzazpB6XHL+HRO0HaegiwCUpXaTi+QSnPAxsW9BHBL=50Q@mail.gmail.com>
Subject: Re: [PATCH 19/34] rcu: Update Requirements.rst for RCU Tasks Trace
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 7:21=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> This commit updates the documentation to declare that RCU Tasks Trace
> is implemented as a thin wrapper around SRCU-fast.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: <bpf@vger.kernel.org>
> ---
>  .../RCU/Design/Requirements/Requirements.rst         | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Doc=
umentation/RCU/Design/Requirements/Requirements.rst
> index f24b3c0b9b0dc6..4a116d7a564edc 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -2779,12 +2779,12 @@ Tasks Trace RCU
>  ~~~~~~~~~~~~~~~
>
>  Some forms of tracing need to sleep in readers, but cannot tolerate
> -SRCU's read-side overhead, which includes a full memory barrier in both
> -srcu_read_lock() and srcu_read_unlock().  This need is handled by a
> -Tasks Trace RCU that uses scheduler locking and IPIs to synchronize with
> -readers.  Real-time systems that cannot tolerate IPIs may build their
> -kernels with ``CONFIG_TASKS_TRACE_RCU_READ_MB=3Dy``, which avoids the IP=
Is at
> -the expense of adding full memory barriers to the read-side primitives.
> +SRCU's read-side overhead, which includes a full memory barrier in
> +both srcu_read_lock() and srcu_read_unlock().  This need is handled by
> +a Tasks Trace RCU API implemented as thin wrappers around SRCU-fast,
> +which avoids the read-side memory barriers, at least for architectures
> +that apply noinstr to kernel entry/exit code (or that build with
> +``CONFIG_TASKS_TRACE_RCU_NO_MB=3Dy``.

For my own education (and due to laziness to try to figure this out on
my own), what's the situation where you'd want to stick to the
old-school "heavy-weight" SRCU vs SRCU-fast variant?

>
>  The tasks-trace-RCU API is also reasonably compact,
>  consisting of rcu_read_lock_trace(), rcu_read_unlock_trace(),
> --
> 2.40.1
>
