Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121D0B67A
	for <rcu@vger.kernel.org>; Fri,  6 Feb 2026 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770380228; cv=pass; b=BX45S+tKKJLxx8P2E4WAZOUPyqUNxni2Wpix15Ho8YQEoynDvUSzZRM9afCCVagZqAyJdVW7V3CoDdyacgGz7Ew19l8sPelqOyaJvNwunKdqze6lHipHB/xxKf3Wvv0uq5hQsdlEIg76M7AY3km0GeaS21TEBNVlc8Wau1XdbWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770380228; c=relaxed/simple;
	bh=pQ9os+9QapMQOEU4idPEbrJa9v5VIhSGwq7uJTyG2ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRKWr08IVGvXi15LmXxGWViRnHDYpnEi+AEEFPekqjuMhvXVPOCGW5J/bZguoE2qTmZcg5VNuvOS4a6PjiMo1qi6HpfTRvIAvx0FtgYc+83cYcV4M2yct//+110mUa1+pgNolThZnpcKBtFiLUcLRuFvnJ7EmcBqk6cQfaeIZVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebxp78h3; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebxp78h3"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82361bcbd8fso441373b3a.0
        for <rcu@vger.kernel.org>; Fri, 06 Feb 2026 04:17:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770380227; cv=none;
        d=google.com; s=arc-20240605;
        b=WhYem2Rm+cx7gvhIgWlx3oLhIDgsPsw/e7S3NDYbu6et5iUjn1RhDNKTKAtXoaMzmr
         O+mEx8orou5ioCw5N5bHL+nUo6SoLElNG13ZGCVrhGOq3DpOjnZ2Rx3R4ZNLYRcv/5z3
         eonEcJTEEl8Bots7Jl/2RX81rlkGpK58OWnjJQUQpLFLMKFAff5BpMY2FG6Xp+4m9uGM
         Lr0SvLVXsG868ytREkNkauQlGA3lMoxupYjPgafClxd0QdODYeRuvzdeSDeL9QyAV2x2
         VEr8FiAqNlWEb51MYyY/fVI9o5kIspVj2AWd7UdiCY729Ojr9lKFbG+UeQdHuVr+X5ir
         F40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d3KbSfDNXXjY/R2pjIovNPpLWPAa2pk5y4Jjv749wPk=;
        fh=1dCF9TNhKWbSwTib7IhBwJY1SUdimkWu31gMjo8tNMk=;
        b=LesTaS+tDoeGOHoYFGwGHGmfgGNrwxkU6Z1cc7JQUACc+VaxdzN73Mqnzff05AWp5o
         XVj0P6Mm6vRR2+aUvJg42GURW8hJ8NjCSfzb6JYyAUlLkwnZEkYfbA7fHpZeuHDS4tK1
         6XQTDk9Hl7K3bRvD0fbFrkfHV+NGllBcFXM5KB8U/pz75YGx7kYbivsu+qJLanicWQpY
         jCBBfLx6JHyQisokRnNHI35MxwNutW2Ca+Q8PGmlYJkOuFkrASL8zWxU0ep9DCZzWflp
         M2F8y4fVYlVqB2fvw6cXhcBzRLjorEpl639oE09pEcdq6/pj2HpVdDGtrLan/UvkqZZM
         2Baw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770380227; x=1770985027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3KbSfDNXXjY/R2pjIovNPpLWPAa2pk5y4Jjv749wPk=;
        b=ebxp78h3+N78XNZjjtFISmOTvH4bQQNyHm+v71Y6dn2SVd3Xi+/guBG8SsBCAIpcxG
         QyF6OQjHhlEm3EU0cIOBU0cBNsQt0FAq9CsLIEDpSKZDqg4tC5uHFgcIxqqkj2o6FsN6
         WGPQT8gXLstdCwm0CpXP0GFMhteLPH689xyLJ220cqGOUOKExE37AR80Ll0F8rXjmwoT
         qp3r8md5ENhRNhiKZ05wQTm2lSOwocg72KNzg6ilD9Xp+pZ4nkIMJTpYuoz60fgX8Nyj
         9x66WNyXtsbTtI0JeQizI7vPw+tFLzZwD44+IT/jMcpfYCvNfRyqQz31RujQW9l3K2IW
         GytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770380227; x=1770985027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d3KbSfDNXXjY/R2pjIovNPpLWPAa2pk5y4Jjv749wPk=;
        b=dxbAIvxuEOY2o8xhtlfk9T0FD4Zokcpa5V2K4JSN+nFqJjP7SOWbiwykGosenk7ScC
         JtD9Zpg5UYhNFM8nonIsLKSssO/aiqHYt2w4Fn82bn3dB9urX01ZuRoihz2XlW7P5wFT
         qSAc4/AMvVZ/r71ydC0ekakAyQqnEvvU/JSqHCHTQ2AJqdIc24g6d16z85ylF4wbuC4f
         Ap+G2/c+QCWZV9Ddzpo4Vq1pXQjM0SpIU2yO4mG8YaMd6c+WN+Tv4sS+qpKPUEAgdRRe
         v6oWn8+8qgpGENDbClRZOkFiqqGPDLwjAaIo6RYCCg/Lkfbl2X8Gsy0URZ+4gcXyzxXe
         bLbw==
