Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA71BD9DD
	for <rcu@vger.kernel.org>; Fri, 21 Feb 2025 05:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740117404; cv=none; b=GSc2F5jpxqM2Ex6N6SELn4S1nF5yYejretztuMCNrmkY2Lwohbj3GFXndktHFWW6GJ4eQSuqgLdzzZGs7PGlvXioqfsIGbOz2yw0K0Qr342d2DR2FJL7L19hVaanzOswMYLPJ2OaKZeyp5I9nnSZCwU1bSBvXm7HrdtPmBMlO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740117404; c=relaxed/simple;
	bh=jOxJsUjD6WlEWXSoHpuBmFO0cUxSK742RJMTX53Ou7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StqY8jnYNIUww5Kd13/F6KxaiCRGLPAhpxCT3p5QmKj8Q0QiLZkXkBOsLdnLOSb1x/Otg37AIXGE/BdyFf+5SXBHbfWEQ1OQYmTlGl2h6h7OgZtZ5Ts6HOZVtzX6Z3mXp83U9x5SgFSqhwuzIe6FG7FKRH4Cj3SUxxk+NrUkGVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RA+Xql1V; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RA+Xql1V"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7be8f281714so191808985a.1
        for <rcu@vger.kernel.org>; Thu, 20 Feb 2025 21:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740117402; x=1740722202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUPXWPxsv5kAc/gYO2Tad1TT1sL6EyDpiR7Q1f3Ooj0=;
        b=RA+Xql1VF3sacpFXUX8tssueTF7K5DVGRN8n2VvwyQpG5Ym+4atulRwi1OadJmotKu
         u9bnD8uD5/X/mFHHQcdFcsJhLPk5RPSD5/EhIhzr0GzygZwt98sfJUvRndL3vFQ30eDa
         Q7CjYxUxR01zrV80p5FV+WmXMzfiQZISgWS+pxk5A9j1lPWHojft9PDXQHV4yo5N6vlJ
         didXUaNhU94uy+HtWbs84wO7Y1z7gsrmqSo1SkHCSM/iZrUCqqoXhDNJkjOKSPx93ukX
         NvyTafkRrc+AdN/40Br7/Or06eVeUGEFPfkK+hEsNm2Edoo+74zYyv7iYHCU1/9+QCVk
         pjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740117402; x=1740722202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUPXWPxsv5kAc/gYO2Tad1TT1sL6EyDpiR7Q1f3Ooj0=;
        b=Mn5bCH5w35buURM9/cOztIANf4ZFNtJYdTuLVkpCe4xx+Tu/LpSC5ZdGtoihuuPGuW
         7gE4uLdMvpab0G81qcEydfX4c7FJtQenDUXnSz9P0FYLOKuBUuORsH+jG9y0dTtrMLvv
         FiD8UMqNr8gbpxb3JTei7yEfRxJ2NVDfVk7t7zSae3CopIyNc2JBvJ/LO9y3EPw6X4xc
         kXfmIedC9xBj78LBVMmULD5JCwnawuD4Nd36SEEGAXCpmzEy3dUl/aiJAoIzLzh8KeV/
         QAPwRvFeS4uY/+0m4bpOyGemzS1aNleiR39hQIJGTPlEK2DJm9Ol6482Vg6S/WgYZxFB
         M7OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeQnd+0Lo+BHV6AkW39sgTlp6lhK/J+kImAYmh/kouLpPqy/VsOlAuvkDBuL75qc4HfaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeiadqKMgMF1MNpXDVkVq1b016Gtgsq5OhrRdqD2p7p0t8L+hn
	tJxOk01lTKMfm8nSQ16b/skuJEsoDLx2rxQNqv9fSI3z8U2/9lLW
