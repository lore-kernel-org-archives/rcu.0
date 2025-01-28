Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0221C1AAA05;
	Tue, 28 Jan 2025 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738074898; cv=none; b=CSNkQI4Tzc+UhbiS++/UQozgz5+2u3jvmOx6XDiCIPnSvI63hZ4bJSESZ1hG0GGGPd+4dN9nARy1YvsgwOb9olBcyyj1tlJmNnIG0UIMNdIcfw3jRgKYiWNb1rJb6YVB0RawX25FLBQs5vqAwXC1Nr97MdcnEhzsJN8ixAbZcKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738074898; c=relaxed/simple;
	bh=eiQgKnIe2z3zahPJ3toVx+gjG98+CuDOWmEPop/CPr4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wbc0BeFJ5P4/2sBZLXmi+On2EJGEPckXR2zE1fcv4RDAjEnvJfkfb+3YVlkte2Zr0dBWv+uuXd5pwVkWHdxwSYNP70VE7Q4nMoADUC9CY9AfzsiC/4LlM6Im0hdJXXi9f5I5IKXR8xxrjobClQOIrRCurnrf15d0SOAm6Rylf10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOb4lax4; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOb4lax4"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54024aa9febso5985784e87.1;
        Tue, 28 Jan 2025 06:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738074894; x=1738679694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=21uIA88qzMJbOeW+TZhDkqMk9xOBTyIKJDE+8u8BEcQ=;
        b=mOb4lax48eiw/FbRmXmXhCbl+AT4k8cvfXVxxqDKlbRFfn74iKixa1HIl9zgM5RvqR
         EaFa3Dfjq2LggvX01wUxJhqULLVayVU6dlLxeloIVzob1zc85MnpfYjUYNXXN6BXVR3M
         mh4yTB70xnH0pI7HxDpADJta/EeFYVqKrrEZHQnqceRIMupx1+U/n5KMDg2EJJTkQsnc
         pDnBm9aAwatOzTRu6lLw9IwlyiqT+24Jn69gxI9rMIUFjRS4iqUcfIhtADkCBQPdavxk
         OjhtVbr3Zu4sGFldZW4VSkYm/LChHeR5M8yqcJ79oJGCPw7TylHwPooyp6n3dy5wTF6w
         1MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738074894; x=1738679694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21uIA88qzMJbOeW+TZhDkqMk9xOBTyIKJDE+8u8BEcQ=;
        b=LLePj+c0NojfwnpbGj+GATyMV1ZlrePwydV8DaKsHNOwnG+X892kqzDami23ZOIGL0
         uCRHa8q4AjoqX2RwofUp77e6UjB4sbn/Gb8sp9E2/Rke7Etgey3IkKzigvnDSUQ/z6Ap
         5SK4zEY12V5o8rRB58g2ItJ4BaPaCsB7uskt5Gx9ReJBb7t76DJv0EQoneMXTZV5HxCs
         8ZIePh07Yb47g3gTlqANVmos7ohGxZo0bk+9WTLXI4AoFLFLSjF3mG0xLMrDg6dxEk6f
         rXc0z5yC0wTd0zT34BgY/5/LRcnQoigVQZ7k2v9DBU9goVmGddNucLcXjRhVHMyNlANy
         r74g==
X-Forwarded-Encrypted: i=1; AJvYcCUDFoGGNV5YAzp73gL7bInBZvZddthHNKyuPYbu8k16ukYowZrzIRv/zS1pf1oSw5rMmqH+@vger.kernel.org, AJvYcCXt23WiRPIKOSlbFVI8y/C4AVKRojogVBgGa5vlYsMe7GzZhpoP35q8dIbtSuOn4F8ivUAWFEQ8Lsf3u80=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrmJDJC//gWOI58hd+WKJc/dUuutGIBkjL4U82vlTZmXoN1wkR
	uyOjQTu2KzZOA7GTuzIfQicU2ZyPHwNaqZpfgecUDoHKDChAgT2o
