Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06D42A8F;
	Sat, 14 Dec 2024 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734192993; cv=none; b=O+icbsR6wKd9dHx3g5WLlh+RRpLEKiOVKJyPRzRfAPYYRLaHCMslfNeh+N3iIATF4zB+R5KhvpklD5xZ+PSODiCxIXpEsuLS9HnwUtczpdMfldRvhe/mNCIlQManLnnzKcMSqkxCAVhNo/W9SjnSFnUoZmJJNdzbBpvnvvR7RCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734192993; c=relaxed/simple;
	bh=QEK45FpIgVz8lykFCUeTYYjcWzewrIcJ3liwvfV/Fts=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GD0Fp35K2FC7Q3niaqEGAldvkJfXiehzAn2I5GZddXCCyLbsqns4MtjZzx58cCsUK5u1PdaGj5/kRxWsVMZTdQ+yfeW7SmrMO+igLBmkphR7bVPptElqGzq7ST04lDji/XvSULmq3L+aUArvt8U6qHxXw+eYffSwaTDGYkz53Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNBK4g9X; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNBK4g9X"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53df19bf6a9so3908612e87.1;
        Sat, 14 Dec 2024 08:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734192989; x=1734797789; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mh4b+XcCR46wXDqiSFlZELAzSEKxQH+Xckte12EcJCg=;
        b=SNBK4g9XVsA6nct4YxFdtZvIC6N4fWu1waXYWOIC9l/7w+00Jv7qHVOcV9mxqal48n
         o8uKJ1aGEY3ZF2qK7p6WjOAmcjwRi8+1WX8u0mg44V5mH+VXoYHFYdyrBB2GtQH2iUfa
         NptAfip59hzvDlAgrBPmZHDT3952E3badQpxyxFaZaHpQ3lopVeQgjtZyYayIB6omOH9
         gjnwXsp/JqLw2+FznrxmUfQynvHD5W7fYsUPtkGntoIlGeiDoHiyZcIh4P2VPonOT9fc
         3JdGrwkOtfFqJqcMCBcS4xchlTYVfudW6c7lUE1RaFgtF2TFBafNM2WV7U2jdhpCyTIc
         pMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734192989; x=1734797789;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mh4b+XcCR46wXDqiSFlZELAzSEKxQH+Xckte12EcJCg=;
        b=PsvaBqjLlU3WAXmWGM1x1s/h0EUtdOUs8AJnXs1papOt3ciAKMI0hD9zTRPKsVG45b
         sfR/8P0FY/22IW6GYtsGgMB+cHp0Yh3KMSo5CPKRLfSUgulXlsmHKakVyCDUugaYGuzY
         zQlTZBLS/A6YhErWzUM8ktYPpjVRmJ8p26epPot/2Wn3r2M+SZ+gZsAcB4PVz4Jf6GVa
         vrzlF/dimM97buIXRhUWXsnJWQBKJRjcbaO4bjjpq3a/vHTdFCivDGGgRLvEGmhViIMM
         yIFhGosDpOZ8iVVcyxfv+y4BM/ELsRsu+gSDOxtHnwJ6socRmr84hnnGpARGaua4zZ7N
         CIuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0LqM+ezEQv4Qk9B92q4U1DsmolPgLCFa4C4wtzKaiHdCPvpg560Oae0qhrdxdkisHTW/e@vger.kernel.org, AJvYcCVlOCKalbLONUQYJwn6vqcWxG3fL0bHn2d+lJwf8k6FN/afSi5mowknJv9d59OXTS/usoMAtHIDAVU0deo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVud5vfeFcARlpoZVYB5L4dGY/316yTj8hEAj8NN+eGOOhCxbs
	21wIOKWFvyk7Mvw7zr/JMBhjqByw1gRUB7P4d7ib9p7V/HXnPqlj
