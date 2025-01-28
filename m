Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B82A1DFDA2;
	Tue, 28 Jan 2025 20:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738097854; cv=none; b=doluf9Avdxa8QWmdzqDiBZVX7xV61BCvpDKMQw3DljwdKK81MQe+X+grQ33AVYYTXtZKwuqUmVsKzAjBrehFfW5MRRFhbqV+w4/BzuMEOCkRcFQrlZleZju0YmkTahOXw6lZIGot0PhrV3I2bcfibyLx8+5vKygYu0q/A0D7WfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738097854; c=relaxed/simple;
	bh=EMZ5foFih2dQfiYrLUEiee87MpHBzfa7W1GDZ6Dxhrc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DESoDb+RiDs6pHyP3/ukio2EmNzZImPFN+SD78t3ToGWOmMRQ9etY0YPJhZiTmgaDqEmKZsxGCI+msZYuuXDochcGkhMKBxuFKJRb4dLJ0YqceXPvplai8wPTzjIIDTNCAsk5yH1BJS7AaoZCHUSadI3tslQ436JYR0jNWKUA0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCQyg4B/; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCQyg4B/"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30761be8fa7so61173281fa.2;
        Tue, 28 Jan 2025 12:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738097850; x=1738702650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9xxgpNaitcXwO5sPWNlmb0BZDgC3JEylSPFtwgOYEeE=;
        b=eCQyg4B/g9kVHqKbkX8eRZzeGCPMDElBVZVYntkUJk6tOu5kpIgsP8yhLQA4ofBU3G
         eVp0WhvlHbB7mkWqAmejv2XRrSsyJfcOlXUS2LQm/3+W5xY9KWd9XV1/KD0O6CKylziY
         0jCbYaVdhcCY6LG0Z1Z5k6Ci2xFj5z2O9RlIYghl0jcAhKStcF4FnYnp/G2DlDLFmHUA
         Ui1oLLJWDmwTiK/lPyg7fy0pePQbiWDnuHExlSGe9vUG/jlg8agEjaPII620bTe9dqK/
         aUP1rJMWt+m3wEf1+2DLw1M0D6qkxKqJUZ0XcqNVZgPCcDZIs7Kdnns0Gnf6Ob7slH4y
         Lu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738097850; x=1738702650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xxgpNaitcXwO5sPWNlmb0BZDgC3JEylSPFtwgOYEeE=;
        b=BAWJsPAw7DF16N5Yyy54jGWHSM7j1NLnUZ5Z/FXMcodEpHnlHGdUm7QIuFBFR+ZeBP
         aUyn7jvzb5sH0C0IRTyxcuNd5hE7Hjy2BrU6UlC6sRJxo69XgHBNVgEyop4V1tw9KjJM
         z/SxR7qpRef3skWPqoRWjN9cKrzl8NM+Th04+MqIMyJtt+y4ulnFHQOkelMGIdkcPd9k
         dd8XRMPblJzyLxChVPjncjxkmCp5S/Q6JGqLP1Fy/AN1KmmuJBmsDMYPtz0RQzwiHG6Z
         hemsJPIAFO237IokikR2Hzg/pvFoonGvzxeVEwswzLosYxqGvTr9xMFZCIOzJKErYWWl
         AJ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIdmkdVHZA6LEqeqcB3NL1aYVzLHj9f7r+2wGUZd+LwgYH7HvDLoXuetMVVrbBKc35pK4SfvJblKiNg+8=@vger.kernel.org, AJvYcCXrlRyM8AY9ba7W0xk4SoPtyCjc/mJRaAtwBNOhoKCUEAZDNAdbnZvS3t4BLrXO7PdK+jD9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+0TxmmXWqimMWRZeKOIF6zN1wlNfVlH3d+1kmZZMeT6syqAfN
	aRz7DWjXEEjv9GC4yq39icQQ75E6ERaYaHQkISjmZjfaGj6TgPYN
