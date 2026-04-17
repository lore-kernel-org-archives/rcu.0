Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B37DDCD
	for <rcu@vger.kernel.org>; Fri, 17 Apr 2026 01:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776389950; cv=none; b=ls2aprsiHAdmkQ+DVmhKsCbzrhaUKSZjb95+XsLLGcWIIQmyXLnorbicM3ElgVHKkLzQ7Z/Gd4bSgMVGYJ7f1+PSR21Pi/vmUVCWwvuOwAZ5Yb8eN8qz19vyU2aO2wgwo02BNwOkJwnnyueU06BpJHmZ1c8BwuXp02i/iVxbhTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776389950; c=relaxed/simple;
	bh=ymV6t/NdrjmHad4wbaTWumiKbEe0NhAhjXXVnPnHkeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o/OsyxDf8Mmes6dnTYDHvZFTl5XSyE/Tj2pfZd86xpVrb+f0pl0RkY5PO1gx2CUapWNwOUY316/WQ4iVvbNfSOeqd6I3+QzGJLmLfvkA5tcG/EYaU0sbT0fRq7eO83OL82qam5wsINFvwKtWprGV3hu5qsjz84IP7oxvt9GwoXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhN13cng; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhN13cng"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-651b0eb2564so206243d50.3
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2026 18:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776389948; x=1776994748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XJYFBOkT7QLcVrpDO+/kqkqDv7BQIh1JsSGA3i0E7PE=;
        b=BhN13cngh+Cmplo2gGwxPMoOwtArIH+b9KA9TT7KkdPOEPQxKpQvlj2cTMixxGaH0c
         oU+lQcjpxsBCmJcd4pqeS6pQMs/YP+qIRdmkoM7cTGxO7PimueSN+Xkmg17+4Fz4zKH8
         ZenpVVxsqGGlr2SXgtGXlBNpecBrgcuWpj+GKBVxx+Fz+dJh4UGzJ7Zjs7lLiRKZDGWG
         /Vr6N2VXjxnofgJjtupSkTMHU2NjYoxIZN5GdiPW0s9NmRX0Ns02dSPTT/SOcDpImsEd
         wpdYrjd1mkltUX24C94XKkVpKomdBAgNMuTIqmOrdBQMSkfZxJHJefRTbGr7QPrClmTN
         ZoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776389948; x=1776994748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJYFBOkT7QLcVrpDO+/kqkqDv7BQIh1JsSGA3i0E7PE=;
        b=Jz2HK1og6XJEB/k9MEMhfDSZlNtLexU1II/aTQCaPWVq/DcoMWvHNHVP2MUdumPL1e
         NsrXKibpEdpaH7zgU0Wi2t2J6+Kys06lKszVV/WiQeiw4HjiY6xWIw53O2GcxhQc8N1w
         /pLTEPvXtpR57ykUIO7kZosbAft/wvmIIrY73X+bnUcA45KcMFW2rBbQqN2kSCZLqOTt
         yvymoSFqCDOhIuozScsnzX7xHkAAzmnb4uwOUr4hmM2624S1dQlI86w3h/iyy8/BZ3sB
         4oHgw9AriBnLcRIL5bCZ+1R777eBr7xOBuUch/E0Ue/L8Wf2lIhpmmgGkgKuyrMaKRk5
         H2hw==
X-Forwarded-Encrypted: i=1; AFNElJ/ZK6oXrgoQt3wcIcQv/kVDui7erzIuspW7MqTGt04t7PAHvYttwVwSZ5LGsEJN4jVlp8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE1qhuDAIhvagPbg0NQmfE+xlWjjgdD0VAH3SVmZAYRvx09zES
	Sw93EoSvaYgZtGFy3vZYSTvA8hb0L6oFO70K6vE82qAsncS6EU+i6TON
X-Gm-Gg: AeBDieuY3mynp/GUEW0/GwCCjkF1YCyWN0VRY6II6HnNnZmdxIQV2kqzCovpVZ1wsG0
	LJ4PGZJdEEGuLFsHxTI01PSd6sXdZwm0POBfFTABeRpFC7zaT1gY4J93ecN1+RsKNB+laj+VBEF
	R/ZCbZiPrTAEErwTF1iwN3/Bm2pD86deqgsBi0PGeJSXr7oGPcNHhCUmSaRGTb/91SQogMFkB7j
	lg/qZ2aKY2MU56b0cQ1cwamInalKe9/z4+jcBMiMgZ6FtllaKRh92wX2inLjZfJkbu3mwClf+FA
	foyIcMs3YVsjADNGbLihRg33EvUtUZnZxBeE0lBVbBdQ4/6ZMOWNijHihFh++coyC3zX2LjWSg1
	9IwKHzYjEgfza36QEE1eCR7Mxj0tLNXb8uxcYNDmP0zo086cz98aYWKSG97dfzhu9ptKqk368cr
	mpGMslzKzckdhqEwNNA/NHhWiERVOZTmoe1UQ0V+Zh