X-Gm-Gg: ASbGncvBF/ctJmdSV1CpC3v2TxTWxc2//nvuSkyf6Q3z5DaNpFYPVUxF12DZymKPt9W
	g5FhKw3NsztCFJqBa2iOExZKgAEEsf4mJA1Uykr4a51rfL3ilAX+BL/qRgVmcA/arxdPDMWA8Nm
	sr4pCfVLGqIsppS4uqgwrSQayFyws+iZHUFZUCmLr8kxZgoO+h0GdJ2g7x96NrG/eZtkgpWCyhX
	vQM7uJYpKXvJp+nv+sCxtlKiDGVMcULgKWYIvF4jK1aiYCDLhV09BosMHvWEJi9MzsXvL24FKNa
	v3d6JK9CeX6cgD98CH+IifwTyXQV4I1Epo3esDnLbrU=
X-Google-Smtp-Source: AGHT+IEOtqDY9mVWv1YoyImD97Mwl0iAiBu6s7X7rKHWBXu12BPIhgM0884OPj6bEEzO/WTJ3QCpBQ==
X-Received: by 2002:ac2:522c:0:b0:542:9636:297e with SMTP id 2adb3069b0e04-5439c2510a1mr10526484e87.25.1738074893716;
        Tue, 28 Jan 2025 06:34:53 -0800 (PST)
Received: from pc636 (host-95-203-24-189.mobileonline.telia.com. [95.203.24.189])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543e3c2b591sm40237e87.149.2025.01.28.06.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 06:34:53 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 28 Jan 2025 15:34:50 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/4] torture: Remove CONFIG_NR_CPUS configuration
Message-ID: <Z5jrCqL-PFitmGkK@pc636>
References: <c0280436-2239-41d8-b118-1e6792995778@paulmck-laptop>
 <Z5epgkyeyAvTVOQg@pc636>
 <fd09724c-dcd9-4f41-b33c-20f6258da6b0@paulmck-laptop>
 <Z5fB4xTWD7PWmVXq@pc636>
 <77d09c35-b970-4103-9be2-11c05d7fe124@paulmck-laptop>
 <Z5fdaj2HnhpagC-A@pc636>
 <Z5fueD7u1tXQv-jI@pc636>
 <321dd3a8-4d0e-4115-af3d-27f38171cb18@paulmck-laptop>
 <Z5jK3juSZcDYc7bA@pc636>
 <48ce1bcc-15e9-4e05-9b00-2b0903b122a9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48ce1bcc-15e9-4e05-9b00-2b0903b122a9@paulmck-laptop>

