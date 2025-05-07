Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111DF189B8C;
	Wed,  7 May 2025 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746617182; cv=none; b=o9XD2E2Qy0EVEOvKW6bJIRvLBi7ZlkDFK+0ftpy40TtMhkR4SwuwMtPMIiKPoYgklei1BDwkujbc0EVR/wmuDCVsjqvMxGCUCuWlxySpMdweY8iFMzwg25qxTznDUbecQn+VLhO05y2cWhlesIGIO1v1fOw3S5VEJZq01OSbP2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746617182; c=relaxed/simple;
	bh=OWonO6PyHcEEsydcyWemY8C0jemBCk1E0AwXvnaYG/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aAdxiGFS0VnngnXMhGT58LmE10z5z1fRkpwuzIthu1VQQE85PTeWt7bQUkIKdICSmJVsL5G0fYyPP6fjmyzvUNPwK/VKlbya0w2xeZezO2mfCYrVXDzww0jnYmcPcFxihJ4ejERnDYE2nbQbEiDu00sHpdwwmKHZflHaMkrW69E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2CM839D; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2CM839D"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736a72220edso7376008b3a.3;
        Wed, 07 May 2025 04:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746617179; x=1747221979; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GMNvKxOPFGagkiX4nWGhokncKv/c3K3QOeRTRxkUohI=;
        b=F2CM839DZSWzeoaNWYGBlqfusgkzeA+7y4Z48cagwYGsHiGMPM7EnvtvwnXx+MPFSN
         8J28pBAbbT5Kf5uxzeD2myjNDMchUiKxqAtgclfFgghA2QjnTEPPZhXJ97ozGmsZhiFH
         fOHWA2IV/Pplg+EcE0E7IUY17wcM0JUAMtfY+EhC7S2aLi0XaNXALnXfej9jej9yalfJ
         DFnR3w2KqO194T1oz1xisZW21Lt28KIUsveMm+JYv8Khk7JhF4+abDiNaNffqi4cBvCz
         nwAluvbM6eAuKu/WfYpbM+G0nB5TqfONBUlIe9XsOEh7AOGKcTAa6lMLWSc5U4b4qB9U
         6KNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746617179; x=1747221979;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMNvKxOPFGagkiX4nWGhokncKv/c3K3QOeRTRxkUohI=;
        b=wS9Adv4JX3aoRJC1ySf3ikWZtobPno+ESgZwqgVgcVm418fUUNzEaP1PPL3k1DRG7W
         4wvBDysv6z77wc6t+7HTPB91AsQ+0zzBkQggfdFrQjRg/PQ4esq131p8tPw6tzF0/SKq
         lhP2nYboyOEblzuv6zveuwwr0sPC/nVJkeyDCsFdsW6Np09NVUFZNcXHmauLKH7kGQZd
         1ZbXvnFCwWPoxHLK2rcT0636VTS2knrESPHKe3UCggK2otrsj4n9fMj53M29KDNGZj7y
         gTtxPFLHzOEAfNANF+yqizOlm5VQaDt1J2w6Jy32QhNnk0oXGGTZvPiTDRRSjf6dwiR1
         ZQog==
X-Forwarded-Encrypted: i=1; AJvYcCV8giGxviFjlIgkXGw0cb//OV7jZ5vqBVxlbO3zPlqNA4FsPyTfF1So35tZiTn4NJ3qxdnx@vger.kernel.org, AJvYcCWnL6cbq+uD3YwrEaIGPnX1q8WsezTHs0XdDWd6Tl6HGArJs4pzGpAXx8V4wU7WzQMKXZ3JVlMT7fdahlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn46Vy/mA178s7YzEcPzQeFUxOwnjuwWkZx5QBMCWPeZjN0vPY
	ZTrUFOzE0RwI/ABmKWfBqs/wK8CKLJE6rBTVc1SzX9HnXwpmp0i8K7ZDxRk2Bu4=
