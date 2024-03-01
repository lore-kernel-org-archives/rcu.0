Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA71E4BD
	for <rcu@vger.kernel.org>; Fri,  1 Mar 2024 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281847; cv=none; b=mDbgg9ahlkv6dQVes1YIwMMS+L0SWMvD1qRpuWjbeW5F78U2G68lDyIeiEcbHkmMX7yILbk1CYAuktyi1PQNJvqurxFS01TWdaj+yD1+3wDo83KXD9a0JSG8WaCYtMFelI+fClF3iUMmyXmBwoj3b8kOrAuszsyEJCCQgo5EFks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281847; c=relaxed/simple;
	bh=kmXMD5wxosP4C0HytvGYV8f6rRp1M0hxu3/wjfE2CJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQf3E7iEZu0UmnCqBAAwBAffHF6WHxBvRARPP5UUwfMVmaKA3lwi/uzSV5pTujjYsA0QRUU5rEasSSL2I7XRf3NE+Ltn0KPA6SPzVKtiMxq8X2xzpXEf4ICrFY7Y8LbgkSytIInWg1mClfUC5Zr+qdV81r9052fv3MvB0MZjYgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGXprctB; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGXprctB"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso8660a12.0
        for <rcu@vger.kernel.org>; Fri, 01 Mar 2024 00:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709281843; x=1709886643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmXMD5wxosP4C0HytvGYV8f6rRp1M0hxu3/wjfE2CJ8=;
        b=rGXprctBDcRXELGRZjuJjUglDPm4/EGZQqkhXTQ/CVqpVjQ1vO9ClIB8VJjDsvvzP1
         tHuX1uKzcss99uesUQNo9NHEU9IyAb9Shd9sh/E2QYacSWlO6ZzpeUxa4+7s2f3lkUv6
         uQr7OSexv1DfIFUVmSmu95u9vPNExqqW55M57ibHkpn1sLBhaT62BIm+Rrm3mM9IVCwh
         bKpWGSSKogKIJo+g+yM20PUXg8Qmx0NQvWzXdFNTQUdvETtkym/AJrv12ylTlsF2IinR
         S5kIL44DHvqujGfOKlT0HHV7EH7j3nYIASHUxNMZ2a6DIV/G6WJarQI/8oo18olAoMni
         MALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709281843; x=1709886643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmXMD5wxosP4C0HytvGYV8f6rRp1M0hxu3/wjfE2CJ8=;
        b=N1o0i44moCKlG+7uHpZNC583nVApVgCHw9Enf7UftxYdp941BoXcm7kVI38hLYyoCL
         DUb4sY7CTbwsr6LK3bdfkqq5ENKo1BaA9BEwRR430qA5U46Nw8b2T69pX+Rat78QcMUe
         K95+VPUyhRh1mizHqx9DiGYeFVObF4xIrHn9lRQ7ezVUP1H2nPUJXIARMZhXYucWMv9D
         lfUdCgM9q9JBLSLDazbKyvSTdWi6HsCFlh2B+8sIZLCPmw0EIk5pXTCF9GnOfsNp3DWQ
         vOiFJKDVJPJ+u7w+Z1z5VWzLgTIpO2ocTpYBcCAnrWaYJM3hw1yQ+d9n6dFjNtAZszsw
         a4IA==
X-Forwarded-Encrypted: i=1; AJvYcCWGNoUlGYYJum0T0ZWAvY47beALbC7+o1Xhew3cKyods5igBoooyRee26prp5tVK4Mafyb9BtWFozyG3Wp3Z4G4yqHy
X-Gm-Message-State: AOJu0YzH7Wcj1Bv/xjktRLP2Myid1rdYANQ3jt+RTDrMKi0Q9DnNLK+c
	l8EEIltmpxXyFeN6i3vIjO8pm6U6GNSJKxoZ6RScSrr5uKnSuVpKOa+EBf9yal/u7TcleGWEEn4
	Fc82PNZSydtdhr7k/d7GKQNrWzh2zx39JMdHI
X-Google-Smtp-Source: AGHT+IEwf1M0NlR4bQMpE6O2swlKwBptVLThyMgoIRxdaxLQgX35Cs6YnZnFaBd9av2rZ/03Z91FM2azqVxy5Ou4Vt8=
X-Received: by 2002:a05:6402:b10:b0:565:ad42:b97d with SMTP id
 bm16-20020a0564020b1000b00565ad42b97dmr90989edb.0.1709281843426; Fri, 01 Mar
 2024 00:30:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeFPz4D121TgvCje@debian.debian> <CAO3-PboqKqjqrAScqzu6aB8d+fOq97_Wuz8b7d5uoMKT-+-WvQ@mail.gmail.com>
In-Reply-To: <CAO3-PboqKqjqrAScqzu6aB8d+fOq97_Wuz8b7d5uoMKT-+-WvQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 09:30:32 +0100
Message-ID: <CANn89iLCv0f3vBYt8W+_ZDuNeOY1jDLDBfMbOj7Hzi8s0xQCZA@mail.gmail.com>
Subject: Re: [PATCH v2] net: raise RCU qs after each threaded NAPI poll
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com, Joel Fernandes <joel@joelfernandes.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 4:50=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wrote:
>
> On Thu, Feb 29, 2024 at 9:47=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wro=
te:
> >
> > We noticed task RCUs being blocked when threaded NAPIs are very busy at
> > workloads: detaching any BPF tracing programs, i.e. removing a ftrace
> > trampoline, will simply block for very long in rcu_tasks_wait_gp. This
> > ranges from hundreds of seconds to even an hour, severely harming any
...
> >
> > Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop suppo=
rt")
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> > v1->v2: moved rcu_softirq_qs out from bh critical section, and only
> > raise it after a second of repolling. Added some brief perf test result=
.
> >
> Link to v1: https://lore.kernel.org/netdev/Zd4DXTyCf17lcTfq@debian.debian=
/T/#u
> And I apparently forgot to rename the subject since it's not raising
> after every poll (let me know if it is prefered to send a V3 to fix
> it)
>

I could not see the reason for 1sec (HZ) delays.

Would calling rcu_softirq_qs() every ~10ms instead be a serious issue ?

In anycase, if this all about rcu_tasks, I would prefer using a macro
defined in kernel/rcu/tasks.h
instead of having a hidden constant in a networking core function.

Thanks.
