Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D181A704B
	for <rcu@vger.kernel.org>; Wed,  9 Oct 2024 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728498209; cv=none; b=KPKear3K1PyQBu7P15xFG4JroZy8bCTU16D0VAPc/UA+pegqFPq/pfNxHzqVP24MYJ+gqW4MKiplBhIxf/WjH2cumfQ1H4BvBZFTt8tcOcZCH94+d4GFYC2Kv+ZdLdYLP/u+Q7gKYMP/T3zFvCYvwLqFuLjPq2qu+xoBwXj1atg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728498209; c=relaxed/simple;
	bh=Q2Vx9BF3bF3iGVgQVOHTeL/KxrH9jG/XSZcnQxdpnCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+semOXR4vtKzXUKxSUVxiPo75Lv5ysegfz0vmtGAW4aIvv4cPEiF+wj8hJhSEDnygOWvLyZRftMf74nWJq1v+F4omiBdvGw7PN9OOM53ck1G9AEaius9kkW0Hv/e3P4D5OfXXjt+H9sqYzxh0P5WmOpHbVGITFy+Tu/0zY7DTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Z8tHnRyP; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Z8tHnRyP"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e038f3835so132764b3a.0
        for <rcu@vger.kernel.org>; Wed, 09 Oct 2024 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1728498207; x=1729103007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x62U96HJG0zxZRYG4nMRhEPMT04s/45JFblgVOnczYw=;
        b=Z8tHnRyPE2nmkhdVvsmJRxFcO2WiYGKYSeGh31awzxvp0lpzzrBn3KeNbFTPqQzIcp
         TYpJYYlZ8cTKIKowxdKlmfOHFKbRKzAoOZC+XiAANiiY/AFsuQu9C+DW+/0HvESP4wvR
         Rrulhlt4h06iiukX1uWPF4TlKTX1ueHbQFt0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728498207; x=1729103007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x62U96HJG0zxZRYG4nMRhEPMT04s/45JFblgVOnczYw=;
        b=cDShsVtvfBv+nX14eLxRdvkffXFxMRFACISpENF/P5L86JEjWouN42fhIgqPvxl+QH
         FCshCFD6pP1FPzeEVEtULoyfP98NNSSCE3w0fIAV+YjTAUDu4Nwo2cCZ1d0mZ/xaQjbz
         Dpzf1JKkMDySr9T0x2TVOc45bUwJ8j4KOyU8BSPknWWXDnmTe3Pt5zUAourB7Zl0lWcA
         3GfnrVh4JrvqQiUaD/0QIxttSmjE2yZeH9PqWQSrETQb+P+zXUN8YlBfCHmDoqpC5HFl
         pSLHlNxrOzL3VTmmdg9wBHmGGGkJ1eWXKHV0ZTcbzdoF5BW9UxuI0VHUCUgb3x9eY2+6
         BZ1w==
X-Forwarded-Encrypted: i=1; AJvYcCXgHOlHy1DqNHwmMpEs5F35drCGUdiyE0mCrXyyYblMPddn6eTyRT4EMiEBnbdudPjRzp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1USdNqZ1cY4QhOeE/wcP6DFipMkVY8cmfmJFyYrtFuS7hjOzm
	RGATBi+s/XNFXcWd3sj+bNKjsraUXB7AvKiFG8+XH2yF8nfNQ06GQ9limSm0eKrPqjw4LwUydvZ
	ef7+YNlFBJzvQtFiM7YsKPb0nwlFqmOb4RmfcTg==
X-Google-Smtp-Source: AGHT+IF0g+2XDV7HiwiEZTjsZy0h8SFQQaXvikhKHyX1AuvN5lae+EJK6gzcWvf2k48PhDoVF7TY/a03CyfCl3yCr90=
X-Received: by 2002:a05:6a00:8d3:b0:71d:fc11:628c with SMTP id
 d2e1a72fcca58-71e1dbcaadcmr4106155b3a.25.1728498207117; Wed, 09 Oct 2024
 11:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002145738.38226-1-frederic@kernel.org> <20241002145738.38226-3-frederic@kernel.org>
