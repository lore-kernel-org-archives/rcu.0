Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D24175AB;
	Fri, 13 Dec 2024 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734122265; cv=none; b=eO1/F1NEuSXQhgJ6b3PFbpUgKwdSm9cY2LvUxe01ITkPy2tKuJfPTpvu7g9/9NOLI0w4csIup8Lzlk3TXE964Dmev0mIZnh6OqrDUiDpcvBZAoz1nDA2RQDU9YVG+7//OZOEHVv4EfCWiLw1tzfXPwP599de+Pwro3l2dtoY5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734122265; c=relaxed/simple;
	bh=K6QZ1TxxKCBf8A8qbvwGo280gAv3OmuGt7sIjSOpryU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iNVc/HxIEz4LCtyDOUfsh1nKvD71IHIgW/pgTiHAutodBmVzPebwUVRiNXKD6ZBlHCbcYYFeq6zEfJuWbwUG5FAN0YLfQBp1oQeUzFaimEXlz87l02Td2epaTHMMgqH+QqzgdukOplj2x9M1cnSCirQBT1+wl/LoUDi9XcU2nA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMQ2mzjb; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMQ2mzjb"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-467a63f5d1cso10508511cf.0;
        Fri, 13 Dec 2024 12:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734122263; x=1734727063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ourHhKVYzOBg1yEuLjh4qlGIVWq5DzAEGlr8M472leM=;
        b=JMQ2mzjbMGPKQs76Q6nVh8N/KAQ/WIt2SHyWdQS1Hd5lwGjk/n4HRH3Da2PyE/iw2k
         +wX4AtGNbYPwV01htijbDlaAIZrquYo5yF+Y7R2Ju9FiL44BD01j1W0aFLxTg67z/0K+
         v9QhT552TI+ZaGIOR8e5lHzWh9SDmcdAy3OD4JoW62JZJyTS0G+sFjbujUo6tvfEpUeN
         YHzYvi8Ep2MNybp+401FhCWOMSdTQoaIIs4ZuG5v2lUQu7i15p9DVf4WEfF5VhiH3F4b
         i3PC/4X3w7wczK8HHlqlQdUi7JE+Y8iwCHlPErhWapWMXc86T6pBcYfoxmPmgouLCyxj
         fEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734122263; x=1734727063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ourHhKVYzOBg1yEuLjh4qlGIVWq5DzAEGlr8M472leM=;
        b=uBT5tKdbEQ6DvTAdHLCgpFZydkxaLRTYyLsFBlmLFaRni434GkPsAKbbTZLWWFaRHX
         /FIJoT12IlCQv7iUZwCf/naF5jRwd2vJmZXCQP1pnpg+XwUes/cD5yBkWFhEWgfBeDOa
         tf33/wWcDHZ0QS3kNokK1eCT9cYu6FvFgo0leWEfK03MUKyTjm6+IV+yCgORfyeGvBxE
         g5rDtbLvjIBuTn0M235iAyAzy4gFSpQj5rYC333uqtcgSbXnlugD0UVC/Cnz05476Bgp
         nibD/LRMhjeZRgTp8XMPAvNygytkDgaoucOLKWLPd3gQxrTqJ6tkOmphrAwpN4M22nMU
         GqbA==
X-Forwarded-Encrypted: i=1; AJvYcCVhHPKW88H4rn4knJECccjtV/hbyL8JHjUpls8ukN9Z+DDaxkks4V5WzqrzoKOmLh1Dtj7w@vger.kernel.org, AJvYcCXouYhCrJJe/ZQfDPDbh4cjzbgjKeaEqgg1sUErKtywLBSWRMObYcNhGplS5inmJ0mhiRovtmLzX3o+kuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxxli7qIsK1uW/Q05tPu/H9I85wlZUtW3mu0QyyHUHBqbPzioJ
	QMLGiibp4KctL4865e90DlOj3JsHEJioVqFDJKzJ5jw0+oySGo+3
X-Gm-Gg: ASbGncvMUuOCkShpy5fOC2x41Nzn7s47M5K+CgWiYK0Kv+y5iNzAsWQNhQGz1Rvwb4H
	V6ZoBah7X03mC/7/bEnqCLVEjUppKMHx0BdeiLkR2MHwYPdv8vW5BXQP7yCVsURrNBrOZxNG2E3
	IDh4OAFsNnpOhPTijevPbfkXcixda9j/a3YIjijC3qGijDzO7JG0+GyWe1z1IqOuRLm17EJ/8eG
	z2YZAqjVG+teSisL/rAvY2laBO49S59EYiOx3srn9mdgAo0a5GvAA==
X-Google-Smtp-Source: AGHT+IG40vULa7VB9jnVn12piaYJboj5bBO3uZ9xlEm9L9silyL18rPgjqSZV94vTuAHYUcprJ2lFg==
X-Received: by 2002:a05:622a:1a94:b0:463:64b2:2e0d with SMTP id d75a77b69052e-467a5807b26mr77401201cf.40.1734122263125;
        Fri, 13 Dec 2024 12:37:43 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:a::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e8097asm1290211cf.63.2024.12.13.12.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 12:37:42 -0800 (PST)
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
Subject: [RFC 0/1] sched: defer completion task to online CPU
Date: Fri, 13 Dec 2024 20:33:44 +0000
Message-ID: <20241213203739.1519801-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We (meta) are running 6.12 release kernel in production and are encoutering
the below warning, mostly at boot time, reported by Vlad Poenaru.

           ------------[ cut here ]------------
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
           ---[ end trace 0000000000000000 ]---

It looks like completion that requires an hrtimer is being scheduled on a
CPU that is not yet completely online. There have been other issues with
hrtimer that have been fixed recently [1]. This bug might have been
introduced in [2].

We dont have a reliable reproducer for this (just see it popping up in
production). A possible fix might be to defer the completion to be done
to a CPU that is already online, which is what is done in RFC. It would be
good to get feedback on how this could be reproduced, if the RFC makes sense
or if there is another way to solve this.

Thanks!

[1] https://lore.kernel.org/all/20240913214205.12359-2-frederic@kernel.org/
[2] https://lore.kernel.org/all/169972295552.3135.1094880886431606890.tip-bot2@tip-bot2/

Usama Arif (1):
  sched: defer completion task to online CPU

 kernel/sched/completion.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

-- 
2.43.5

