Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3895D218EB7;
	Thu,  8 May 2025 06:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746686605; cv=none; b=vFl6rhbI6qqaL8HTB+zuVafQ5CoC+GNVqBZ6uBsvpH9y5r9ns0bce3qEGpFEMbpg9W1MVyL7CijIk4VO4trfZWiASuwlSccQ9J/v4TAWQsR5hcc423bY5hbPaGqRqqlBNvM8E8bgnuJyERJewilHsykPbRp23RsLuxaAMWztFXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746686605; c=relaxed/simple;
	bh=+/YH4Ykm0Br/gWU2mNE6fJ0JRyLQW7ZvlvtpcQYTTKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8oDFfeOA+X6uQd2RDqpBe7te+po3yY7eulTenysmRMPkmzStGs/vBr6KT+xnSQs0UZC6X9SjOsDzNT07ihyOZr8G6wPNVycmX86T82I6sPL2CkEZhoX4czwTto57W7yEhdwr6CadqrM0jfDhfIREXa7u1VgKkBUMe8BcUe4Th0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBIlYedY; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBIlYedY"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30ab344a1d8so668684a91.3;
        Wed, 07 May 2025 23:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746686603; x=1747291403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3vd+nr4/md7mLkaiDNilczJy6QhOL5CAcFpVz4SHQ8=;
        b=SBIlYedYMvJaJhr+Nob22KBDXxARnqyy54osAkgayfhwvR49a9NgE+gkImNc4e34V5
         PhXerpHwZv37JzhCtmc6oXT0Qmg48Uo5YFJCbTE3g38rEW6kRZ7axul7dZ6mKF4Cj8QK
         AovICAHMhCaZMn/neauOU4+YQdlzR5AiP150GXI74e1N5E8H7j5+ZyfQKIPEz35Z0eR5
         Q0akmr8AAbF+Ok+nl+5jisZf1ijKhUsg9nC2iJiOb+UrPsgzdTFNwzRBarAtLVFWSgw0
         uWdL9qiF0aQ7sIXxiwI/iSc1oJBBmhd/CbFS9ml/Kiof1zNc92YZ8yzODF1Gr9kL/zge
         Q/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746686603; x=1747291403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3vd+nr4/md7mLkaiDNilczJy6QhOL5CAcFpVz4SHQ8=;
        b=AN6M/nlS2MHTYV0Oxj2iwSIYYS91diErb7H/A72rxmZmFLkKo8wPN+rHIOVGc1GnJ5
         0MtkszGiE+XFJyyL/DD+qWTm8Qz6jtLtMym3wiypeRwd1PWyrJbCalBPQbYZ9kLnecpq
         GdBtM8cYbl5KdJ4QW6MFuCmndpQPLwL2bo3k+8EWwN7MjxF/y5OK0k6W7jC4crNLLZlD
         r16Z4AfsGfYKzVh530IUhQxlPrSyoniNcnyNrOTC+/qQYfDulDDrIHzgmtpkKQ3CvfS0
         E5mPNR7sJSOxHziQ3gu2jZpCGHI4jr+HkfxdFY7SNN48gxM4h3nTrluPnbfP8SI/K0Ft
         xCeg==
X-Forwarded-Encrypted: i=1; AJvYcCU8X3usP/pskaISySlBT1vOqGoLx/x0Uk7RP1EJx4KLP7cBRNhs/QxEKE8VBXm7U1TvIIT+@vger.kernel.org, AJvYcCVQPXgLLsx3Yh3UwfzNzgr5ULCVx4d7LTy7nN2w/+vrM3Mqzl38M7vSl9VEXJmBLqCEoHA0C5cwIeoIddM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcy/8D0iaO+MWpn936xXTghW5kL6/JwZnbcUfzk7v0UiByLcsk
	H4LrTc3EnaGoVS3+WXS2RjhmkiTPGA10imTZW1sMc88no9ILSRBdbXM8Oi0MsANJh5rItM2emfG
	uja7AkhzkCWzbi0f35pjrP2ksev8=
X-Gm-Gg: ASbGncuZWUNDGAneHXbLvlpTqnJvWL/cAe03hcjHsuIZMvQhGKAs73+MXVtvJUaafRW
	X9Oe9CS9wlEMWqEelOnN/ZsnpbRcpfQ+TEzBWtWiz28Lt9Do3XbW2VYV7xaH7XlPA+Z9zY0IpN8
	epdpWnMkX7GMSCHv7aCxEr7z4=
X-Google-Smtp-Source: AGHT+IHs0+G6cnOMbkhmEl2R3v8x6Wpv8AqOpmwjAOEsQWYOqj+oCa9TUpu5N7X1n0YVeShQ8G5nVSehLEilduQ+Dc4=
X-Received: by 2002:a17:90b:3c07:b0:2f9:c144:9d13 with SMTP id
 98e67ed59e1d1-30b3a6d3433mr3156049a91.24.1746686603369; Wed, 07 May 2025
 23:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
 <20250507112605.20910-2-qiang.zhang1211@gmail.com> <aBuJi3jhcp4dCbSY@localhost.localdomain>
