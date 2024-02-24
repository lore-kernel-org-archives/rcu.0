Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E76AD54
	for <rcu@vger.kernel.org>; Sat, 24 Feb 2024 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708743341; cv=none; b=o2TCxQv4B9lGBEbqVUo1rJJgccVL93/lCh+yTu8V5gN08OhKa04jJdatAektA1odeWznhB0pFnHJUpQFnNb0QB56/pUqmPpHo5CNChQp0HVyOGF58cCOY/ieH6V08JjpfMUXDiZktRLV52yWKJsxPULiSW6fY2i4LXKCAA4kTpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708743341; c=relaxed/simple;
	bh=s0+7DUkxC9v95WTMsMb6JK4YaSoyruhPTd6puPiPmmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTJ1iGi9hjZYN815SY4baXBDEakiWJK1a5rYc1DaK0nq+VfMhFSPzycJ3Skc8AxOHzqT9SUMlSf+9sX9vw46sExvWlgq94MdMKsTrxr1iXbk8VHG3y16o40mXT6DNeP8yHYKDGed+Lju3siGHAFCXptuTVLH34+0+MkRSJ2qmnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFTfIApc; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFTfIApc"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so2330976a12.2
        for <rcu@vger.kernel.org>; Fri, 23 Feb 2024 18:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708743338; x=1709348138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKSTnM2v+jmLIpYPi1kbD+Pb1Qc9BSBN4XGZJPjFFPc=;
        b=BFTfIApcesuZfo0fijYqV2OIduDGhyqXOp8tcjvtN/fhBu0ruO/fiumt+aixl0Rztv
         8aiuSDdY04VK6p0Db9n/u2kJu/Yc1h24Bs4eJjs0bQtuDLF7q5mu1/zgPZ4nSCjlbh84
         vZ0ostgpR+z1DIDQuERCA3mARebpH/V1zxblK2Xh2o/jeTlgBBtZPlRrMSGsSCqh9TV1
         S/xBEAoz6MPHX+1v234zZeMlFA754oy0g9aYgdoPHbx+7/CdqE35Eb0+LX6Bi7LhDOY2
         qjE1ebVmYzEdnWVXaedkl1m1O7QCIpLxSwueAz4KcUvnu11bFo7lhCkx3DgEE5i2Ab69
         koeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708743338; x=1709348138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKSTnM2v+jmLIpYPi1kbD+Pb1Qc9BSBN4XGZJPjFFPc=;
        b=fGwwpZoRQ/oLEMo4mGPQFUdhCaXlRVlEuTQYACZqnAFFKOE51+N+r9uCw/2QpA5o1L
         GqqwtqqQP/O3eUwT65ergbOkwLpBaScle4s/PeCXb6rnTIu22QZ9n7Y1GBSQOFrF9a7m
         tKjKV5kXjNxrrTALskNKpxUnDAL0uHdR2y+0xUVDLPAUL61KMaE1w8EUgQX4Sr12F0aK
         5k7c1l5igKC32S9rggtLfEvLKGyKvMUb5f51bUazduwCo4j559dbOm8YQPbAgI82stOG
         X2l++hRZVlP/d1W2njkvqXqyDdGVKz6t0eybVbGjwpv0BZ0WFES2b+9f5lUEYxxOJL1d
         N6Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVQQtjXjkD4ASwxB3UZNcARnGxQyx+zMimRDk6wUDS/bWAnmpEzJDz7KM8kRrYXFij3FHSDv9s2w8dVLxrUu070cw1D
X-Gm-Message-State: AOJu0YzkEYusIMHQx/XiFkGToJAl/cxyPKGf6QqYIi1LWvYE2wFoe1/X
	obkV8qS8t/ME0e4xibEU/mKL3dcJh/Zz8MrGhc5TG1d3zD7w6pUFDJT3gN+9wAsaK0m+dOxpObd
	fmIMPTcqk8GIrnsghoBHU7V4D6s8=
X-Google-Smtp-Source: AGHT+IHqimg10K1/L+NRQXdNA2GGrmNDOmgRLEkO8bWLdybN2k28avxqLXsoB1b3MUY5xGyvrKtcfZlp0iCGclsq5VA=
X-Received: by 2002:a05:6402:5201:b0:565:a5e1:3a10 with SMTP id
 s1-20020a056402520100b00565a5e13a10mr183414edd.36.1708743337653; Fri, 23 Feb
 2024 18:55:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202402201506.b7e4b9b6-oliver.sang@intel.com> <CANpmjNNGCkfFBNiSsc+DOm1EDzXZoNLQy_jnEZjt9WuxP5aayw@mail.gmail.com>
