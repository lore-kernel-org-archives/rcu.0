Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A91B5C5F1
	for <rcu@vger.kernel.org>; Tue, 20 Feb 2024 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416190; cv=none; b=PiC1R3j15okBlZWKPq647MfgbH1A2tLUJE15MmmpnSWu8hMKO+OUowwvX7QdIjxo7bWNdSSczABPh6zU0QjkfwDZ8lUCazPhto09oRNsJWoR7FCxNVlZrijmO75nf2hlJ520pPkBIKHC7Td8MSSY8QpJ7L1DVcEtgjqBa/kClzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416190; c=relaxed/simple;
	bh=9/tlsQMBkfjjKLI9eGKfgWphyzXWhPtK20nWQDbPC9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zmy3f0mHzNg+52fP1yOuEOrKcjOckGre6bMbgZTFm1SLp8H+aH7kthnvKnz4rDzCd06yP2a8i2Qdrx9Cv96bgE7QJEqjUd0OZrrwiZFqmfXJtEjOBWkUb0Lx6fOVZKCp+7V4XcXX5RTa4GDLoj14lQ6j/x4uZVBTRZQflBq2mJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AphMDZig; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AphMDZig"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4704f3e2a99so317447137.3
        for <rcu@vger.kernel.org>; Tue, 20 Feb 2024 00:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708416187; x=1709020987; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8cERgU0ZSCW6FWHFRH3BebgYcwtul5dolkTErrkCLA=;
        b=AphMDZigfZQr+V0A0knT1VRg3CJHTWHGrG0zgkfnkxGssNVTK1wAi8dsglfSvn8tKR
         WrkLUjOvkcOUVGQ8H3iW+L9P7uyuvfeJUu0AEeRixX+zKI/+Of4JoUzcPpZcXUagYwvG
         JDeoxd4LhmRLjd35+f3BEWpQssgb1qbxZr1G0LjBWFylcphOOPA6Qn22ENl61JGKfMwY
         HKel4K+2rOqtWSU0t5PUmnGrEaWPv0UyhijwG4I7KIQ5y65rENB7qCs1D5/fbt55BPcS
         +/dgKnY8afmqPz36I11lNOkM05LEqejIutEzITntssrWNCjeSLxfv2s0gdT34ePqqOYI
         mpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708416187; x=1709020987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8cERgU0ZSCW6FWHFRH3BebgYcwtul5dolkTErrkCLA=;
        b=ZF078efXH2VJx/wsJ1VyZGoDgJ31Q7UQfyCpPsDfs6OU63Yf5yWYIHXLAh/yAaquke
         5qtaqhY5ed1HZWaf9gBeV//UZsV+9pJc7WqpXIQOM0SfNxay32yfY9aVb7b3lVbvFsQE
         v1G5R4ya2HzqDJz+0BqiJ1rsxaFshoSwYTzl47Zjo7SKNHijZHX63pviMVXMyxgHiM8/
         yoeZTKrf7coT2s58TpF6Ex0c2IrxoOaqDWc5R0yFcmOzd3dPrtArqQDT2v6l0K8daEts
         ARsoUSCltz0eBLxGJ4U43YJnfA/uPWcLkXrxOmwPUUVEleKZfUqCuYzFBQtcPj+Apdex
         7LEw==
X-Forwarded-Encrypted: i=1; AJvYcCVOyrifapAvQsmpR4xgwJjT/tT89CcJp+y7AksEpQrCRpOEPABfFgB5AUM1hAFjD1+SZbKlpApj6PFXvDzCua4Zpe1x
X-Gm-Message-State: AOJu0YxZi+/rGtYoct0teulrB+HHd0mXjdvANrn2WRNjY1TGk25uyEvf
	3CkFom282Cn6ygY8VGfJiMWJEWZTxbAJdHEifDzK/kxeJUzc8bXV5v2H8Bxg3jcBO2MG73ssGcf
	0qPOH4g65By57rrUxI6BfyG0EZlramiMr98Ke
X-Google-Smtp-Source: AGHT+IHCY45ImoK8ekSyrT6/DLUYhFKBJDrM3udG68+Od7iJhRKR3MiCxjlUk1plcTgb4AuccfyMMculuYJkx51wdOo=
X-Received: by 2002:a67:eb94:0:b0:46e:c865:6b4a with SMTP id
 e20-20020a67eb94000000b0046ec8656b4amr11196789vso.34.1708416186959; Tue, 20
 Feb 2024 00:03:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202402201506.b7e4b9b6-oliver.sang@intel.com>