In-Reply-To: <aBuJi3jhcp4dCbSY@localhost.localdomain>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Thu, 8 May 2025 14:43:11 +0800
X-Gm-Features: ATxdqUH2wLg29BGAZrqR2MNZ_QdKuosI9csOwke_G2Is7of6WmLuP4ITBol-kTc
Message-ID: <CALm+0cWyWrEcsYx+6nDT9XjMdLBDwx27SmAXTPUFLB59TbEc3Q@mail.gmail.com>
Subject: Re: [PATCH v2] rcu/nocb: Add Safe checks for access offloaded rdp
To: Frederic Weisbecker <frederic@kernel.org>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 12:25=E2=80=AFAM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Wed, May 07, 2025 at 07:26:04PM +0800, Zqiang a =C3=A9crit :
> > For built with CONFIG_PROVE_RCU=3Dy and CONFIG_PREEMPT_RT=3Dy kernels,
> > Disable BH does not change the SOFTIRQ corresponding bits in
> > preempt_count(), but change current->softirq_disable_cnt, this
> > resulted in the following splat:
> >
> > WARNING: suspicious RCU usage
> > kernel/rcu/tree_plugin.h:36 Unsafe read of RCU_NOCB offloaded state!
> > stack backtrace:
> > CPU: 0 UID: 0 PID: 22 Comm: rcuc/0
> > Call Trace:
> > [    0.407907]  <TASK>
> > [    0.407910]  dump_stack_lvl+0xbb/0xd0
> > [    0.407917]  dump_stack+0x14/0x20
> > [    0.407920]  lockdep_rcu_suspicious+0x133/0x210
> > [    0.407932]  rcu_rdp_is_offloaded+0x1c3/0x270
> > [    0.407939]  rcu_core+0x471/0x900
> > [    0.407942]  ? lockdep_hardirqs_on+0xd5/0x160
> > [    0.407954]  rcu_cpu_kthread+0x25f/0x870
> > [    0.407959]  ? __pfx_rcu_cpu_kthread+0x10/0x10
> > [    0.407966]  smpboot_thread_fn+0x34c/0xa50
> > [    0.407970]  ? trace_preempt_on+0x54/0x120
> > [    0.407977]  ? __pfx_smpboot_thread_fn+0x10/0x10
> > [    0.407982]  kthread+0x40e/0x840
> > [    0.407990]  ? __pfx_kthread+0x10/0x10
> > [    0.407994]  ? rt_spin_unlock+0x4e/0xb0
> > [    0.407997]  ? rt_spin_unlock+0x4e/0xb0
> > [    0.408000]  ? __pfx_kthread+0x10/0x10
> > [    0.408006]  ? __pfx_kthread+0x10/0x10
> > [    0.408011]  ret_from_fork+0x40/0x70
> > [    0.408013]  ? __pfx_kthread+0x10/0x10
> > [    0.408018]  ret_from_fork_asm+0x1a/0x30
> > [    0.408042]  </TASK>
> >
> > Currently, triggering an rdp offloaded state change need the
> > corresponding rdp's CPU goes offline, and at this time the rcuc
> > kthreads has already in parking state. this means the corresponding
> > rcuc kthreads can safely read offloaded state of rdp while it's
> > corresponding cpu is online.
> >
> > This commit therefore add softirq_count() check for
> > Preempt-RT kernels.
> >
> > Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > ---
> >  kernel/rcu/tree_plugin.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 003e549f6514..a91b2322a0cd 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -29,7 +29,7 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp=
)
> >                 (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held=
()) ||
> >                 lockdep_is_held(&rdp->nocb_lock) ||
> >                 lockdep_is_held(&rcu_state.nocb_mutex) ||
> > -               (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &=
&
> > +               ((!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) =
|| softirq_count()) &&
> >                  rdp =3D=3D this_cpu_ptr(&rcu_data)) ||
>
> On a second thought, isn't "rdp =3D=3D this_cpu_ptr(&rcu_data)" enough?

If the CONFIG_DEBUG_PREEMPT=3Dy, the following code will cause
a warning in rcuop kthreads:

WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp))

> The offloaded state can only change if the CPU is completely offline.
> But if the current CPU is looking at the local rdp, it means it is online
> and the rdp can't be concurrently [de]offloaded, right?

yes

Thanks
Zqiang

>
> Thanks.
>
> >                 rcu_current_is_nocb_kthread(rdp)),
> >               "Unsafe read of RCU_NOCB offloaded state"
> > --
> > 2.17.1
> >
> >
>
> --
> Frederic Weisbecker
> SUSE Labs