X-Gm-Gg: ASbGncvaXw9N5OgOd1WNS7C3yDoEIPl9Rrmj8CHYj4N21tToLlcHV3zoKrTTx7kM1EN
	1ugf6vRUpRjeHb+MNaWV+sdtZQtBq0+FIL+z8W/e+I7E468nJE0II+9D+S67/mbJiZavCkSMxQB
	On+OZ8DcTZA5nBj+fquJDXpnlEwnnUbW7k9H7ujmnnoXMLBC35ayQIL5P9PMCm0R/uRNi36RaAL
	hIr1FQE4J/fHK1GrOP6pXo=
X-Google-Smtp-Source: AGHT+IG5+RJPZ86OOramJ6CmBHmXc5TVydW50wFZp6Bo0XCn4EowKJSH6Y95I4d4FE4u3BYiHw4SIw==
X-Received: by 2002:a05:6512:3b2c:b0:540:1ec0:4d86 with SMTP id 2adb3069b0e04-54090557eccmr1986805e87.17.1734192989105;
        Sat, 14 Dec 2024 08:16:29 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c13a22sm258809e87.189.2024.12.14.08.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 08:16:28 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Sat, 14 Dec 2024 17:16:27 +0100
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH rcu 2/2] rcu/nocb: Fix rcuog wake-up from offline softirq
Message-ID: <Z12vW37q35hvP5n6@pc636>
References: <c0daba35-f647-40cd-b556-3a04e03da93c@paulmck-laptop>
 <20241212184214.2018411-2-paulmck@kernel.org>
 <Z1y-LbA1UFLb314l@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1y-LbA1UFLb314l@pavilion.home>

On Sat, Dec 14, 2024 at 12:07:25AM +0100, Frederic Weisbecker wrote:
> Le Thu, Dec 12, 2024 at 10:42:14AM -0800, Paul E. McKenney a écrit :
> > From: Frederic Weisbecker <frederic@kernel.org>
> > 
> > After a CPU has set itself offline and before it eventually calls
> > rcutree_report_cpu_dead(), there are still opportunities for callbacks
> > to be enqueued, for example from an IRQ. When that happens on NOCB, the
> > rcuog wake-up is deferred through an IPI to an online CPU in order not
> > to call into the scheduler and risk arming the RT-bandwidth after
> > hrtimers have been migrated out and disabled.
> > 
> > But performing a synchronized IPI from an IRQ is buggy as reported in
> > the following scenario:
> > 
> > 	WARNING: CPU: 1 PID: 26 at kernel/smp.c:633 smp_call_function_single
> > 	Modules linked in: rcutorture torture
> > 	CPU: 1 UID: 0 PID: 26 Comm: migration/1 Not tainted 6.11.0-rc1-00012-g9139f93209d1 #1
> > 	Stopper: multi_cpu_stop+0x0/0x320 <- __stop_cpus+0xd0/0x120
> > 	RIP: 0010:smp_call_function_single
> > 	<IRQ>
> > 	swake_up_one_online
> > 	__call_rcu_nocb_wake
> > 	__call_rcu_common
> > 	? rcu_torture_one_read
> > 	call_timer_fn
> > 	__run_timers
> > 	run_timer_softirq
> > 	handle_softirqs
> > 	irq_exit_rcu
> > 	? tick_handle_periodic
> > 	sysvec_apic_timer_interrupt
> > 	</IRQ>
> > 
> > The periodic tick must be shutdown when the CPU is offline, just like is
> > done for oneshot tick. This must be fixed but this is not enough:
> > softirqs can happen on any hardirq tail and reproduce the above scenario.
> > 
> > Fix this with introducing a special deferred rcuog wake up mode when the
> > CPU is offline. This deferred wake up doesn't arm any timer and simply
> > wait for rcu_report_cpu_dead() to be called in order to flush any
> > pending rcuog wake up.
> > 
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202409231644.4c55582d-lkp@intel.com
> > Fixes: 9139f93209d1 ("rcu/nocb: Fix RT throttling hrtimer armed from offline CPU")
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> You can drop this patch, it has been replaced with another version upstream.
> 
Dropped. Thank you!

--
Uladzislau Rezki