X-Forwarded-Encrypted: i=1; AJvYcCUYz+e4H0MynUQrBQwcVmswFRyUmrlK/xZgm2AuUXE+q0qeJZmqYVkVgm+uPu96s29OOk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrJ6qfQ8A8bSCWN7hy1+UnBwcMVTn5lkjDCMwCkt59+etd2n+W
	oSRkNOONnkEzRnvmmjB1FUTdFlDODcBy5OfgasAnEXIN+mpxIjlYIm78v4dDWwPMf9ffymzwJdG
	762KQBQHV+0FXnlb+l0us3dp5168sDM8YBvNC
X-Gm-Gg: AZuq6aIGIyfFQtrJlnn/xfevAY4z4dR2CrIPcRybmINmNb3TIsqE4dVwNxgxANv4OgA
	dXLeEpjjf1ddOq4DGDHeJlb+mSsivmzdm5ywRmLkyKkKc3Muc53Ox9nHhNSaBAK1PrxGNWELBPG
	eiCvjjTcmSlwlhhRew1bE/dZM8K6Ywh9SZGCga4XiVKZGGKE9gjcJ65VspVRN5qJ2E6MPKchVy/
	ba1BGWsSnDSw7ceCQOzPCHu8ca4eHxRN6ppvFZQWImD2J1rF2KVicasw3RU/xe69uV6LKX6JP6S
	J/86dw==
X-Received: by 2002:a05:6a20:72a2:b0:37e:4319:d7c8 with SMTP id
 adf61e73a8af0-393ad4043a5mr2428748637.75.1770380227170; Fri, 06 Feb 2026
 04:17:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPHJ_V+75SmoRQmoQmAT0GfdP-JotzwW801uPHZtHyynwdSOgw@mail.gmail.com>
 <e5ae996b-b5de-46cf-8c1a-532e4852a412@linux.dev> <PS1PPF7E1D7501F6FE46DF307FFB8086E2FAB66A@PS1PPF7E1D7501F.apcprd02.prod.outlook.com>
In-Reply-To: <PS1PPF7E1D7501F6FE46DF307FFB8086E2FAB66A@PS1PPF7E1D7501F.apcprd02.prod.outlook.com>
From: Zw Tang <shicenci@gmail.com>
Date: Fri, 6 Feb 2026 20:16:55 +0800
X-Gm-Features: AZwV_QjejJSCC1v7jUQprGWkxeFN35WAUicWGf_C1T0bQ5M7jfVAg14PzKRDigk
Message-ID: <CAPHJ_VL=PVuevdXQC+XTRv9c_JrRDFeCZ8+z7qFvXE9nxHcFeQ@mail.gmail.com>
Subject: =?UTF-8?B?5Zue5aSNOiBbQlVHXSByY3UgZGV0ZWN0ZWQgc3RhbGwgaW4gc2htZW1fZmlsZV93cml0ZQ==?=
	=?UTF-8?B?X2l0ZXI=?=
To: Kunwu Chan <kunwu.chan@linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Cc: "hughd@google.com" <hughd@google.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>, 
	"chrisl@kernel.org" <chrisl@kernel.org>, "kasong@tencent.com" <kasong@tencent.com>, 
	"paulmck@kernel.org" <paulmck@kernel.org>, "frederic@kernel.org" <frederic@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David, hi Kunwu,
thanks a lot for the suggestions.
I reran the reproducer with
CONFIG_PROVE_LOCKING=3Dy, CONFIG_LOCKDEP=3Dy, CONFIG_DEBUG_LOCK_ALLOC=3Dy e=
nabled.
Based on the lockdep-enabled run, here is what I can clarify:

Lockdep does not report any lock inversion, recursive locking, or
circular dependency.
The samples showing __mod_zone_page_state() do not appear to indicate
a blocking point; this frame indeed seems to be just where the task
was sampled.

From the timeline of the reports, the earliest problematic behavior
appears before the MM/LRU-heavy paths.
In the first hung-task report, multiple repro1 threads are already blocked =
in:

