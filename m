Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9961547C7;
	Thu, 29 Aug 2024 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919459; cv=none; b=cnGeLUsYY6v1MN8Zy/SPclN1nb21wPvdljsUvYaLgG97gw8mv0CSBIA1RyXj0f4RaT6rhrGNcGaIK750QvDL+DcGPifopC6+NReLb8T6YcL6HABQfRmfAUl/gYj/a4IWSYdPNSVAbC5GOC92dQV7yq98+hyrIi/NUdqZTkjZiqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919459; c=relaxed/simple;
	bh=94yesiRcSKI7p8hgdXnXcUCe/LjasPsTf4pmmkoiuew=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahRncCbtz1SL5Nf/fxnHvN+auvLG4dtCH0PE8V5t1ywsLkM5fpbgli12Pgsx6Xm5WXgDpIt+6yh9s2Ozg9oD2LoMx49OtOpirOkZP6zhD/7AvBXjjpSapom4F75xthgk+QpdMU0Ne36p724hr3ZWA1ki/TA71SVhQ/FTreG+kcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaFukGtV; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaFukGtV"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f401b2347dso3371061fa.1;
        Thu, 29 Aug 2024 01:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724919456; x=1725524256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xRw+yYJIWYJBgQtd5Koyt9FZtq29Nv6YI6t+mocf7VM=;
        b=PaFukGtVs6ywHYYxW7gL0NU3YObBie+kAej9O6Dbc+un3juZcsWFQIWQg+/yrpE6B3
         Prai0e45sPKTpeEeeQq/wpY/Cw4Om7b72J/1siqLQCh9xftl0TLKm2bZtx/2ylU5kn7r
         hX2j8yH6Zrb4qm1RKn9YQ013d0+5huW/g/JMivcRdXKvyOuWEog6p6T3WWP9rDbVeig6
         35vp4LP3GPgSf5khoSNQQm5N2/ebMVnADz/USrvulVHI3sBMwTRbRdQkZiNQH1uVJ5nm
         1UjYdqV+IclYq/ZTiogYkxrsT06kN3uXcHGXFsMEnPz6zdb53IBSScp7UvXYdlgmY/Ul
         fzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724919456; x=1725524256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRw+yYJIWYJBgQtd5Koyt9FZtq29Nv6YI6t+mocf7VM=;
        b=hlh2yi1+bXjQp5Cw0FRtY7FhHGiovNv/hqbFJc8tNQMPCQ8+A422fYWLpXiv1KPb/O
         KMpY38ZSmYGijspNbSzGu9AoTNsVOhcTlD5aZ3/qMN9YiEO4ek3L73j6+huoEcjkHEFh
         3H6wIGYbsv1ZbPMnvj10PUi7Rgx+TpYGeVA+eDLQ97z+PgtgbgrQSSz8oCvHXr39zjWb
         uGBLEyJCQx3xedqJ5jmyoearZJkwlJC8ZxiaDRqi/N1Chuu5SbgH2U+BlgfI5G9Vs398
         Dm57DB0ff04wd1Wf2yDfjuolsSazLHMvQN5nEn0kQbvsgjbncXqOhL+DuXIPSnDq5kGi
         tr0A==
X-Forwarded-Encrypted: i=1; AJvYcCU7C3UyvA1xIpXNLOa3i4ccycvoDHRP0r16sXU9baUEfau6VUSoLslyaKHWrPOjpSxYqRA4@vger.kernel.org, AJvYcCUgWK9nrO1UGKX/twoNOMb5jVqZ8tuI7GWNc/e5zaBLHjn++Htep6dgeoOQEpW49ZbBCt3QSDDQuIjkLK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjF9QWVzg8m0lUkV3hAPPZQI0sFuaXlEPL5zsb6e/0+XsYFih/
	lV0Q1s0daeDZEUV+OrOX8X8wEqx5ApmJr8Zox6qFIHotarYn9Onw
