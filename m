Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E886A2B9B7;
	Tue, 28 Jan 2025 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738066661; cv=none; b=g8lVFEstGfPIy2Es+dG2l0owb2MM8H8SAFk3Kton/DsegmmypiPHB4NaY2vJ03kpID3dHvReNBzDE8+58rgYgL7fdEKhmeinEFH7SNZwBJrPUQv/Ab9x3wDvsq7wix+O64RcZiJ4kDN9VuCi0yd2yndag0ib95PWPgkF2tw0ndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738066661; c=relaxed/simple;
	bh=txBRVrklpLsiAzLX4Aqn8au9qXGsH+sNRWQDXIRI0MY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGVtlpShpbcAUNgt1fP08zjpn3QzMVTAB+tOGBBSsQwCvesC05SaZvSkPMEPJgdqwl5/etdmjSMlz9QpU9tVFI2cE+44dg4FV4ZhLoG1Z6UXx1AX6jIkj3Sy3nUVEeCeitUyEfZiQVVkMIMekFttMUCzKWwYnXK0ibJbo43eQyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaefkzu7; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaefkzu7"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-305d840926fso46034451fa.2;
        Tue, 28 Jan 2025 04:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738066658; x=1738671458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JatwI/i6hoNjH1OZtZ0ZTWG3uDxcoZVlH58ksGxhcMc=;
        b=jaefkzu7U9+BeiFZJeusQrS34rUWu+VMXxrdDrzjwdc9TI4neU7tsiqYGx77hd7H/t
         9XCP0KmcpBGy4OIsZg/4Y4a8DoAwh2RGl5+3esV5lfTAuIDebj/ijPAh6iIB0W3m91dQ
         UTkLFs75Bkt+HGt6uyEEHylQC221Lx13Z99awNiI4rvIzzNUB9XcXMJQngX8P/y+ok9Y
         cx4Bs6lEehluIgqi0rM0TGylRHtRduGi7+CqiaNibFsKYhWaho8CKxEoLSbAP6fMYNGU
         LJd+ykX4j/iRUR4YXQpVkHTyaR8eL8UMf/TFLauYVeGlPgQyMVR9w4+yp5P1/2cJcB58
         wXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738066658; x=1738671458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JatwI/i6hoNjH1OZtZ0ZTWG3uDxcoZVlH58ksGxhcMc=;
        b=fNkUp9m5tmTfByvGJRgN9sVsF7OiDfRd1qMahKxy8fuCbTxZfVlPZDwBnfcbql6N7Z
         1GWo+R2iDZhG4ZOA8Hzbwzwttq8soUluoZWwaUzxUqvFhRb5fT5xBz/gULQETdnZVoCc
         41v+mw6RgDDdI2InlLcyYtj7QRbTfm8jqKT0wkZD6zrNDaxdRZzTYfUy2lXsZ970PZdQ
         Mj306QHe52kn3tnKRB/OgODnYLAcqJdcXADqOR+eOV9fHza84Ibx0Y4n8g6MDMtR11h6
         HO0HxDk1pZd4IfUyBg+GWwuyc3/dYhvAmbSw1UljKz9AVdeiNvSUyBJ1nJfzzTcNJomG
         6YuA==
X-Forwarded-Encrypted: i=1; AJvYcCWd+PlYDDRExEXzaEh6iFlgFqw/DUsf+428SXSYnQ7lmpaVEr/kVpum1KhNVYWKY17Kyerz@vger.kernel.org, AJvYcCX76EYnBs+pZvE/kI1sUzqajVVtwlH7EClWFGgbwDUDKqRgEG3mUYxchDrUNUagKtFVy/TmcTyy5T2d8bU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/A8/Q1eWGXSohEeNm6H7mlCI7yGZyUlxacb5nFVkE0HPWIbiY
	wYJvZSO1RUmJkJUQcPQPSgtt1bIgana9qkDEvkRq145u28shbb9k
X-Gm-Gg: ASbGnctwFamJWnhNpdcf0LMhvXVtcnt2dLUtJTZXCwgtXsW0zFkP2xosAfNgnTEc+bP
	KYbuAG+IAqKY7djpb+F8Z4fMEirScf/moF8Lc+dP67qIpG+RClVR//loVkIEgYueRroaSNU5Jm2
	LnChxBfkR08EzjZ7h4KO2kzYLuBInDmnL6vxOz/qmVRW55/Lt1d56hJYUGflRHHmhIBvMLzjSfN
	aDS4Jj5BGYyoyXtIYS/rGQey9RBDn0BLiUQ2RU0JYFprI0NPxz7lFVUbXgZGj59bi2iTdqqboLF
	WjYkf1u8czAOaiFb8HnXktlB1Rmce40/P4dhc3IEV2U=
X-Google-Smtp-Source: AGHT+IHacYZJbu8fPF7uXBfESZ3AFnvSpOB4Nrf71dRYbYreRznnkeXKlhK2/w6yaZgsoRSPhq52+Q==
X-Received: by 2002:a2e:be91:0:b0:300:3de4:ff57 with SMTP id 38308e7fff4ca-3072cb0efbdmr186343311fa.26.1738066657619;
        Tue, 28 Jan 2025 04:17:37 -0800 (PST)
