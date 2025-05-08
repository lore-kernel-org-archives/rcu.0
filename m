Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B74517BA5;
	Thu,  8 May 2025 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746709402; cv=none; b=g3wuj2afSzfV+ODaAjRZsZvN6w62T0iUZv4BCs8K+ph+Psn/waLBZLUYxbIk29/kacxCO/q7r7mNFR/nMNTkVtAUJLHBeKhvsz7DmnCMQ6a/GUu8uJSzeWSD4BwfiQAYcCKDBj5jklI4ce4HzmSkvMRXLYkBF80z3k3vYxZk9Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746709402; c=relaxed/simple;
	bh=oKl2Phw5e2Ra+XisV/dsapRnV31IUYrWmbKbjLL4bfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhxD4LZbWwv6duoCZbzlke+dFxbYIi07Tn9XTS0BkDZtoR0k130EjZ5rsv0gF51gLKYCx1OgD7Y2y4SvbCYGMntB4rdYGTCvfqDwvxD6Ui2h2SOvHGjQw9cPYu1JyAFwSWESzg7v8eCWhRJJZUsj//2QpCknNTAt+rEjWw0jDqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJVssHiO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJVssHiO"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30828fc17adso974864a91.1;
        Thu, 08 May 2025 06:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746709400; x=1747314200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D57AozDDjPJ7InJhem8ymv1OTuorJu+QVHHQXratBUI=;
        b=kJVssHiOaQpFp4N4LDg7YTLksojFgcYg2yfxD89hKhOvJ8sNYwwBez9sXxunwkHLc9
         nk7n0cnqA4aP1USWYn6idrDXx1Bf0DAuutO7Y1N2n8HsSNYgdPCw9RmPAjzsWm47rRiz
         H+QpD8LHhiEjq4QQmtE0A7c6Iz9Nanp1JpUGuYBtt/wPVPdG3ZJEOdXJNWSOT+xPfQf5
         wK2wWmzpCY9rjZp+17CyvcitmoYwJf23N4MU9UTXfjh54lM5K0z4QUK+JQGxOc732p6D
         PfJDTNB5XmgYUbCMF/Vono8M1kjdc0ojepSAqviMJWyxfqNbHKm1VZecM11ZrQZHUx08
         3Bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746709400; x=1747314200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D57AozDDjPJ7InJhem8ymv1OTuorJu+QVHHQXratBUI=;
        b=eAiVCF5NP7oL0ZGJ+n/oSkhvu7+qL1LHUNMA2Z5iB30K813HJHSvVk6Hpqiij1OVRL
         eWOvBos6FDNGiGmWq8VBU3kgnU7vDQyYD7gsylEY6TUYhGcxf4dpJXgpyvJigFqZAxEH
         xxgkAlP/hnCXeh1CD8r0fxI4Fd0ML/UDBeTCZLK9dbF3yaGmS1p7BjWLuH2F/+Kk+LVa
         ESfVxngjzObd6BKSRf524XshHtTCn07sBn76beC3XuQh4j3ihVAy6qPTeAGVK1SnfpF+
         9O9xXKCkskORwngX3amku/n3xDIiJ8K2kN32ObV40KEKOgj6uNdp+Jt6YyJqZSizftnq
         FF1w==
X-Forwarded-Encrypted: i=1; AJvYcCV2lPiPNIu6t5p3a6dIcJLgiHdNCntdYtNftDGnsWnB30vssNdnRsXDICAUQGp/3bM5rlaG@vger.kernel.org, AJvYcCXXEvJACUx0g80On9jsx7YW0VFtTlF+nkIJv4TRWorWr0sowWy5UBcb5QYiCe75i5C0U4HMKq1VPsAy2qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAj40gMu/m4ETST+ngLcKJojubPhAY4AElMUtEb53uj6MDblpT
	O+1vi2/uMTNXfjDhKKbTKr/xPm1rrZ4G9kqwhO5Y6T5+oYAnL/zqpD7oI4bNxG56aZOdzBSl+Nz
	9JxZwHsQ4Zsl1LuQJN1i3bR+LrZ3e2Le2MpG/ReWX
X-Gm-Gg: ASbGncstWgbfVm2gmBxpeUUcLi6cdT3m1arBD4WGusqfaOTjEP/xQOn7hA8IIqUBShA
	6BWiLpzhpYX1ps05to2gqrsEnbZwAkp3T1M4lSA3kvcwJwkqR39ghd5YJWFHo4jCOUzDu9gaWiC
	PqL7C4wFdwNLKtVlkZT5jyAs7kEHgWw7Tox1SYT+UD0HnDw3bSK9U=
X-Google-Smtp-Source: AGHT+IGhC7EFJwwg497CidQd4xtssDERnzd0b3XgXg2hzh3s2ssRpfNz85llFiLCjlyaMIWIg0u+6YNrDlDF/oyzwn4=
X-Received: by 2002:a17:90b:4c88:b0:2fa:15ab:4de7 with SMTP id
 98e67ed59e1d1-30aac19cf0dmr13542374a91.12.1746709400105; Thu, 08 May 2025
 06:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
 <20250507112605.20910-2-qiang.zhang1211@gmail.com> <aBuJi3jhcp4dCbSY@localhost.localdomain>
 <CALm+0cWyWrEcsYx+6nDT9XjMdLBDwx27SmAXTPUFLB59TbEc3Q@mail.gmail.com>
