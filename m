Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BEC13D638
	for <rcu@vger.kernel.org>; Tue, 31 Mar 2026 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774981043; cv=none; b=caTO38Y2Y9TWnG7gudkDFmAtzctRPJ9tm6Kp1CJNevrHX5wEIrmLbdbcBegmLgFDRaKxbUi4rfqsoKb1gNpUPY2j45lrfnjxSYdR6ayxQsCndp4ThEsPO4ZaURoHppVGX/bxxTOpm+4Fpz3XdeAFwnb8VeD+PA30Gga0RfPezlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774981043; c=relaxed/simple;
	bh=Ly67QODbGgBIWZqgOO/FYMst4z4v/VNIbOUN1sgHf5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XkQFxocTZ9kuZ7IYoKjVEQWgL35QC5bUUGtp8tapGasHzjqIdblA3hDby4mcLHH8Qv9puWKAnC28golNIVSXHKvZH8qzETjSjz/sf0rYzn+3ClKzy0l9EI248ZT96bxUXPvpbgek7SWRh0ZXbPr0EpBVYEF32GGntYAG6z+45cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rfKzOPa/; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rfKzOPa/"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c646e980bso4062553b3a.0
        for <rcu@vger.kernel.org>; Tue, 31 Mar 2026 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774981042; x=1775585842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WXUZURrZS3Jc82G6mEnvbSujfdYAVx/0v5wtIwtfir4=;
        b=rfKzOPa/4HsAdWevstTm7L9Ykaw/mVuVPJDN1MdhF3NvKQ9Q9fk7OLtJW2oB7ftFNM
         AtMAkQ15yyLCfSkst3EtiYE8naqfWOF/6gHnRi2809XR3koFARcbfWRhXTuRoERqn7RX
         0aSwJNL86L9KiHnIcraSLWlPTdY83xfnp4JobTVtGYW9FPngFwwprDyJl3zWMSb7Ha58
         I1wmWIMIm3rrVhWUsgiMd0xT4OIprAELmLjLPoA4F6dS4DcKbP5LVFZ56IipOa0frrMr
         RZJQa2BajpD6b45uBpa7iiQbX2TQSA7hwRuC8tZTipysEvpsDVscwA3ylayA/M2dkC6N
         WVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774981042; x=1775585842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXUZURrZS3Jc82G6mEnvbSujfdYAVx/0v5wtIwtfir4=;
        b=WU+yXpg0A61LJdYznV0n2pm/UxpDzY+7VHevTGVwQRaeNeHlnbOzkQjCfXRBOLQXTD
         21QNqEU4RBmuSz8AxJQUqwlbSA3fNMpVbIFI/67r366058OAQeScYSqJWTX9XDTyk4um
         7z0rasnVe/xatk/JdTC6AtnEpsaAK14Kp2jjyJnRRV8LVR7s+PTSmapugVkyXeI8ZBYu
         cEIchtgIojml7ZEQuB/x9ovPkqLAAfq+iif2I/3yrShdvHY0d4uLvI+oBtbpuIKY0qoK
         kR0rk4jkqpvdpcSHlEIRJ/XU8hqJLp3B3ITHEYEcXNR0cybuxO8o6XXUMnZfQEOmq3KP
         jB+w==
X-Forwarded-Encrypted: i=1; AJvYcCXZKNl+g3pjsdifUt8DF7tBz/U0JToUCUVKoxl4r3qoqHc8atYYpNYJD7Dtzx9dkhJ6CRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyYtbgRsW34Xrrysh9asT+1/tYK9/tjmAHhPo6nahyG/oiNXgU
	ZWCzuPME0KaAkqAk5XJyHV7VPma/7EWWR9BtZ7KVUky9qGEHj06LsDTdvYg+vRiRQhzgz0KJZpY
	Fkn+WhA==
X-Received: from pfbfa42.prod.google.com ([2002:a05:6a00:2d2a:b0:82a:60b4:e9e9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:448d:b0:82c:70a8:faec
 with SMTP id d2e1a72fcca58-82ce8960f03mr651000b3a.21.1774981041480; Tue, 31
 Mar 2026 11:17:21 -0700 (PDT)
Date: Tue, 31 Mar 2026 11:17:19 -0700
In-Reply-To: <20260323064248.1660757-1-sonam.sanju@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323053353.805336-1-sonam.sanju@intel.com> <20260323064248.1660757-1-sonam.sanju@intel.com>
Message-ID: <acwPr_Aic9xd95_R@google.com>
Subject: Re: [PATCH v2] KVM: irqfd: fix deadlock by moving synchronize_srcu
 out of resampler_lock
From: Sean Christopherson <seanjc@google.com>
To: Sonam Sanju <sonam.sanju@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vineeth Pillai <vineeth@bitbyteword.org>, 
	Dmitry Maluka <dmaluka@chromium.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

+srcu folks

Please don't post subsequent versions In-Reply-To previous versions, it tends to
muck up tooling.

On Mon, Mar 23, 2026, Sonam Sanju wrote:
> irqfd_resampler_shutdown() and kvm_irqfd_assign() both call
> synchronize_srcu_expedited() while holding kvm->irqfds.resampler_lock.
> This can deadlock when multiple irqfd workers run concurrently on the
> kvm-irqfd-cleanup workqueue during VM teardown or when VMs are rapidly
> created and destroyed:
> 
>   CPU A (mutex holder)               CPU B/C/D (mutex waiters)
>   irqfd_shutdown()                   irqfd_shutdown() / kvm_irqfd_assign()
>    irqfd_resampler_shutdown()         irqfd_resampler_shutdown()
>     mutex_lock(resampler_lock)  <---- mutex_lock(resampler_lock) //BLOCKED
>     list_del_rcu(...)                     ...blocked...
>     synchronize_srcu_expedited()      // Waiters block workqueue,
>       // waits for SRCU grace            preventing SRCU grace
>       // period which requires            period from completing
>       // workqueue progress          --- DEADLOCK ---
> 
> In irqfd_resampler_shutdown(), the synchronize_srcu_expedited() in
> the else branch is called directly within the mutex.  In the if-last
> branch, kvm_unregister_irq_ack_notifier() also calls
> synchronize_srcu_expedited() internally.  In kvm_irqfd_assign(),
> synchronize_srcu_expedited() is called after list_add_rcu() but
> before mutex_unlock().  All paths can block indefinitely because:
> 
>   1. synchronize_srcu_expedited() waits for an SRCU grace period
>   2. SRCU grace period completion needs workqueue workers to run
>   3. The blocked mutex waiters occupy workqueue slots preventing progress

Unless I'm misunderstanding the bug, "fixing" in this in KVM is papering over an
underlying flaw.  Essentially, this would be establishing a rule that
synchronize_srcu_expedited() can *never* be called while holding a mutex.  That's
not viable.

>   4. The mutex holder never releases the lock -> deadlock