X-Gm-Gg: ASbGncthjkHLH41v2JnGoHJCfSLu/vZFG871+pJSoZPHgwj35JBpkCi8Wr3k6X6ygjX
	YhSZmme0lhk9Zstj1VpFoogDfYc3rrvQO8OPWKfIlvb+j3yBYLyT3L+8VCHPnSQGhCzwbd3w/SV
	ZzZFxYG06dhG01dXR50kcnQuW5W9jRlvp554FUBOr5p/SklVIloy31VDxiaV0AQrHKdOGrf109q
	9kodmjlNJpMh1Srl8/UNelpQwBiEt3iGImv3xFRbwF2gux7pEEYv/rNBD9FKB/Um79WZYEmD0FV
	L0m4f230nW4DI0k2ueE7SDsUcNsr0lh1qvofr8YMADYAsoyQtOPdasQhon0f6uNp+Ac3eEIgWw=
	=
X-Google-Smtp-Source: AGHT+IGTN0G5Dp4LwYX0oFotYV3fs2z0ObHi1fyCHJjWJr6LOIWPO0GtZbVAqqKw7nPvo3BHDhWgig==
X-Received: by 2002:a05:6a00:1bca:b0:73d:b1ff:c758 with SMTP id d2e1a72fcca58-7409cfa5a4dmr4022519b3a.18.1746617179219;
        Wed, 07 May 2025 04:26:19 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740590610desm11184898b3a.146.2025.05.07.04.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 04:26:18 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	urezki@gmail.com,
	boqun.feng@gmail.com
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu/nocb: Add Safe checks for access offloaded rdp
Date: Wed,  7 May 2025 19:26:04 +0800
Message-Id: <20250507112605.20910-2-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
References: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

For built with CONFIG_PROVE_RCU=y and CONFIG_PREEMPT_RT=y kernels,
Disable BH does not change the SOFTIRQ corresponding bits in
preempt_count(), but change current->softirq_disable_cnt, this
resulted in the following splat:

WARNING: suspicious RCU usage
kernel/rcu/tree_plugin.h:36 Unsafe read of RCU_NOCB offloaded state!
stack backtrace:
CPU: 0 UID: 0 PID: 22 Comm: rcuc/0
Call Trace:
[    0.407907]  <TASK>
[    0.407910]  dump_stack_lvl+0xbb/0xd0
[    0.407917]  dump_stack+0x14/0x20
[    0.407920]  lockdep_rcu_suspicious+0x133/0x210
[    0.407932]  rcu_rdp_is_offloaded+0x1c3/0x270
[    0.407939]  rcu_core+0x471/0x900
[    0.407942]  ? lockdep_hardirqs_on+0xd5/0x160
[    0.407954]  rcu_cpu_kthread+0x25f/0x870
[    0.407959]  ? __pfx_rcu_cpu_kthread+0x10/0x10
[    0.407966]  smpboot_thread_fn+0x34c/0xa50
[    0.407970]  ? trace_preempt_on+0x54/0x120
[    0.407977]  ? __pfx_smpboot_thread_fn+0x10/0x10
[    0.407982]  kthread+0x40e/0x840
[    0.407990]  ? __pfx_kthread+0x10/0x10
[    0.407994]  ? rt_spin_unlock+0x4e/0xb0
[    0.407997]  ? rt_spin_unlock+0x4e/0xb0
[    0.408000]  ? __pfx_kthread+0x10/0x10
[    0.408006]  ? __pfx_kthread+0x10/0x10
[    0.408011]  ret_from_fork+0x40/0x70
[    0.408013]  ? __pfx_kthread+0x10/0x10
[    0.408018]  ret_from_fork_asm+0x1a/0x30
[    0.408042]  </TASK>

Currently, triggering an rdp offloaded state change need the
corresponding rdp's CPU goes offline, and at this time the rcuc
kthreads has already in parking state. this means the corresponding
rcuc kthreads can safely read offloaded state of rdp while it's
corresponding cpu is online.

This commit therefore add softirq_count() check for
Preempt-RT kernels.

Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 003e549f6514..a91b2322a0cd 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -29,7 +29,7 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
 		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
 		  lockdep_is_held(&rdp->nocb_lock) ||
 		  lockdep_is_held(&rcu_state.nocb_mutex) ||
-		  (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
+		  ((!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) || softirq_count()) &&
 		   rdp == this_cpu_ptr(&rcu_data)) ||
 		  rcu_current_is_nocb_kthread(rdp)),
 		"Unsafe read of RCU_NOCB offloaded state"
-- 
2.17.1