down_write()
 =E2=94=94=E2=94=80 rwbase_write_lock()
    =E2=94=94=E2=94=80 __rt_mutex_slowlock_locked()
       =E2=94=94=E2=94=80 rt_mutex_schedule()

via the do_vfs_ioctl() =E2=86=92 perf_fasync() path, and are in D state for
more than 143 seconds at that point.
After several threads are stuck there, the system degrades further:
other threads remain in R state, spending long, uninterrupted time in
MM allocation / LRU paths
(alloc_pages(), get_page_from_freelist(), __handle_mm_fault()),
without hitting reschedule points.
This then leads to RCU preempt stalls, and eventually workqueue lockups
(e.g. vmstat_shepherd, do_cache_clean, wb_workfn).
Lockdep=E2=80=99s =E2=80=9Cshow all locks held=E2=80=9D output does not sho=
w the blocked repro1
threads holding any MM/LRU/zone locks themselves; they typically only hold
the filesystem mutex at that point, which suggests the contended RT rwsem
is held elsewhere.
Overall, this currently looks less like a single blocking bug in
__mod_zone_page_state(), and more like a PREEMPT_RT-specific
starvation scenario,
where long-held RT rwsems in the ioctl/perf path combined with long CPU-bou=
nd
MM/LRU execution amplify into RCU starvation and workqueue lockups.
Below is the earliest hung-task report from the lockdep-enabled run
for reference:


[386.499937] INFO: task repro1:2066 blocked for more than 143 seconds.
[386.499956] Not tainted 6.19.0-rc7 #4
[386.499964] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[386.499970] task:repro1 state:D stack:28400 pid:2066 tgid:2066 ppid:293 2
[386.500022] Call Trace:
[386.500027] <TASK>
[386.500037] __schedule+0x1198/0x3f00
[386.500069]  ? io_schedule_timeout+0x80/0x80
[386.500088]  ? kvm_sched_clock_read+0x16/0x20
[386.500111]  ? local_clock_noinstr+0xf/0xc0
[386.500125]  ? __rt_mutex_slowlock_locked.constprop.0+0xecd/0x30c0
[386.500148] rt_mutex_schedule+0x9f/0xe0
[386.500171] __rt_mutex_slowlock_locked.constprop.0+0xedc/0x30c0
[386.500197]  ? down_write_trylock+0x1a0/0x1a0
[386.500222]  ? lock_acquired+0xbd/0x340
[386.500245] rwbase_write_lock+0x744/0xa80
[386.500266]  ? perf_fasync+0xc0/0x130
[386.500284]  ? rt_mutex_adjust_prio_chain.isra.0+0x3240/0x3240
[386.500304]  ? kvm_sched_clock_read+0x16/0x20
[386.500329]  ? perf_fasync+0xc0/0x130
[386.500344]  ? local_clock+0x10/0x20
[386.500364]  ? lock_contended+0x189/0x420
[386.500385] down_write+0x6e/0x1e0
[386.500405] perf_fasync+0xc0/0x130
[386.500421]  ? perf_cgroup_css_free+0x50/0x50
[386.500440] do_vfs_ioctl+0x9b9/0x1480
[386.500457]  ? lock_vma_under_rcu+0x7ee/0xd90
[386.500475]  ? ioctl_file_clone+0xf0/0xf0
[386.500490]  ? lock_is_held_type+0xa0/0x110
[386.500506]  ? handle_mm_fault+0x5a6/0x9d0
[386.500526]  ? kvm_sched_clock_read+0x16/0x20
[386.502053]  ? local_clock_noinstr+0xf/0xc0
[386.502073]  ? handle_mm_fault+0x5a6/0x9d0
[386.502092]  ? exc_page_fault+0xb0/0x180
[386.502106]  ? kvm_sched_clock_read+0x16/0x20
[386.502129]  ? local_clock_noinstr+0xf/0xc0
[386.502142]  ? exc_page_fault+0xb0/0x180
[386.502154]  ? local_clock+0x10/0x20
[386.502174]  ? lock_release+0x258/0x3c0
[386.502196]  ? irqentry_exit+0xf0/0x6d0
[386.502213] __x64_sys_ioctl+0x112/0x220
[386.502232] do_syscall_64+0xc3/0x430
[386.502253] entry_SYSCALL_64_after_hwframe+0x4b/0x53
[386.502269] RIP: 0033:0x7f62f7922fc9
[386.502351] </TASK>
[386.502357] INFO: task repro1:2072 blocked for more than 143 seconds.
[386.502366] Not tainted 6.19.0-rc7 #4
[386.502373] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[386.502378] task:repro1 state:D stack:28400 pid:2072 tgid:2072 ppid:294 2
[386.502427] Call Trace:
[386.502431] <TASK>
[386.502439] __schedule+0x1198/0x3f00
[386.502463]  ? io_schedule_timeout+0x80/0x80
[386.502483]  ? mark_held_locks+0x50/0x80
[386.502505] rt_mutex_schedule+0x9f/0xe0
[386.502527] __rt_mutex_slowlock_locked.constprop.0+0xedc/0x30c0
[386.503218]  ? down_write_trylock+0x1a0/0x1a0
[386.503246]  ? lock_acquired+0xbd/0x340
[386.503269] rwbase_write_lock+0x744/0xa80
[386.503290]  ? perf_fasync+0xc0/0x130
[386.503306]  ? rt_mutex_adjust_prio_chain.isra.0+0x3240/0x3240
[386.503327]  ? kvm_sched_clock_read+0x16/0x20
[386.503351]  ? perf_fasync+0xc0/0x130
[386.503366]  ? local_clock+0x10/0x20
[386.503386]  ? lock_contended+0x189/0x420
[386.503407] down_write+0x6e/0x1e0
[386.503427] perf_fasync+0xc0/0x130
[386.503442]  ? perf_cgroup_css_free+0x50/0x50
[386.503461] do_vfs_ioctl+0x9b9/0x1480
[386.503476]  ? lock_vma_under_rcu+0x7ee/0xd90
[386.503493]  ? ioctl_file_clone+0xf0/0xf0
[386.503508]  ? lock_is_held_type+0xa0/0x110
[386.503524]  ? handle_mm_fault+0x5a6/0x9d0
[386.503543]  ? kvm_sched_clock_read+0x16/0x20
[386.504012]  ? local_clock_noinstr+0xf/0xc0
[386.504049]  ? exc_page_fault+0xb0/0x180
[386.504312]  ? irqentry_exit+0xf0/0x6d0
[386.504330] __x64_sys_ioctl+0x112/0x220
[386.504369] entry_SYSCALL_64_after_hwframe+0x4b/0x53
[386.504464] </TASK>[386.504470] INFO: task repro1:2073 blocked for
more than 143 seconds.
[386.504491] task:repro1 state:D stack:28400 pid:2073 tgid:2073 ppid:292 2
[386.504540] Call Trace:
[386.504544] <TASK>
[386.505300] __schedule+0x1198/0x3f00
[386.505347]  ? mark_held_locks+0x50/0x80
[386.505369] rt_mutex_schedule+0x9f/0xe0
[386.505391] __rt_mutex_slowlock_locked.constprop.0+0xedc/0x30c0
[386.505464] rwbase_write_lock+0x744/0xa80
[386.505988] down_write+0x6e/0x1e0
[386.506042] do_vfs_ioctl+0x9b9/0x1480
[386.506301] __x64_sys_ioctl+0x112/0x220
[386.506340] entry_SYSCALL_64_after_hwframe+0x4b/0x53
[386.506434] </TASK>
[386.506442] Showing all locks held in the system:
[386.506447] 4 locks held by pr/legacy/16:
[386.506456] 1 lock held by khungtaskd/37:
[386.506464] #0: ffffffff85041540 (rcu_read_lock){....}-{1:3}
[386.506503] 1 lock held by in:imklog/196:
[386.506513] 1 lock held by repro1/2040:
[386.506522] 1 lock held by repro1/2066:
[386.506532] #0: ffff88800784bc50 (&sb->s_type->i_mutex_key#17)
[386.507276] 1 lock held by repro1/2072:
[386.507284] #0: ffff88800784bc50 (&sb->s_type->i_mutex_key#17)
[386.507321] 1 lock held by repro1/2073:
[386.507328] #0: ffff88800784bc50 (&sb->s_type->i_mutex_key#17)
[427.459692] BUG: workqueue lockup - pool cpus=3D0 node=3D0 flags=3D0x0
nice=3D0 stuck for 40s!
[427.459779] workqueue events:
[427.459809]   pending: vmstat_shepherd, e1000_watchdog
[427.460020] workqueue events_freezable_pwr_efficient:
[427.460020]   in-flight: disk_events_workfn
[427.460052] workqueue writeback:
[427.460084]   in-flight: wb_workfn
[427.460231] Showing backtraces of running workers in stalled
CPU-bound worker pools
Message from syslogd@syzkaller at Feb 6 10:27:59 ... kernel:[
427.459692] BUG: workqueue lockup - pool cpus=3D0 node=3D0 flags=3D0x0
nice=3D0 stuc!

Thanks
Zw Tang
