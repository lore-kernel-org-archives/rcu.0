Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3AB34CFD2;
	Wed,  5 Nov 2025 20:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374004; cv=none; b=pTSOBcLVydBVyZ6DGcfD/M/chq3gObImuGWN32VojWqbaqVHlPnA6ViLEtGoKTvm3TcqQR7otx4Q+PyPOKT6GqojadAuU/SFE1qmgAqtKUDqzDIpmJivZNycZwBR4VaLmT097qFJN1noy/m3fjM8Qmjx3X3j0UrnjTeRNSH0YCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374004; c=relaxed/simple;
	bh=nTHX1YfCh7X8t+gy7/mwsMUuWMwgp6cK39S8CemYIGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BF96o+IltziKw+TjCDrM41p5ztKvY4Ws7M7pw7lgvEnUmc1JjKmCnJDoezAN+Lejc/5nmR8VjEx3Si0t5U5kKY/rJrZ5BFlwyPHgIzEhpxw5POIm097/Grm5VyZQ+UGv9prVGd8PYfux4M49IlQJGbKkCK83Ht4hOAORedZDn5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rneu7ILz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rneu7ILz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1BAC4CEF5;
	Wed,  5 Nov 2025 20:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762374003;
	bh=nTHX1YfCh7X8t+gy7/mwsMUuWMwgp6cK39S8CemYIGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rneu7ILzxQDORkplKIJfKvcj8v60TRP81/uyvwte9HSLfL7ka7KYQJUSzyNqeMovd
	 TvUbLw+MwO3mA8HfJD3dcgIU0rwKDlIekpd13ZiYRb1mi42eZ16KbxseqA9BT70FUh
	 vWztC0dPOfLhyUNqtuR1cowriYxY0mbSgBzoORqC9HZpZVYcevkRVi//BZsVnDc00U
	 2dhQkE2KM4ZIEvSVpJor2LSlwzYbtx+Rrlf775JjapiChYOz3d223OiZ22hPcXx1ge
	 7uNdszXznlWAylcVYJal5dWVdNVFt8j/XrJJN5yJEyTJysvKrxHPpKNZlKzGKNWyH4
	 Mp8YkuDvOLnmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 96B75CE0B94; Wed,  5 Nov 2025 12:20:02 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Wang Liang <wangliang74@huawei.com>,
	Zhang Changzhong <zhangchangzhong@huawei.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 1/5] locktorture: Fix memory leak in param_set_cpumask()
Date: Wed,  5 Nov 2025 12:19:56 -0800
Message-Id: <20251105202000.2700370-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cf8b57e0-1803-45e9-a217-9c9aeb64a2f9@paulmck-laptop>
References: <cf8b57e0-1803-45e9-a217-9c9aeb64a2f9@paulmck-laptop>
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

