Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CED714AD10
	for <rcu@vger.kernel.org>; Sun, 21 Jul 2024 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721566403; cv=none; b=gJT4VKhSVupAqP/1Rui/Czh5gBttt9tAWxilFRFhGVMLOohipD/SeHiXzrDvlYHURD5pewWEw7RAQ3NwJbraCjXENRQ7EjFRfl9njvtMnNM9CfTGxo+Ghn9p+MQAFPItfccl2c5Sc8nEL6GtWKrHh8i4pgSwsEEMVV+/hUlEh+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721566403; c=relaxed/simple;
	bh=GS9l8wdEmkvBU5bZxN6g+tkipbBCL3zJVDOOR5pn/DY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oONa++FZiVrGKUBeMDETX1lN+0qBtt1fr4Ma7xqG1LZ2SX26AkevAybsVzsd86qFdSChVXDyGlyNipCOd9XmfgGORVdh10C/+V+FmKN93+91h1odJiS7eAEE+KF3wbv3Lk+FZBwqGSXsik9OZRnwfbrzA+0BA3ibakbB8xR/MUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-397e0efded3so45117095ab.2
        for <rcu@vger.kernel.org>; Sun, 21 Jul 2024 05:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721566401; x=1722171201;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uoyn+M2RwBINIpTWPEWdIvNtlbtkDUozGyW/wCsqI/0=;
        b=KZ+dDtnbQG1W15K5sQAa6Goz8wHDMp/jqLRocn1EsV5zDtssnxIVK+p4IN4syJNZhB
         NYKYicBp8MgPDGja7NuFir6XiuHC8K0S7WhuMlwBrKjqASlVW6gWsllNepp8e8SDCHgB
         HGFJdlkWpgo8+6LUNvN5/TZ1SQEZYpUW1b8Oxbohf7Gkw5BxwpwtpILv2eZGcav9qGXx
         8iQSfVdWsATez/4w97Fu5HfP8qQPyfouRtiBj2qXYPBZexQiKDYhwFEAtoEGRd1mql+r
         atTNtG6tmBBK0LXpSH+hZ/tCJUcm7ReWlG2q1mu5uAfpe8/JZzsWRCfX2+/3rZorPqEV
         vy6w==
X-Forwarded-Encrypted: i=1; AJvYcCUttgwrPiLf9LlvFmDI3kL08+b3GJoO0k3zBqJjQFQ22R6Q0F9sdPJIkbGszvTGK4TU0HCfaJ/mRAHmSkTg9WPX0Xdk
X-Gm-Message-State: AOJu0Yy9kGAE1bJ+iExOkUWDGoyYWXCOOSVa2hPDcgb2Oe1vHN2jA0cx
	qs/fXpkwUjipbQ5cld9kUXekeu2G9iBjm3M9RmOzODWDU7Y3pcP2gqGOCOEOcXYYLKn3EvwXee7
	89q4weaHAeVxz5Rn8P9nKZI91OjBXXUaAyvMaynjvongreOHKG7jOvpA=
X-Google-Smtp-Source: AGHT+IFNhhrIqCAazpjH+ygGa5hhvw5bPOFQTOVE4HQvpcZD4D1w55V0yciYG91bR13COsO61MHovI28d37USB8TiJHCgLBklr2t
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cf:b0:396:ec3b:df63 with SMTP id
 e9e14a558f8ab-398e782180cmr2437225ab.4.1721566401448; Sun, 21 Jul 2024
 05:53:21 -0700 (PDT)
Date: Sun, 21 Jul 2024 05:53:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0e3b5061dc16993@google.com>
Subject: [syzbot] [rcu?] WARNING in rcu_note_context_switch (2)
From: syzbot <syzbot+784d0a1246a539975f05@syzkaller.appspotmail.com>
To: boqun.feng@gmail.com, frederic@kernel.org, jiangshanlai@gmail.com, 
	joel@joelfernandes.org, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, neeraj.upadhyay@kernel.org, 
	paulmck@kernel.org, qiang.zhang1211@gmail.com, rcu@vger.kernel.org, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    51835949dda3 Merge tag 'net-next-6.11' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150e825e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28bac69fa31fbb3a
dashboard link: https://syzkaller.appspot.com/bug?extid=784d0a1246a539975f05
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d4bf4e980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a3c349980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-51835949.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7a3a01db5542/vmlinux-51835949.xz
kernel image: https://storage.googleapis.com/syzbot-assets/14d329019155/Image-51835949.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+784d0a1246a539975f05@syzkaller.appspotmail.com

------------[ cut here ]------------
Voluntary context switch within RCU read-side critical section!
WARNING: CPU: 0 PID: 3460 at kernel/rcu/tree_plugin.h:330 rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:330
Modules linked in:
CPU: 0 PID: 3460 Comm: syz-executor248 Not tainted 6.10.0-syzkaller-04472-g51835949dda3 #0
Hardware name: linux,dummy-virt (DT)
pstate: 614000c9 (nZCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:330
lr : rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:330
sp : ffff800089523d30
x29: ffff800089523d30 x28: f6f0000005d4a480 x27: 0000000000000000
x26: 0000000000000000 x25: f6f0000005d4a480 x24: ffff800082643318
x23: 0000000000000000 x22: f6f0000005d4a480 x21: fff000007f8d6240
x20: ffff80008261e040 x19: fff000007f8d7040 x18: fffffffffffcb658
x17: fff07ffffd2b9000 x16: ffff800080000000 x15: 0000000000000048
x14: fffffffffffcb6a0 x13: ffff80008266b0a8 x12: 000000000000088b
x11: 00000000000002d9 x10: ffff80008271f500 x9 : ffff80008266b0a8
x8 : 00000000ffffdfff x7 : ffff80008271b0a8 x6 : 00000000000002d9
x5 : fff000007f8cbf48 x4 : 40000000ffffe2d9 x3 : fff07ffffd2b9000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f6f0000005d4a480
Call trace:
 rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:330
 __schedule+0xb0/0x850 kernel/sched/core.c:6417
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x34/0x104 kernel/sched/core.c:6621
 do_notify_resume+0xe4/0x164 arch/arm64/kernel/entry-common.c:136
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_interrupt+0xc4/0xc8 arch/arm64/kernel/entry-common.c:797
 __el0_irq_handler_common+0x18/0x24 arch/arm64/kernel/entry-common.c:802
 el0t_64_irq_handler+0x10/0x1c arch/arm64/kernel/entry-common.c:807
 el0t_64_irq+0x19c/0x1a0 arch/arm64/kernel/entry.S:599
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
