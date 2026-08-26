Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107643C0611
	for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787738134; cv=none; b=HH+wH0bJP8EgtrM875gUSiV9qW+sw0MytrEOjECufD/CR6pACr9YGMmDWyrpZhQp/enLjAUASclHMyDvmnnBZAwnDWOucsAsrIwKQQ1PwIyESJRaR52U+bCF5cBsZuv/lYGdYkFlAQzHZLJAfktrOL6NDG/WFfK4lS+CfSGjuhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787738134; c=relaxed/simple;
	bh=vKVBgVDkC9p9ib6VLZnEvV0q/NZX0XWkJd+kAZl8gC0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIuJ592zwIZd01J4+sEuybavW5/n4XtZQMcsiDX6JHo60Wvb5o8BFfR0lLLb65Y8BmCgADIz6ZQJUL9i27FrgTNFzr4sVsv2KG16YBZQch5r4Aa+q5AjXOUjgRCmUo8fvn0wp2jnse4RoMGk/fzywbyL1ZIetRFWAhoog8z9Fdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyK/dWId; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyK/dWId"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47fd66a094eso133431f8f.3
        for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 02:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787738130; x=1788342930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6o19Hkqlah4gFMgFOPcHOs0qa4glxgWTSQ80gDs39Yc=;
        b=jyK/dWIdQaVx2XbcgBBICYbyHd7D4hN6O7w2aGfP/1sJME5fJK6e9ahwyMWmYmh1TG
         xJX2gimiaMAtIjnq1Be7bUQJKry+yFwtZITwXbBW7/ks2Vq6+2CvmKuOa8/wgGLtUWaA
         sDCNeKHvvqHDZVTza612OGSN6HqvGa0JqZSCEEpbCeKIyqxPQFdEwrbEOlAKq4bWFsO8
         kFguG0/6hmECBLgxhb2SCtxwqL1aP7HbNIpjlw5yZko4NT+EWbqf+ljZ2dpy4a96L4R1
         V6pUiEgvDgHkNu5X1b5IWWa0mtmMcECrUpB/tK+CBq+bYhFyaooU2qcVTL/TmLO1Y12n
         Cv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787738130; x=1788342930;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6o19Hkqlah4gFMgFOPcHOs0qa4glxgWTSQ80gDs39Yc=;
        b=mfJWHDx46IJPhZqFf5eaHEvq9nw9bwRzXjRuXWlSRvJZwpx5VNnmqrerODWa1VHZXM
         Cx+DuCLxk9kxMgRfqFaL68vob9RasKNz0H5d841bXn0D9kOsLJJ+M/65qEvn9BQq4I+3
         lxPEHjAdu+C1ojtVoCKUzeSZ0MkvaNEUJZqjja3i/v/Tu2bj02q+eNQ50W6axCn0VnRH
         dz2m+x8tPev7j/NdGN3aLRTUadWu1s0oN1Geqw828/qyp3aiJg83H1XKEAd2thfHGCHD
         q5bVNCZ/FvBCUagZ91wqB/gNnU5VuNn6uHIv1nu4Ve9VjYs1OuTcRcfu9xSawRKKzESU
         lGrQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpvil2xBQyiYCrYenMDyDMs8m2yYI1Tz9LhCvMx4wdlGFE6jsN1KaYJrYRXjMgjhblUnro=@vger.kernel.org
X-Gm-Message-State: AFuF++nBR+qUsUkq37YEDRIV8BokfdsTiVWRxBU7CcRtsjDa8JPOWc0S
	Ddw6prdSWfnZe8HVkBFD9qJfWZ/0cdCgmKGiz7jUcfWIpIgk36iUAQU3
X-Gm-Gg: AR+sD10SieMbqsn4SzLj0AKvSE5LoJCWiuf+Yke2OcyNy0fdfiObQ82ahFLD4UQKqJh
	uuqpRC5J6+e6JXDUOsZ2RQXSX4da2rGjDA9Eylb9cW77OhYQ9qXcApH1wbobxU7LJSpLNiNVx7h
	psvxNPJcE5i9A82anM9V1oTNOrYSETb+Ad5bC5tK1tQ5ruMuJnVPiew4xErq6YqNe56CYdaCGd3
	v1KDeQMYuJ117ayd5XaZM3sGtU1WmHc+Mr6aCOUcZDiZSsbqaWAMlZIX8diZUQ4LHYORDPb2O1X
	uHDrZlL/wF41oiQ2I3UBT864ANhkcvV4Evs4uz7Xb+a6x5hGL6VQYOeR54YISqrdJ8Du5vCDKuX
	k4l/b+bAtpsHVkIh+/IQiX2JpdHxhWOThaEJl4KhxO9N8jOPSB5sYUFVTnLDxSr0xk/6cRHTvgk
	SqMO8Y4O2ctQtK74VYpq37MtEaDh1gBfP8ie3T7kJxMvW46MbQXxMhZS6ly9TizeW9cHiwExxav
	9TBlu9NuiJJS8vgaEbl/lvUsA==
