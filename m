Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FC6198E63;
	Tue, 25 Feb 2025 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508410; cv=none; b=bzmx3T8G3gFZCZaE/pF9y3/OisO/3nx0PdhFx/dsHGFUWTw44T3FnpV3HmMLv483rqKbYm5XBoJpQSkycW6jc8JDLPFamFvZ6eAAjfWFBT7JMekkiMXjv+53cTXBWjSq1nKFQbLiEmj/iDNgIUHZkGQ5eqzCiCmpxLN0Vt9/CL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508410; c=relaxed/simple;
	bh=bBItIqzwltwC+TCsuqofxmj3GfVFhtE23r50c2BKncQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l6nTvDw5y1rxAoDTIoUMQYZPIXF/Jc7uIxZrfDi1U74rLOoXDscgXEeFFe/QiiL7tviGtH6D6+srS7j8zArboPDZbZTKNPfoepKyoQK/b+MRURXvtuPpHKootVW1eF02//nogqCcJ88djAcpKkEW/7H22hqPKaBxvla5kpykhP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byILlQzb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byILlQzb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61763C4CEE2;
	Tue, 25 Feb 2025 18:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740508409;
	bh=bBItIqzwltwC+TCsuqofxmj3GfVFhtE23r50c2BKncQ=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=byILlQzbc5JGnFIQUA0x5qdJlCR0vxEvzYMNH6CrS1ES+sOY0ipN8SnyTX7AeXkJw
	 O7aHFFrdrUiaQvQFOZKa0+ECESde8BT0DKOQaU978clpnH0k5gdkSVkqzCjQV1n6zE
	 Qb6p985UtN50Pq53joGLRy8KSSrsXqGsv5r+JooCRkNsK6miRm+GmB44zvNL0Vjgqb
	 ozcStsf9w2bROIvxar3WjDgFk/aMpOYFi8DKRUg7DsGer0bVGOn9+/M7kupUn2OznI
	 o2H+aRsgqUCLTJKIeN0Z4V6RnrZhRJMbb1lkfU02Cl2d6NaSXtKXMw0mxCDfHgQCmx
	 7nZgOr98SGN2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0514ECE045A; Tue, 25 Feb 2025 10:33:29 -0800 (PST)
Date: Tue, 25 Feb 2025 10:33:28 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	kernel-team@meta.com, rcu@vger.kernel.org
Cc: john.ogness@linutronix.de, pmladek@suse.com, rostedt@goodmis.org,
	senozhatsky@chromium.org, boqun.feng@gmail.com
Subject: [PATCH printk] Flush console log from kernel_power_off()
Message-ID: <5f743488-dc2a-4f19-bdda-cf50b9314832@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Kernels built with CONFIG_PREEMPT_RT=y can lose significant console output
and shutdown time, which hides shutdown-time RCU issues from rcutorture.
Therefore, make pr_flush() public and invoke it after then last print
in kernel_power_off().

[ paulmck: Apply John Ogness feedback. ]
[ paulmck: Appy Sebastian Andrzej Siewior feedback. ]
[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/printk.h |    6 ++++++
 kernel/printk/printk.c |    4 +---
 kernel/reboot.c        |    1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 4217a9f412b26..5b462029d03c1 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -207,6 +207,7 @@ void printk_legacy_allow_panic_sync(void);
 extern bool nbcon_device_try_acquire(struct console *con);
 extern void nbcon_device_release(struct console *con);
 void nbcon_atomic_flush_unsafe(void);
+bool pr_flush(int timeout_ms, bool reset_on_progress);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -315,6 +316,11 @@ static inline void nbcon_atomic_flush_unsafe(void)
 {
 }
 
+static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
+{
+	return true;
+}
+
 #endif
 
 bool this_cpu_in_panic(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 07668433644b8..057db78876cd9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2461,7 +2461,6 @@ asmlinkage __visible int _printk(const char *fmt, ...)
 }
 EXPORT_SYMBOL(_printk);
 
-static bool pr_flush(int timeout_ms, bool reset_on_progress);
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress);
 
 #else /* CONFIG_PRINTK */
@@ -2474,7 +2473,6 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 static u64 syslog_seq;
 
-static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
 
 #endif /* CONFIG_PRINTK */
@@ -4466,7 +4464,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
  * Context: Process context. May sleep while acquiring console lock.
  * Return: true if all usable printers are caught up.
  */
-static bool pr_flush(int timeout_ms, bool reset_on_progress)
+bool pr_flush(int timeout_ms, bool reset_on_progress)
 {
 	return __pr_flush(NULL, timeout_ms, reset_on_progress);
 }
diff --git a/kernel/reboot.c b/kernel/reboot.c
index b5a8569e5d81f..41ab9e1ba3575 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -704,6 +704,7 @@ void kernel_power_off(void)
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
 	pr_emerg("Power down\n");
+	pr_flush(1000, true);
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
 	machine_power_off();
 }
