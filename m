Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A46818F2D1
	for <rcu@vger.kernel.org>; Thu, 29 Aug 2024 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724974206; cv=none; b=pKvrh3W67MtzHmLif7uNseHjM98X8vo/PBDo3aOpzTsAgXDlpRyTYK0d6HJ7jC2KMNwGGySnXKStoh6LtZHBUGZ5ZwtRILqIR6EFoeRDVSTjELELjtb78bKMI6PrwXHdotZvsrRJo51wXnJJFwF9Fjnyc4TwipWPSPQ41AMcklQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724974206; c=relaxed/simple;
	bh=T+j7RRKzuWmA1q1ZqCVTtLsVcebKArnx6jNOTkQeqxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZ3atGPT8n9K2sF8DnpagmHCu2NjZgv1Yvnj2XZkJ4SYH9oa7y5bELCQlZ9Up21Nkgy6CozbzVXrkbGh3wpNl3rPqOMJ9ixMLbUmhnE6Zgd0dCg/4UwA5qJ5maLadxpLHbeclAubcAFMM4SNyqy7cg6CZQRnN82I5bCSTgnY2z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=ncpYIMTK; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=avsyoLbL; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="ncpYIMTK";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="avsyoLbL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724974205; x=1756510205;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=T+j7RRKzuWmA1q1ZqCVTtLsVcebKArnx6jNOTkQeqxQ=;
  b=ncpYIMTKgsnNZusq4b8+cM9tAQBnzofEmwx3S0NNEAtyvBW1XmS4NbFQ
   UgyZ86ZOuBt5GhEe4iYLWbzlSqKTB7S5W+S76PYLdAJ8QdGJPQLy7lazP
   cow/493RIHAOa2Yg6JLLKmbrkwxClePsVEZ2LIweKeSK8DjREwwm16lgK
   2uYlN0/gVOdxrNuQsuCHR5nfBzehe/HpmvuChWTkkpHJL9RY+3q1HQiTV
   Eh0jm6mo7uwEDcJRcNll9SU6I2wuPozHi0Dp768reeVJBTh6vvFxsmClr
   cNMz8k7HixOmr++Qd4aLE5NNguaudDzOr6Et7ihHI/wn4SgTFYb/RByEx
   Q==;
X-CSE-ConnectionGUID: 5vbap7jJSZ2B3czSKAjCNg==
X-CSE-MsgGUID: MS2CNoGsQtSxKXCDGVHz9g==
Received: from mail-pj1-f70.google.com ([209.85.216.70])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Aug 2024 16:30:02 -0700
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d3bd8a0bd4so1336580a91.0
        for <rcu@vger.kernel.org>; Thu, 29 Aug 2024 16:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724974202; x=1725579002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dG6xO0A35GPbOYxBbex6zJAAI0IdJmPbZ/QkQuyWeEI=;
        b=avsyoLbLukH8WLwAXUnYSJuF80whLx2PNYSvGo+G/qcXYLSAab9te1LC4pWlkVnQz8
         riHzNsnLuYn31GkdHFznsMxrVl1tMrC51DdZZZa2dogJSPPvy3HaT3wtF8eq8+8Yi5p4
         1EbcXzj0yQzdl5vrjVft0oqb69ijhyXqm8zYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724974202; x=1725579002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dG6xO0A35GPbOYxBbex6zJAAI0IdJmPbZ/QkQuyWeEI=;
        b=ZD1AC29eIQRj56NreOSyjZDEwd3YDzQQ1QuBBzH8RKDUewL5dhYfqMDp9CmGG8ZFHX
         LOOEYA5gFgl9BNmHuCqJFI2Ni7yCtissKZxH+OcZh2Rvycn4uiJbWwoQrOAG0rOTMioA
         TiMa0HoM0zIzEfwzN0UqIViwSfpyd8tiUm/lOmOwoEp6nRD9BF2HRSwC88RQBJg6uoo2
         264AMpLY4gy9P/mYhip/H7ruZPt+yg1e91yc21b82r9Jg8be5MR1BR5K/qr4Aufk/eCE
         fMdJHYW+c/GFzRQDJa6RxNIz/wo8SqOOcdMErWkWrK1BfgLxBibH8T853Juf8uIMONVA
         +9EA==
X-Forwarded-Encrypted: i=1; AJvYcCX6pbRqtglLQGlBdJp8pSLU0igHUBQLCNAitHQrlEtnQ0Z3oHfWZfB5Rgn+vBo0234Tvsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzmsvvSSORtad6jIpbQTeOG3jeVjo5Wy+9JVgZjoyUNyVYn8VT
	hoANXkJ1s/qhW58zxvSjHpiKrEq1x2yFTCL2VXIZKXJPyepxQEwfwFFKoXHvfTm91wjBdzhnbQt
	cKjkx5KNnrwfOuUIZX6Afz+Or3OqUrqm9U4xROFxOMyKXShjsggucOBtO54RjAFcmFx4817Wvha
	4AMDh2ic9DkY/tBvGEsTzT0YK5sg==
