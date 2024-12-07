Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD2286A9
	for <rcu@vger.kernel.org>; Sat,  7 Dec 2024 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733590113; cv=none; b=JRMsJws2EEbo9RDwXhkJdL2jzEaxXgJLRrSHLQgZiO/cFPCdWj/6/h05ucel+Dm1Qg7i/HZ3MhMrqSNofI/0YLkCBMG+ArcaQkjAdLjKzSwzS4VYoXtmmdiImjBej5C9lID3nBp2eLAFbXrWhhWntbrZsDgv4xogxcI4xIv1SqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733590113; c=relaxed/simple;
	bh=q4GoVJeno8ycip4I4bsx48XBP/Zh+mHBk7GqR7ykypw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Bm7ZQ1gFC3ox+2pI05iXIToHppj/39L0rqI2Dre4wD2Z2GmdY61Xl3NxLABF1Bv3V8/tEDpdRh2i1GmfEcP5olq7XnpV4e+NMY32sL8vLHanSIdF4KLkrX8tbuBqesctEmXDUVmJRufonJnxTbX63XwfTRWv1T9GUZdvGBC7nEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP6Gw2SD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP6Gw2SD"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-216395e151bso748015ad.0
        for <rcu@vger.kernel.org>; Sat, 07 Dec 2024 08:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733590111; x=1734194911; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPCH0TFI949yK1CObak2B5toScZYMSDVvY/B+jHjkV0=;
        b=IP6Gw2SDX2Ckrc3uBaeK70GkRb+DAdQatMMZ868Rw727vQc8HRF70H8o8+7JOatsRb
         z0E4cp6/F3SYrfGbsdm3qW4ajFE5+L/c3i7KXqLN8Gwi5wOFDUzY3IAMJUKv7B/vyz2H
         UUTqmPbaWtXruNPfCTGwImDWcLOyaR+UK6fnFQVwIgsuTRZrzi4xMqy9qNaBsbdcjFus
         poSnAB8FzhYVHVL7WYJe/tjrL7gOX7ZDWcGkshThxnPvjfMda8Z+H1UdUr6j2TlrAtxo
         CdcRhy7g4hBVPj6Xm3DuSqvprEZWUjI/Ki5/CIuF8PLxIR5m0ZTmF2nsVYBu24C4n268
         x7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733590111; x=1734194911;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPCH0TFI949yK1CObak2B5toScZYMSDVvY/B+jHjkV0=;
        b=Y1dxcPhK8JjDxWkFeclacQC1nRqLDVNaRLos03wMBn70LOWmWMMOVQWCqaYaEqVkPq
         W5o0cqWjkISd+xccH1M4X2bA9PX76IBv1Lc2IYCePBhxwPMfOtCF3Mq65io0aVNH9XqG
         OxQzGBtLOhGx1nQEPI3IfAg8QQSBFMvHJx6OQolPfvsaFrYw6pHJrZ/iHtQhNIDExcCj
         Vkngyj10BwZEUJCwM60hlUSJeBPTM/VsJB4o9zu1ToeXwH/mu6wjAV+WmhHrPv9cuH8d
         sIBMZIV15z9rfIKEUukBV09eOxBgqs3mKUr/y9HhbcUSh8rQvmlFr4ATlwM5Sf7SeDEp
         3VZg==
X-Forwarded-Encrypted: i=1; AJvYcCXe0pgoyTLUDBmXrnii5MZnDkO7X3zRfcQ8dDL7Y1zzWaJxs5GOvT1SLZV90RFIE6VIhrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVnOhIrelLfCSVWb9fuhIY6nZ5KHZuXIMRkbvg3l3z7dsBK4+s
	G+x2T+t/LTWeDR0BcyRRus5+63v4SgLK08rNAMD3e7CbYPMHbehX
X-Gm-Gg: ASbGncvacXLJc3eTSwe+f0lrPYfcmQdUdoO1baL/0zoznU1lAcyx1f8Ybx4gEw8aKjm
	ch/kjcHlU9CzkVKx3SoL7afJPt2VanQ/rBdxBUzBheOVNKoXfAnUJU9KN1CHLpmmm+iJDFkiA9W
	OSt+in8AfGOHVVpbsy9rbh/1LHEY9kHoqLTIvBAgN6J4UBLv56zJ3auukfhWqSHvVpxP25h0Qj5
	mM/2zEARClgBOI7xj5BQbxvhiC9pN93YQavUq22iaAB7K3x6srDIik/Vho=
X-Google-Smtp-Source: AGHT+IE9vLcrqtolkSuxPhtcw3Zhm4o5Otor3aGeAULFh2VtFustOAHyXoJrp6cOPIGRlnJvjSEkuA==
X-Received: by 2002:a17:902:e5c3:b0:215:b01a:6288 with SMTP id d9443c01a7336-21611afcaa8mr129135715ad.21.1733590111049;
        Sat, 07 Dec 2024 08:48:31 -0800 (PST)