In-Reply-To: <CALm+0cWyWrEcsYx+6nDT9XjMdLBDwx27SmAXTPUFLB59TbEc3Q@mail.gmail.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Thu, 8 May 2025 21:03:07 +0800
X-Gm-Features: ATxdqUFwxnWO4YXMOE8xJGdHbuZTyWf7d1sXFjN0VzpXVj4T0RY0h_crRDp3hWg
Message-ID: <CALm+0cXkGJVnf6cMZ+CMtCgvC3zxT+OdwWguZS0SpZUeyiEb5w@mail.gmail.com>
Subject: Re: [PATCH v2] rcu/nocb: Add Safe checks for access offloaded rdp
To: Frederic Weisbecker <frederic@kernel.org>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On Thu, May 8, 2025 at 12:25=E2=80=AFAM Frederic Weisbecker <frederic@ker=
nel.org> wrote:
> >
> > Le Wed, May 07, 2025 at 07:26:04PM +0800, Zqiang a =C3=A9crit :
> > > For built with CONFIG_PROVE_RCU=3Dy and CONFIG_PREEMPT_RT=3Dy kernels=
,
> > > Disable BH does not change the SOFTIRQ corresponding bits in
> > > preempt_count(), but change current->softirq_disable_cnt, this
> > > resulted in the following splat:
> > >
> > > WARNING: suspicious RCU usage
> > > kernel/rcu/tree_plugin.h:36 Unsafe read of RCU_NOCB offloaded state!
> > > stack backtrace:
> > > CPU: 0 UID: 0 PID: 22 Comm: rcuc/0
> > > Call Trace:
> > > [    0.407907]  <TASK>
> > > [    0.407910]  dump_stack_lvl+0xbb/0xd0
> > > [    0.407917]  dump_stack+0x14/0x20
> > > [    0.407920]  lockdep_rcu_suspicious+0x133/0x210
> > > [    0.407932]  rcu_rdp_is_offloaded+0x1c3/0x270
> > > [    0.407939]  rcu_core+0x471/0x900
> > > [    0.407942]  ? lockdep_hardirqs_on+0xd5/0x160
> > > [    0.407954]  rcu_cpu_kthread+0x25f/0x870
> > > [    0.407959]  ? __pfx_rcu_cpu_kthread+0x10/0x10
> > > [    0.407966]  smpboot_thread_fn+0x34c/0xa50
> > > [    0.407970]  ? trace_preempt_on+0x54/0x120
> > > [    0.407977]  ? __pfx_smpboot_thread_fn+0x10/0x10
> > > [    0.407982]  kthread+0x40e/0x840
> > > [    0.407990]  ? __pfx_kthread+0x10/0x10
> > > [    0.407994]  ? rt_spin_unlock+0x4e/0xb0
> > > [    0.407997]  ? rt_spin_unlock+0x4e/0xb0
> > > [    0.408000]  ? __pfx_kthread+0x10/0x10
> > > [    0.408006]  ? __pfx_kthread+0x10/0x10
> > > [    0.408011]  ret_from_fork+0x40/0x70
> > > [    0.408013]  ? __pfx_kthread+0x10/0x10
> > > [    0.408018]  ret_from_fork_asm+0x1a/0x30
> > > [    0.408042]  </TASK>
> > >
> > > Currently, triggering an rdp offloaded state change need the
> > > corresponding rdp's CPU goes offline, and at this time the rcuc
> > > kthreads has already in parking state. this means the corresponding
> > > rcuc kthreads can safely read offloaded state of rdp while it's
> > > corresponding cpu is online.
> > >
> > > This commit therefore add softirq_count() check for
> > > Preempt-RT kernels.
> > >
> > > Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > ---
> > >  kernel/rcu/tree_plugin.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index 003e549f6514..a91b2322a0cd 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -29,7 +29,7 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *r=
dp)
> > >                 (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_he=
ld()) ||
> > >                 lockdep_is_held(&rdp->nocb_lock) ||
> > >                 lockdep_is_held(&rcu_state.nocb_mutex) ||
> > > -               (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())=
 &&
> > > +               ((!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()=
) || softirq_count()) &&
> > >                  rdp =3D=3D this_cpu_ptr(&rcu_data)) ||
> >
> > On a second thought, isn't "rdp =3D=3D this_cpu_ptr(&rcu_data)" enough?
>
> If the CONFIG_DEBUG_PREEMPT=3Dy, the following code will cause
> a warning in rcuop kthreads:
>
Only "rdp =3D=3D this_cpu_ptr(&rcu_data)", this_cpu_ptr() trigger warnings.

> WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp))
>
> > The offloaded state can only change if the CPU is completely offline.
> > But if the current CPU is looking at the local rdp, it means it is onli=
ne
> > and the rdp can't be concurrently [de]offloaded, right?
>
> yes
>
> Thanks
> Zqiang
>
> >
> > Thanks.
> >
> > >                 rcu_current_is_nocb_kthread(rdp)),
> > >               "Unsafe read of RCU_NOCB offloaded state"
> > > --
> > > 2.17.1
> > >
> > >
> >
> > --
> > Frederic Weisbecker
> > SUSE Labs