X-Received: by 2002:a05:690c:46c5:b0:7ac:24ba:3e61 with SMTP id 00721157ae682-7b9ecece409mr9375477b3.19.1776389948611;
        Thu, 16 Apr 2026 18:39:08 -0700 (PDT)
Received: from localhost ([103.74.250.37])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee8c8192sm852437b3.20.2026.04.16.18.39.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Apr 2026 18:39:08 -0700 (PDT)
From: Jiazi Li <jqqlijiazi@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Jiazi Li <jqqlijiazi@gmail.com>,
	rcu@vger.kernel.org,
	"mingzhu.wang" <mingzhu.wang@transsion.com>
Subject: [PATCH] rcu: use NMI to dump backtrace of blkd-task running on other cpu
Date: Fri, 17 Apr 2026 09:38:13 +0800
Message-ID: <20260417013816.3653-1-jqqlijiazi@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sched_show_task cannot dump backtrace of blkd-task running on other
cpu:
[117421.286553][    C0] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[117421.286579][    C0] rcu:    Tasks blocked on level-0 rcu_node (CPUs 0-7): P2280
[117421.286595][    C0] rcu:    (detected by 0, t=5252 jiffies, g=751845, q=66318 ncpus=8)
[117421.286604][    C0] task:android.imms2   state:R  running task     stack:0     ...
[117421.286617][    C0] Call trace:
[117421.286622][    C0]  __switch_to+0x1a0/0x318
[117421.286636][    C0]  0x0

So use NMI to dump backtrace:
[  390.584143] rcub/0: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  390.585156] rcub/0: rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-7): P6816
[  390.586207] rcub/0: rcu:     (detected by 5, t=52532 jiffies, g=7405, q=63942 ncpus=8)
[  390.587320] rcub/0: Sending NMI from CPU 5 to CPUs 4:
[  390.588111] rcu_stall_threa: NMI backtrace for cpu 4
[  390.588116] rcu_stall_threa: CPU: 4 UID: 0 PID: 6816 Comm: rcu_stall_threa Tainted: P...
[  390.588120] rcu_stall_threa: Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  390.588122] rcu_stall_threa: Hardware name: MT6858 (DT)
[  390.588123] rcu_stall_threa: pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  390.588125] rcu_stall_threa: pc : _raw_spin_unlock_irqrestore+0x1c/0x44
[  390.588131] rcu_stall_threa: lr : ___ratelimit+0xd4/0x110
[  390.588134] rcu_stall_threa: sp : ffffffc08464bdf0
[  390.588135] rcu_stall_threa: x29: ffffffc08464bdf0 x28: 0000000000000000 x27: 0000000000000000
[  390.588138] rcu_stall_threa: x26: 0000000000000000 x25: 0000000000000000 x24: 00000000000004e2
[  390.588140] rcu_stall_threa: x23: ffffffd82ae77000 x22: ffffffd82af1fae8 x21: 000000000000000a
[  390.588142] rcu_stall_threa: x20: 0000000000000000 x19: 0000000000000000 x18: ffffffc08456d020
[  390.588144] rcu_stall_threa: x17: 000000008c623181 x16: 000000008c623181 x15: 0000000000000010
[  390.588146] rcu_stall_threa: x14: 0000000000000100 x13: ffffffc084648000 x12: ffffffc08464c000
[  390.588148] rcu_stall_threa: x11: 5e2da9f91a08d800 x10: ffffffd8299b39fc x9 : 0000000100005874
[  390.588150] rcu_stall_threa: x8 : 0000000000000000 x7 : 0000000000000001 x6 : fffffffebea2b0a0
[  390.588152] rcu_stall_threa: x5 : 0000000000000000 x4 : 0000000000000402 x3 : 0000000000000000
[  390.588154] rcu_stall_threa: x2 : ffffff81ca8d9680 x1 : 0000000000000000 x0 : 0000000000000001
[  390.588156] rcu_stall_threa: Call trace:
[  390.588157] rcu_stall_threa:  _raw_spin_unlock_irqrestore+0x1c/0x44
[  390.588159] rcu_stall_threa:  ___ratelimit+0xd4/0x110
[  390.588161] rcu_stall_threa:  rcu_thread_func+0x90/0xa8
[  390.588164] rcu_stall_threa:  kthread+0x110/0x1a4
[  390.588167] rcu_stall_threa:  ret_from_fork+0x10/0x20

Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
Tested-by: mingzhu.wang <mingzhu.wang@transsion.com>
---
 kernel/rcu/tree_stall.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b67532cb8770..5806f9a43579 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -289,7 +289,12 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
 		 * Avoid triggering hard lockup.
 		 */
 		touch_nmi_watchdog();
-		sched_show_task(t);
+		if (unlikely(t->on_cpu && t != current) &&
+				trigger_single_cpu_backtrace(task_cpu(t))) {
+			/*Successfully triggered remote backtrace*/
+		} else {
+			sched_show_task(t);
+		}
 	}
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
-- 
2.49.0