Received: from localhost.localdomain ([43.153.70.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f29beesm45674775ad.254.2024.12.07.08.48.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2024 08:48:30 -0800 (PST)
From: MengEn Sun <mengensun88@gmail.com>
X-Google-Original-From: MengEn Sun <mengensun@tencent.com>
To: paulmck@kernel.org
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org
Subject: Softlock up of rcu_sched has been detect
Date: Sun,  8 Dec 2024 00:48:29 +0800
Message-Id: <1733590109-12926-1-git-send-email-mengensun@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

Hi,

The kernel version that we are using is 5.4.241. Recently, we
encountered a case of rcu_sched thread soft lock. The kernel stack
is as follows:

crash> bt
PID: 10     TASK: ffff8a83cc610000  CPU: 14  COMMAND: "rcu_sched"
 #0 [ffffc90000a64d50] machine_kexec at ffffffff8105714c 
 #1 [ffffc90000a64da0] __crash_kexec at ffffffff8112c9bd 
 #2 [ffffc90000a64e68] panic at ffffffff819e29d8 
 #3 [ffffc90000a64ee8] watchdog_timer_fn.cold.9 at ffffffff819e9a3f 
 #4 [ffffc90000a64f18] __hrtimer_run_queues at ffffffff8110b5d0 
 #5 [ffffc90000a64f78] hrtimer_interrupt at ffffffff8110bdf0 
 #6 [ffffc90000a64fd8] smp_apic_timer_interrupt at ffffffff81c0268a 
 #7 [ffffc90000a64ff0] apic_timer_interrupt at ffffffff81c01c0f 
--- <IRQ stack> ---
 #8 [ffffc9000006bdd8] apic_timer_interrupt at ffffffff81c01c0f 
    [exception RIP: _raw_spin_unlock_irqrestore+14]
 #9 [ffffc9000006be80] force_qs_rnp at ffffffff810fa0b0 
#10 [ffffc9000006beb8] rcu_gp_kthread at ffffffff810fd9b6 
#11 [ffffc9000006bf10] kthread at ffffffff8109e40c 
#12 [ffffc9000006bf50] ret_from_fork at ffffffff81c00255 

It seems that it is because a CPU did not report its QS in time.
I see from vmcore that the 141 cpu did not report its QS


The current process on the 141 CPU is as follows, it looks like 141
has detected the rcu stall and the print serial port log

crash> bt -c 141
PID: 594039  TASK: ffff8a699dab8000  CPU: 141  COMMAND: "stress-ng-zombi"
 #0 [fffffe0001f70e40] crash_nmi_callback at ffffffff8104b54f 
 #1 [fffffe0001f70e60] nmi_handle at ffffffff8101cf92 
 #2 [fffffe0001f70eb8] default_do_nmi at ffffffff8101d16e 
 #3 [fffffe0001f70ed8] do_nmi at ffffffff8101d351 
 #4 [fffffe0001f70ef0] end_repeat_nmi at ffffffff81c015f3 
    [exception RIP: vprintk_emit+492]
--- <NMI exception stack> ---
 #5 [ffffc90002038db0] vprintk_emit at ffffffff810eb19c 
 #6 [ffffc90002038e00] printk at ffffffff819e6544 
 #7 [ffffc90002038e60] rcu_check_gp_kthread_starvation at ffffffff819e78bd 
 #8 [ffffc90002038e88] rcu_sched_clock_irq.cold.84 at ffffffff819e8021 
 #9 [ffffc90002038ed0] update_process_times at ffffffff8110a8e4 
#10 [ffffc90002038ee0] tick_sched_handle at ffffffff8111be22 
#11 [ffffc90002038ef8] tick_sched_timer at ffffffff8111c147 
#12 [ffffc90002038f18] __hrtimer_run_queues at ffffffff8110b5d0 
#13 [ffffc90002038f78] hrtimer_interrupt at ffffffff8110bdf0 
#14 [ffffc90002038fd8] smp_apic_timer_interrupt at ffffffff81c0268a 
#15 [ffffc90002038ff0] apic_timer_interrupt at ffffffff81c01c0f 
--- <IRQ stack> ---
#16 [ffffc90004227c98] apic_timer_interrupt at ffffffff81c01c0f 
    [exception RIP: __rb_erase_color+34]
#17 [ffffc90004227d78] unlink_file_vma at ffffffff81241e0b 
#18 [ffffc90004227da0] free_pgtables at ffffffff8123708e 
#19 [ffffc90004227dd8] exit_mmap at ffffffff81243ea1 
#20 [ffffc90004227e78] mmput at ffffffff81074fd4 
#21 [ffffc90004227e90] do_exit at ffffffff8107d50c 
#22 [ffffc90004227f08] do_group_exit at ffffffff8107de6a 
#23 [ffffc90004227f30] __x64_sys_exit_group at ffffffff8107dee4 
#24 [ffffc90004227f38] do_syscall_64 at ffffffff81002535 
#25 [ffffc90004227f50] entry_SYSCALL_64_after_hwframe at ffffffff81c000a4 

I think the reasons are as follows:
- The rcu_sched needs to lock the rcu node where the 141 cpu is located
  to force the QS operations.
- However 141 detects rcu stall and locks rcu node to print some serial
  logs.
- The 141 cpu does touch nmi considering that printing port logs may
  cause system soft or hard locks.
- However, The 141 cpu does not take into account other cpu, such as
  cpu 14, which may be blocked because it holds the lock of rcu node.

I think printing serial port log is a more expensive operation, can
we only let the 141 cpu in the critical section of the rcu node lock,
collect the information it needs to print, and print the log it
collected after it released the rcu node lock?

I'm not sure if there is a better way to solve this problem?

Regards,
Meng En