X-Received: by 2002:a05:6000:228a:b0:481:568e:d6ed with SMTP id ffacd0b85a97d-482e26ba50bmr5626743f8f.15.1787738129797;
        Wed, 26 Aug 2026 02:55:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28dc134sm2176581f8f.20.2026.08.26.02.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 02:55:29 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:55:27 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Steven
 Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Dan Carpenter <error27@gmail.com>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rcu: Fix casting while dereferencing rcu pointers
Message-ID: <20260826105527.7ebbb4b1@pumpkin>
In-Reply-To: <20260825-unqual-v1-1-7024fb81b4f9@chromium.org>
References: <20260825-unqual-v1-0-7024fb81b4f9@chromium.org>
	<20260825-unqual-v1-1-7024fb81b4f9@chromium.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Aug 2026 20:02:10 +0000
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Recent versions of smatch preserved the address space qualifiers with
> typeof()[1].
> 
> This fix has discovered an invalid casting in rcu dereference logic.
> 
> This patch fixes tens of smatch errors like the following:
> ./include/trace/events/vb2.h:46:1: warning: incorrect type in assignment (different address spaces)
> ./include/trace/events/vb2.h:46:1:    expected struct tracepoint_func *it_func_ptr
> ./include/trace/events/vb2.h:46:1:    got struct tracepoint_func __rcu *
> 
> [1] https://github.com/error27/smatch/commit/e53027a4e816a772403baafa83c09e4a94c1cb8f
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  include/linux/rcupdate.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 44c07a66edff..80276cedda80 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -488,7 +488,7 @@ static __always_inline bool lockdep_assert_rcu_helper(bool c, const struct __ctx
>  context_unsafe(								\
>  	typeof(*p) *local = (typeof(*p) *__force)(p);			\
>  	rcu_check_sparse(p, __rcu);					\
> -	((typeof(*p) __force __kernel *)(local))			\
> +	((TYPEOF_UNQUAL(*p) __force __kernel *)(local))			\

Ugg... TYPEOF_UNQUAL() is absolutely horrid...
When __CHECKER__ is undefined the whole thing is just (p).

I suspect reducing all the definitions would measurably improve
kernel compile time (even before these changes).

David

>  )
>  /**
>   * unrcu_pointer - mark a pointer as not being RCU protected
> @@ -503,7 +503,7 @@ context_unsafe(								\
>  ({ \
>  	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>  	rcu_check_sparse(p, space); \
> -	((typeof(*p) __force __kernel *)(local)); \
> +	((TYPEOF_UNQUAL(*p) __force __kernel *)(local)); \
>  }) )
>  #define __rcu_dereference_check(p, local, c, space) \
>  ({ \
> @@ -511,19 +511,19 @@ context_unsafe(								\
>  	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
>  	rcu_check_sparse(p, space); \
> -	((typeof(*p) __force __kernel *)(local)); \
> +	((TYPEOF_UNQUAL(*p) __force __kernel *)(local)); \
>  })
>  #define __rcu_dereference_protected(p, local, c, space) \
>  ({ \
>  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
>  	rcu_check_sparse(p, space); \
> -	((typeof(*p) __force __kernel *)(p)); \
> +	((TYPEOF_UNQUAL(*p) __force __kernel *)(p)); \
>  })
>  #define __rcu_dereference_raw(p, local) \
>  ({ \
>  	/* Dependency order vs. p above. */ \
>  	typeof(p) local = READ_ONCE(p); \
> -	((typeof(*p) __force __kernel *)(local)); \
> +	((TYPEOF_UNQUAL(*p) __force __kernel *)(local)); \
>  })
>  #define rcu_dereference_raw(p) __rcu_dereference_raw(p, __UNIQUE_ID(rcu))
>  
> 