Received: from pc636 (host-95-203-24-189.mobileonline.telia.com. [95.203.24.189])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3076bc19561sm17469951fa.85.2025.01.28.04.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 04:17:36 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 28 Jan 2025 13:17:34 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/4] torture: Remove CONFIG_NR_CPUS configuration
Message-ID: <Z5jK3juSZcDYc7bA@pc636>
References: <06b6c9f2-c668-4c7d-8555-69a23cc8b4e7@paulmck-laptop>
 <Z5eJ13aWwMDK00U1@pc636>
 <c0280436-2239-41d8-b118-1e6792995778@paulmck-laptop>
 <Z5epgkyeyAvTVOQg@pc636>
 <fd09724c-dcd9-4f41-b33c-20f6258da6b0@paulmck-laptop>
 <Z5fB4xTWD7PWmVXq@pc636>
 <77d09c35-b970-4103-9be2-11c05d7fe124@paulmck-laptop>
 <Z5fdaj2HnhpagC-A@pc636>
 <Z5fueD7u1tXQv-jI@pc636>
 <321dd3a8-4d0e-4115-af3d-27f38171cb18@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <321dd3a8-4d0e-4115-af3d-27f38171cb18@paulmck-laptop>

> > > with 4 CPUs inside VM :)
> > > 
> > And when running 16 instances with 4 CPUs each i can reproduce the
> > splat which has been reported:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --configs \
> >   '16*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1' \
> >   --kconfig "CONFIG_NR_CPUS=4"
> > 
> > <snip>
> > ...
> > [    0.595251] ------------[ cut here ]------------
> > [    0.595867] A full grace period is not passed yet: 0
> > [    0.595875] WARNING: CPU: 1 PID: 16 at kernel/rcu/tree.c:1617 rcu_sr_normal_complete+0xa9/0xc0
> > [    0.598248] Modules linked in:
> > [    0.598649] CPU: 1 UID: 0 PID: 16 Comm: rcu_preempt Not tainted 6.13.0-02530-g8950af6a11ff #261
> > [    0.599248] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    0.600248] RIP: 0010:rcu_sr_normal_complete+0xa9/0xc0
> > [    0.600913] Code: 48 29 c2 48 8d 04 0a ba 03 00 00 00 48 39 c2 79 0c 48 83 e8 04 48 c1 e8 02 48 8d 70 02 48 c7 c7 20 e9 33 b5 e8 d8 03 f4 ff 90 <0f> 0b 90 90 48 8d 7b 10 5b e9 f9 38 fb ff 66 0f 1f 84 00 00 00 00
> > [    0.603249] RSP: 0018:ffffadad0008be60 EFLAGS: 00010282
> > [    0.603925] RAX: 0000000000000000 RBX: ffffadad00013d10 RCX: 00000000ffffdfff
> > [    0.605247] RDX: 0000000000000000 RSI: ffffadad0008bd10 RDI: 0000000000000001
> > [    0.606247] RBP: 0000000000000000 R08: 0000000000009ffb R09: 00000000ffffdfff
> > [    0.607248] R10: 00000000ffffdfff R11: ffffffffb56789a0 R12: 0000000000000005
> > [    0.608247] R13: 0000000000031a40 R14: fffffffffffffb74 R15: 0000000000000000
> > [    0.609250] FS:  0000000000000000(0000) GS:ffff9081f5c80000(0000) knlGS:0000000000000000
> > [    0.610249] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.611248] CR2: 0000000000000000 CR3: 00000002f024a000 CR4: 00000000000006f0
> > [    0.612249] Call Trace:
> > [    0.612574]  <TASK>
> > [    0.612854]  ? __warn+0x8c/0x190
> > [    0.613248]  ? rcu_sr_normal_complete+0xa9/0xc0
> > [    0.613840]  ? report_bug+0x164/0x190
> > [    0.614248]  ? handle_bug+0x54/0x90
> > [    0.614705]  ? exc_invalid_op+0x17/0x70
> > [    0.615248]  ? asm_exc_invalid_op+0x1a/0x20
> > [    0.615797]  ? rcu_sr_normal_complete+0xa9/0xc0
> > [    0.616248]  rcu_gp_cleanup+0x403/0x5a0
> > [    0.616248]  ? __pfx_rcu_gp_kthread+0x10/0x10
> > [    0.616818]  rcu_gp_kthread+0x136/0x1c0
> > [    0.617249]  kthread+0xec/0x1f0
> > [    0.617664]  ? __pfx_kthread+0x10/0x10
> > [    0.618156]  ret_from_fork+0x2f/0x50
> > [    0.618728]  ? __pfx_kthread+0x10/0x10
> > [    0.619216]  ret_from_fork_asm+0x1a/0x30
> > [    0.620251]  </TASK>
> > ...
> > <snip>
> > 
> > Linus tip-tree, HEAD is c4b9570cfb63501638db720f3bee9f6dfd044b82
> 
> Very good!  And of course, the next question is "does going to _full()
> make the problem go away?"  ;-)
> 
Yes does its job if i apply:

https://lore.kernel.org/rcu/00900afe-ac4e-4362-a3f9-d65f2c9dcd9a@paulmck-laptop/T/#m5d9263f3825d3170c044beedbae741717702d4aa

after that i am not able to reproduce the warning anymore. Tested over
night. Without it, i can reproduce it pretty easy :)

--
Uladzislau Rezki
