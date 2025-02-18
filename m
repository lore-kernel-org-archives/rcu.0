Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C9026FA59
	for <rcu@vger.kernel.org>; Tue, 18 Feb 2025 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900849; cv=none; b=C5s1Mqvmxj2e9LclEWPM1RpNR6OVBz6e28xDrDsSlAHsSOLBYEt83LOFauB+8vl8KXSmPZNQ8GKnG6kXAWZyQHXC7dHiAoZAew1neFL6+6+EmL1z/LaLVsf0SWGvg6bv1kU94BSs+W34nBAMtEaXI5Lyu0ThOVj8nC1yf+jTXaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900849; c=relaxed/simple;
	bh=G7jAdoKyk4Tl3i8c6lua2KF1s86o7R9biqbqovqRrOg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sRh029G3r3QRawbDNs6ZdyQBTJBbg6Yd51+xKHTvlQWoYolHzTGdAJyDmo9xHpXmbnjuTzDrgUt3CZR+CKZHtipVVetBawue/yaeKx63dCAWcdwYSd2t16oloFLx3R0picpwhA20wCHiv78WOn/RJ8gN1viEbwi2T6S1AMjDy3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d2a1d6747aso260765ab.0
        for <rcu@vger.kernel.org>; Tue, 18 Feb 2025 09:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739900847; x=1740505647;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/LAb5Gkl8+g/7om/oRuC8agrJEeJzdmGTELJx8DNgyQ=;
        b=YtMdSao8puEIfmx98LU+567vDxlVAU2x+FwxMlUCV6aQfvKdpCOIxgPrkGK7O9h97+
         vTVF9FTfsihL7MHkFueGXabM3aGl/5qBb2nDr8jmwsDPz7LtCP3cayI08rHfGl2T/6w9
         LMIoRtLHsZWnm/41/KPhxlr2Dmijn9daeseZh0siu6Efjrf+9d/GxtQYN6RYioLWRwIm
         vNB9zMhL/RQoQDyuLjW/qu4rRlHGDFzBKfw8hRXe/5mNQPte3A9leh9qpuMGgP02djh0
         5eL+iJup+mmy6EOwRtEPVr9nmXAJUljUmpV4ft/uVDom4NeD4cjtjvey9H3FF6XfWLe7
         2lHA==
X-Forwarded-Encrypted: i=1; AJvYcCUl250k+GR1MEXjAhvAbGsfYHNJmUaFF8YzdsQQ2KEcxrHhxD4tTSDXuYWs3nXxw6VOfiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlDXarOui5I+KA+f5xbmPRM3gYlkUpa537criVKATSMXPFxX0i
	qhVK5nXNTIOZepY1lMmBoBY7ovnQOuCL369agfo40PBj0UsyMTVHxPjTYXvtlrMO5XNGHXsg9QR
	Sh8iR+NSsj9aI6sgNpRYAPSm/zlG82ZPtpB+mhcDXz4/jpQji4EWteOM=
X-Google-Smtp-Source: AGHT+IGE17WvWAJrUz174Es6yNTYuV9cJVr5+AGAR0wY0ruIZFXAwgq9eAebXm+serZ8QkT1FRfF7MVCMJJtnrHhmf4ufyxOoKib
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a06:b0:3d0:353a:c97e with SMTP id
 e9e14a558f8ab-3d2b4ba13e9mr11497535ab.10.1739900847383; Tue, 18 Feb 2025
 09:47:27 -0800 (PST)
Date: Tue, 18 Feb 2025 09:47:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b4c7af.050a0220.14d86d.000a.GAE@google.com>
Subject: [syzbot] [rcu?] WARNING in srcu_invoke_callbacks (2)
From: syzbot <syzbot+ae5b16688c0c675b1a1f@syzkaller.appspotmail.com>
To: jiangshanlai@gmail.com, josh@joshtriplett.org, 
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	paulmck@kernel.org, rcu@vger.kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a64dcfb451e2 Linux 6.14-rc2
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12398f18580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9c47badcd079906
dashboard link: https://syzkaller.appspot.com/bug?extid=ae5b16688c0c675b1a1f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c0a862fcec77/disk-a64dcfb4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f03793fc001b/vmlinux-a64dcfb4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ae71c33eae14/Image-a64dcfb4.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ae5b16688c0c675b1a1f@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6430 at kernel/rcu/srcutree.c:1798 srcu_invoke_callbacks+0x368/0x3d8
Modules linked in:
CPU: 0 UID: 0 PID: 6430 Comm: kworker/0:3 Not tainted 6.14.0-rc2-syzkaller-ga64dcfb451e2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: rcu_gp srcu_invoke_callbacks
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : srcu_invoke_callbacks+0x368/0x3d8
lr : srcu_invoke_callbacks+0x1ec/0x3d8 kernel/rcu/srcutree.c:1791
sp : ffff8000a3497960
x29: ffff8000a3497a20 x28: ffff700014692f34 x27: ffff80009c6f6ce8
x26: 0000000000000000 x25: ffff80008b87d7e0 x24: dfff800000000000
x23: fffffdffbf6e3d08 x22: fffffdffbf6e3c80 x21: ffff8000a34979c0
x20: fffffdffbf6e3c40 x19: fffffdffbf6e3d60 x18: 1ffff0001472cf04
x17: ffff80008fbad000 x16: ffff8000804683c4 x15: 0000000000000001
x14: 1ffff000138ded9f x13: ffff8000a3498000 x12: 0000000000000003
x11: 0000000000000000 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000001 x7 : ffff80008044b5b8 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : 0000000000000080 x0 : 0000000000000000
Call trace:
 srcu_invoke_callbacks+0x368/0x3d8 (P)
 process_one_work+0x810/0x1638 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x97c/0xeec kernel/workqueue.c:3398
 kthread+0x65c/0x7b0 kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
irq event stamp: 206698
hardirqs last  enabled at (206697): [<ffff800080310c38>] __local_bh_enable_ip+0x224/0x44c kernel/softirq.c:394
hardirqs last disabled at (206698): [<ffff80008b7b3b54>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (206696): [<ffff80008050b40c>] local_bh_enable+0xc/0x2c include/linux/bottom_half.h:32
softirqs last disabled at (206692): [<ffff80008050b3e0>] local_bh_disable+0xc/0x2c include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