X-Received: by 2002:a17:90a:b009:b0:2d3:d7b9:2c7e with SMTP id 98e67ed59e1d1-2d8561e2311mr5153831a91.24.1724974202149;
        Thu, 29 Aug 2024 16:30:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf4IbX8pjDuJ17LiI0JESNcEAoJRqhux2YvDF/r066A854/JgY5hubPEp2jNebzjXmKDOTnfmPI6BBhhT4kJo=
X-Received: by 2002:a17:90a:b009:b0:2d3:d7b9:2c7e with SMTP id
 98e67ed59e1d1-2d8561e2311mr5153811a91.24.1724974201770; Thu, 29 Aug 2024
 16:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-7JNKw5m0wpGAN+ezCL-qn7LcTL5vgyBmQZKbf5BTNUCw@mail.gmail.com>
 <ZtAunXBPC4WElcez@pc636>
In-Reply-To: <ZtAunXBPC4WElcez@pc636>
From: Xingyu Li <xli399@ucr.edu>
Date: Thu, 29 Aug 2024 16:29:50 -0700
Message-ID: <CALAgD-4kr9MLE6jSF7pXFX9msd-NWFL8mrscvJAOecNWAYL4RQ@mail.gmail.com>
Subject: Re: BUG: WARNING in kvfree_rcu_bulk
To: Uladzislau Rezki <urezki@gmail.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joel@joelfernandes.org, josh@joshtriplett.org, boqun.feng@gmail.com, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here is the config file:
https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd

On Thu, Aug 29, 2024 at 1:17=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> Hello!
>
> > Hi,
> >
> > We found a bug in Linux 6.10 using syzkaller. It is possibly a  task hu=
ng bug.
> > The reprodcuer is
> > https://gist.github.com/freexxxyyy/67172235de920ccf2f282f9e1179354d
> >
> > The bug report is:
> >
> > ------------[ cut here ]------------
> > ODEBUG: active_state not available (active state 0) object:
> > ffff88802526c180 object type: rcu_head hint: 0x0
> > WARNING: CPU: 0 PID: 4497 at lib/debugobjects.c:517 debug_print_object
> > lib/debugobjects.c:514 [inline]
> > WARNING: CPU: 0 PID: 4497 at lib/debugobjects.c:517
> > debug_object_active_state+0x2b0/0x360 lib/debugobjects.c:954
> > Modules linked in:
> > CPU: 0 PID: 4497 Comm: kworker/0:3 Not tainted 6.10.0 #13
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > Workqueue: events kfree_rcu_work
> > RIP: 0010:debug_print_object lib/debugobjects.c:514 [inline]
> > RIP: 0010:debug_object_active_state+0x2b0/0x360 lib/debugobjects.c:954
> > Code: d7 95 fd 4d 8b 0c 24 48 c7 c7 a0 61 a9 8b 48 c7 c6 60 5e a9 8b
> > 48 89 ea 8b 4c 24 04 49 89 d8 41 57 e8 24 1b f7 fc 48 83 c4 08 <0f> 0b
> > ff 05 88 0c c6 0a 48 83 c4 28 5b 41 5c 41 5d 41 5e 41 5f 5d
> > RSP: 0018:ffffc90002cc7a10 EFLAGS: 00010292
> > RAX: f9c69a923cadb800 RBX: ffff88802526c180 RCX: ffff88801e3cbc00
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: ffffffff8ba96360 R08: ffffffff8155a25a R09: 1ffff1100c74519a
> > R10: dffffc0000000000 R11: ffffed100c74519b R12: ffffffff8b4de5c0
> > R13: 0000000000000005 R14: dffffc0000000000 R15: 0000000000000000
> > FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fa7a316ef78 CR3: 000000000d932000 CR4: 0000000000350ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  debug_rcu_head_unqueue kernel/rcu/rcu.h:236 [inline]
> >  debug_rcu_bhead_unqueue kernel/rcu/tree.c:3287 [inline]
> >  kvfree_rcu_bulk+0xc5/0x4d0 kernel/rcu/tree.c:3364
> >  kfree_rcu_work+0x443/0x500 kernel/rcu/tree.c:3450
> >  process_one_work kernel/workqueue.c:3248 [inline]
> >  process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
> >  worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
> >  kthread+0x2eb/0x380 kernel/kthread.c:389
> >  ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
> >  </TASK>
> >
> Is your kernel configuration special? I mean should i have something
> truly enabled in the .config to reproduce it?
>
> Thank you for the report!
>
> --
> Uladzislau Rezki



--=20
Yours sincerely,
Xingyu
