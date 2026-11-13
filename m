Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531499;
	b=24EFPzgyx9lHV7E+TY496DVOMEI5+W/VlckXrxDRVrboJdSI8NJN0gQUN0QRsCfdWDR8
	 A70efbbtlFuOViHVK/NhFy7QdJXPlZgHJlpQQlcdIfDpW364c7MVe9OldjoClC5Harhod
	 MLbnZUoiAvOeOUTSD1YS596D9g2ox/rrw7dbCVWXRHRd/YrnznACfzJvIaN7ikybHxi3E
	 +NlQlXaKBccMecV/8Juje4qwivD3rP0KUSrWbgUpbngOHcAxqHDfllaILgNybHAePl4Tm
	 Td8LZazfElEd+rPF2pCTt72rlgeyAcsvd8nPsRIZ1OleTZYsU3jjAwjJ/Kh2QL8Fj0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531499;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=B7RYo3yC1mhzOBCyNWXKDdJRMoBz+kSlrVKc6a18mLw=;
	b=IOkZLj1niCo67hYvixquKSs1HOnkSYryxaExxythSvMSsiyx1SxV+YFunbvaiLqjK9wK
	 lijBf6sTKSu+1V8AcUOhbz6TeOnozIq2nz0TsYQOVROkrpcTSIOw6QRGRPsipiluDadI5
	 9rTiDx58S1LixvvhHkcpTeilTX9tI0mvZczn4MOoar2QBh2LkRuOHdoCI+EkcSPUQU3Hm
	 Rs3gnz4U+aDJYJ0T2+Owv0WQlAZAwj3hz43FXUMbbFJEgxT4EN6hDsu7uqaUqwiOQbjkp
	 V6Qmf+CHbGw6Ki615M6q6uZY7K8wTWktt3wh6j0/KdZkAXCMuVdQdwFBytEjJm/AZJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H33LFaG6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C742660A5BE1;
	Fri, 13 Nov 2026 00:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H33LFaG6
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 26DE01F000C4;
	Fri, 13 Nov 2026 00:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531499;
	bh=B7RYo3yC1mhzOBCyNWXKDdJRMoBz+kSlrVKc6a18mLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H33LFaG6k6ZL6JUKH/Mrghwi1gV68eMkih7OqOZeddQwCAwqqpc+dZgD2jcYx6/q2
	 YpuxXTHTejKWF5ge7oQkLzUTAO1nzXT9mxMfIAxj9z8Nw21Lqd13DfPyqoyLT+wY/P
	 I4ypPbqS8PEBieITcwqJpeQ6wX9YqOSRupN78rk62/ubGGYF9XIPISgR1C8e0NcGzi
	 TTgi/22enUhMegIOSxW3/wwJ4UpjnbEJdTJLMwEr1X1noQYYJ5Y7UCe9HwH1W4418K
	 W6pZEUNfYL8ivsNv1cRA5tzepSOot6q8Ro+29A8w5mi9M2+eBYytuphjxJLm4/Fnu/
	 ecpcPeSGxT7HQ==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: rcu@vger.kernel.org
Subject: [PATCH for-v7.5 14/14] torture: Forgive SMT-control failures in CPU-hotplug testing
Date: Thu, 12 Nov 2026 19:57:41 -0500
Message-ID: <20261113005747.2977123-15-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005747.2977123-1-jfern@kernel.org>
References: <20261113005747.2977123-1-jfern@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The onoff task ends rcutorture with "End of test: RCU_HOTPLUG" if any
CPU-hotplug attempt fails, other than -EBUSY during boot.  Toggling
/sys/devices/system/cpu/smt/control while onoff runs causes two failures
that are not the test's fault.  cpu_up() returns -EPERM for an SMT thread
that SMT control keeps offline, and device_online() and device_offline()
return 1 when the toggle already did the operation.

Repro: in a 16-vCPU guest (8 cores, 2 threads), run
"modprobe rcutorture onoff_interval=1 gp_exp=0" while looping
"echo off/on > smt/control" for 120 seconds.  This ended in RCU_HOTPLUG,
with no reader errors.  With this change it ends in SUCCESS.

Forgive these like boot-time -EBUSY, by not counting the attempt.

Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/torture.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 8c4e6b2fe8ba..b860c99e9ca7 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -194,6 +194,24 @@ int torture_num_online_cpus(void)
 }
 EXPORT_SYMBOL_GPL(torture_num_online_cpus);
 
+/*
+ * If the CPU-hotplug failure is not the torture test's fault, return a
+ * string saying why it is forgiven.  Otherwise, return NULL.
+ */
+static const char *torture_onoff_forgive(int ret)
+{
+	// PCI probe frequently disables hotplug during boot.
+	if (!rcu_inkernel_boot_has_ended() && ret == -EBUSY)
+		return " (-EBUSY forgiven during boot)";
+	// Hotplug is forbidden, for example by SMT control.
+	if (ret == -EPERM)
+		return " (-EPERM forgiven, hotplug forbidden)";
+	// Something else, such as SMT control, already did the operation.
+	if (ret == 1)
+		return " (already in requested state, forgiven)";
+	return NULL;
+}
+
 /*
  * Attempt to take a CPU offline.  Return false if the CPU is already
  * offline or if it is not subject to CPU-hotplug operations.  The
@@ -204,7 +222,7 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 {
 	unsigned long delta;
 	int ret;
-	char *s;
+	const char *s;
 	unsigned long starttime;
 
 	if (!cpu_online(cpu) || !cpu_is_hotpluggable(cpu))
@@ -220,12 +238,11 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 	(*n_offl_attempts)++;
 	ret = remove_cpu(cpu);
 	if (ret) {
-		s = "";
-		if (!rcu_inkernel_boot_has_ended() && ret == -EBUSY) {
-			// PCI probe frequently disables hotplug during boot.
+		s = torture_onoff_forgive(ret);
+		if (s)
 			(*n_offl_attempts)--;
-			s = " (-EBUSY forgiven during boot)";
-		}
+		else
+			s = "";
 		if (verbose)
 			pr_alert("%s" TORTURE_FLAG
 				 "torture_onoff task: offline %d failed%s: errno %d\n",
@@ -266,7 +283,7 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
 {
 	unsigned long delta;
 	int ret;
-	char *s;
+	const char *s;
 	unsigned long starttime;
 
 	if (cpu_online(cpu) || !cpu_is_hotpluggable(cpu))
@@ -280,12 +297,11 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
 	(*n_onl_attempts)++;
 	ret = add_cpu(cpu);
 	if (ret) {
-		s = "";
-		if (!rcu_inkernel_boot_has_ended() && ret == -EBUSY) {
-			// PCI probe frequently disables hotplug during boot.
+		s = torture_onoff_forgive(ret);
+		if (s)
 			(*n_onl_attempts)--;
-			s = " (-EBUSY forgiven during boot)";
-		}
+		else
+			s = "";
 		if (verbose)
 			pr_alert("%s" TORTURE_FLAG
 				 "torture_onoff task: online %d failed%s: errno %d\n",
-- 
2.54.0