X-Gm-Gg: ASbGncv3UuWo7hfomIylWIYzs5EFjZvAwL4mJ0B6btKGKUxNHkoN8o5Q9YpnVfz8rb7
	HDxsrZTDdTrh7ixVqZrC9Ies5UZL+1uIcyXm3vShrsGZkzV5UrBIhYgdcsZg95nkwb8doSujEXv
	Yai/s9Rs6+EbKq1gYTQc6/72Mrf2Rm7pmyCz7gu/2FIMTX2dhYv++pNa3j56f1UK8NN1QN2tbA9
	lY5iHP5GoDD7qlzekdH0Jy1C5B6bXMOgiPNydG3rBBnUpWST6+/05LcDGXGl0IOTryW+TpIrUmN
	2BZjFzYE4wtt+VuuPHbSzAgFZb2y2+KM4jWPMIXeDHr09NPSO0A6cK67L80qCQeOzlzGC5HajvK
	coiYen4m3FjYEmYxl
X-Google-Smtp-Source: AGHT+IGkyTE6+h6UFagj3u7D26BpXLNgXWPrZ6Uk2njkXbsgFFUn//H1rbGuaEYzCYoyyL7/tljTkg==
X-Received: by 2002:a05:620a:2618:b0:7c0:791a:6faf with SMTP id af79cd13be357-7c0cef66786mr368600085a.53.1740117401618;
        Thu, 20 Feb 2025 21:56:41 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471eb3fac8dsm57381531cf.47.2025.02.20.21.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 21:56:41 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 830581200066;
	Fri, 21 Feb 2025 00:56:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 21 Feb 2025 00:56:40 -0500
X-ME-Sender: <xms:mBW4Z0O1iglK0az2fcdVf5x069CYSCSqI-7KIOb_GixrxNUYIRbkWw>
    <xme:mBW4Z697oypcHZZF-pynNynfoiJCFcXV5rWQQdSFYMAa2Z1jTA4rumF8nPR-hmVuP
    aAfbA2oRnMeovogXQ>
X-ME-Received: <xmr:mBW4Z7Q7b8doq3uXDQymP9a_Fdmxmmc3CuaZHJxeG0ZUUeidowl7aPfF7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiledvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepudduueegffefveehgfeuieehudetheejudff
    ffdtgefgjeegieehieetuddttdegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdptd
    durdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghe
    dtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhes
    fhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopeho
    lhhivhgvrhdrshgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghnkhhurhdrrg
    drrghrohhrrgesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepohgvqdhlkhhpsehlihhs
    thhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprh
    gtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehf
    rhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:mBW4Z8uP00CSykVS6EZtdeZ0j5PvI86ryduoHuA1soBBrF5KFmm_NQ>
    <xmx:mBW4Z8dfrIIoCtzgKj-HxjRCoeELrA5v7UVhkoT4uDy5mUOx58tY_A>
    <xmx:mBW4Zw0uzN8c1v39ejOFa8rBx707KoLYMINBTubqmYuv_KOUXCRzSw>
    <xmx:mBW4Zw_b6Ofj79BF7qvkk8bClOfGbdVVp8L31foqUO4T8Qg01eE65A>
    <xmx:mBW4Zz-Mee_btTMWf7HAMO1N4cLfAN0LMUvvbj1ZO-ip7nrT-jwcGLwd>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 00:56:39 -0500 (EST)
Date: Thu, 20 Feb 2025 21:56:39 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>,
	Ankur Arora <ankur.a.arora@oracle.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [linux-next:master] [rcu]  c9b55f9da0:
 WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
Message-ID: <Z7gVly_1k_YPmBmw@Mac.home>
References: <202502171415.8ec87c87-lkp@intel.com>
 <08e755d1-9f7d-4238-ac2d-1869d68a8ddc@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08e755d1-9f7d-4238-ac2d-1869d68a8ddc@paulmck-laptop>