On Tue, Jan 28, 2025 at 04:41:16AM -0800, Paul E. McKenney wrote:
> On Tue, Jan 28, 2025 at 01:17:34PM +0100, Uladzislau Rezki wrote:
> > > > > with 4 CPUs inside VM :)
> > > > > 
> > > > And when running 16 instances with 4 CPUs each i can reproduce the
> > > > splat which has been reported:
> > > > 
> > > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --configs \
> > > >   '16*TREE05' --memory 10G --bootargs 'rcutorture.fwd_progress=1' \
> > > >   --kconfig "CONFIG_NR_CPUS=4"
> > > > 
> > > > <snip>
> > > > ...
> > > > [    0.595251] ------------[ cut here ]------------
> > > > [    0.595867] A full grace period is not passed yet: 0
> > > > [    0.595875] WARNING: CPU: 1 PID: 16 at kernel/rcu/tree.c:1617 rcu_sr_normal_complete+0xa9/0xc0
> > > > [    0.598248] Modules linked in:
> > > > [    0.598649] CPU: 1 UID: 0 PID: 16 Comm: rcu_preempt Not tainted 6.13.0-02530-g8950af6a11ff #261
> > > > [    0.599248] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > > [    0.600248] RIP: 0010:rcu_sr_normal_complete+0xa9/0xc0
> > > > [    0.600913] Code: 48 29 c2 48 8d 04 0a ba 03 00 00 00 48 39 c2 79 0c 48 83 e8 04 48 c1 e8 02 48 8d 70 02 48 c7 c7 20 e9 33 b5 e8 d8 03 f4 ff 90 <0f> 0b 90 90 48 8d 7b 10 5b e9 f9 38 fb ff 66 0f 1f 84 00 00 00 00
> > > > [    0.603249] RSP: 0018:ffffadad0008be60 EFLAGS: 00010282
> > > > [    0.603925] RAX: 0000000000000000 RBX: ffffadad00013d10 RCX: 00000000ffffdfff
> > > > [    0.605247] RDX: 0000000000000000 RSI: ffffadad0008bd10 RDI: 0000000000000001
> > > > [    0.606247] RBP: 0000000000000000 R08: 0000000000009ffb R09: 00000000ffffdfff
> > > > [    0.607248] R10: 00000000ffffdfff R11: ffffffffb56789a0 R12: 0000000000000005
> > > > [    0.608247] R13: 0000000000031a40 R14: fffffffffffffb74 R15: 0000000000000000
> > > > [    0.609250] FS:  0000000000000000(0000) GS:ffff9081f5c80000(0000) knlGS:0000000000000000
> > > > [    0.610249] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [    0.611248] CR2: 0000000000000000 CR3: 00000002f024a000 CR4: 00000000000006f0
> > > > [    0.612249] Call Trace:
> > > > [    0.612574]  <TASK>
> > > > [    0.612854]  ? __warn+0x8c/0x190
> > > > [    0.613248]  ? rcu_sr_normal_complete+0xa9/0xc0
> > > > [    0.613840]  ? report_bug+0x164/0x190
> > > > [    0.614248]  ? handle_bug+0x54/0x90
> > > > [    0.614705]  ? exc_invalid_op+0x17/0x70
> > > > [    0.615248]  ? asm_exc_invalid_op+0x1a/0x20
> > > > [    0.615797]  ? rcu_sr_normal_complete+0xa9/0xc0
> > > > [    0.616248]  rcu_gp_cleanup+0x403/0x5a0
> > > > [    0.616248]  ? __pfx_rcu_gp_kthread+0x10/0x10
> > > > [    0.616818]  rcu_gp_kthread+0x136/0x1c0
> > > > [    0.617249]  kthread+0xec/0x1f0
> > > > [    0.617664]  ? __pfx_kthread+0x10/0x10
> > > > [    0.618156]  ret_from_fork+0x2f/0x50
> > > > [    0.618728]  ? __pfx_kthread+0x10/0x10
> > > > [    0.619216]  ret_from_fork_asm+0x1a/0x30
> > > > [    0.620251]  </TASK>
> > > > ...
> > > > <snip>
> > > > 
> > > > Linus tip-tree, HEAD is c4b9570cfb63501638db720f3bee9f6dfd044b82
> > > 
> > > Very good!  And of course, the next question is "does going to _full()
> > > make the problem go away?"  ;-)
> > > 
> > Yes does its job if i apply:
> > 
> > https://lore.kernel.org/rcu/00900afe-ac4e-4362-a3f9-d65f2c9dcd9a@paulmck-laptop/T/#m5d9263f3825d3170c044beedbae741717702d4aa
> > 
> > after that i am not able to reproduce the warning anymore. Tested over
> > night. Without it, i can reproduce it pretty easy :)
> 
> Thank you, and good to hear!!!
> 
> May I add your Tested-by to that patch?
> 
Sure.

Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

One question, we discussed that it is worth to print seq-delta
in case of warning. Whereas a newly patch does do it and just
emits a plain text.

I can send a separate patch or modify this one?

--
Uladzislau Rezki