In-Reply-To: <CANpmjNNGCkfFBNiSsc+DOm1EDzXZoNLQy_jnEZjt9WuxP5aayw@mail.gmail.com>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Sat, 24 Feb 2024 08:25:24 +0530
Message-ID: <CAFwiDX-tVTsNcbrzd63oCCat5DqzhouA_HQv4sd4xS=c-C01yQ@mail.gmail.com>
Subject: Re: [linux-next:master] [kasan] 187292be96: WARNING:suspicious_RCU_usage
To: Marco Elver <elver@google.com>
Cc: kernel test robot <oliver.sang@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 20, 2024 at 1:33=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Tue, 20 Feb 2024 at 08:35, kernel test robot <oliver.sang@intel.com> w=
rote:
> >
> >
> >
> > Hello,
> >
> > we noticed this is a revert commit, below report is for an issue we obs=
erved
> > on this commit but not on its parent. just FYI.
> >
> > 113edefd366346b3 187292be96ae2be247807fac1c3
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :6          100%           6:6     dmesg.WARNING:suspicious_=
RCU_usage
> >
> >
> > kernel test robot noticed "WARNING:suspicious_RCU_usage" on:
> >
> > commit: 187292be96ae2be247807fac1c3a6d89a7cc2a84 ("kasan: revert evicti=
on of stack traces in generic mode")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> This commit didn't touch rcutorture or the rcu subsystem in any way,
> so I currently don't understand how rcutorture would be affected.
> While stackdepot has started to use RCU, this already happened in a
> previous commit, and this particular commit actually reduced RCU usage
> (no more evictions and re-allocations of stacktraces).
>
> The only explanation I have is that it improved performance of a
> KASAN-enabled kernel (which the config here has enabled) so much that
> previously undiscovered issues have now become much more likely to
> occur.
>
> [+Cc rcu folks]
>
> > in testcase: rcutorture

The rcutorture test type executed here is busted_srcud (torture_type:
busted_srcud). The busted_srcud torture test creates bad reader critical
section usages - in this case the rcu reader lock acquired was not
srcu lock, which subsequently resulted in rcu_dereference_check() to
cause a splat due to srcu read lock not being held.

 So, this is expected behavior, and not a problem in either KASAN or RCU.



Thanks
Neeraj

> > version:
> > with following parameters:
> >
> >         runtime: 300s
> >         test: cpuhotplug
> >         torture_type: busted_srcud
> >
> >
> >
> > compiler: clang-17
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m=
 16G
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202402201506.b7e4b9b6-oliver.s=
ang@intel.com
> >
> >
> > [  292.513535][  T653] WARNING: suspicious RCU usage
> > [  292.514923][  T653] 6.8.0-rc4-00126-g187292be96ae #1 Not tainted
> > [  292.516369][  T653] -----------------------------
> > [  292.517743][  T653] kernel/rcu/rcutorture.c:1983 suspicious rcu_dere=
ference_check() usage!
> > [  292.519310][  T653]
> > [  292.519310][  T653] other info that might help us debug this:
> > [  292.519310][  T653]
> > [  292.523130][  T653]
> > [  292.523130][  T653] rcu_scheduler_active =3D 2, debug_locks =3D 1
> > [  292.525644][  T653] no locks held by rcu_torture_rea/653.
> > [  292.526974][  T653]
> > [  292.526974][  T653] stack backtrace:
> > [  292.529271][  T653] CPU: 0 PID: 653 Comm: rcu_torture_rea Not tainte=
d 6.8.0-rc4-00126-g187292be96ae #1
> > [  292.530780][  T653] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [  292.532329][  T653] Call Trace:
> > [  292.533524][  T653]  <TASK>
> > [ 292.534696][ T653] dump_stack_lvl (lib/dump_stack.c:?)
> > [ 292.535941][ T653] ? __cfi_dump_stack_lvl (lib/dump_stack.c:98)
> > [ 292.537221][ T653] ? lockdep_rcu_suspicious (kernel/locking/lockdep.c=
:6712)
> > [ 292.538523][ T653] rcu_torture_one_read (kernel/rcu/rcutorture.c:?) r=
cutorture
> > [ 292.539887][ T653] ? __cfi_lockdep_hardirqs_on_prepare (kernel/lockin=
g/lockdep.c:4312)
> > [ 292.541226][ T653] ? rcu_torture_timer (kernel/rcu/rcutorture.c:1955)=
 rcutorture
> > [ 292.542621][ T653] ? __cfi_rcu_torture_timer (kernel/rcu/rcutorture.c=
:2055) rcutorture
> > [ 292.544012][ T653] ? init_timer_key (include/linux/lockdep.h:135 incl=
ude/linux/lockdep.h:142 include/linux/lockdep.h:148 kernel/time/timer.c:847=
 kernel/time/timer.c:867)
> > [ 292.545262][ T653] rcu_torture_reader (kernel/rcu/rcutorture.c:2093) =
rcutorture
> > [ 292.546579][ T653] ? __cfi_rcu_torture_reader (kernel/rcu/rcutorture.=
c:2076) rcutorture
> > [ 292.547872][ T653] ? __cfi__raw_spin_unlock_irqrestore (kernel/lockin=
g/spinlock.c:193)
> > [ 292.549108][ T653] ? __cfi_rcu_torture_timer (kernel/rcu/rcutorture.c=
:2055) rcutorture
> > [ 292.550341][ T653] ? __kthread_parkme (kernel/kthread.c:?)
> > [ 292.551425][ T653] ? __kthread_parkme (include/linux/instrumented.h:?=
 include/asm-generic/bitops/instrumented-non-atomic.h:141 kernel/kthread.c:=
280)
> > [ 292.552489][ T653] kthread (kernel/kthread.c:390)
> > [ 292.553504][ T653] ? __cfi_rcu_torture_reader (kernel/rcu/rcutorture.=
c:2076) rcutorture
> > [ 292.554689][ T653] ? __cfi_kthread (kernel/kthread.c:341)
> > [ 292.555749][ T653] ret_from_fork (arch/x86/kernel/process.c:153)
> > [ 292.556792][ T653] ? __cfi_kthread (kernel/kthread.c:341)
> > [ 292.557852][ T653] ret_from_fork_asm (arch/x86/entry/entry_64.S:250)
> > [  292.558920][  T653]  </TASK>
> >
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240220/202402201506.b7e4b9b6-=
oliver.sang@intel.com
> >
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
>