On Wed, Feb 19, 2025 at 08:51:45AM -0800, Paul E. McKenney wrote:
> On Mon, Feb 17, 2025 at 02:30:16PM +0800, kernel test robot wrote:
> > 
> > hi, Ankur Arora and all,
> > 
> > this is not a regression report as our bot normally does. this report is just
> > FYI that we observe a WARNING with this config, in case it could supply any
> > useful information and/or somebody wants to have a look.
> > 
> > by this change, the config has below diff with parent:
> > 
> > ==================== PARENT FIRST_BAD KCONFIGS f001b7165def8f7af6ce95d08f0e1bbc2442654d ====================
> > --- /pkg/linux/i386-randconfig-r121-20250212/gcc-12/f001b7165def8f7af6ce95d08f0e1bbc2442654d/.config    2025-02-13 07:56:33.420457682 +0800
> > +++ /pkg/linux/i386-randconfig-r121-20250212/gcc-12/c9b55f9da0d2c72c8c8d8cd5df84af5251b74283/.config    2025-02-13 08:43:08.186415593 +0800
> > @@ -147,7 +147,6 @@ CONFIG_BSD_PROCESS_ACCT=y
> >  # RCU Subsystem
> >  #
> >  CONFIG_TREE_RCU=y
> > -CONFIG_PREEMPT_RCU=y
> >  CONFIG_RCU_EXPERT=y
> >  CONFIG_TREE_SRCU=y
> >  CONFIG_TASKS_RCU_GENERIC=y
> > @@ -162,7 +161,6 @@ CONFIG_RCU_STALL_COMMON=y
> >  CONFIG_RCU_NEED_SEGCBLIST=y
> >  CONFIG_RCU_FANOUT=32
> >  CONFIG_RCU_FANOUT_LEAF=16
> > -# CONFIG_RCU_BOOST is not set
> >  # CONFIG_RCU_NOCB_CPU is not set
> >  # CONFIG_TASKS_TRACE_RCU_READ_MB is not set
> >  # CONFIG_RCU_DOUBLE_CHECK_CB_TIME is not set
> > 
> > 
> > below is full report.
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]" on:
> > 
> > commit: c9b55f9da0d2c72c8c8d8cd5df84af5251b74283 ("rcu: limit PREEMPT_RCU configurations")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > [test failed on linux-next/master c674aa7c289e51659e40dda0f954886ef7f80042]
> > 
> > in testcase: rcutorture
> > version: 
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	test: cpuhotplug
> > 	torture_type: rcu
> > 
> > 
> > 
> > config: i386-randconfig-r121-20250212
> > compiler: gcc-12
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > +-----------------------------------------------------------------------------+------------+------------+
> > |                                                                             | f001b7165d | c9b55f9da0 |
> > +-----------------------------------------------------------------------------+------------+------------+
> > | WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture] | 0          | 12         |
> > | EIP:rcutorture_one_extend_check                                             | 0          | 12         |
> > +-----------------------------------------------------------------------------+------------+------------+
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202502171415.8ec87c87-lkp@intel.com
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250217/202502171415.8ec87c87-lkp@intel.com
> > 
> > 
> > [  109.553253][  T781] rcu-torture: rcu_torture_reader task started
> > [  109.553258][  T781] ------------[ cut here ]------------
> > [  109.553259][  T781] rcutorture_one_extend_check during change: Current 0x4  To add 0x4  To remove 0x0  preempt_count() 0x1
> > [  109.553292][  T781] WARNING: CPU: 1 PID: 781 at kernel/rcu/rcutorture.c:1905 rcutorture_one_extend_check+0x25a/0x267 [rcutorture]
> > [  109.553302][  T781] Modules linked in: rcutorture(+) torture
> > [  109.553307][  T781] CPU: 1 UID: 0 PID: 781 Comm: rcu_torture_rea Tainted: G                T  6.14.0-rc1-00007-gc9b55f9da0d2 #1
> > [  109.553310][  T781] Tainted: [T]=RANDSTRUCT
> > [  109.553311][  T781] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [  109.553312][  T781] EIP: rcutorture_one_extend_check+0x25a/0x267 [rcutorture]
> > [  109.553318][  T781] Code: 75 2d c6 05 fd 04 1c f1 01 64 a1 84 77 7c 97 25 ff ff ff 7f 50 ff 75 08 57 53 56 68 60 9f 1c f1 68 a4 74 1c f1 e8 8d d3 ca a3 <0f> 0b 83 c4 1c 8d 65 f4 5b 5e 5f 5d c3 55 31 d2 83 f8 1f 89 e5 53
> > [  109.553320][  T781] EAX: 00000066 EBX: 00000004 ECX: 00000027 EDX: e89c1a00
> > [  109.553322][  T781] ESI: f11c92d9 EDI: 00000004 EBP: 825d1d88 ESP: 825d1d54
> > [  109.553323][  T781] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010282
> > [  109.553327][  T781] CR0: 80050033 CR2: 77235000 CR3: 010c5000 CR4: 00040690
> > [  109.553328][  T781] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > [  109.553330][  T781] DR6: fffe0ff0 DR7: 00000400
> > [  109.553331][  T781] Call Trace:
> > [  109.553333][  T781]  ? show_regs+0x4c/0x52
> > [  109.553343][  T781]  ? rcutorture_one_extend_check+0x25a/0x267 [rcutorture]
> > [  109.553349][  T781]  ? __warn+0x9e/0x15f
> > [  109.553354][  T781]  ? report_bug+0xe8/0x14a
> > [  109.553357][  T781]  ? rcutorture_one_extend_check+0x25a/0x267 [rcutorture]
> > [  109.553364][  T781]  ? exc_overflow+0x37/0x37
> > [  109.553367][  T781]  ? handle_bug+0x3a/0x55
> > [  109.553369][  T781]  ? exc_invalid_op+0x1a/0x56
> > [  109.553372][  T781]  ? handle_exception+0x148/0x148
> > [  109.553376][  T781]  ? osq_wait_next+0x18/0x41
> > [  109.553379][  T781]  ? exc_overflow+0x37/0x37
> > [  109.553381][  T781]  ? rcutorture_one_extend_check+0x25a/0x267 [rcutorture]
> > [  109.553388][  T781]  ? exc_overflow+0x37/0x37
> > [  109.553390][  T781]  ? rcutorture_one_extend_check+0x25a/0x267 [rcutorture]
> > [  109.553399][  T781]  rcutorture_one_extend+0x18c/0x3c1 [rcutorture]
> > [  109.553410][  T781]  rcu_torture_one_read+0x95/0x4d2 [rcutorture]
> > [  109.553417][  T781]  ? validate_chain+0x3d/0x24c
> > [  109.553420][  T781]  ? mark_lock+0x6a/0x14d
> > [  109.553440][  T781]  rcu_torture_reader+0xc4/0xdbd [rcutorture]
> > [  109.553448][  T781]  ? rcu_torture_one_read+0x4d2/0x4d2 [rcutorture]
> > [  109.553457][  T781]  kthread+0x169/0x16e
> > [  109.553459][  T781]  ? rcu_torture_read_exit_child+0x3a/0x3a [rcutorture]
> > [  109.553466][  T781]  ? kthread_is_per_cpu+0x17/0x17
> > [  109.553468][  T781]  ret_from_fork+0x19/0x2c
> > [  109.553471][  T781]  ? kthread_is_per_cpu+0x17/0x17
> > [  109.553472][  T781]  ret_from_fork_asm+0x12/0x20
> > [  109.553475][  T781]  entry_INT80_32+0x108/0x108
> > [  109.553481][  T781] irq event stamp: 307
> > [  109.553482][  T781] hardirqs last  enabled at (313): [<94ebb6cb>] console_trylock_spinning+0x6b/0x10a
> > [  109.553485][  T781] hardirqs last disabled at (318): [<94ebb691>] console_trylock_spinning+0x31/0x10a
> > [  109.553486][  T781] softirqs last  enabled at (0): [<94e613c4>] copy_process+0x945/0x1a7d
> > [  109.553489][  T781] softirqs last disabled at (0): [<00000000>] 0x0
> > [  109.553491][  T781] ---[ end trace 0000000000000000 ]---
> > [  109.553494][  T781] ------------[ cut here ]------------
> > [  109.553496][  T781] rcutorture_one_extend_check after change: Current 0x60  To add 0x60  To remove 0x4  preempt_count() 0x2
> > [  109.553510][  T781] WARNING: CPU: 1 PID: 781 at kernel/rcu/rcutorture.c:1902 rcutorture_one_extend_check+0x20d/0x267 [rcutorture]
> > [  109.553517][  T781] Modules linked in: rcutorture(+) torture
> > [  109.553520][  T781] CPU: 1 UID: 0 PID: 781 Comm: rcu_torture_rea Tainted: G        W       T  6.14.0-rc1-00007-gc9b55f9da0d2 #1
> > [  109.553523][  T781] Tainted: [W]=WARN, [T]=RANDSTRUCT
> > [  109.553524][  T781] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [  109.553525][  T781] EIP: rcutorture_one_extend_check+0x20d/0x267 [rcutorture]
> > [  109.553530][  T781] Code: 3d fe 04 1c f1 00 75 27 25 ff ff ff 7f c6 05 fe 04 1c f1 01 50 ff 75 08 57 53 56 68 60 9f 1c f1 68 a4 74 1c f1 e8 da d3 ca a3 <0f> 0b 83 c4 1c a1 40 09 1c f1 8b 40 1c 85 c0 74 41 f6 c3 60 75 3c
> > [  109.553532][  T781] EAX: 00000067 EBX: 00000060 ECX: 00000027 EDX: e89c1a00
> > [  109.553533][  T781] ESI: f11c936d EDI: 00000060 EBP: 825d1d88 ESP: 825d1d54
> > [  109.553535][  T781] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010282
> > [  109.553537][  T781] CR0: 80050033 CR2: 77235000 CR3: 010c5000 CR4: 00040690
> > [  109.553539][  T781] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > [  109.553540][  T781] DR6: fffe0ff0 DR7: 00000400
> > [  109.553541][  T781] Call Trace:
> > [  109.553543][  T781]  ? show_regs+0x4c/0x52
> > [  109.553545][  T781]  ? rcutorture_one_extend_check+0x20d/0x267 [rcutorture]
> > [  109.553551][  T781]  ? __warn+0x9e/0x15f
> > [  109.553555][  T781]  ? report_bug+0xe8/0x14a
> > [  109.553558][  T781]  ? rcutorture_one_extend_check+0x20d/0x267 [rcutorture]
> > [  109.553565][  T781]  ? exc_overflow+0x37/0x37
> > [  109.553567][  T781]  ? handle_bug+0x3a/0x55
> > [  109.553569][  T781]  ? exc_invalid_op+0x1a/0x56
> > [  109.553572][  T781]  ? handle_exception+0x148/0x148
> > [  109.553575][  T781]  ? osq_wait_next+0x18/0x41
> > [  109.553578][  T781]  ? exc_overflow+0x37/0x37
> > [  109.553580][  T781]  ? rcutorture_one_extend_check+0x20d/0x267 [rcutorture]
> > [  109.553587][  T781]  ? exc_overflow+0x37/0x37
> > [  109.553589][  T781]  ? rcutorture_one_extend_check+0x20d/0x267 [rcutorture]
> > [  109.553599][  T781]  rcutorture_one_extend+0x3b7/0x3c1 [rcutorture]
> > [  109.553610][  T781]  rcu_torture_one_read+0x21b/0x4d2 [rcutorture]
> > [  109.553638][  T781]  rcu_torture_reader+0xc4/0xdbd [rcutorture]
> > [  109.553646][  T781]  ? rcu_torture_one_read+0x4d2/0x4d2 [rcutorture]
> > [  109.553655][  T781]  kthread+0x169/0x16e
> > [  109.553658][  T781]  ? rcu_torture_read_exit_child+0x3a/0x3a [rcutorture]
> > [  109.553664][  T781]  ? kthread_is_per_cpu+0x17/0x17
> > [  109.553667][  T781]  ret_from_fork+0x19/0x2c
> > [  109.553669][  T781]  ? kthread_is_per_cpu+0x17/0x17
> > [  109.553671][  T781]  ret_from_fork_asm+0x12/0x20
> > [  109.553673][  T781]  entry_INT80_32+0x108/0x108
> > [  109.553679][  T781] irq event stamp: 607
> > [  109.553680][  T781] hardirqs last  enabled at (613): [<94ebb6cb>] console_trylock_spinning+0x6b/0x10a
> > [  109.553682][  T781] hardirqs last disabled at (618): [<94ebb691>] console_trylock_spinning+0x31/0x10a
> > [  109.553684][  T781] softirqs last  enabled at (0): [<94e613c4>] copy_process+0x945/0x1a7d
> > [  109.553686][  T781] softirqs last disabled at (0): [<00000000>] 0x0
> > [  109.553688][  T781] ---[ end trace 0000000000000000 ]---
> > [  109.634034][  T769] rcu-torture: Creating torture_shuffle task
> > [  109.635952][  T782] rcu-torture: rcu_torture_stats task started
> > [  109.637994][  T769] rcu-torture: Creating torture_stutter task
> 
> And rcutorture's WARN_ON() has a bug that is exposed by that change
> in Kconfig option.  Does the patch shown below help?
> 
> Either way, thank you for your testing efforts!
> 