X-Gm-Gg: ASbGncuelYQgVQFNMvK4krYWCAXEiJeygSAy7DsXQeWuPZgjZbsvzdwXOFeAvwBLpOf
	MB/V+aE720fKqeMQpHtRCC38IZVjZLywys3o+3zVdbCw+ddudAQzsNuTq9lQpxGngBklc7Hr8QT
	WMi1oqzlNysohFoPyAwpki8XK7Ys2UHZlN6CS+KfBy20ZWz+LLT1yCdUtrNW5lWHEoTcniHs/HK
	GwjTHkP5KytBgHUQ/saPIdfIhcuHGEpQymRcYtGZ7ApQI9Vg/X/BSB2gBISBWKFWCCL
X-Google-Smtp-Source: AGHT+IHgqh6hCD4JIUOEiOQPGWRWV3RHRpVf6wYdsRDizn707hy5GkrQpLBi7qiBwqlBja+hPZ2C+g==
X-Received: by 2002:a2e:9a04:0:b0:300:38ff:f8ee with SMTP id 38308e7fff4ca-307968d2b67mr2577491fa.9.1738097850267;
        Tue, 28 Jan 2025 12:57:30 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3076bc1978esm19338811fa.71.2025.01.28.12.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 12:57:29 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 28 Jan 2025 21:57:27 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/4] torture: Remove CONFIG_NR_CPUS configuration
Message-ID: <Z5lEt7NCnzVQGqgl@pc636>
References: <fd09724c-dcd9-4f41-b33c-20f6258da6b0@paulmck-laptop>
 <Z5fB4xTWD7PWmVXq@pc636>
 <77d09c35-b970-4103-9be2-11c05d7fe124@paulmck-laptop>
 <Z5fdaj2HnhpagC-A@pc636>
 <Z5fueD7u1tXQv-jI@pc636>
 <321dd3a8-4d0e-4115-af3d-27f38171cb18@paulmck-laptop>
 <Z5jK3juSZcDYc7bA@pc636>
 <48ce1bcc-15e9-4e05-9b00-2b0903b122a9@paulmck-laptop>
 <Z5jrCqL-PFitmGkK@pc636>
 <50fe6944-383e-48bf-979b-f146260ec74a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50fe6944-383e-48bf-979b-f146260ec74a@paulmck-laptop>

