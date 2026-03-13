Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84253CAE62
	for <rcu@vger.kernel.org>; Fri, 13 Mar 2026 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773421114; cv=none; b=IUh4vZOg9S/65GfnwivjC6NuUgIklXZG8kwa2P/gZnjGudY7CJIsEPmuHWRXNcyP86lBG4HP6LLXCe93d6GOEKjIUoSf/ckpc79JttctpcDxzZx2Puw+xdcuPRSBl6giWeTtO/vMniqNqSktIoBEkMHM8k9ju+tQU1lSBvO17IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773421114; c=relaxed/simple;
	bh=E4xjmXbQMZsSL9twktF001VB0Po/i1Xtc8jL4NfJMNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dqPIG9IbdXxY1KSB+IrRc3Zc/Q8jyWqS1kME8rN69aTwe1mOWQtPDiSil/ImARVupfS8qtmHH2epRmhdLj1fyj4TpB618z+JHJCL0lFnOKeueD4fzDK4sj4EMjQK4oIWp4QrfNlHztjRryfMD/6iXo0rjWLKbwb2c1Rz05VDAP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TP6Vgq1V; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TP6Vgq1V"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4830b67aa6bso1660255e9.0
        for <rcu@vger.kernel.org>; Fri, 13 Mar 2026 09:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773421111; x=1774025911; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K1+GQ1DJS9XbWAiFfkTydBohoj52U6GiccGbV5XrVS4=;
        b=TP6Vgq1VJajIz43hFUfNCKYmh87f/WHMFLuHLDkavhMBG39F52QKn1WsBkOI8Ar3SX
         AencXdir1IgOeIaQ8bsAHMmfZuEh/EanwyY310/xaRnYdgIAClL/DvE3ZUcSbSxvMpCr
         iYNWkS36+o7+BWh6sPKzmaI4Iqzx1s+HSGuo9xi6BGSDHX3hhqXAfVopFNXnQ1qBAtPo
         cHvEeVFpwaBKXAGmYJnMdTjzrAGjo8vercs8iuU12t0m3rFdMywlVsBL8dNvpZhxLDR5
         o7FLsmJMkD94squokjlrxz6texfVbe6FMTz0XLz0Z/nspaxUAlYsKHcF/ZX1B2NZw1RM
         xUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773421111; x=1774025911;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1+GQ1DJS9XbWAiFfkTydBohoj52U6GiccGbV5XrVS4=;
        b=WR1LordalCtzwzBVyi6d0X71WwmjRhMa2753sj6/t4PQ0VKkFHVc8RnqkyQkTcz06d
         vCQJzDtRvoboLPEtYYFQYeRS71s6yJgypycI4W+0xC2sxQkvJSPavqhVd5zbY2scwOwG
         XneHbJiwpdyDWlbhqLiVK6lhZk7V4vfQX9zpNh/dg9hUwkbSHyMRhNTxWfddr4qi1kT7
         x/p35dZV9Zj05Z/1K5+DEjL1AWnwSPQ7hbFjlxqSw3CyABONbBp7eR2XrOeh6GHwRB79
         tStRIbl4CYhxD2U4I5bWYL+xRGJjjhMHEqH6YYRt6jorHaPASzvl+IHzGs+d6/v30pZM
         IK2Q==
X-Gm-Message-State: AOJu0YxBX5i1IvPCgGDh2ogHavI0PbDR7L6Spp1aN65jrJf+7ZHlhtbq
	1km+FStoAZAef38Jv/qaKUZWq3KrjsHcKTOGAuJ8JK4kui9FeMyZU9Ac
X-Gm-Gg: ATEYQzw3PadK6tTvPQRX9/F8o/pIxHJIE5e/mUAlDPyPFfD4EsLHbenhZajOGix8SYm
	lISecTihlNJ6A4tHf9wId+6PwzTQ8tU5L+8znYTAp26W8lbNMYcMuPkXcLEU6H3D+PkKJjc6lSS
	IOk7+7kK/URTlKXmYa4Vf3hGw2Ix/tN9do1TTpVjizt6WO3dS9lGH7ylJEQge32/k+mUZ7GFKhJ
	beP3IxqrrXdcHoq7ImqOvrEz+RvyzhMS+Zzno/X8lXPps7ERV6TXI6r75zhWZxs5QdqcBQWORF6
	LHh2lBBGFsST/Uah99QPOcUuE9cX2gB7BKvUur+6CkaFcV8e5z+Tj36as2hALIkSBnASdUT68q8
	2DadDDc03j3ESpdUh8FzMnpwhv50+GRdCofSJDKWtqkz2L/kd0F4feId1VUX8rFOpnvZn/n7nSH
	boyEIYfIYkFbkdqqHnN7gWYBadUmA=