In-Reply-To: <202402201506.b7e4b9b6-oliver.sang@intel.com>
From: Marco Elver <elver@google.com>
Date: Tue, 20 Feb 2024 09:02:28 +0100
Message-ID: <CANpmjNNGCkfFBNiSsc+DOm1EDzXZoNLQy_jnEZjt9WuxP5aayw@mail.gmail.com>
Subject: Re: [linux-next:master] [kasan] 187292be96: WARNING:suspicious_RCU_usage
To: kernel test robot <oliver.sang@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 08:35, kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Hello,
>
> we noticed this is a revert commit, below report is for an issue we observed
> on this commit but not on its parent. just FYI.
>
> 113edefd366346b3 187292be96ae2be247807fac1c3
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6          100%           6:6     dmesg.WARNING:suspicious_RCU_usage
>
>
> kernel test robot noticed "WARNING:suspicious_RCU_usage" on:
>
> commit: 187292be96ae2be247807fac1c3a6d89a7cc2a84 ("kasan: revert eviction of stack traces in generic mode")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

This commit didn't touch rcutorture or the rcu subsystem in any way,
so I currently don't understand how rcutorture would be affected.
While stackdepot has started to use RCU, this already happened in a
previous commit, and this particular commit actually reduced RCU usage
(no more evictions and re-allocations of stacktraces).

The only explanation I have is that it improved performance of a
KASAN-enabled kernel (which the config here has enabled) so much that
previously undiscovered issues have now become much more likely to
occur.

[+Cc rcu folks]

> in testcase: rcutorture
> version:
> with following parameters:
>
>         runtime: 300s
>         test: cpuhotplug
>         torture_type: busted_srcud
>
>
>
> compiler: clang-17
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202402201506.b7e4b9b6-oliver.sang@intel.com
>
>
> [  292.513535][  T653] WARNING: suspicious RCU usage
> [  292.514923][  T653] 6.8.0-rc4-00126-g187292be96ae #1 Not tainted
> [  292.516369][  T653] -----------------------------
> [  292.517743][  T653] kernel/rcu/rcutorture.c:1983 suspicious rcu_dereference_check() usage!
> [  292.519310][  T653]
> [  292.519310][  T653] other info that might help us debug this:
> [  292.519310][  T653]
> [  292.523130][  T653]
> [  292.523130][  T653] rcu_scheduler_active = 2, debug_locks = 1
> [  292.525644][  T653] no locks held by rcu_torture_rea/653.
> [  292.526974][  T653]
> [  292.526974][  T653] stack backtrace:
> [  292.529271][  T653] CPU: 0 PID: 653 Comm: rcu_torture_rea Not tainted 6.8.0-rc4-00126-g187292be96ae #1
> [  292.530780][  T653] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  292.532329][  T653] Call Trace:
> [  292.533524][  T653]  <TASK>
> [ 292.534696][ T653] dump_stack_lvl (lib/dump_stack.c:?)
> [ 292.535941][ T653] ? __cfi_dump_stack_lvl (lib/dump_stack.c:98)
> [ 292.537221][ T653] ? lockdep_rcu_suspicious (kernel/locking/lockdep.c:6712)
> [ 292.538523][ T653] rcu_torture_one_read (kernel/rcu/rcutorture.c:?) rcutorture
> [ 292.539887][ T653] ? __cfi_lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4312)
> [ 292.541226][ T653] ? rcu_torture_timer (kernel/rcu/rcutorture.c:1955) rcutorture
> [ 292.542621][ T653] ? __cfi_rcu_torture_timer (kernel/rcu/rcutorture.c:2055) rcutorture
> [ 292.544012][ T653] ? init_timer_key (include/linux/lockdep.h:135 include/linux/lockdep.h:142 include/linux/lockdep.h:148 kernel/time/timer.c:847 kernel/time/timer.c:867)
> [ 292.545262][ T653] rcu_torture_reader (kernel/rcu/rcutorture.c:2093) rcutorture
> [ 292.546579][ T653] ? __cfi_rcu_torture_reader (kernel/rcu/rcutorture.c:2076) rcutorture
> [ 292.547872][ T653] ? __cfi__raw_spin_unlock_irqrestore (kernel/locking/spinlock.c:193)
> [ 292.549108][ T653] ? __cfi_rcu_torture_timer (kernel/rcu/rcutorture.c:2055) rcutorture
> [ 292.550341][ T653] ? __kthread_parkme (kernel/kthread.c:?)
> [ 292.551425][ T653] ? __kthread_parkme (include/linux/instrumented.h:? include/asm-generic/bitops/instrumented-non-atomic.h:141 kernel/kthread.c:280)
> [ 292.552489][ T653] kthread (kernel/kthread.c:390)
> [ 292.553504][ T653] ? __cfi_rcu_torture_reader (kernel/rcu/rcutorture.c:2076) rcutorture
> [ 292.554689][ T653] ? __cfi_kthread (kernel/kthread.c:341)
> [ 292.555749][ T653] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 292.556792][ T653] ? __cfi_kthread (kernel/kthread.c:341)
> [ 292.557852][ T653] ret_from_fork_asm (arch/x86/entry/entry_64.S:250)
> [  292.558920][  T653]  </TASK>
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240220/202402201506.b7e4b9b6-oliver.sang@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