On Tue, Jan 28, 2025 at 10:43:39AM -0800, Paul E. McKenney wrote:
> On Tue, Jan 28, 2025 at 03:34:50PM +0100, Uladzislau Rezki wrote:
> > On Tue, Jan 28, 2025 at 04:41:16AM -0800, Paul E. McKenney wrote:
> > > On Tue, Jan 28, 2025 at 01:17:34PM +0100, Uladzislau Rezki wrote:
> > > > > > > with 4 CPUs inside VM :)
> > > > > > > 
> > > > > > And when running 16 instances with 4 CPUs each i can reproduce the
> > > > > > splat which has been reported:
> > > > > > 
> > > > > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --configs \
> > > > > >   '16*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1' \
> > > > > >   --kconfig "CONFIG_NR_CPUS=4"
> > > > > > 
> > > > > > <snip>
> > > > > > ...
> > > > > > [    0.595251] ------------[ cut here ]------------
> > > > > > [    0.595867] A full grace period is not passed yet: 0
> > > > > > [    0.595875] WARNING: CPU: 1 PID: 16 at kernel/rcu/tree.c:1617 rcu_sr_normal_complete+0xa9/0xc0
> > > > > > [    0.598248] Modules linked in:
> > > > > > [    0.598649] CPU: 1 UID: 0 PID: 16 Comm: rcu_preempt Not tainted 6.13.0-02530-g8950af6a11ff #261
> > > > > > [    0.599248] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > > > > [    0.600248] RIP: 0010:rcu_sr_normal_complete+0xa9/0xc0
> > > > > > [    0.600913] Code: 48 29 c2 48 8d 04 0a ba 03 00 00 00 48 39 c2 79 0c 48 83 e8 04 48 c1 e8 02 48 8d 70 02 48 c7 c7 20 e9 33 b5 e8 d8 03 f4 ff 90 <0f> 0b 90 90 48 8d 7b 10 5b e9 f9 38 fb ff 66 0f 1f 84 00 00 00 00
> > > > > > [    0.603249] RSP: 0018:ffffadad0008be60 EFLAGS: 00010282
> > > > > > [    0.603925] RAX: 0000000000000000 RBX: ffffadad00013d10 RCX: 00000000ffffdfff
> > > > > > [    0.605247] RDX: 0000000000000000 RSI: ffffadad0008bd10 RDI: 0000000000000001
> > > > > > [    0.606247] RBP: 0000000000000000 R08: 0000000000009ffb R09: 00000000ffffdfff
> > > > > > [    0.607248] R10: 00000000ffffdfff R11: ffffffffb56789a0 R12: 0000000000000005
> > > > > > [    0.608247] R13: 0000000000031a40 R14: fffffffffffffb74 R15: 0000000000000000
> > > > > > [    0.609250] FS:  0000000000000000(0000) GS:ffff9081f5c80000(0000) knlGS:0000000000000000
> > > > > > [    0.610249] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > [    0.611248] CR2: 0000000000000000 CR3: 00000002f024a000 CR4: 00000000000006f0
> > > > > > [    0.612249] Call Trace:
> > > > > > [    0.612574]  <TASK>
> > > > > > [    0.612854]  ? __warn+0x8c/0x190
> > > > > > [    0.613248]  ? rcu_sr_normal_complete+0xa9/0xc0
> > > > > > [    0.613840]  ? report_bug+0x164/0x190
> > > > > > [    0.614248]  ? handle_bug+0x54/0x90
> > > > > > [    0.614705]  ? exc_invalid_op+0x17/0x70
> > > > > > [    0.615248]  ? asm_exc_invalid_op+0x1a/0x20
> > > > > > [    0.615797]  ? rcu_sr_normal_complete+0xa9/0xc0
> > > > > > [    0.616248]  rcu_gp_cleanup+0x403/0x5a0
> > > > > > [    0.616248]  ? __pfx_rcu_gp_kthread+0x10/0x10
> > > > > > [    0.616818]  rcu_gp_kthread+0x136/0x1c0
> > > > > > [    0.617249]  kthread+0xec/0x1f0
> > > > > > [    0.617664]  ? __pfx_kthread+0x10/0x10
> > > > > > [    0.618156]  ret_from_fork+0x2f/0x50
> > > > > > [    0.618728]  ? __pfx_kthread+0x10/0x10
> > > > > > [    0.619216]  ret_from_fork_asm+0x1a/0x30
> > > > > > [    0.620251]  </TASK>
> > > > > > ...
> > > > > > <snip>
> > > > > > 
> > > > > > Linus tip-tree, HEAD is c4b9570cfb63501638db720f3bee9f6dfd044b82
> > > > > 
> > > > > Very good!  And of course, the next question is "does going to _full()
> > > > > make the problem go away?"  ;-)
> > > > > 
> > > > Yes does its job if i apply:
> > > > 
> > > > https://lore.kernel.org/rcu/00900afe-ac4e-4362-a3f9-d65f2c9dcd9a@paulmck-laptop/T/#m5d9263f3825d3170c044beedbae741717702d4aa
> > > > 
> > > > after that i am not able to reproduce the warning anymore. Tested over
> > > > night. Without it, i can reproduce it pretty easy :)
> > > 
> > > Thank you, and good to hear!!!
> > > 
> > > May I add your Tested-by to that patch?
> > > 
> > Sure.
> > 
> > Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Thank you!  I will apply this on my next rebase.
> 
> > One question, we discussed that it is worth to print seq-delta
> > in case of warning. Whereas a newly patch does do it and just
> > emits a plain text.
> > 
> > I can send a separate patch or modify this one?
> 
> A separate patch would be best.
> 
Sounds good :)

> If it helps, one possible set of functions to model this on is
> rcutorture_format_gp_seqs() on the "dev" branch of -rcu:
> 
> 9357e5aecb63 ("rcutorture: Include grace-period sequence numbers in failure/close-call")
> 
> This has the needed #ifdefs and the different implementations for Tree
> and Tiny RCU.
> 
I will have a look.

--
Uladzislau Rezki
