Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090F1288B1;
	Fri, 24 Jan 2025 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740928; cv=none; b=RGw8UYHF6S5WsrQCKZpIJalmoy4kN4s5jHsTwJBy3BuFCwAqPqeIove1mZKZyJEAW3fCTai3B9f93g0DMCeiF4zzrtRgmnTHSJUrI2056FK/T/tog2fjPLNeIHClEXclTqtFljDrDgCF8HQOJ8znOM+ALRC92KqZXZq8NFeN6HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740928; c=relaxed/simple;
	bh=2tZxn+7vhKiRLVhMzsCr5d+H+y9GlHUpvF9PxgDw+rQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rj9nAt34lYegfeuZXZa5eIx/vpfakeyB9gOvSnzwe34R9Z7e34PHcGomn+8yA3MJt0AOs61fxK5oz5VKiJ8TROn7XRTAG2uDb9SPoWSJZHfck1vkRW+apr8MogXGj/8BLAp4gQ/Eh+t3UOCdsQywLI7KCbhGUKy84YS4aYIbEio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csU6SdAq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csU6SdAq"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5439b0dd4bfso1913894e87.0;
        Fri, 24 Jan 2025 09:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737740924; x=1738345724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9YA+s894oT6kK4alFLepxPrvIAMR8VCqTe87d8oCirk=;
        b=csU6SdAqiwykHjkqTB/K85o6S4DQWjFTRu3qmUhgaBP2mlNKzwVzrENp3kfGs0Oivv
         znzEUp6w2reQ/C2tIkKKriY9pe1QMQzuG5JyxmB4uV0s8D4pBgnGUFDABMt0hPIjN8ya
         Hn3OBcSD19pWuY89gbm247GIbuP7TvtIfwbVs744wbfM0PzJQEINJgK4wRdALDO+rONj
         jaPB40GjBw67H93x/qvKatDF5ZmONhY3K3irvOoUyAF+kw7sHITbei60hMEp4ImRQvMO
         J0UI1nCnZ/E2iRJ5Tbl1bbkcFfYwaseYUVGAUrWb53Gh8mibkD+3Lg7Lm6uqzbqtm87e
         0ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737740924; x=1738345724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YA+s894oT6kK4alFLepxPrvIAMR8VCqTe87d8oCirk=;
        b=VoakPUMJ7Wv8zkPMRGjZU3zLndenEBr05dd88uGOWq/3Pe/C29jDnQxbiTSly2HEsU
         lviz4IESh/EAd9+abb1Qn95E1vjLnH4TTfhjVt6q2Wk5TDVibMEAb1J1csok7HTNuXWq
         QUxp8nVHBOx6BTwegb8Ya0BVo6yixTZtBkP58kGmMA7oSZ7ZbeXFMGzVQbhMCfFEYvKW
         hw9pkN7lS74PKlygow9Nf1GguV5lxPEqqTmNVZJncRrld6KspRxiLF/RfirYujo5AWAN
         JL/9CqjhR/V55uey1+RAPfQwsU8Jlb/0IZ29VAfvHAHyaGt0BjnaQqBK6UtHvibAQtnA
         eHHg==
X-Forwarded-Encrypted: i=1; AJvYcCUW3cX+MJN0UsldPDWwgk+Cqs4X4SXGqS32iBxvW0LUtlW3P5REqXs7fGc16Hq3smmrMw9M7wfRX9TIFHg=@vger.kernel.org, AJvYcCWrcrP86c7yP0iMKoo/ZiSKy3WdRHVgCvEgxRvSA8jSgJH+z5SGuRAvTnLBZz2URC/1wxme@vger.kernel.org
X-Gm-Message-State: AOJu0YzeAANUOT1Z2PfFjQv3lXwzMPfbIvMV//hQbrTYAzYKIZgy4N7d
	XeRul9FaPtb/LtcHWoJ6I/IAqpkSh9h0rKAl2OkzByO3rc4duLt4
