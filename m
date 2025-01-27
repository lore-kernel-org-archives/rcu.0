Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BAE18FDA5;
	Mon, 27 Jan 2025 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738010239; cv=none; b=E1C7t6jpSwk6Hnsvai0qLTGEZbzWwclxyS+UOYSnMfXckv0gGrAFeH19QXlfrXu+PL71EdhELLOjHZ3w4CM9Z5LYzkWizbK8lBa2jBfnkHEreGqtQrvsJg8IWL3MLvRQ4Un6iI5R9WeywNN+tqb52t1NKnSnVU2mQ0ekLe+GVBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738010239; c=relaxed/simple;
	bh=3PwW9c1adnsVU4IiDat7Hgr9Gu0zYbM9iWYJQVBn56o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rC14lpfW+sUVyx6iNl5V0RnMNylBlmaK/Hl0OtVNOxlmDBIkPNx6fqHPIzm1fcFo873tiJe7LiXlsy2nshzboHT9LFnzeJ3UF5RwuDVDvlO+JnnQ0OHboKNjjKkDDhJoZEUM/OEL7YGM3GmxoFzyTWjejK/YmpM7wcvYpXcTmRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZPIP8Fi; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZPIP8Fi"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3072f8dc069so53320691fa.3;
        Mon, 27 Jan 2025 12:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738010235; x=1738615035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uUVeO+z5RA436nqRNo8bH1pl7VST3NSBYOxfyH+ohFE=;
        b=EZPIP8Fiv+Qi0JZ9uybT2DeHPVchCeSbBnLgmoz2waTCSD4ppTWZZcZw5vW1ZMpUz/
         Ik4XbJhMdIE+cCmLn3Ik4LF5vgwHXeO0GyielYI/OqJyCMagwtz69fWNb9OaMv2udTrB
         w6o8tpQhm1+HIDFSfGzr9sYocwW/I1U0gMzQ0k7z/yfiAODymF+gxvYI4ucC2sgpcwOv
         sxbhDoT300ISd+7ZV1uq7LObX82VzCBuV0TeDQ6F6cILqR0b+ezPC148OOfUBk2psGtE
         l+LLQNdOvqwSpZkw8xvTRrp19dhEVFlTxA6/DqFSmfVYk8V6tCX4L39ioVpgjnY7UqnA
         9dGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738010235; x=1738615035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUVeO+z5RA436nqRNo8bH1pl7VST3NSBYOxfyH+ohFE=;
        b=F0Q1l9VtDNVxfHHxEnYKA1c1VQdX77UMqmAf7UEGsXms/ssGalw5KUZT0q1w/oTd9a
         3E2SeJO6kMWVWMYFTK6K4QDwsAWeAtkvrexriRLbnH6PcAbg0GVch8yU6sTxOMMwYRkK
         AH1vG2ny7FiqdTymVv/A2B6+jBFm0Y7+RyclRn7aQBTvDaE/RffutrflsJhjtzrQc86a
         FANBGsl/OLh/o26NMUhf5J97AIqm7oWERBHXeAzmmXrvn/KN8rMTfL1HtZHt0K34NoM3
         tqZpyKwq1q0Vd0K8KD8N7hKuWjivRtNeOkMeYwqkSZc5ytGDjH6EA5UYKwHgxvS/FoF+
         JzeA==
X-Forwarded-Encrypted: i=1; AJvYcCUJGa6AJ5u/+1UoBdrmKVuYtgsQyrF5dmUXbEj6uuSmjjikJg53y5BlxxHVV9DUPHQOAikP@vger.kernel.org, AJvYcCXQRaAUF8hHAMvpDhQnBmZ83Uav78TxlH8QltFcJ0yZoibnZN5qXERCU5HZM6zlOIiyVhMJjpldkBvlS4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy49tZQ6WO44PgUx+gGqd00mHhYD55HQgP4WXQzTceAiUQw8sAy
	HcDrp5QbN8jEQbJz9Bl6P5OHR7OL7bkgBu8RW0ZxTWHzN1H0GSo9
X-Gm-Gg: ASbGncuaEFKgTyLwFk1P7BthbWvV0l4UVWz+4HNq2WPE2JbITG8MQNUOERNz2dP6o/a
	zfR7i3fNY2qs8KJxNG0k/cIJMWnhIm25UXDyMbmr0pNzLGMEVULGrpQOb66ZJjHcTrx+O5lm/9B
	pjSJKdTAZ2fBkhFggS74bOgQKcfEtSSb2c336+Z72QVZxSe0rvkmX8tXQwQX/Wbo0yTrq98MEQ2
	hGTQF6WBFlGu7a8GakK21wTpKOLoIGusVkgjKekccpTN08=