Thanks! I put it in the topic branch (and update the next branch of rcu
repo) for the upcoming PR (right before commit "rcu: limit PREEMPT_RCU
configurations"), unfortunately I cannot reproduce the issue, maybe
kernel test robot can help confirm it?

Regards,
Boqun

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit bb638fe1a683316397d5517cb7d1797d70d21c86
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Wed Feb 19 08:41:11 2025 -0800
> 
>     rcutorture: Update rcutorture_one_extend_check() for lazy preemption
>     
>     The rcutorture_one_extend_check() function's last check assumes that
>     if cur_ops->readlock_nesting() returns greater than zero, either the
>     RCUTORTURE_RDR_RCU_1 or the RCUTORTURE_RDR_RCU_2 bit must be set, that
>     is, there must be at least one rcu_read_lock() in effect.
>     
>     This works for preemptible RCU and for non-preemptible RCU running in
>     a non-preemptible kernel.  But it fails for non-preemptible RCU running
>     in a preemptible kernel because then RCU's cur_ops->readlock_nesting()
>     function, which is rcu_torture_readlock_nesting(), will return
>     the PREEMPT_MASK mask bits from preempt_count().  The result will
>     be greater than zero if preemption is disabled, including by the
>     RCUTORTURE_RDR_PREEMPT and RCUTORTURE_RDR_SCHED bits.
>     
>     This commit therefore adjusts this check to take into account the case
>     fo non-preemptible RCU running in a preemptible kernel.
>     
>     Reported-by: kernel test robot <oliver.sang@intel.com>
>     Closes: https://lore.kernel.org/oe-lkp/202502171415.8ec87c87-lkp@intel.com
>     Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
>     Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>     Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
>     Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 895a27545ae1e..0f446ff04eda1 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1981,6 +1981,8 @@ static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
>  #define ROEC_ARGS "%s %s: Current %#x  To add %#x  To remove %#x  preempt_count() %#x\n", __func__, s, curstate, new, old, preempt_count()
>  static void rcutorture_one_extend_check(char *s, int curstate, int new, int old, bool insoftirq)
>  {
> +	int mask;
> +
>  	if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE))
>  		return;
>  
> @@ -2010,8 +2012,10 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
>  	WARN_ONCE(cur_ops->extendables &&
>  		  !(curstate & (RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED)) &&
>  		  (preempt_count() & PREEMPT_MASK), ROEC_ARGS);
> -	WARN_ONCE(cur_ops->readlock_nesting &&
> -		  !(curstate & (RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2)) &&
> +	mask = RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2;
> +	if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> +		mask |= RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
> +	WARN_ONCE(cur_ops->readlock_nesting && !(curstate & mask) &&
>  		  cur_ops->readlock_nesting() > 0, ROEC_ARGS);
>  }
>  
> 
