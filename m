Received: from mta0.migadu.com (out-138.mta0.migadu.com [91.218.175.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA7D403E88
	for <rcu@vger.kernel.org>; Mon, 14 Sep 2026 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386953; cv=none; b=Qd4PgDekAbuHq/ELLKntYtKPUHSXuthJf9355b6INIFr7xLemfU3SWfPomGEfXdETwYqi4kpXn9XMk+bWHdgdoVAVxKdPE3vV6CUHWgD77AyUka5cK0TA53OtNgwUBx+Dj65HlJAdB9paIwKkZh3ichDG8YFpUpd1gl76uAVyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386953; c=relaxed/simple;
	bh=HAh6LWtciOn8v6l3PjIIaLJbIazmwCoFjvScDX9gmwU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=qluSWL5sGXdChK/4BYg95go3+V52/S331mX4lh9IuGOV17PqfkDLb/yDlqGOifks+yuSGX6dYCivPv9By8LzZhzYjGZo1ZLz9gg/EoSqNzopvxzcw2T/i0ZcFjF6xf9W/qqkMwUPT8IFqW66KT3LnAc9eFN5xwIpcQsNM4Hxg14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u3wKZB2+; arc=none smtp.client-ip=91.218.175.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u3wKZB2+"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HAh6LWtciOn8v6l3PjIIaLJbIazmwCoFjvScDX9gmwU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789386948; v=1; x=1789991748;
 b=u3wKZB2+l9/ESeyhFX8OM67k9D9HpbTqesLzDEuKkPwQDDwG0HctAReeNyU+H/tDYgy7tC+b
 d2jiAZTyRZCMNMro257Icg+ZztnrNMce7dfI6X2Rw2F9GYvv/rXJpf/HoMVjxPGw3CItGTIjOA1
 NJs4rXvlpoCAulf5ZbR1H8uw=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 17e21db79ff49fa5;
	Mon, 14 Sep 2026 11:55:47 +0000
X-Mizu-Trace-ID: 17e21db79ff49fa5
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Sep 2026 11:55:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <54054db90fe06708c2c4109a1b0747a47e52cae5@linux.dev>
TLS-Required: No
Subject: Re: [syzbot] [kvm?] WARNING in kvm_put_kvm (3)
To: "syzbot" <syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com>,
 frederic@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, paulmck@kernel.org, pbonzini@redhat.com,
 rcu@vger.kernel.org, rostedt@goodmis.org, seanjc@google.com,
 shpark061104@gmail.com, syzkaller-bugs@googlegroups.com,
 work@onurozkan.dev
In-Reply-To: <6aa79c42.4c28b7d0.c1bba.0014.GAE@google.com>
References: <6aa79c42.4c28b7d0.c1bba.0014.GAE@google.com>

>=20
>=20syzbot has found a reproducer for the following issue on:
>=20
>=20HEAD commit: 50d05c7c76c9 Merge tag 'landlock-7.3-rc3' of git://git.k=
er..
> git tree: upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1779e925580=
000
> kernel config: https://syzkaller.appspot.com/x/.config?x=3D5e4e3a0e188a=
497e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd4faf7db59e11=
f6fd1ab
> compiler: Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~=
exp1~20260613092250.77), Debian LLD 22.1.8
> userspace arch: i386
> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=3D14ef08c9580000
> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=3D10f9e92558000=
0
>=20
>=20Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/daf497619736/d=
isk-50d05c7c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/748fbd82f647/vmli=
nux-50d05c7c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e61c59099d07=
/bzImage-50d05c7c.xz
>=20
>=20IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> Reported-by: syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
>=20
>=20------------[ cut here ]------------
> timer_delete_sync(&sdp->delay_work) && rcu_segcblist_n_cbs(&sdp->srcu_c=
blist)
> WARNING: kernel/rcu/srcutree.c:707 at cleanup_srcu_struct+0x3d6/0x8b0 k=
ernel/rcu/srcutree.c:706, CPU#0: syz.0.4746/16077

This should be fixed:
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
91153bd0ee7f ("srcu: Fix WARN_ON() for rcu_segcblist_n_cbs() in cleanup_s=
rcu_struct()")

Thanks
Zqiang



> Modules linked in:
> CPU: 0 UID: 0 PID: 16077 Comm: syz.0.4746 Not tainted syzkaller #0 PREE=
MPT(full)=20
>=20Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 07/24/2026
> RIP: 0010:cleanup_srcu_struct+0x3d6/0x8b0 kernel/rcu/srcutree.c:706
> Code: fd 8b 00 48 83 7d 00 00 4c 8b 74 24 10 0f 85 dd 03 00 00 41 ff c5=
 41 83 e5 0f 41 83 fd 07 0f 86 e2 fe ff ff e9 ab 00 00 00 90 <0f> 0b 90 4=
c 8d b5 00 02 00 00 4c 89 f3 48 c1 eb 03 48 b8 00 00 00
> RSP: 0018:ffffc90002e2fc10 EFLAGS: 00010206
> RAX: 1ffffd1ffff8ff4d RBX: 0000607edafad980 RCX: dffffc0000000000
> RDX: 0000000000000001 RSI: ffffffff8e475f59 RDI: 00000000ffffffff
> RBP: ffffe8ffffc7f980 R08: ffffffff907a2b7f R09: 1ffffffff20f456f
> R10: dffffc0000000000 R11: fffffbfff20f4570 R12: ffff88802b081000
> R13: 0000000000000000 R14: ffffe8ffffc7fa68 R15: 1ffffffff1ce91de
> FS: 0000000000000000(0000) GS:ffff888124cd2000(0063) knlGS:000000005731=
0480
> CS: 0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000073e86000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  kvm_destroy_vm virt/kvm/kvm_main.c:1303 [inline]
>  kvm_put_kvm+0x9cb/0xb50 virt/kvm/kvm_main.c:1332
>  kvm_vm_release+0x43/0x50 virt/kvm/kvm_main.c:1355
>  __fput+0x418/0xa50 fs/file_table.c:512
>  task_work_run+0x1d9/0x270 kernel/task_work.c:233
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
>  exit_to_user_mode_loop+0x204/0x770 kernel/entry/common.c:101
>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inli=
ne]
>  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230=
 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:336 [inline]
>  __do_fast_syscall_32+0x437/0x6a0 arch/x86/entry/syscall_32.c:294
>  do_fast_syscall_32+0x33/0x70 arch/x86/entry/syscall_32.c:316
>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> RIP: 0023:0xf7f470ec
> Code: 90 85 d2 74 0a 89 ce 81 e6 ff 0f 00 00 89 32 85 c0 74 05 c1 e9 0c=
 89 08 31 c0 5e 5d c3 90 0f 1f 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c=
3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 58 b8
> RSP: 002b:00000000ffa0002c EFLAGS: 00000206 ORIG_RAX: 00000000000001b4
> RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000000001e
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> ----------------
> Code disassembly (best guess):
>  0: 90 nop
>  1: 85 d2 test %edx,%edx
>  3: 74 0a je 0xf
>  5: 89 ce mov %ecx,%esi
>  7: 81 e6 ff 0f 00 00 and $0xfff,%esi
>  d: 89 32 mov %esi,(%rdx)
>  f: 85 c0 test %eax,%eax
>  11: 74 05 je 0x18
>  13: c1 e9 0c shr $0xc,%ecx
>  16: 89 08 mov %ecx,(%rax)
>  18: 31 c0 xor %eax,%eax
>  1a: 5e pop %rsi
>  1b: 5d pop %rbp
>  1c: c3 ret
>  1d: 90 nop
>  1e: 0f 1f 00 nopl (%rax)
>  21: 51 push %rcx
>  22: 52 push %rdx
>  23: 55 push %rbp
>  24: 89 e5 mov %esp,%ebp
>  26: 0f 34 sysenter
>  28: cd 80 int $0x80
> * 2a: 5d pop %rbp <-- trapping instruction
>  2b: 5a pop %rdx
>  2c: 59 pop %rcx
>  2d: c3 ret
>  2e: 90 nop
>  2f: 90 nop
>  30: 90 nop
>  31: 90 nop
>  32: 90 nop
>  33: 90 nop
>  34: 90 nop
>  35: 90 nop
>  36: 90 nop
>  37: 90 nop
>  38: 90 nop
>  39: 90 nop
>  3a: 90 nop
>  3b: 90 nop
>  3c: 90 nop
>  3d: 90 nop
>  3e: 58 pop %rax
>  3f: b8 .byte 0xb8
>=20
>=20---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing=
.
>
