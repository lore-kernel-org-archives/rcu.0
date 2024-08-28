Received: from mx5.ucr.edu (mx.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344015C122
	for <rcu@vger.kernel.org>; Wed, 28 Aug 2024 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880626; cv=none; b=cnmYT0DfMHbpqWJXepgeSgdW3m0A8RpbMpkA2ggxSE404ELltgjqJENU8XPniPszOWWmkUsbfL6o+B5536r0F1ImVsTpVxfgKMlXAo9Jj0pFT62mJGhfaMzjbXLSgGYjdaKrYJBDNS5im950dObGleusDF14acbVFO5SlyBdsf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880626; c=relaxed/simple;
	bh=W5t+TsHDdqtEqlQVwzAKb8FXLK5wwvdp8VqTqGXN3yE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=l2PLwOXmZ3I0mfFZ/5tsd9pwa++yJyBMha/OQi4eGQKpl8KZAILSLSEqAgfSCE1h+Z1qoB5W1LrLphlb0bCslgZkx03SAmAauvm4aTxXFsEcngapkwzzyZPMNSrrbxjU83TQvyNqwNTlWTaRI4U3M6nWwWYE0XT88O7me8C7iVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=FFkYPEfk; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=N5vENj3z; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="FFkYPEfk";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="N5vENj3z"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724880625; x=1756416625;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=W5t+TsHDdqtEqlQVwzAKb8FXLK5wwvdp8VqTqGXN3yE=;
  b=FFkYPEfkDNPEK0ML+TL0QVGgMX+iA0xUfMUPO9n+m9pFgBLZTnTVyLyD
   9Wv6MaUhHXvc9smBmq6oGKgMcJ+7nHonel6Zut+JYYXA4F438Gpr4oD4P
   XNDDlv+oIKC2dkLL8hJ3Mr61PStM+lWWjBie4+31pOuz45giYw6hORqDY
   i49XazdoTvwosd3ovRPN2UIGfEcc7sH/VHV3lqwZAohsP2LoI/82QJsTv
   HFECMtLCM74glopGt+Va6kPepuQGovxdV8F2lrUT8rTenX+DiZyWX/8jw
   Igk7QmuDLtNcPoZKVs2MaJSHou3/Oev3fsc+JoIw/QF7bRiNUYs3es9dM
   Q==;
X-CSE-ConnectionGUID: jyqf3WYAS1GaIYxpaT+kEA==
X-CSE-MsgGUID: ObfJg5eeQv2Xvk3Q2pMiFQ==
Received: from mail-pj1-f70.google.com ([209.85.216.70])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 14:30:23 -0700
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d5dafe951eso8104128a91.3
        for <rcu@vger.kernel.org>; Wed, 28 Aug 2024 14:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724880623; x=1725485423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p7w2fRhYaEno5pjgH9P7KAMSDvs8lR65sZW4tF1Hqts=;
        b=N5vENj3zT/++vzucKJ/iGmK0aubkRo6+cAII5VAcfOeCZgY18M36djk9ghK4fUvixc
         JyqkxAVzAVQPHV05P5NXJdrRMdrXTSnoFu6ARCszWrjQpGWl60FlDCMnYmTzjBobgy+J
         aKcSLf6EurYF3TEM8Lc+4y2AY85BuDAJwa9rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724880623; x=1725485423;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p7w2fRhYaEno5pjgH9P7KAMSDvs8lR65sZW4tF1Hqts=;
        b=u+wUayxC8RtlwvMlcZtnD26R4L9peDnihRUepajVrE63KKxHQAW02FyODluzfZwxpV
         lDLbZ5JJDgkeNy2oGAJJVd83+93fw+jNKOLpsfCBnJnaayrlp1zqDhFszlQRnSEzFtPL
         a49j4b5K/SJ1NLfcR1VYKZbEygvqrZmrW+qZANf+Fs5PSHTxeyCbjU+Zj+8rTYI4ie9i
         sMUA9iXfaTAmcUBv30PbVLfN18NrRbNCsujQvWprK2/I53U+vjPUNPkfD/dFSj/6YHQc
         IM0BqTIg/fmKj6sVku3i83UAvC2b+MZino7R23usLyPcmxS6qkd6bOamRs4QvlwiCaqS
         3Q9w==
X-Forwarded-Encrypted: i=1; AJvYcCVUyUXSZM/Dp2UkU5Y9kO5Jy1YxS0xSvsS0PyyQI7vgMiQR88Qt2aKseBo2IZOmSHDvI1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoRsBKmFPK//HM16RHyD8/Ia/zeiB8FVGHXb5Lq9DS0nvwjOnN
	uN/4+dY9jH87XsXy3K+3HSfh6GR4RFj7+nNE827lySIC6YVRMe7ApgS77c5XGSp5mZUw0t7ifGN
	vVej+aeYegFCWbkrFcvY45fCM4IF2/vARhaQgvIVkednNN9PkkwOt2U9ksjef2VTia9RvtNGnL5
	OigMiyO2v55adqFVmn8R2AOnii0w==
X-Received: by 2002:a17:90b:4b07:b0:2d3:b8eb:9c3c with SMTP id 98e67ed59e1d1-2d85618a1e0mr605252a91.2.1724880622401;
        Wed, 28 Aug 2024 14:30:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGV5H75RSLzKNcOXv8IbEQGpVirzOsDloof6cRBzWiFNyeyDgl3TGz7xoZhUQf2+V5Eb4kH90EKD9vAAH4mbk=
X-Received: by 2002:a17:90b:4b07:b0:2d3:b8eb:9c3c with SMTP id
 98e67ed59e1d1-2d85618a1e0mr605234a91.2.1724880622051; Wed, 28 Aug 2024
 14:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 14:30:11 -0700
Message-ID: <CALAgD-7JNKw5m0wpGAN+ezCL-qn7LcTL5vgyBmQZKbf5BTNUCw@mail.gmail.com>
Subject: BUG: WARNING in kvfree_rcu_bulk
To: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joel@joelfernandes.org, josh@joshtriplett.org, boqun.feng@gmail.com, 
	urezki@gmail.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a  task hung bug.
The reprodcuer is
https://gist.github.com/freexxxyyy/67172235de920ccf2f282f9e1179354d

The bug report is:

------------[ cut here ]------------
ODEBUG: active_state not available (active state 0) object:
ffff88802526c180 object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 4497 at lib/debugobjects.c:517 debug_print_object
lib/debugobjects.c:514 [inline]
WARNING: CPU: 0 PID: 4497 at lib/debugobjects.c:517
debug_object_active_state+0x2b0/0x360 lib/debugobjects.c:954
Modules linked in:
CPU: 0 PID: 4497 Comm: kworker/0:3 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events kfree_rcu_work
RIP: 0010:debug_print_object lib/debugobjects.c:514 [inline]
RIP: 0010:debug_object_active_state+0x2b0/0x360 lib/debugobjects.c:954
Code: d7 95 fd 4d 8b 0c 24 48 c7 c7 a0 61 a9 8b 48 c7 c6 60 5e a9 8b
48 89 ea 8b 4c 24 04 49 89 d8 41 57 e8 24 1b f7 fc 48 83 c4 08 <0f> 0b
ff 05 88 0c c6 0a 48 83 c4 28 5b 41 5c 41 5d 41 5e 41 5f 5d
RSP: 0018:ffffc90002cc7a10 EFLAGS: 00010292
RAX: f9c69a923cadb800 RBX: ffff88802526c180 RCX: ffff88801e3cbc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff8ba96360 R08: ffffffff8155a25a R09: 1ffff1100c74519a
R10: dffffc0000000000 R11: ffffed100c74519b R12: ffffffff8b4de5c0
R13: 0000000000000005 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa7a316ef78 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_rcu_head_unqueue kernel/rcu/rcu.h:236 [inline]
 debug_rcu_bhead_unqueue kernel/rcu/tree.c:3287 [inline]
 kvfree_rcu_bulk+0xc5/0x4d0 kernel/rcu/tree.c:3364
 kfree_rcu_work+0x443/0x500 kernel/rcu/tree.c:3450
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>

-- 
Yours sincerely,
Xingyu
