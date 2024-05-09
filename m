Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1949F2747D;
	Thu,  9 May 2024 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240459; cv=none; b=tifoVr5FXz46442XTuJBoQQgbcud5T0b9CAs51d7yFWqk+2C/fJ4V3ndF5DrAJ80SHxC8AAJFUAr43ICEm9ecd5HPqVTWZNh0hBrw0VfVvvzaxYM+TfutSK0YNgMCXbv03mQ9r1ieitpemyMqj6MX62T5fhHhHCW3M1h1Lxr9Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240459; c=relaxed/simple;
	bh=/Hk+HDUCApUoxRrI1cEqlgRHMEvYYo4NSGj6AmNqJRo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jBaNi9WGpisirLAfAGiisZVWkFhDEw4sEUgrsnDOfB+CjL5RxRYz7jo5ZF+3HgCuIOF/h8i4iDzTYJLDm5fbA9+SLBLQSVIDMGo+fUAFZBShj593xIiGBD+J9AY5Dy/u8AIxqICr7rEWvXsJTJmwxxc5y9wj6Wui0Tmlb8DkAxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nshiaoNo; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nshiaoNo"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-61aef9901deso491091a12.1;
        Thu, 09 May 2024 00:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715240457; x=1715845257; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKiSBeXRcVkUUdzkMxkRSXFHQgmY3xB5UE0hRtjhYGQ=;
        b=nshiaoNoJHZhtaSYtDZwrThTj3gQTCbQlEuNPkhKmxGMHusLRozZZSRFx/ml6E7t9L
         Mux5J8FtznMQBNGHhyXquEqv2wREcotkLcRnMBy71Dm5mCq6lt6S45lCLhSqc3KJ1i7k
         frrfd8PrX7gi5uCwKxqav28pOAxRzmN105K1bVr+W0R2kw4GvNg4XZk2848lz4aQngEn
         XH2ht2aivgJZuyx6A2UzrK8quXIx9/zxPDyMrbmxjY3wW73uX5WmcCdfaXpW1yB99Rws
         ZgrQR1Y4m3pB/kHu5kHKJnBtrw+AkMZ0mBIq3RwyWsIW/AYRnRbwcp5AlErqeHrPQVDr
         H3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715240457; x=1715845257;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKiSBeXRcVkUUdzkMxkRSXFHQgmY3xB5UE0hRtjhYGQ=;
        b=JbOJORqyl9Ybh3Q3bZxKPiTQD3F5lh52As3+t2bIeEz69LlOuy0HV7NjE2HXxAym+J
         pxES+RhUwJjENJ13UVjbqKAz7xmS1Pe/AN1TRBmoY13m7oiuHAmSvvfLyEy+4J5lS7jp
         7y0z+kthLEBLJ0mTsYE2RI0w3u5I9nHVsVpaDU89pvj1w7ZTsawqrDvxm48cHHwt3c9E
         6MyZECHbPF4T+gGKIv7pwnaNGOA/mGrlkzbb939tltLKQWWSKgXF8RvkNK6eMR2m7adj
         dTHZdKNpnlPEKoOtgYyNxIsrwE4ny06/2DsXhazLJFBWI96SuzBYnpxqae698LCLqJoy
         o0fg==
X-Forwarded-Encrypted: i=1; AJvYcCWea6c3mut0Uro196W2g6WDaDerm5flQkIyJ15wqg/weEVdqPLD9ADmZYgf9ijHA9zfa9D1ENp3sYHXFx1fnSUtCu/sRkcsGodW6Poiq8ZXpdUlSa4lps2qGV02FigDKVgT
X-Gm-Message-State: AOJu0YyG87l8iLYTtT4bibn6C7rSa3dVZeWhR7efOB4YkY0wFLZ87Qox
	S057U2rlpVoU0Xt+acFU2tFCx/5wkVpYRma+Ud93vP0Vjl3OFf/R
X-Google-Smtp-Source: AGHT+IHtF241YpleHFBSCoJUp2H3nJXVUq96ckEcjrHjq+yDTYMOICd2IbJGMGX7Rm32Y2XVRXvfxw==
X-Received: by 2002:a05:6a20:2d23:b0:1ad:5325:d9b7 with SMTP id adf61e73a8af0-1afc8ddc16cmr6140115637.52.1715240457349;
        Thu, 09 May 2024 00:40:57 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c256299sm7569085ad.286.2024.05.09.00.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 00:40:57 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcu/nocb: Fix using smp_processor_id() in preemptible warning
Date: Thu,  9 May 2024 15:40:46 +0800
Message-Id: <20240509074046.15629-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

Currently, the this_cpu_ptr(&rcu_data) in rcu_rdp_is_offloaded() is called
before the condition "!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())"
is checked, and occurs in preemptible task context, this will trigger the
following warning.

[ 4.106221][ T18] BUG: using smp_processor_id() in preemptible [00000000] code: rcuop/0/18
[ 4.107796][ T18] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
[ 4.108547][ T18] CPU: 0 PID: 18 Comm: rcuop/0 Not tainted 6.9.0-rc2-00079-g4c66bc7cacc0 #1
[ 4.109667][ T18] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 4.111064][ T18] Call Trace:
[ 4.111064][ T18]  <TASK>
[ 4.111064][ T18] dump_stack_lvl (lib/dump_stack.c:116)
[ 4.111064][ T18] dump_stack (lib/dump_stack.c:124)
[ 4.111064][ T18] check_preemption_disabled (arch/x86/include/asm/preempt.h:84 (discriminator 15) lib/smp_processor_id.c:53 (discriminator 15))
[ 4.111064][ T18] debug_smp_processor_id (lib/smp_processor_id.c:61)
[ 4.111064][ T18] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:27 (discriminator 1))
[ 4.111064][ T18] nocb_cb_wait (kernel/rcu/tree_nocb.h:936 (discriminator 2))
[ 4.111064][ T18] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:983 (discriminator 1))
[ 4.111064][ T18] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:976)
[ 4.111064][ T18] kthread (kernel/kthread.c:388)
[ 4.111064][ T18] ? kthread (kernel/kthread.c:373 (discriminator 2))
[ 4.111064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
[ 4.111064][ T18] ret_from_fork (arch/x86/kernel/process.c:153)
[ 4.111064][ T18] ? kthread_complete_and_exit (kernel/kthread.c:341)
[ 4.111064][ T18] ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
[ 4.111064][ T18]  </TASK>

This commit fix this warning by priority check the condition 
"!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())" , to
ensure whether the this_cpu_ptr(&rcu_data) can be executed in
rcu_rdp_is_offloaded().

Fixes: 8feeeba60711 ("rcu/nocb: Use kthread parking instead of ad-hoc implementation")
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/tree_plugin.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 340bbefe5f65..1bb73466a8a9 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -28,8 +28,8 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
 		!(lockdep_is_held(&rcu_state.barrier_mutex) ||
 		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
 		  rcu_lockdep_is_held_nocb(rdp) ||
-		  (rdp == this_cpu_ptr(&rcu_data) &&
-		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
+		   (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
+			rdp == this_cpu_ptr(&rcu_data)) ||
 		  rcu_current_is_nocb_kthread(rdp)),
 		"Unsafe read of RCU_NOCB offloaded state"
 	);
-- 
2.17.1