X-Gm-Gg: ASbGncu/WtR5XP/Vokts9kDIovuV/H4rKMyScWHAufg89eN3tYT3tTTjFR1JUSDmU9G
	HK7ZhDAUXz+yridQdDn5kIp0nb7BzzUAO4+ntgVy2VQa89jrbHNubcu9rs9UbSbHTAPZV3Nhj3b
	l9O9kDbfJCtJhKP8MI4dBR0p0sainXvERr2C8AiEnr/XjN8GdugQFnnqz18eobABbP0LxHp8kHw
	KUzPBQQlORsacynG28KYbU8fIJlawFBvbFyO0HuTplno2X7qsdM5dqxCYT5Bn4qNnAIr0lSi2Cx
	+dwUr7+w36fYZOBVpDlM+ZQCUluTI2opDXc=
X-Google-Smtp-Source: AGHT+IFPhuajbawBuz4mBr3cmkLZfIPVdv0RF+ZfRB63ihwbsMcNL5vtlPG+ngWBRLUkTrEXtewZvA==
X-Received: by 2002:a05:6512:3b25:b0:542:2930:4376 with SMTP id 2adb3069b0e04-5439c2462c0mr10847901e87.20.1737740923624;
        Fri, 24 Jan 2025 09:48:43 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c8229276sm358937e87.17.2025.01.24.09.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 09:48:43 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 24 Jan 2025 18:48:40 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/4] torture: Remove CONFIG_NR_CPUS configuration
Message-ID: <Z5PSeEn_ceFuqbnz@pc636>
References: <20250123185828.460836-1-urezki@gmail.com>
 <20250123185828.460836-2-urezki@gmail.com>
 <6f2969e3-344d-4f2d-a71c-ed999ac35324@paulmck-laptop>
 <Z5N8cmpD-HmTYQQJ@pc636>
 <d410ab83-515a-4454-8420-1ada8cf86efd@paulmck-laptop>
 <Z5PMGlDb489VEZ7S@pc636>
 <c57daf05-1018-40b5-9684-22dfd94cc8d9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c57daf05-1018-40b5-9684-22dfd94cc8d9@paulmck-laptop>

On Fri, Jan 24, 2025 at 09:36:07AM -0800, Paul E. McKenney wrote:
> On Fri, Jan 24, 2025 at 06:21:30PM +0100, Uladzislau Rezki wrote:
> > On Fri, Jan 24, 2025 at 07:45:23AM -0800, Paul E. McKenney wrote:
> > > On Fri, Jan 24, 2025 at 12:41:38PM +0100, Uladzislau Rezki wrote:
> > > > On Thu, Jan 23, 2025 at 12:29:45PM -0800, Paul E. McKenney wrote:
> > > > > On Thu, Jan 23, 2025 at 07:58:26PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > > This configuration specifies the maximum number of CPUs which
> > > > > > is set to 8. The problem is that it can not be overwritten for
> > > > > > something higher.
> > > > > > 
> > > > > > Remove that configuration for TREE05, so it is possible to run
> > > > > > the torture test on as many CPUs as many system has.
> > > > > > 
> > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > 
> > > > > You should be able to override this on the kvm.sh command line by
> > > > > specifying "--kconfig CONFIG_NR_CPUS=128" or whatever number you wish.
> > > > > For example, see the torture.sh querying the system's number of CPUs
> > > > > and then specifying it to a number of tests.
> > > > > 
> > > > > Or am I missing something here?
> > > > > 
> > > > It took me a while to understand what happens. Apparently there is this
> > > > 8 CPUs limitation. Yes, i can do it manually by passing --kconfig but
> > > > you need to know about that. I have not expected that.
> > > > 
> > > > Therefore i removed it from the configuration because i have not found
> > > > a good explanation why we need. It is confusing instead :)
> > > 
> > > Right now, if I do a run with --configs "TREE10 14*CFLIST", this will
> > > make use of 20 systems with 80 CPUs each.  If you remove that line from
> > > TREE05, won't each instance of TREE05 consume a full system, for a total
> > > of 33 systems?  Yes, I could use "--kconfig CONFIG_NR_CPUS=8" on the
> > > command line, but that would affect all the scenarios, not just TREE05.
> > > Including (say) TINY01, where I believe that it would cause kvm.sh
> > > to complain about a Kconfig conflict.
> > > 
> > > Hence me not being in favor of this change.  ;-)
> > > 
> > > Is there another way to make things work for both situations?
> > > 
> > OK, i see. Well. I will just go with --kconfig CONFIG_NR_CPUS=foo if i
> > need more CPUs for TREE05.
> > 
> > I will not resist, we just drop this patch :)
> 
> Thank you!
> 
> The bug you are chasing happens when a given synchonize_rcu() interacts
> with RCU readers, correct?
> 
Below one:

<snip>
/*
 * RCU torture fake writer kthread.  Repeatedly calls sync, with a random
 * delay between calls.
 */
static int
rcu_torture_fakewriter(void *arg)
{
...
<snip>

> In rcutorture, only the rcu_torture_writer() call to synchronize_rcu()
> interacts with rcu_torture_reader().  So my guess is that running
> many small TREE05 guest OSes would reproduce this bug more quickly.
> So instead of this:
> 
> 	--kconfig CONFIG_NR_CPUS=128
> 
> Do this:
> 
> 	--configs "16*TREE05"
> 
> Or maybe even this:
> 
> 	--configs "16*TREE05" --kconfig CONFIG_NR_CPUS=4
Thanks for input.

> 
> Thoughts?
> 
If you mean below splat:

<snip>
[   32.107748] =============================
[   32.108512] WARNING: suspicious RCU usage
[   32.109232] 6.12.0-rc4-dirty #66 Not tainted
[   32.110058] -----------------------------
[   32.110817] kernel/events/core.c:13962 RCU-list traversed in non-reader section!!
[   32.111221] kworker/u34:2 (251) used greatest stack depth: 12112 bytes left
[   32.112125]
[   32.112125] other info that might help us debug this:
[   32.112125]
[   32.112130]
[   32.112130] rcu_scheduler_active = 2, debug_locks = 1
[   32.116039] 3 locks held by cpuhp/1/20:
[   32.116758]  #0: ffffffff93a6a750 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x50/0x220
[   32.118410]  #1: ffffffff93a6ce00 (cpuhp_state-down){+.+.}-{0:0}, at: cpuhp_thread_fun+0x50/0x220
[   32.120091]  #2: ffffffff93b7eb68 (pmus_lock){+.+.}-{3:3}, at: perf_event_exit_cpu_context+0x32/0x2d0
[   32.121723]
[   32.121723] stack backtrace:
[   32.122413] CPU: 1 UID: 0 PID: 20 Comm: cpuhp/1 Not tainted 6.12.0-rc4-dirty #66
[   32.123666] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[   32.125302] Call Trace:
[   32.125769]  <TASK>
[   32.126148]  dump_stack_lvl+0x83/0xa0
[   32.126823]  lockdep_rcu_suspicious+0x113/0x180
[   32.127652]  perf_event_exit_cpu_context+0x2c4/0x2d0
[   32.128593]  ? __pfx_perf_event_exit_cpu+0x10/0x10
[   32.129489]  perf_event_exit_cpu+0x9/0x10
[   32.130243]  cpuhp_invoke_callback+0x187/0x6e0
[   32.131065]  ? cpuhp_thread_fun+0x50/0x220
[   32.131800]  cpuhp_thread_fun+0x185/0x220
[   32.132560]  ? __pfx_smpboot_thread_fn+0x10/0x10                                                                                                                           [   32.133394]  smpboot_thread_fn+0xd8/0x1d0
[   32.134050]  kthread+0xd0/0x100
[   32.134592]  ? __pfx_kthread+0x10/0x10
[   32.135270]  ret_from_fork+0x2f/0x50
[   32.135896]  ? __pfx_kthread+0x10/0x10
[   32.136610]  ret_from_fork_asm+0x1a/0x30
[   32.137356]  </TASK>
[   32.140997] smpboot: CPU 1 is now offline
<snip>

I reproduced that using:

+rcutorture.nfakewriters=128
+rcutorture.gp_sync=1
+rcupdate.rcu_expedited=0
+rcupdate.rcu_normal=1
+rcutree.rcu_normal_wake_from_gp=1
<snip>

The test script:

for (( i=0; i<$LOOPS; i++ )); do
        tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 64 --configs \
        '100*TREE05' --memory 20G --bootargs 'rcutorture.fwd_progress=1'
        echo "Done $i"
done

i.e. with more nfakewriters.

If you mean the one that has recently reported, i am not able to
reproduce it anyhow :)

--
Uladzislau Rezki