X-Google-Smtp-Source: AGHT+IH70QNFyAgfqi5VL2FKlw2yGhj6rK1Had6crqsW9+bzitn59t7tNEe/79Zri9fxkQOKH4Yz+g==
X-Received: by 2002:a2e:a548:0:b0:300:1f12:3d54 with SMTP id 38308e7fff4ca-3072ca5eb8dmr155179411fa.1.1738010234569;
        Mon, 27 Jan 2025 12:37:14 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3076bc51792sm15676441fa.109.2025.01.27.12.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 12:37:14 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 27 Jan 2025 21:37:12 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/4] torture: Remove CONFIG_NR_CPUS configuration
Message-ID: <Z5fueD7u1tXQv-jI@pc636>
References: <c57daf05-1018-40b5-9684-22dfd94cc8d9@paulmck-laptop>
 <Z5PSeEn_ceFuqbnz@pc636>
 <06b6c9f2-c668-4c7d-8555-69a23cc8b4e7@paulmck-laptop>
 <Z5eJ13aWwMDK00U1@pc636>
 <c0280436-2239-41d8-b118-1e6792995778@paulmck-laptop>
 <Z5epgkyeyAvTVOQg@pc636>
 <fd09724c-dcd9-4f41-b33c-20f6258da6b0@paulmck-laptop>
 <Z5fB4xTWD7PWmVXq@pc636>
 <77d09c35-b970-4103-9be2-11c05d7fe124@paulmck-laptop>
 <Z5fdaj2HnhpagC-A@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5fdaj2HnhpagC-A@pc636>

> > > > > > > > > > > need more CPUs for TREE05.
> > > > > > > > > > > 
> > > > > > > > > > > I will not resist, we just drop this patch :)
> > > > > > > > > > 
> > > > > > > > > > Thank you!
> > > > > > > > > > 
> > > > > > > > > > The bug you are chasing happens when a given synchonize_rcu() interacts
> > > > > > > > > > with RCU readers, correct?
> > > > > > > > > > 
> > > > > > > > > Below one:
> > > > > > > > > 
> > > > > > > > > <snip>
> > > > > > > > > /*
> > > > > > > > >  * RCU torture fake writer kthread.  Repeatedly calls sync, with a random
> > > > > > > > >  * delay between calls.
> > > > > > > > >  */
> > > > > > > > > static int
> > > > > > > > > rcu_torture_fakewriter(void *arg)
> > > > > > > > > {
> > > > > > > > > ...
> > > > > > > > > <snip>
> > > > > > > > > 
> > > > > > > > > > In rcutorture, only the rcu_torture_writer() call to synchronize_rcu()
> > > > > > > > > > interacts with rcu_torture_reader().  So my guess is that running
> > > > > > > > > > many small TREE05 guest OSes would reproduce this bug more quickly.
> > > > > > > > > > So instead of this:
> > > > > > > > > > 
> > > > > > > > > > 	--kconfig CONFIG_NR_CPUS=128
> > > > > > > > > > 
> > > > > > > > > > Do this:
> > > > > > > > > > 
> > > > > > > > > > 	--configs "16*TREE05"
> > > > > > > > > > 
> > > > > > > > > > Or maybe even this:
> > > > > > > > > > 
> > > > > > > > > > 	--configs "16*TREE05" --kconfig CONFIG_NR_CPUS=4
> > > > > > > > > Thanks for input.
> > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > Thoughts?
> > > > > > > > > > 
> > > > > > > > > If you mean below splat:
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > i.e. with more nfakewriters.
> > > > > > > > 
> > > > > > > > Right, and large nfakewriters would help push the synchronize_rcu()
> > > > > > > > wakeups off of the grace-period kthread.
> > > > > > > > 
> > > > > > > > > If you mean the one that has recently reported, i am not able to
> > > > > > > > > reproduce it anyhow :)
> > > > > > > > 
> > > > > > > > Using larger numbers of smaller rcutorture guest OSes might help to
> > > > > > > > reproduce it.  Maybe as small as three CPUs each.  ;-)
> > > > > > > > 
> > > > > > > OK. I will give a try this:
> > > > > > > 
> > > > > > > for (( i=0; i<$LOOPS; i++ )); do
> > > > > > > 	tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 5 --configs \
> > > > > > > 	'16*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1'
> > > > > > > 	echo "Done $i"
> > > > > > > done
> > > > > > 
> > > > > > Making each guest OS smaller needs "--kconfig CONFIG_NR_CPUS=4" (or
> > > > > > whatever) as well, perhaps also increasing the "16*TREE05".
> > > > > > 
> > > > > 
> > > > > By default we have NR_CPUS=8, we we discussed. Providing to kvm "--cpus 5"
> > > > > parameter will just set number of CPUs for a VM to 5:
> > > > > 
> > > > > <snip>
> > > > > ...
> > > > > [    0.060672] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=5, Nodes=1
> > > > > ...
> > > > > <snip>
> > > > > 
> > > > > so, for my test i do not see why i need to set --kconfig CONFIG_NR_CPUS=4.
> > > > > 
> > > > > Am i missing something? :)
> > > > 
> > > > Because that gets you more guest OSes running on your system, each with
> > > > one RCU-update kthread that is being checked by RCU reader kthreads.
> > > > Therefore, it might double the rate at which you are able to reproduce
> > > > this issue.
> > > > 
> > > You mean that setting --kconfig CONFIG_NR_CPUS=4 and 16*TREE05 will run
> > > 4 separate KVM instances?
> > 
> > Almost but not quite.
> > 
> > I am assuming that you have a system with a multiple of eight CPUs.
> > 
> > If so, and assuming that Cheung's bug is an interaction between a fast
> > synchronize_rcu() grace period and a reader task that this grace period
> > is waiting on, having more and smaller guest OSes might make the problem
> > happen faster.  So instead of your:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 5 --configs \
> > '16*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1'
> > 
> > You might be able to double the number of reproductions of the bug
> > per unit time by instead using:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 5 --configs \
> > '32*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1' \
> > --kconfig "CONFIG_NR_CPUS=4"
> > 
> > Does that seem reasonable to you?
> >
> It only runs one instance for me:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 5 --configs 32*TREE05 --memory 10G --bootargs rcutorture.fwd_progress=1 --kconfig CONFIG_NR_CPUS=4
> ----Start batch 1: Mon Jan 27 08:20:17 PM CET 2025
> TREE05 4: Starting build. Mon Jan 27 08:20:17 PM CET 2025
> TREE05 4: Waiting for build to complete. Mon Jan 27 08:20:17 PM CET 2025
> TREE05 4: Build complete. Mon Jan 27 08:21:26 PM CET 2025
> ---- TREE05 4: Kernel present. Mon Jan 27 08:21:26 PM CET 2025
> ---- Starting kernels. Mon Jan 27 08:21:26 PM CET 2025
> 
> with 4 CPUs inside VM :)
> 
And when running 16 instances with 4 CPUs each i can reproduce the
splat which has been reported:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --configs \
  '16*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1' \
  --kconfig "CONFIG_NR_CPUS=4"