X-Google-Smtp-Source: AGHT+IGmUjcQLAojmb2e/G6yBZ1hi4nWMRHDXhhWQIFuqgSyag/8WKfzfR4Rs7r8Wx+pbZiXxr62Sw==
X-Received: by 2002:a2e:6111:0:b0:2f4:f66f:d55a with SMTP id 38308e7fff4ca-2f61689caa4mr2653121fa.21.1724919455229;
        Thu, 29 Aug 2024 01:17:35 -0700 (PDT)
Received: from pc636 (84-217-131-213.customers.ownit.se. [84.217.131.213])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614ed15f1sm1147021fa.4.2024.08.29.01.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:17:34 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 29 Aug 2024 10:17:33 +0200
To: Xingyu Li <xli399@ucr.edu>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org, josh@joshtriplett.org, boqun.feng@gmail.com,
	urezki@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>
Subject: Re: BUG: WARNING in kvfree_rcu_bulk
Message-ID: <ZtAunXBPC4WElcez@pc636>
References: <CALAgD-7JNKw5m0wpGAN+ezCL-qn7LcTL5vgyBmQZKbf5BTNUCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAgD-7JNKw5m0wpGAN+ezCL-qn7LcTL5vgyBmQZKbf5BTNUCw@mail.gmail.com>

Hello!

> Hi,
> 
> We found a bug in Linux 6.10 using syzkaller. It is possibly a  task hung bug.
> The reprodcuer is
> https://gist.github.com/freexxxyyy/67172235de920ccf2f282f9e1179354d
> 
> The bug report is:
> 
> ------------[ cut here ]------------
> ODEBUG: active_state not available (active state 0) object:
> ffff88802526c180 object type: rcu_head hint: 0x0
> WARNING: CPU: 0 PID: 4497 at lib/debugobjects.c:517 debug_print_object
> lib/debugobjects.c:514 [inline]
> WARNING: CPU: 0 PID: 4497 at lib/debugobjects.c:517
> debug_object_active_state+0x2b0/0x360 lib/debugobjects.c:954
> Modules linked in:
> CPU: 0 PID: 4497 Comm: kworker/0:3 Not tainted 6.10.0 #13
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Workqueue: events kfree_rcu_work
> RIP: 0010:debug_print_object lib/debugobjects.c:514 [inline]
> RIP: 0010:debug_object_active_state+0x2b0/0x360 lib/debugobjects.c:954
> Code: d7 95 fd 4d 8b 0c 24 48 c7 c7 a0 61 a9 8b 48 c7 c6 60 5e a9 8b
> 48 89 ea 8b 4c 24 04 49 89 d8 41 57 e8 24 1b f7 fc 48 83 c4 08 <0f> 0b
> ff 05 88 0c c6 0a 48 83 c4 28 5b 41 5c 41 5d 41 5e 41 5f 5d
> RSP: 0018:ffffc90002cc7a10 EFLAGS: 00010292
> RAX: f9c69a923cadb800 RBX: ffff88802526c180 RCX: ffff88801e3cbc00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffffff8ba96360 R08: ffffffff8155a25a R09: 1ffff1100c74519a
> R10: dffffc0000000000 R11: ffffed100c74519b R12: ffffffff8b4de5c0
> R13: 0000000000000005 R14: dffffc0000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa7a316ef78 CR3: 000000000d932000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  debug_rcu_head_unqueue kernel/rcu/rcu.h:236 [inline]
>  debug_rcu_bhead_unqueue kernel/rcu/tree.c:3287 [inline]
>  kvfree_rcu_bulk+0xc5/0x4d0 kernel/rcu/tree.c:3364
>  kfree_rcu_work+0x443/0x500 kernel/rcu/tree.c:3450
>  process_one_work kernel/workqueue.c:3248 [inline]
>  process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
>  worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
>  kthread+0x2eb/0x380 kernel/kthread.c:389
>  ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
>  </TASK>
> 
Is your kernel configuration special? I mean should i have something
truly enabled in the .config to reproduce it?

Thank you for the report!

--
Uladzislau Rezki
