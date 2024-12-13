Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464C11917D4;
	Fri, 13 Dec 2024 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734122267; cv=none; b=AhWPJUuD10CuVpZNMUcudOfDOGdLhAjPZyzAohTLEp4RzaECJiYna7xWAeoXvbt9ShAftJr0pcGuDd4N9hi4CYjlhKtfYWjlaJ+F4K0iE0D8gOC9dN+26oOfZn4Audo2a3dnVGtrZzRDy5YchhFakXQg1g1FP4ArE/Q+MfPVsEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734122267; c=relaxed/simple;
	bh=dgBhccywBUi1Z1Jrf/UmDmrf7/D+q5cAvcMcLNPy01U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EygauKTXUtBMzcSp0+9tY0EQ5k1XGNXCUsBzsRaiwx2laM9fPcCRJ9lhEyu/EnHudefq8dvvIIui1QQVSLNwuDR/jvmqtEpVDN2UCuPLotyMbb7rukXxW22gh7aNJ5ZBKTKOhVs0qSoJQbr/CKM6U4pzs9Vf8SqlSok82ZCcB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miL62lH1; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miL62lH1"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6e8814842so211098685a.0;
        Fri, 13 Dec 2024 12:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734122265; x=1734727065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2hCD8dxslZh6qdjajfz4JhbUYrlSzYCmognMfbfPug=;
        b=miL62lH1BrOARr5C8Z9hD1teDj4Krth70XsTbo8ftyv3Y6zrDj0EnzwXFOIT2MrYrV
         FXSLdA5tn1W/h3r9poKpKczkkrhil3VgU3gVX5ywRe/RljryPZ34yTlxx30QrDyga6wQ
         /dW+yE4Iarv/vCxUmcAVU6La8aFDy8DV8o9OOaFkfYAo6ljBGwUlOQJScEOu6akWoEnS
         e8QN/Mg3Oem3cShKb8IEMKRdUezwJNig4ANPpWNFKsQZOyey6XGXVJqwg3UEYZlS4qh/
         DYKtu/N5TdKwROxWh5CueWHXMzB7MSevPHTd8SxsvpUp1NIAnvRk1NOHzgybpPaK4+Jg
         hN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734122265; x=1734727065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2hCD8dxslZh6qdjajfz4JhbUYrlSzYCmognMfbfPug=;
        b=hLDa+mmB35vf57UZA3xB4yZ+3a0Xm6k37cIYMTV1jkqIfg8ZK62Q3QRjjXWIgIhS7s
         cMkIBlRV24XRQLUp4+mNCvfOWdWEIT43WfsKLo5Epo86HKD64QRH7TIaxqXvCN40hgWP
         NJGJZl7Lom4jGk0jcQLERVMBjgR2flRCi2hCvVK23mzZm0Lu7h71M7ChsO6YGK3kgibV
         LNteGnMxQtSpC2xB2KmAUVZJFRbDD/YPXNl7d3A2V013u7CQMZ49frUdpQjP+0xodjnM
         JXXH7m03Lz49/5CV4lZN1bR30lOo5Fa+ieFeukhbNeLZN8PxMJYLRQNxb8cJkaEYEej0
         bYFA==
X-Forwarded-Encrypted: i=1; AJvYcCVWS3Xn6TbHZuHck8/W1bBloyfsmvxQ9Hsp9A8LgQeZ2fRHFt2vxGSkfxRLHjTPZ0DrUQZH@vger.kernel.org, AJvYcCWUWwg4klmJM0f1+xir/DoP8lAXCJf4Jgdi6CPrRx63/NexlfN6lIkzzXi6LC+OeHduEf0GXOlrlOHpswA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydZi/qWwg/2BUxOdtFqpft66ElMAgD65t4810XQmyn3Cr+YRI1
	3K1KnmQ3EGK8vwnejAzXG/xjBhZwf9O+y4LQW53bikpQIBP+tajQ
X-Gm-Gg: ASbGncvBaHl+WbKOW/CsCx7uN+ldtXQrnWcrEj0EIk3UwZjkvRE1RTS1olbOnp+BPVF
	7zEVJHS61ReHagnXh0JTR7Lzg+bXlTwiIJsWzUoFdotpKfaIUuomQin7sOVsaNnzAj2v1WXTRa9
	77H5JxEYmdeguNUWgbzSmzSkjeZ55q0v7SE5OxTcJhKjWKwSK4ImnDoHKwcOnnzRAXBo17iS1Pj
	KFOx8U67qCHUnHbzaUqq1gNr7AfhK7LJGidwGX5sEwSZI3bco0bvw==
X-Google-Smtp-Source: AGHT+IEd6vFvaoKvpCfh5RZWFZyloaTzshD/S9KFbQ4lTog5nXVcBMVF610olcrJB+CM/UzbRWBjQA==
X-Received: by 2002:a05:620a:4720:b0:7b6:70b5:306c with SMTP id af79cd13be357-7b6fbf7ae02mr637794785a.61.1734122265090;
        Fri, 13 Dec 2024 12:37:45 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:3::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7048bc4acsm11043685a.74.2024.12.13.12.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 12:37:43 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: frederic@kernel.org,
	tglx@linutronix.de,
	paulmck@kernel.org