<snip>
...
[    0.595251] ------------[ cut here ]------------
[    0.595867] A full grace period is not passed yet: 0
[    0.595875] WARNING: CPU: 1 PID: 16 at kernel/rcu/tree.c:1617 rcu_sr_normal_complete+0xa9/0xc0
[    0.598248] Modules linked in:
[    0.598649] CPU: 1 UID: 0 PID: 16 Comm: rcu_preempt Not tainted 6.13.0-02530-g8950af6a11ff #261
[    0.599248] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    0.600248] RIP: 0010:rcu_sr_normal_complete+0xa9/0xc0
[    0.600913] Code: 48 29 c2 48 8d 04 0a ba 03 00 00 00 48 39 c2 79 0c 48 83 e8 04 48 c1 e8 02 48 8d 70 02 48 c7 c7 20 e9 33 b5 e8 d8 03 f4 ff 90 <0f> 0b 90 90 48 8d 7b 10 5b e9 f9 38 fb ff 66 0f 1f 84 00 00 00 00
[    0.603249] RSP: 0018:ffffadad0008be60 EFLAGS: 00010282
[    0.603925] RAX: 0000000000000000 RBX: ffffadad00013d10 RCX: 00000000ffffdfff
[    0.605247] RDX: 0000000000000000 RSI: ffffadad0008bd10 RDI: 0000000000000001
[    0.606247] RBP: 0000000000000000 R08: 0000000000009ffb R09: 00000000ffffdfff
[    0.607248] R10: 00000000ffffdfff R11: ffffffffb56789a0 R12: 0000000000000005
[    0.608247] R13: 0000000000031a40 R14: fffffffffffffb74 R15: 0000000000000000
[    0.609250] FS:  0000000000000000(0000) GS:ffff9081f5c80000(0000) knlGS:0000000000000000
[    0.610249] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.611248] CR2: 0000000000000000 CR3: 00000002f024a000 CR4: 00000000000006f0
[    0.612249] Call Trace:
[    0.612574]  <TASK>
[    0.612854]  ? __warn+0x8c/0x190
[    0.613248]  ? rcu_sr_normal_complete+0xa9/0xc0
[    0.613840]  ? report_bug+0x164/0x190
[    0.614248]  ? handle_bug+0x54/0x90
[    0.614705]  ? exc_invalid_op+0x17/0x70
[    0.615248]  ? asm_exc_invalid_op+0x1a/0x20
[    0.615797]  ? rcu_sr_normal_complete+0xa9/0xc0
[    0.616248]  rcu_gp_cleanup+0x403/0x5a0
[    0.616248]  ? __pfx_rcu_gp_kthread+0x10/0x10
[    0.616818]  rcu_gp_kthread+0x136/0x1c0
[    0.617249]  kthread+0xec/0x1f0
[    0.617664]  ? __pfx_kthread+0x10/0x10
[    0.618156]  ret_from_fork+0x2f/0x50
[    0.618728]  ? __pfx_kthread+0x10/0x10
[    0.619216]  ret_from_fork_asm+0x1a/0x30
[    0.620251]  </TASK>
...
<snip>

Linus tip-tree, HEAD is c4b9570cfb63501638db720f3bee9f6dfd044b82

--
Uladzislau Rezki
