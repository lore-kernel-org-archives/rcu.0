Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8686D3E3D81
	for <rcu@vger.kernel.org>; Tue, 17 Mar 2026 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759175; cv=none; b=uEKbHAip0wAwqRw98AiABBVkl0i6HYnMx/NT+SRWZnLC9gne7e43APMcQ4n9wuyP3zIUzd7z1J3kgQrWfTkEBULSDE5GkMr8Sq2T7m9CAtGwdDGWKBEc9XXoDdh2bicHFpnU8NBFmcfGY5cpnum+l4y5j6lmn+F05xC5FK48do8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759175; c=relaxed/simple;
	bh=hU7Ja8MxE/dZQQrcMBR1UXNehBbNM13GFFWz7ogHftw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClIAv9gqgohgdED/tTMEGq5N5XjIEZQdlNEhbYkao4++ghmJleOdWYekJpAzMGtsP++rOWf6Ayk3jlID5lzuaWSHAKBf78KDvlns2rZfnadKz7Q8fv7y/JJ2tj03UbYZcmEJnJ0lDonYbRHJEjHlxiWToY+u/A9joUl7P4bh7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=iZQaMoUL; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="iZQaMoUL"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4fZvsW4vvzz4DtN;
	Tue, 17 Mar 2026 15:46:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1773758767;
	bh=hU7Ja8MxE/dZQQrcMBR1UXNehBbNM13GFFWz7ogHftw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iZQaMoUL+oEc/38KhuA8S8+7E2NC0J9rVIUVZT1JJx77OS2j03vgj/xPlEfi1f+0P
	 2E/ZAkpooyMSNVCR4T3TYQVQ3+OwddXBwg7Y+3xoXtRP3DFc5KNG8fP+yXV9/cfZSV
	 3EzJwd34x2jmlmbejI6WdW8jHuCLwJzCDBWEuh9Tg+wuceQFsDh4WaGmC5hJKDTA3r
	 67oSp6nLaKx47Ueixr32DUPLT7p9+kllIMM41Exr1T0pZI4f5i0pEXrMQ4KobMEtEc
	 k3qh4fDeKdkqz9s+0mbTL/7yXh+BO/eRgcFgbfyzO6w375znWGq2hZ3OEUqDAkKer6
	 F/Pt2AlX37nsQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4fZvsW4Bygz7wZR;
	Tue, 17 Mar 2026 15:46:07 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fZvsW0drvz8svF;
	Tue, 17 Mar 2026 15:46:07 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 7C11D632D3;
	Tue, 17 Mar 2026 15:46:06 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <bbba90be-5825-41d5-a0b2-49a56f75256a@leemhuis.info>
Date: Tue, 17 Mar 2026 15:46:06 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [regression] Re: RCU stall in unmap_page_range during exit_mmap (6.19
 regression)
To: Benjamin Eikel <debian@eikel.org>, linux-mm@kvack.org
Cc: rcu@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <6261958.lOV4Wx5bFT@thinkpad-benjamin>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <6261958.lOV4Wx5bFT@thinkpad-benjamin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177375876673.4092997.3395963888020776942@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 7C11D632D3
X-NC-CID: VI8GR9lw6G18Uo1yXINFhZklGUWTm/u/WkVDAqWoHVKv1JU15aY=

[ccing the regression list]

Lo!

On 3/16/26 09:18, Benjamin Eikel wrote:
> 
> I have reported this issue as Debian bug #1130138 [1], which has been marked 
> “upstream”. I am therefore also reaching out here to make you aware of it. 
> Please let me know if you need additional information.

FWIW, if no developer soon shows up to look into this, you likely need
to perform a git bisection to identify the change that causes this; you
might also want to check if mainline is affected:

https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html
https://docs.kernel.org/admin-guide/bug-bisect.html

Ciao, Thorsten


