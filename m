Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDAC2FB97B
	for <rcu@vger.kernel.org>; Tue, 17 Mar 2026 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764357; cv=none; b=GXaOwXLWeTq4N7r5Kmgm5D0zIiet9yU21Ibb6wwWUmkxiP7/Q5Yn04a7KBpV+Dilx07EOfHOhbbyd+tu0y2yJIxpeIPoYYjW51CzwXm0mNQj1f/gtf+YendUN0SoLa9rJGgz/cjju4esassgz/dGM469YjBZekg2P+mn7MBwONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764357; c=relaxed/simple;
	bh=zt/myOAXjTb3IKLCZWRJQ0u436gYOOcokHSuuMAdx1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F848T5GaUquodzatSmrN5ug6uXB/WGFoB8ek2K/I0dgwEFEBxGG8A4fHe6Me0twvCEodi5MuWgGxJAvDYuyv/UwAyn/stMiveLNxdeDTlRq9xeFoTO9FbNasJapCrW1b8y+9rmD9yi+f8pSD+Ygig2eyibkraAxQjv9M8O1dPDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=onANVyMs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nlxj7QJh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=onANVyMs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nlxj7QJh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="onANVyMs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nlxj7QJh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="onANVyMs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nlxj7QJh"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CB7E4D300;
	Tue, 17 Mar 2026 16:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773764353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRuj8oliuRB8vfh4ORqIsVuipaAv9fM7y492n9A5HMI=;
	b=onANVyMsJfK7ABC1vv+qswwa87L39qBQ4jINzeVewhK1AxkNO/aRCI0CPap79lhYmdLKSa
	fBkVn6baSYdEsoEOnc7lpQdzmJvqcZGY0CWer1mbj7P/l64FvIaNGGGWY7kOzAZ444NUhK
	22BYKQH0txhm6fSYB5w5cnbI31YuNaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773764353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRuj8oliuRB8vfh4ORqIsVuipaAv9fM7y492n9A5HMI=;
	b=nlxj7QJh47csd9CoxFDXIr77mCwdKUKjxJu3FlJGc8Egx7/Y9EgsYBwk1XVPUJUSw2Vomz
	msNdQCjpVK2rTuCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773764353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRuj8oliuRB8vfh4ORqIsVuipaAv9fM7y492n9A5HMI=;
	b=onANVyMsJfK7ABC1vv+qswwa87L39qBQ4jINzeVewhK1AxkNO/aRCI0CPap79lhYmdLKSa
	fBkVn6baSYdEsoEOnc7lpQdzmJvqcZGY0CWer1mbj7P/l64FvIaNGGGWY7kOzAZ444NUhK
	22BYKQH0txhm6fSYB5w5cnbI31YuNaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773764353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRuj8oliuRB8vfh4ORqIsVuipaAv9fM7y492n9A5HMI=;
	b=nlxj7QJh47csd9CoxFDXIr77mCwdKUKjxJu3FlJGc8Egx7/Y9EgsYBwk1XVPUJUSw2Vomz
	msNdQCjpVK2rTuCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD75C4273B;
	Tue, 17 Mar 2026 16:19:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8njFLgB/uWkddQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 17 Mar 2026 16:19:12 +0000
Date: Tue, 17 Mar 2026 16:19:11 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Benjamin Eikel <debian@eikel.org>
Cc: linux-mm@kvack.org, rcu@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	David Hildenbrand <david@kernel.org>
Subject: Re: [BUG] RCU stall in unmap_page_range during exit_mmap (6.19
 regression)
Message-ID: <6ccygsneky6la4unzj2qd6m6o3ty3ek6xwidznzgrpdvc7tfel@qeoj7rramrmu>
References: <6261958.lOV4Wx5bFT@thinkpad-benjamin>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6261958.lOV4Wx5bFT@thinkpad-benjamin>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

+Cc a bunch of relevant people
On Mon, Mar 16, 2026 at 09:18:37AM +0100, Benjamin Eikel wrote:
> Dear Linux kernel developers,
> 
> I have reported this issue as Debian bug #1130138 [1], which has been marked 
> “upstream”. I am therefore also reaching out here to make you aware of it. 
> Please let me know if you need additional information.
> 
> After upgrading from linux-image-6.18.15+deb14-amd64, I see this error several 
> times and the system shortly freezes. It seems related to Zoom crashing first, 
> but the freezes were not noticable with older Linux kernels.

Do you have a simpler repro you can share?

> Currently booted into 6.18.15+deb14-amd64 which does not exhibit this issue. 
> The stalls occurred when running 6.19.6+deb14-amd64. More information about my 
> system can be found in the Debian bug report.
>

Can you attach the debian kernel config? Is it possible something relevant
changed since 6.18?
 
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

Hmm. We have a bunch of cond_resched() sprayed around this code. This _should_
work. I don't see anything particularly interesting that changed between
6.18 and 6.19.

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
> 

-- 
Pedro