Cc: vlad.wing@gmail.com,
	rcu@vger.kernel.org,
	boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org,
	joel@joelfernandes.org,
	neeraj.upadhyay@amd.com,
	urezki@gmail.com,
	qiang.zhang1211@gmail.com,
	Cheng-Jui.Wang@mediatek.com,
	leitao@debian.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [RFC 1/1] sched: defer completion task to online CPU
Date: Fri, 13 Dec 2024 20:33:45 +0000
Message-ID: <20241213203739.1519801-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241213203739.1519801-1-usamaarif642@gmail.com>
References: <20241213203739.1519801-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following warning is being encountered at boot time:

           WARNING: CPU: 94 PID: 588 at kernel/time/hrtimer.c:1086 hrtimer_start_range_ns+0x289/0x2d0
           Modules linked in:
           CPU: 94 UID: 0 PID: 588 Comm: migration/94 Not tainted
           Stopper: multi_cpu_stop+0x0/0x120 <- stop_machine_cpuslocked+0x66/0xc0
           RIP: 0010:hrtimer_start_range_ns+0x289/0x2d0
           Code: 41 5c 41 5d 41 5e 41 5f 5d e9 63 94 ea 00 0f 0b 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d e9 39 fc 15 01 0f 0b e9 c1 fd ff ff <0f> 0b 48 8b 45 00 e9 59 ff ff ff f3 0f 1e fa 65 8b 05 1d ec e8 7e
           RSP: 0018:ffffc900019cbcc8 EFLAGS: 00010046
           RAX: ffff88bf449a4c40 RBX: 0000000000000082 RCX: 0000000000000001
           RDX: 0000000000000001 RSI: ffff88bf43224c80 RDI: ffff88bf449a4c40
           RBP: ffff88bf449a4c80 R08: ffff888280970090 R09: 0000000000000000
           R10: ffff88bf432252e0 R11: ffffffff811abf70 R12: ffff88bf449a4c40
           R13: ffff88bf43234b28 R14: ffff88bf43224c80 R15: 0000000000000000
           FS:  0000000000000000(0000) GS:ffff88bf44980000(0000) knlGS:0000000000000000
           CR2: 0000000000000000 CR3: 000000404b230001 CR4: 0000000000770ef0
           PKRU: 55555554
           Call Trace:
            <TASK>
            ? __warn+0xcf/0x1b0
            ? hrtimer_start_range_ns+0x289/0x2d0
            ? report_bug+0x120/0x1a0
            ? handle_bug+0x60/0x90
            ? exc_invalid_op+0x1a/0x50
            ? asm_exc_invalid_op+0x1a/0x20
            ? register_refined_jiffies+0xb0/0xb0
            ? hrtimer_start_range_ns+0x289/0x2d0
            ? hrtimer_start_range_ns+0x186/0x2d0
            start_dl_timer+0xfc/0x150
            enqueue_dl_entity+0x367/0x640
            dl_server_start+0x53/0xa0
            enqueue_task_fair+0x363/0x460
            enqueue_task+0x3c/0x200
            ttwu_do_activate+0x94/0x240
            try_to_wake_up+0x315/0x600
            complete+0x4b/0x80
            ? stop_two_cpus+0x2f0/0x2f0
            cpu_stopper_thread+0xb1/0x120
            ? smpboot_unregister_percpu_thread+0xc0/0xc0
            smpboot_thread_fn+0xf7/0x150
            kthread+0x121/0x130
            ? kthread_blkcg+0x40/0x40
            ret_from_fork+0x39/0x50
            ? kthread_blkcg+0x40/0x40
            ret_from_fork_asm+0x11/0x20
            </TASK>

It looks like completion that requires an hrtimer is being scheduled on a
CPU that is not yet completely online. There have been other issues with
hrtimer that have been fixed recently [1]. A possible fix would be to
defer the completion to be done by a CPU already online.
This bug might have been introduced in [2].

[1] https://lore.kernel.org/all/20240913214205.12359-2-frederic@kernel.org/
[2] https://lore.kernel.org/all/169972295552.3135.1094880886431606890.tip-bot2@tip-bot2/
Reported-by: Vlad Poenaru <vlad.wing@gmail.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 kernel/sched/completion.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 3561ab533dd4..b79d0868f997 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -30,6 +30,13 @@ void complete_on_current_cpu(struct completion *x)
 	return complete_with_flags(x, WF_CURRENT_CPU);
 }
 
+static void complete_ipi(void *arg)
+{
+	struct completion *x = arg;
+
+	complete_with_flags(x, 0);
+}
+
 /**
  * complete: - signals a single thread waiting on this completion
  * @x:  holds the state of this particular completion
@@ -44,7 +51,23 @@ void complete_on_current_cpu(struct completion *x)
  */
 void complete(struct completion *x)
 {
-	complete_with_flags(x, 0);
+	int cpu = get_cpu();
+
+	/* The scheduler might queue an ignored hrtimer. Defer the wake up
+	 * to an online CPU instead.
+	 */
+	if (unlikely(cpu_is_offline(cpu))) {
+		int target;
+
+		target = cpumask_any_and(housekeeping_cpumask(HK_TYPE_RCU),
+					 cpu_online_mask);
+
+		smp_call_function_single(target, complete_ipi, x, 1);
+		put_cpu();
+	} else {
+		put_cpu();
+		complete_with_flags(x, 0);
+	}
 }
 EXPORT_SYMBOL(complete);
 
-- 
2.43.5

