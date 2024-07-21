Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87F81FBA;
	Sun, 21 Jul 2024 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721546778; cv=none; b=NDsgLiR13km7kmdz6UIWXTtvqUn0KfZDtGmsUnyzx4vnTAAe/YhhA2mFks752oui0eG2tS2dVyBzgToVxY+p36RIlJ0CAB2WsIaB4dAPTeEtv29/fgpl9PEKG2zxkYXGy5ni5eir85rnuCCvIPgSEdUQgKzSKObB/shi8qT4e1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721546778; c=relaxed/simple;
	bh=cJ3i0/obWWckr6AJB5BV1+8n6uCKwfupk+hR6GnOxU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jHl4wpToGZY5eDZXiKzUQPQbepSMJUZvpzPHURp3KQD9YaxAKqQ1Ri6YvDxS13wvi+wWqqJdZFmQ2Or/LS1qGdRIPh/60pqkuWKcISTf9HppdIL9tEWcPWQRm4YykdeUs6t10m1RK/e1KHudtzovajO4XsEcZ089iCAltqGUAxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=LSgwRhhi; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="LSgwRhhi"
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id VQw7sP3rKfVp1VQw7s8A2z; Sun, 21 Jul 2024 09:24:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1721546695;
	bh=sup3EfDa3fgB07IHFJsI7aMCSMa4OWCW/+hc3teBTJc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=LSgwRhhiPHJxxeZu1l1IyJpSBWBEdNdRzZM+FI8NPptw2l0lul9hKTcgIwUqjWA3E
	 xWVMqHUq63s4o5DlodvykLw+96Nl7UyOrEMie2KGKx8eR9l2/x5SCAuyFbsSt1dERx
	 pcVCp/DOJ9V/xm696W7SiBlJEDDS39IVqnwj2TeWB5KUYNIktOGPNJADwwClLk43Sr
	 MOo4RtBnctPN/+21i2bdQfbjtteeAgBavvuZU272p1GXql8gHfspIZvzYzOTesrZN4
	 o3reGXlbWBLYUQgu73isdBES2aZiD31fhF8DGtk/FsUbxUvnTBSm+743QgntnVKWXC
	 p7wPLeCoG5MBQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jul 2024 09:24:55 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	rcu@vger.kernel.org
Subject: [PATCH v2] refscale: Optimize process_durations()
Date: Sun, 21 Jul 2024 09:23:46 +0200
Message-ID: <77d6d8ee94d7149e6c33b10b78b43daf48ab8c70.1721546569.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

process_durations() is not a hot path, but there is no good reason to
iterate over and over the data already in 'buf'.

Using a seq_buf saves some useless strcat() and the need of a temp buffer.
Data is written directly at the correct place.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is compile tested only.
I introduced a bug in v1 (see 1st item in the changes below), so it should
definitively be tested by someone!

v1 was un-usable because seq_buf_putc() was not exported. It is now
available since v6.7.

Because of the changes, I don't know if the previous R-b should kept.
In case, it was:
	Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
	Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Changes in v2:
  - Use seq_buf_printf() alseo for the first string, otherwise it would
    get lost
  - Use seq_buf_str() instead of seq_buf_terminate() because the API has
    changed

v1: https://lore.kernel.org/all/bbbab32e3e104bdc2238724a6a4a85e539f49ddd.1698512661.git.christophe.jaillet@wanadoo.fr/
---
 kernel/rcu/refscale.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index f4ea5b1ec068..cfec0648e141 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -28,6 +28,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/reboot.h>
 #include <linux/sched.h>
+#include <linux/seq_buf.h>
 #include <linux/spinlock.h>
 #include <linux/smp.h>
 #include <linux/stat.h>
@@ -891,32 +892,34 @@ static u64 process_durations(int n)
 {
 	int i;
 	struct reader_task *rt;
-	char buf1[64];
+	struct seq_buf s;
 	char *buf;
 	u64 sum = 0;
 
 	buf = kmalloc(800 + 64, GFP_KERNEL);
 	if (!buf)
 		return 0;
-	buf[0] = 0;
-	sprintf(buf, "Experiment #%d (Format: <THREAD-NUM>:<Total loop time in ns>)",
-		exp_idx);
+	seq_buf_init(&s, buf, 800 + 64);
+
+	seq_buf_printf(&s, "Experiment #%d (Format: <THREAD-NUM>:<Total loop time in ns>)",
+		       exp_idx);
 
 	for (i = 0; i < n && !torture_must_stop(); i++) {
 		rt = &(reader_tasks[i]);
-		sprintf(buf1, "%d: %llu\t", i, rt->last_duration_ns);
 
 		if (i % 5 == 0)
-			strcat(buf, "\n");
-		if (strlen(buf) >= 800) {
-			pr_alert("%s", buf);
-			buf[0] = 0;
+			seq_buf_putc(&s, '\n');
+
+		if (seq_buf_used(&s) >= 800) {
+			pr_alert("%s", seq_buf_str(&s));
+			seq_buf_clear(&s);
 		}
-		strcat(buf, buf1);
+
+		seq_buf_printf(&s, "%d: %llu\t", i, rt->last_duration_ns);
 
 		sum += rt->last_duration_ns;
 	}
-	pr_alert("%s\n", buf);
+	pr_alert("%s\n", seq_buf_str(&s));
 
 	kfree(buf);
 	return sum;
-- 
2.45.2