X-Received: by 2002:a05:600c:470c:b0:47d:6f12:de57 with SMTP id 5b1f17b1804b1-4855670f964mr37087165e9.4.1773421111016;
        Fri, 13 Mar 2026 09:58:31 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:49::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b65fd3dsm221670575e9.10.2026.03.13.09.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:58:30 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Fri, 13 Mar 2026 09:56:49 -0700
Subject: [PATCH] rcu: Add BOOTPARAM_RCU_STALL_PANIC Kconfig option
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-panic_on_rcustall-v1-1-a4f8fe54a4bd@gmail.com>
X-B4-Tracking: v=1; b=H4sIANFBtGkC/x3MQQqAIBBA0avIrBPUqKirRITpWAOhohVBdPek5
 Vv8/0DGRJhhYA8kvChT8AWyYmA27VfkZItBCdWKWtY8ak9mDn5O5syH3nfeN53ordSLUw5KFxM
 6uv/nOL3vB84or4tjAAAA
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

Add a Kconfig option to set the default value of the
kernel.panic_on_rcu_stall sysctl, allowing the kernel to be built
with panic-on-RCU-stall enabled by default.

This is useful for high-availability systems that require automatic
recovery (via panic_timeout) when a CPU stall is detected, without
needing userspace to configure the sysctl at boot.

This follows the pattern established by BOOTPARAM_SOFTLOCKUP_PANIC
and BOOTPARAM_HUNG_TASK_PANIC.  The runtime sysctl can still override
the Kconfig default.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 kernel/rcu/Kconfig.debug | 24 ++++++++++++++++++++++++
 kernel/rcu/tree_stall.h  |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 625d75392647..fc2c775eeefc 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -175,6 +175,30 @@ config RCU_CPU_STALL_NOTIFIER
 	  Say Y here if you want RCU CPU stall notifiers (you don't want them)
 	  Say N if you are unsure.
 
+config BOOTPARAM_RCU_STALL_PANIC
+	bool "Panic (reboot) on RCU CPU stall"
+	depends on RCU_STALL_COMMON
+	default n
+	help
+	  Say Y here to enable the kernel to panic when an RCU CPU stall
+	  is detected.
+
+	  The panic can be used in combination with panic_timeout,
+	  to cause the system to reboot automatically after an
+	  RCU CPU stall has been detected. This feature is useful for
+	  high-availability systems that have uptime guarantees and
+	  where a CPU stall must be resolved ASAP.
+
+	  The kernel.max_rcu_stall_to_panic sysctl can be used to set
+	  a minimum number of stalls before panicking, allowing the
+	  system to tolerate a given number of RCU CPU stalls before
+	  triggering a panic.
+
+	  This setting can be overridden at runtime via the
+	  kernel.panic_on_rcu_stall sysctl parameter.
+
+	  Say N if unsure.
+
 config RCU_TRACE
 	bool "Enable tracing for RCU"
 	depends on DEBUG_KERNEL
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b67532cb8770..43ddabf46b5e 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -17,7 +17,7 @@
 // Controlling CPU stall warnings, including delay calculation.
 
 /* panic() on RCU Stall sysctl. */
-static int sysctl_panic_on_rcu_stall __read_mostly;
+static int sysctl_panic_on_rcu_stall __read_mostly = IS_ENABLED(CONFIG_BOOTPARAM_RCU_STALL_PANIC);
 static int sysctl_max_rcu_stall_to_panic __read_mostly;
 
 static const struct ctl_table rcu_stall_sysctl_table[] = {

---
base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
change-id: 20260313-panic_on_rcustall-95709d1abf2f

Best regards,
-- 
Gustavo Luiz Duarte <gustavold@gmail.com>