In-Reply-To: <20241002145738.38226-3-frederic@kernel.org>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 9 Oct 2024 14:23:15 -0400
Message-ID: <CAEXW_YQSBwGME1+vKHSM8+svtosunk-QO2oMygFKgapPE3b45w@mail.gmail.com>
Subject: Re: [PATCH 2/3] rcu/nocb: Fix rcuog wake-up from offline softirq
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Wed, Oct 2, 2024 at 10:57=E2=80=AFAM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> After a CPU has set itself offline and before it eventually calls
> rcutree_report_cpu_dead(), there are still opportunities for callbacks
> to be enqueued, for example from an IRQ. When that happens on NOCB, the
> rcuog wake-up is deferred through an IPI to an online CPU in order not
> to call into the scheduler and risk arming the RT-bandwidth after
> hrtimers have been migrated out and disabled.
>
> But performing a synchronized IPI from an IRQ is buggy as reported in
> the following scenario:
>
>         WARNING: CPU: 1 PID: 26 at kernel/smp.c:633 smp_call_function_sin=
gle
>         Modules linked in: rcutorture torture
>         CPU: 1 UID: 0 PID: 26 Comm: migration/1 Not tainted 6.11.0-rc1-00=
012-g9139f93209d1 #1
>         Stopper: multi_cpu_stop+0x0/0x320 <- __stop_cpus+0xd0/0x120
>         RIP: 0010:smp_call_function_single
>         <IRQ>
>         swake_up_one_online
>         __call_rcu_nocb_wake
>         __call_rcu_common
>         ? rcu_torture_one_read
>         call_timer_fn
>         __run_timers
>         run_timer_softirq
>         handle_softirqs
>         irq_exit_rcu

This call stack seems a bit confusing with the context of the first
paragraph. In the beginning of changelog, you had mentioned the issue
happens from IRQ, but in fact the callstack here is from softirq
right? The IRQ issue should already be resolved in current code
AFAICS.

>         ? tick_handle_periodic
>         sysvec_apic_timer_interrupt
>         </IRQ>
>
> The periodic tick must be shutdown when the CPU is offline, just like is
> done for oneshot tick. This must be fixed but this is not enough:
> softirqs can happen on any hardirq tail and reproduce the above scenario.
>
> Fix this with introducing a special deferred rcuog wake up mode when the
> CPU is offline. This deferred wake up doesn't arm any timer and simply
> wait for rcu_report_cpu_dead() to be called in order to flush any
> pending rcuog wake up.
[...]
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index a9a811d9d7a3..7ed060edd12b 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -290,6 +290,7 @@ struct rcu_data {
>  #define RCU_NOCB_WAKE_LAZY     2
>  #define RCU_NOCB_WAKE          3
>  #define RCU_NOCB_WAKE_FORCE    4
> +#define RCU_NOCB_WAKE_OFFLINE   5
>
>  #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
>                                         /* For jiffies_till_first_fqs and=
 */
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 2fb803f863da..8648233e1717 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -295,6 +295,8 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, =
int waketype,
>         case RCU_NOCB_WAKE_FORCE:
>                 if (rdp_gp->nocb_defer_wakeup < RCU_NOCB_WAKE)
>                         mod_timer(&rdp_gp->nocb_timer, jiffies + 1);
> +               fallthrough;
> +       case RCU_NOCB_WAKE_OFFLINE:
>                 if (rdp_gp->nocb_defer_wakeup < waketype)
>                         WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>                 break;
> @@ -562,8 +564,16 @@ static void __call_rcu_nocb_wake(struct rcu_data *rd=
p, bool was_alldone,
>         lazy_len =3D READ_ONCE(rdp->lazy_len);
>         if (was_alldone) {
>                 rdp->qlen_last_fqs_check =3D len;
> -               // Only lazy CBs in bypass list
> -               if (lazy_len && bypass_len =3D=3D lazy_len) {
> +               if (cpu_is_offline(rdp->cpu)) {
> +                       /*
> +                        * Offline CPUs can't call swake_up_one_online() =
from IRQs. Rely
> +                        * on the final deferred wake-up rcutree_report_c=
pu_dead()
> +                        */
> +                       rcu_nocb_unlock(rdp);
> +                       wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_OFFLINE,
> +                                          TPS("WakeEmptyIsDeferredOfflin=
e"));
> +               } else if (lazy_len && bypass_len =3D=3D lazy_len) {

Since the call stack is when softirqs are disabled,  would an
alternative fix be (pseudocode):

Change the following in the "if (was_alldone)" block:

               if (!irqs_disabled_flags(flags)) {

to:
               if (!irqs_disabled_flags(flags) && !in_softirq())

?

That way perhaps an additional RCU_NOCB flag is not needed.

Or does that not work for some reason?

thanks,

 - Joel
