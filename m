Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFBA1B4236;
	Mon, 28 Apr 2025 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745834120; cv=none; b=lW3/qk6dfdK7RM9wUj+2TlHsDM6jEiQ+Qqi7TBu9YumLN0a38TpW1AI0gFY+737JRAPh0Eda0aKGnKig09jXCVQEDsoCTr6NetdAHC9OCJ4MZQ4Pr1EPxgWaSG7c5xxnJOGHoU0cKsOTs/fwkBoMgu8Rxv3I+S52afeCHjtG3hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745834120; c=relaxed/simple;
	bh=xyIvObuf466q/Dg9johj2Od5IvIphpCmwp+0bLxSAbo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Cnu9uws1xT/3OyHJjxXCu8l0mWRPmd0T746ynnurjKQ60LHn4IPxM+FNTJ48hSSduA8InjkaBEWsCtNlD2Wa/fmS4Zjfo4WJVL5ofppdSC8D6PqzxgedoCKZTwhCI85PLWNdFSKs2q1IqWRlpiCTEDuIalGN4bjcfvXDova1iKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAYWEyF4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAYWEyF4"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2264aefc45dso68546305ad.0;
        Mon, 28 Apr 2025 02:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745834117; x=1746438917; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvzHoJ0Ig62smTnWPhMoLx7Hm5DP7D6a933RmPwdRgU=;
        b=EAYWEyF4nw3lrcnwFOCWxSkawphcHYGtLWuh8xZ6y/+3UX7SIL0OFIoGCzArYH7y3q
         GxmxABw8ryz+DLsknoojatevPTwASWSJVqr8zuNfhmec5pP8khKiSC7lBPpLU/1/0bP4
         Az7EJNgQ9rwUkRmnISONVYkjXlo9SIGV1QgsDZu9u+Cquf81hRG84C/pyObiVKAQ7mZD
         AHSGwkX+KFBr/iIVMJbcfWeTO7DslTgnYfsv+NXueuWken55aVpoNyjweo1IxyOo+Z/d
         EE0c5SXf6niFjxrtATIM9JvD6thW/Q5HB+tPkQL4Tj3f6bCS3VoCgn0dWZb75zgL9sb1
         rb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745834117; x=1746438917;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvzHoJ0Ig62smTnWPhMoLx7Hm5DP7D6a933RmPwdRgU=;
        b=DEsOX+/QuqvCbjRYRewhQZImm0mZfkvCO/7DT335m9P+nW8hY+BN+XqnxJP8jq2TRW
         R6PAdU2yg5j8VFm/wZNmxQ1F/si//IIFvhZI5nyyl+PV8ZVaANbnHbXwOx7Dpjs9PVN6
         8fe6nMSBzCi/ivr0pIzI/17lsblJthpLO1tf31jfiT2V+9dQArW55BJaixE3SPD7HmB3
         eD+f6kYb1QxnI02LFFvR0FVMxbWqVCwT7SoauVnQSYhpI5WH4Rfs4zZqHNK1exAsA2cf
         XnzlldM89cLM4usNgsIiGtkCCIjpQXK1VANr+B0Z85wccgTKIKAo4OYeq/9CdYhcgehi
         Rn3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQfTUGuYpljnlOLVPla6GGKWuKj1aV9TU92Df2Y5wUCHZeml42XkyNfuzdphRvEojwcIlCGdr6VCUoWnE=@vger.kernel.org, AJvYcCXXlgC8CrXcNGVSbjcrOLg7TfFYEVokUV2zne1OXBTHdcKMn2VRAAxdc13qDK9gaMUEI8+X@vger.kernel.org
X-Gm-Message-State: AOJu0YzhDcbfJDDRpsDeDlNrwv++YYU+QxVshR76HjvNTv71rIbfliB6
	3OS7K+G0pdrrtYpc/Y0WIpZB3iNaPLlO4YvWRaaj3FmL800JXF3G
X-Gm-Gg: ASbGncvaSzJQWejTRh6VYpy1DUwqz08TXsdE2YsdulweYehp2kGmXUYMlf7oAvNB55b
	kYU1pp7sKAY3SyTWmZWOSnQst6Dqnfk/OAw5Rtuzc0TZ4TsKk5vMIcx7Cl9rLf7NkXlqcGftKwW
	3DyUKOBICPaiuhWreaiL75PSeH0BkZ1ehINhh9DD/YMuJ7dQOYW2EQqfm4R4dUwxlssly7ELJ4I
	UmHC+HSwBYE7Sv9/UbSlQNf+J+mUgL0eO8Lz5sMtxhEw7gpIdbM06sbc8h0FjmxzaCJfTbfJONW
	iFAXKFCpEoT99Tq1psnuEnnocUGPX4DWpAAZ9lpJ/hhrF7pEEQKGl6Crec/lyOCeIpDjKM5Zjw=
	=
X-Google-Smtp-Source: AGHT+IFsue0xtwZLyJ/6qImCX3DmJZDmvXNo/K8GCO5Eg0FZO8GoZSJJEPXmea+5HX6VJR5ZVc0GoQ==
X-Received: by 2002:a17:903:2987:b0:220:c813:dfcc with SMTP id d9443c01a7336-22dbf73671amr172511035ad.40.1745834117077;
        Mon, 28 Apr 2025 02:55:17 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db51062casm77958605ad.208.2025.04.28.02.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 02:55:16 -0700 (PDT)
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
Subject: [PATCH] rcu/nocb: Add Safe checks for access offloaded rdp
Date: Mon, 28 Apr 2025 17:54:03 +0800
Message-Id: <20250428095403.22889-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

For Preempt-RT kernel, when enable CONFIG_PROVE_RCU Kconfig,
disable local bh in rcuc kthreads will not affect preempt_count(),
this resulted in the following splat:

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

This commit therefore add rdp->rcu_cpu_kthread_task check for
Preempt-RT kernels.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/tree_plugin.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 003e549f6514..fe728eded36e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -31,7 +31,9 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
 		  lockdep_is_held(&rcu_state.nocb_mutex) ||
 		  (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
 		   rdp == this_cpu_ptr(&rcu_data)) ||
-		  rcu_current_is_nocb_kthread(rdp)),
+		  rcu_current_is_nocb_kthread(rdp) ||
+		  (IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		   current == rdp->rcu_cpu_kthread_task)),
 		"Unsafe read of RCU_NOCB offloaded state"
 	);
 
-- 
2.17.1

