Received: from server.eikel.org (server.eikel.org [178.77.101.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D491371875
	for <rcu@vger.kernel.org>; Mon, 16 Mar 2026 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.77.101.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773649486; cv=none; b=H8JtNATVOfe9UEEk6xpRrIN5jXDbWZCeJ0aeFNsruEJi0fcixdt3vbntH1ckpQ3CCb0C/pkHMsec+U+E6e4kAyV1J9hXtLSYak1WUAf6qcQUglbA+BgaDM75TcQ6xMdvnR7MSYCpkZ+IgRI/Wl9btiUhX1mjNqCEsB0WD1MRncI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773649486; c=relaxed/simple;
	bh=dPQW9WeWEPuEQhM49ZwwIL/lc0RifueYXeJ4VOOsMdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tajqXvHoe7LeZCaD1zpoe7DJAEQzgSGsveROuDDXDq5hHnhn6vRGuhwHW8vq8AQcL3dYn6rnxRxRketCN/IbHDFhjqQJ1DLJQKjJxOaFMuB2YrQrx7S6qGqd9WpihjNFP0d8THLShDX31jXvAVdBNmwraoAgblLfLiCaGGzYglM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eikel.org; spf=fail smtp.mailfrom=eikel.org; dkim=pass (1024-bit key) header.d=eikel.org header.i=@eikel.org header.b=G0n9kX3c; arc=none smtp.client-ip=178.77.101.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eikel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=eikel.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eikel.org header.i=@eikel.org header.b="G0n9kX3c"
Received: from thinkpad-benjamin.localnet (unknown [80.87.119.134])
	by server.eikel.org (Postfix) with ESMTPSA id B265A1F84F;
	Mon, 16 Mar 2026 09:18:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eikel.org;
	s=default; t=1773649118;
	bh=wGBVXe2TB5XgCdAAUbnS3K46JlvHZt+p4uQTs/+CRRA=; h=From:To:Subject;
	b=G0n9kX3cxQQy2NJ8EecYeuOS9vpXQLTM3n7KXFDeNHE0zxdyfe49CgsYPPTFUtIiT
	 AIrLdWm1v3qGDXF2rH/yZINF9lYM5Ft0O+gw0AdNM4u+sljN40OrCp4N83v5/RmQxv
	 dzgmjYLM2msXrijW3KO4utH2oeEvZg9ZRmG8TKeU=
Authentication-Results: server.eikel.org;
        spf=pass (sender IP is 80.87.119.134) smtp.mailfrom=debian@eikel.org smtp.helo=thinkpad-benjamin.localnet
Received-SPF: pass (server.eikel.org: connection is authenticated)
From: Benjamin Eikel <debian@eikel.org>
To: linux-mm@kvack.org
Cc: rcu@vger.kernel.org
Subject: 
 [BUG] RCU stall in unmap_page_range during exit_mmap (6.19 regression)
Date: Mon, 16 Mar 2026 09:18:37 +0100
Message-ID: <6261958.lOV4Wx5bFT@thinkpad-benjamin>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dear Linux kernel developers,

I have reported this issue as Debian bug #1130138 [1], which has been marke=
d=20
=E2=80=9Cupstream=E2=80=9D. I am therefore also reaching out here to make y=
ou aware of it.=20
Please let me know if you need additional information.

After upgrading from linux-image-6.18.15+deb14-amd64, I see this error seve=
ral=20
times and the system shortly freezes. It seems related to Zoom crashing fir=
st,=20
but the freezes were not noticable with older Linux kernels.
Currently booted into 6.18.15+deb14-amd64 which does not exhibit this issue=
=2E=20
The stalls occurred when running 6.19.6+deb14-amd64. More information about=
 my=20
system can be found in the Debian bug report.

M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel: rcu: INFO: rcu_preempt detec=
ted=20
stalls on CPUs/tasks:
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel: rcu:         Tasks blocked o=
n=20
level-0 rcu_node (CPUs 0-15): P10008/1:b..l
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel: rcu:         (detected by 5,=
 t=3D5252=20
jiffies, g=3D177537, q=3D28067 ncpus=3D16)
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel: task:zoom            state:R=
 =20
running task     stack:0     pid:10008 tgid:10008 ppid:2089  =20
task_flags:0x40040c flags:0x00080802
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel: Call Trace:
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  <TASK>
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  __schedule+0x48a/0xfc0
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  preempt_schedule+0x32/0x50
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  preempt_schedule_thunk+0x16=
/0x30
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  _raw_spin_unlock+0x22/0x30
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  unmap_page_range+0xbcb/0x17=
00
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  unmap_vmas+0xa1/0x180
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  exit_mmap+0xe1/0x3b0
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  __mmput+0x41/0x150
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  do_exit+0x251/0xa70
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  do_group_exit+0x2d/0xc0
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  ?=20
srso_alias_return_thunk+0x5/0xfbef5
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  get_signal+0x8a4/0x920
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel: =20
arch_do_signal_or_restart+0x40/0x250
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  exit_to_user_mode_loop+0x8e=
/0x480
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  ? __x64_sys_sched_setaffini=
ty+0x6a/
0xb0
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  do_syscall_64+0x20b/0x600
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  ?=20
srso_alias_return_thunk+0x5/0xfbef5
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  ? ksys_read+0xcd/0xf0
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  ?=20
srso_alias_return_thunk+0x5/0xfbef5
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  ? do_syscall_64+0xbe/0x600
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  ?=20
srso_alias_return_thunk+0x5/0xfbef5
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  ? do_syscall_64+0xbe/0x600
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  ? __x64_sys_close+0x3d/0x80
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  ?=20
srso_alias_return_thunk+0x5/0xfbef5
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  ? do_syscall_64+0xbe/0x600
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  ?=20
srso_alias_return_thunk+0x5/0xfbef5
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  ? exc_page_fault+0x7e/0x1a0
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel: =20
entry_SYSCALL_64_after_hwframe+0x76/0x7e
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel: RIP: 0033:0x7f2876359e2d
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel: RSP: 002b:00007ffc91243ad8 E=
=46LAGS:=20
00000246 ORIG_RAX: 00000000000000cb
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel: RAX: 0000000000000000 RBX:=20
00007f2875207700 RCX: 00007f2876359e2d
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel: RDX: 00007ffc91243ae0 RSI:=20
0000000000000080 RDI: 0000000000002718
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel: RBP: 0000000000000020 R08:=20
0000000000000001 R09: 00007f2875206de8
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel: R10: 0000000000000000 R11:=20
0000000000000246 R12: 00007ffc91243ae0
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel: R13: 00007ffc91243c80 R14:=20
0000000000000000 R15: 0000000000000020
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel:  </TASK>
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel: rcu: INFO: rcu_preempt detec=
ted=20
expedited stalls on CPUs/tasks: { P10008 } 5361 jiffies s: 1609 root: 0x0/T
M=C3=A4r 09 09:13:48 thinkpad-benjamin kernel: rcu: blocking rcu_node struc=
tures=20
(internal RCU debug):

Another one:

M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel: rcu: INFO: rcu_preempt detec=
ted=20
stalls on CPUs/tasks:
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel: rcu:         Tasks blocked o=
n=20
level-0 rcu_node (CPUs 0-15): P10008/1:b..l
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel: rcu:         (detected by 5,=
 t=3D21007=20
jiffies, g=3D177537, q=3D87903 ncpus=3D16)
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel: task:zoom            state:R=
 =20
running task     stack:0     pid:10008 tgid:10008 ppid:2089  =20
task_flags:0x40040c flags:0x00080802
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel: Call Trace:
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  <TASK>
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  __schedule+0x48a/0xfc0
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  preempt_schedule+0x32/0x50
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  preempt_schedule_thunk+0x16=
/0x30
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  _raw_spin_unlock+0x22/0x30
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  unmap_page_range+0xbcb/0x17=
00
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  unmap_vmas+0xa1/0x180
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  exit_mmap+0xe1/0x3b0
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  __mmput+0x41/0x150
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  do_exit+0x251/0xa70
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  do_group_exit+0x2d/0xc0
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  ?=20
srso_alias_return_thunk+0x5/0xfbef5
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  get_signal+0x8a4/0x920
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel: =20
arch_do_signal_or_restart+0x40/0x250
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  exit_to_user_mode_loop+0x8e=
/0x480
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  ? __x64_sys_sched_setaffini=
ty+0x6a/
0xb0
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  do_syscall_64+0x20b/0x600
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  ?=20
srso_alias_return_thunk+0x5/0xfbef5
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  ? ksys_read+0xcd/0xf0
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  ?=20
srso_alias_return_thunk+0x5/0xfbef5
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  ? do_syscall_64+0xbe/0x600
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  ?=20
srso_alias_return_thunk+0x5/0xfbef5
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  ? do_syscall_64+0xbe/0x600
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  ? __x64_sys_close+0x3d/0x80
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  ?=20
srso_alias_return_thunk+0x5/0xfbef5
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  ? do_syscall_64+0xbe/0x600
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  ?=20
srso_alias_return_thunk+0x5/0xfbef5
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  ? exc_page_fault+0x7e/0x1a0
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel: =20
entry_SYSCALL_64_after_hwframe+0x76/0x7e
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel: RIP: 0033:0x7f2876359e2d
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel: RSP: 002b:00007ffc91243ad8 E=
=46LAGS:=20
00000246 ORIG_RAX: 00000000000000cb
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel: RAX: 0000000000000000 RBX:=20
00007f2875207700 RCX: 00007f2876359e2d
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel: RDX: 00007ffc91243ae0 RSI:=20
0000000000000080 RDI: 0000000000002718
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel: RBP: 0000000000000020 R08:=20
0000000000000001 R09: 00007f2875206de8
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel: R10: 0000000000000000 R11:=20
0000000000000246 R12: 00007ffc91243ae0
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel: R13: 00007ffc91243c80 R14:=20
0000000000000000 R15: 0000000000000020
M=C3=A4r 09 09:14:51 thinkpad-benjamin kernel:  </TASK>
M=C3=A4r 09 09:14:52 thinkpad-benjamin kernel: rcu: INFO: rcu_preempt detec=
ted=20
expedited stalls on CPUs/tasks: { P10008 } 21233 jiffies s: 1609 root: 0x0/T
M=C3=A4r 09 09:14:52 thinkpad-benjamin kernel: rcu: blocking rcu_node struc=
tures=20
(internal RCU debug):

Note the stall duration escalating from t=3D5252 jiffies (~5s) to t=3D21007=
 jiffies=20
(~21s), with the same grace period (g=3D177537), indicating the unmap_page_=
range=20
operation blocked for over a minute.

Kind regards
Benjamin

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1130138


