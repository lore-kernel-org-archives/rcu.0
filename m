Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0E31F418F;
	Sun,  2 Nov 2025 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762117551; cv=none; b=CS+lGrjTa5d7JEn+WfBSV3/A6dbz/U0b/xUTFaZIjb3Vy+7ZdNx/sxzIPeNr9kXYoNakZkA4fPPY8JlAUVdouVmnyPJ8/J107jDZQZw9CPl0pC5owDNPH34PYXF0U6pC7Ma2qJ6etgiCcyHh+EcN9HddlfY1n0G1vCokVUeKVZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762117551; c=relaxed/simple;
	bh=nTHX1YfCh7X8t+gy7/mwsMUuWMwgp6cK39S8CemYIGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MbDRwwUxoB31wLKPSuW6bLNeenD9TwufDset/qEAnLDV6MVSo3pEi4PxdikyHtQbId+fjvD/d9fgiWHNkXhtehCZ2QcQxj9N1lCnHqW3DVKN1bkWtSlFDQejtWI2Y35o1X1yohj9bgZMyChQbAVTOIYk3UD3Vpdol5hVvFSsh6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFj+LG1Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFj+LG1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58283C4CEF7;
	Sun,  2 Nov 2025 21:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762117551;
	bh=nTHX1YfCh7X8t+gy7/mwsMUuWMwgp6cK39S8CemYIGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OFj+LG1Qvk7YNodw8pQtzv2vnJKRnj9xVaY0axOQSaDzpCPJV8DgA/C1c7Hm5zUQa
	 JGI3dMin4BaQD3IEM5kDqUog9AAkE5lzu/cxxx+4H0Z5X8ixaiVcY5hZNpKFzM0NTj
	 YeJzHFr4Ksxhu9l8/8RYaqdKsOwFfAOe5+7UNmECedngREaJryK62Ff22ie0L3bLbh
	 OngBPm2t8ISRF8FbARoj2ZdoVb0CuHrzcP3AuPK3//jx30/pe2Cf10Pc9Djul5Krg4
	 VUBYf4FLR/mUrag+Dvnv+aUTSqEvNJuC77VyJeDmYVDu0TC2Zih+gk6LCkF6teRenx
	 tTk23700Sgz4Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 37630CE0F4C; Sun,  2 Nov 2025 13:05:50 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Wang Liang <wangliang74@huawei.com>,
	Zhang Changzhong <zhangchangzhong@huawei.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 1/3] locktorture: Fix memory leak in param_set_cpumask()
Date: Sun,  2 Nov 2025 13:05:45 -0800
Message-Id: <20251102210547.3898972-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <6eb0d40f-9776-412a-9ab4-2d3298ead766@paulmck-laptop>
References: <6eb0d40f-9776-412a-9ab4-2d3298ead766@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Liang <wangliang74@huawei.com>

With CONFIG_CPUMASK_OFFSTACK=y, the 'bind_writers' buffer is allocated via
alloc_cpumask_var() in param_set_cpumask(). But it is not freed, when
setting the module parameter multiple times by sysfs interface or removing
module.

Below kmemleak trace is seen for this issue:

unreferenced object 0xffff888100aabff8 (size 8):
  comm "bash", pid 323, jiffies 4295059233
  hex dump (first 8 bytes):
    07 00 00 00 00 00 00 00                          ........
  backtrace (crc ac50919):
    __kmalloc_node_noprof+0x2e5/0x420
    alloc_cpumask_var_node+0x1f/0x30
    param_set_cpumask+0x26/0xb0 [locktorture]
    param_attr_store+0x93/0x100
    module_attr_store+0x1b/0x30
    kernfs_fop_write_iter+0x114/0x1b0
    vfs_write+0x300/0x410
    ksys_write+0x60/0xd0
    do_syscall_64+0xa4/0x260
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

This issue can be reproduced by:
  insmod locktorture.ko bind_writers=1
  rmmod locktorture

or:
  insmod locktorture.ko bind_writers=1
  echo 2 > /sys/module/locktorture/parameters/bind_writers

Considering that setting the module parameter 'bind_writers' or
'bind_readers' by sysfs interface has no real effect, set the parameter
permissions to 0444. To fix the memory leak when removing module, free
'bind_writers' and 'bind_readers' memory in lock_torture_cleanup().

Fixes: 73e341242483 ("locktorture: Add readers_bind and writers_bind module parameters")
Suggested-by: Zhang Changzhong <zhangchangzhong@huawei.com>
Signed-off-by: Wang Liang <wangliang74@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index ce0362f0a871..6567e5eeacc0 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -103,8 +103,8 @@ static const struct kernel_param_ops lt_bind_ops = {
 	.get = param_get_cpumask,
 };
 
-module_param_cb(bind_readers, &lt_bind_ops, &bind_readers, 0644);
-module_param_cb(bind_writers, &lt_bind_ops, &bind_writers, 0644);
+module_param_cb(bind_readers, &lt_bind_ops, &bind_readers, 0444);
+module_param_cb(bind_writers, &lt_bind_ops, &bind_writers, 0444);
 
 long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask, bool dowarn);
 
@@ -1211,6 +1211,10 @@ static void lock_torture_cleanup(void)
 			cxt.cur_ops->exit();
 		cxt.init_called = false;
 	}
+
+	free_cpumask_var(bind_readers);
+	free_cpumask_var(bind_writers);
+
 	torture_cleanup_end();
 }
 
-- 
2.40.1