> After upgrading from linux-image-6.18.15+deb14-amd64, I see this error several 
> times and the system shortly freezes. It seems related to Zoom crashing first, 
> but the freezes were not noticable with older Linux kernels.
> Currently booted into 6.18.15+deb14-amd64 which does not exhibit this issue. 
> The stalls occurred when running 6.19.6+deb14-amd64. More information about my 
> system can be found in the Debian bug report.
> 
> Mär 09 09:13:48 thinkpad-benjamin kernel: rcu: INFO: rcu_preempt detected 
> stalls on CPUs/tasks:
> Mär 09 09:13:48 thinkpad-benjamin kernel: rcu:         Tasks blocked on 
> level-0 rcu_node (CPUs 0-15): P10008/1:b..l
> Mär 09 09:13:48 thinkpad-benjamin kernel: rcu:         (detected by 5, t=5252 
> jiffies, g=177537, q=28067 ncpus=16)
> Mär 09 09:13:48 thinkpad-benjamin kernel: task:zoom            state:R  
> running task     stack:0     pid:10008 tgid:10008 ppid:2089   
> task_flags:0x40040c flags:0x00080802
> Mär 09 09:13:48 thinkpad-benjamin kernel: Call Trace:
> Mär 09 09:13:48 thinkpad-benjamin kernel:  <TASK>
> Mär 09 09:13:48 thinkpad-benjamin kernel:  __schedule+0x48a/0xfc0
> Mär 09 09:13:48 thinkpad-benjamin kernel:  preempt_schedule+0x32/0x50
> Mär 09 09:13:48 thinkpad-benjamin kernel:  preempt_schedule_thunk+0x16/0x30
> Mär 09 09:13:48 thinkpad-benjamin kernel:  _raw_spin_unlock+0x22/0x30
> Mär 09 09:13:48 thinkpad-benjamin kernel:  unmap_page_range+0xbcb/0x1700
> Mär 09 09:13:48 thinkpad-benjamin kernel:  unmap_vmas+0xa1/0x180
> Mär 09 09:13:48 thinkpad-benjamin kernel:  exit_mmap+0xe1/0x3b0
> Mär 09 09:13:48 thinkpad-benjamin kernel:  __mmput+0x41/0x150
> Mär 09 09:13:48 thinkpad-benjamin kernel:  do_exit+0x251/0xa70
> Mär 09 09:13:48 thinkpad-benjamin kernel:  do_group_exit+0x2d/0xc0
> Mär 09 09:13:48 thinkpad-benjamin kernel:  ? 
> srso_alias_return_thunk+0x5/0xfbef5
> Mär 09 09:13:48 thinkpad-benjamin kernel:  get_signal+0x8a4/0x920
> Mär 09 09:13:48 thinkpad-benjamin kernel:  
> arch_do_signal_or_restart+0x40/0x250
> Mär 09 09:13:48 thinkpad-benjamin kernel:  exit_to_user_mode_loop+0x8e/0x480
> Mär 09 09:13:48 thinkpad-benjamin kernel:  ? __x64_sys_sched_setaffinity+0x6a/
> 0xb0
> Mär 09 09:13:48 thinkpad-benjamin kernel:  do_syscall_64+0x20b/0x600
> Mär 09 09:13:48 thinkpad-benjamin kernel:  ? 
> srso_alias_return_thunk+0x5/0xfbef5
> Mär 09 09:13:48 thinkpad-benjamin kernel:  ? ksys_read+0xcd/0xf0
> Mär 09 09:13:48 thinkpad-benjamin kernel:  ? 
> srso_alias_return_thunk+0x5/0xfbef5
> Mär 09 09:13:48 thinkpad-benjamin kernel:  ? do_syscall_64+0xbe/0x600
> Mär 09 09:13:48 thinkpad-benjamin kernel:  ? 
> srso_alias_return_thunk+0x5/0xfbef5
> Mär 09 09:13:48 thinkpad-benjamin kernel:  ? do_syscall_64+0xbe/0x600
> Mär 09 09:13:48 thinkpad-benjamin kernel:  ? __x64_sys_close+0x3d/0x80
> Mär 09 09:13:48 thinkpad-benjamin kernel:  ? 
> srso_alias_return_thunk+0x5/0xfbef5
> Mär 09 09:13:48 thinkpad-benjamin kernel:  ? do_syscall_64+0xbe/0x600
> Mär 09 09:13:48 thinkpad-benjamin kernel:  ? 
> srso_alias_return_thunk+0x5/0xfbef5
> Mär 09 09:13:48 thinkpad-benjamin kernel:  ? exc_page_fault+0x7e/0x1a0
> Mär 09 09:13:48 thinkpad-benjamin kernel:  
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Mär 09 09:13:48 thinkpad-benjamin kernel: RIP: 0033:0x7f2876359e2d
> Mär 09 09:13:48 thinkpad-benjamin kernel: RSP: 002b:00007ffc91243ad8 EFLAGS: 
> 00000246 ORIG_RAX: 00000000000000cb
> Mär 09 09:13:48 thinkpad-benjamin kernel: RAX: 0000000000000000 RBX: 
> 00007f2875207700 RCX: 00007f2876359e2d
> Mär 09 09:13:48 thinkpad-benjamin kernel: RDX: 00007ffc91243ae0 RSI: 
> 0000000000000080 RDI: 0000000000002718
> Mär 09 09:13:48 thinkpad-benjamin kernel: RBP: 0000000000000020 R08: 
> 0000000000000001 R09: 00007f2875206de8
> Mär 09 09:13:48 thinkpad-benjamin kernel: R10: 0000000000000000 R11: 
> 0000000000000246 R12: 00007ffc91243ae0
> Mär 09 09:13:48 thinkpad-benjamin kernel: R13: 00007ffc91243c80 R14: 
> 0000000000000000 R15: 0000000000000020
> Mär 09 09:13:48 thinkpad-benjamin kernel:  </TASK>
> Mär 09 09:13:48 thinkpad-benjamin kernel: rcu: INFO: rcu_preempt detected 
> expedited stalls on CPUs/tasks: { P10008 } 5361 jiffies s: 1609 root: 0x0/T
> Mär 09 09:13:48 thinkpad-benjamin kernel: rcu: blocking rcu_node structures 
> (internal RCU debug):
> 
> Another one:
> 
> Mär 09 09:14:51 thinkpad-benjamin kernel: rcu: INFO: rcu_preempt detected 
> stalls on CPUs/tasks:
> Mär 09 09:14:51 thinkpad-benjamin kernel: rcu:         Tasks blocked on 
> level-0 rcu_node (CPUs 0-15): P10008/1:b..l
> Mär 09 09:14:51 thinkpad-benjamin kernel: rcu:         (detected by 5, t=21007 
> jiffies, g=177537, q=87903 ncpus=16)
> Mär 09 09:14:51 thinkpad-benjamin kernel: task:zoom            state:R  
> running task     stack:0     pid:10008 tgid:10008 ppid:2089   
> task_flags:0x40040c flags:0x00080802
> Mär 09 09:14:51 thinkpad-benjamin kernel: Call Trace:
> Mär 09 09:14:51 thinkpad-benjamin kernel:  <TASK>
> Mär 09 09:14:51 thinkpad-benjamin kernel:  __schedule+0x48a/0xfc0
> Mär 09 09:14:51 thinkpad-benjamin kernel:  preempt_schedule+0x32/0x50
> Mär 09 09:14:51 thinkpad-benjamin kernel:  preempt_schedule_thunk+0x16/0x30
> Mär 09 09:14:51 thinkpad-benjamin kernel:  _raw_spin_unlock+0x22/0x30
> Mär 09 09:14:51 thinkpad-benjamin kernel:  unmap_page_range+0xbcb/0x1700
> Mär 09 09:14:51 thinkpad-benjamin kernel:  unmap_vmas+0xa1/0x180
> Mär 09 09:14:51 thinkpad-benjamin kernel:  exit_mmap+0xe1/0x3b0
> Mär 09 09:14:51 thinkpad-benjamin kernel:  __mmput+0x41/0x150
> Mär 09 09:14:51 thinkpad-benjamin kernel:  do_exit+0x251/0xa70
> Mär 09 09:14:51 thinkpad-benjamin kernel:  do_group_exit+0x2d/0xc0
> Mär 09 09:14:51 thinkpad-benjamin kernel:  ? 
> srso_alias_return_thunk+0x5/0xfbef5
> Mär 09 09:14:51 thinkpad-benjamin kernel:  get_signal+0x8a4/0x920
> Mär 09 09:14:51 thinkpad-benjamin kernel:  
> arch_do_signal_or_restart+0x40/0x250
> Mär 09 09:14:51 thinkpad-benjamin kernel:  exit_to_user_mode_loop+0x8e/0x480
> Mär 09 09:14:51 thinkpad-benjamin kernel:  ? __x64_sys_sched_setaffinity+0x6a/
> 0xb0
> Mär 09 09:14:51 thinkpad-benjamin kernel:  do_syscall_64+0x20b/0x600
> Mär 09 09:14:51 thinkpad-benjamin kernel:  ? 
> srso_alias_return_thunk+0x5/0xfbef5
> Mär 09 09:14:51 thinkpad-benjamin kernel:  ? ksys_read+0xcd/0xf0
> Mär 09 09:14:51 thinkpad-benjamin kernel:  ? 
> srso_alias_return_thunk+0x5/0xfbef5
> Mär 09 09:14:51 thinkpad-benjamin kernel:  ? do_syscall_64+0xbe/0x600
> Mär 09 09:14:51 thinkpad-benjamin kernel:  ? 
> srso_alias_return_thunk+0x5/0xfbef5
> Mär 09 09:14:51 thinkpad-benjamin kernel:  ? do_syscall_64+0xbe/0x600
> Mär 09 09:14:51 thinkpad-benjamin kernel:  ? __x64_sys_close+0x3d/0x80
> Mär 09 09:14:51 thinkpad-benjamin kernel:  ? 
> srso_alias_return_thunk+0x5/0xfbef5
> Mär 09 09:14:51 thinkpad-benjamin kernel:  ? do_syscall_64+0xbe/0x600
> Mär 09 09:14:51 thinkpad-benjamin kernel:  ? 
> srso_alias_return_thunk+0x5/0xfbef5
> Mär 09 09:14:51 thinkpad-benjamin kernel:  ? exc_page_fault+0x7e/0x1a0
> Mär 09 09:14:51 thinkpad-benjamin kernel:  
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Mär 09 09:14:51 thinkpad-benjamin kernel: RIP: 0033:0x7f2876359e2d
> Mär 09 09:14:51 thinkpad-benjamin kernel: RSP: 002b:00007ffc91243ad8 EFLAGS: 
> 00000246 ORIG_RAX: 00000000000000cb
> Mär 09 09:14:51 thinkpad-benjamin kernel: RAX: 0000000000000000 RBX: 
> 00007f2875207700 RCX: 00007f2876359e2d
> Mär 09 09:14:51 thinkpad-benjamin kernel: RDX: 00007ffc91243ae0 RSI: 
> 0000000000000080 RDI: 0000000000002718
> Mär 09 09:14:51 thinkpad-benjamin kernel: RBP: 0000000000000020 R08: 
> 0000000000000001 R09: 00007f2875206de8
> Mär 09 09:14:51 thinkpad-benjamin kernel: R10: 0000000000000000 R11: 
> 0000000000000246 R12: 00007ffc91243ae0
> Mär 09 09:14:51 thinkpad-benjamin kernel: R13: 00007ffc91243c80 R14: 
> 0000000000000000 R15: 0000000000000020
> Mär 09 09:14:51 thinkpad-benjamin kernel:  </TASK>
> Mär 09 09:14:52 thinkpad-benjamin kernel: rcu: INFO: rcu_preempt detected 
> expedited stalls on CPUs/tasks: { P10008 } 21233 jiffies s: 1609 root: 0x0/T
> Mär 09 09:14:52 thinkpad-benjamin kernel: rcu: blocking rcu_node structures 
> (internal RCU debug):
> 
> Note the stall duration escalating from t=5252 jiffies (~5s) to t=21007 jiffies 
> (~21s), with the same grace period (g=177537), indicating the unmap_page_range 
> operation blocked for over a minute.
> 
> Kind regards
> Benjamin
> 
> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1130138
> 
> 

