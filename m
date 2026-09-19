Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D785323392A;
	Sat, 19 Sep 2026 00:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776062; cv=none; b=rVj+Cf6xDsevRb33rTiIx9+Q5zUR1doTZ1JtOaw6Q3Uh81Y5V4XuTTVeJs0oxHbCJwt07YHrKBHenOAw5tQrehM7Wzium9rfiBZtIhLVVIHf5HNcx8thNzb6go0VUMvmN0Y4cyTFvx7VWLjFV/hb1XQeBSWJQhH3X9vKsKbrMQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776062; c=relaxed/simple;
	bh=5NmpaBgZZTNdCVrDtYsCo3NWBPDoDOvVSihJo28UyCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tRjrEZE6bJIh3reHdJBMP3faRQUX42HXFJENGeQIsslUeOc+VXELL/0SBm8/I0rZq0EvVMFliV7VJx0C1eG/qXag9jbYH+94GOzBsbED5UWA5kZG3Sj8JkJ7vqHm8bgZ2XADQYOdU9W/MRDq+YHCgG6WdAlPk4m8Hc5kQxZ1UV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQaV5A5W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQaV5A5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DF91F0089D;
	Sat, 19 Sep 2026 00:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776059;
	bh=9iImI7pge0zj7YnIYJa7VF9XuKWLcrJ8NdsyV1nJzqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EQaV5A5WXM8PP7BxTaGj3bX+X88l+2plhBDCB+JrEz2R2Rlw1jMMPYe2qskFpyBzp
	 6qXaLGRrLg0ru0jBZ3/R0DSLID351D8QtljjSWVjFjM0HXVpwULTeXmXOB92fCfx7V
	 ToQaaVEp2iEq8OLuqW96wfHqg8D5qhMkBKVGxwOs60x8bbd8zCrRsI9tu0LXoZP6fa
	 PXLFyq/dW95mWmdDOjBuEJ9r+I5I/HQ0WntG6eU99jhvrKN9x85oHGlVvZq+0V9pRx
	 x1JPanmo91benNwc82/KCt/xoLk28wiTA+rOwhTTvLqyuItf0Lc3GWUEIUgNxaUWCJ
	 jx3Q7u2rfGxJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5A935CE0A73; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 06/28] hazptrtorture: Enable system-independent CPU overcommit
Date: Fri, 18 Sep 2026 17:00:34 -0700
Message-Id: <20260919000056.3132131-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit interprets negative values of the nreaders module parameter
as a number of readers per CPU, so that hazptrtorture.nreaders=-5 would
spawn five hazard-pointer reader kthreads per CPU.  As CPUs go offline,
a number of readers determined by the overcommit are idled, so that
again when hazptrtorture.nreaders=-5, five readers would be idled for
each offline CPU.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 kernel/rcu/hazptrtorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 9ecb86520551..e9ba25f156ac 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -362,7 +362,7 @@ static int hazptr_torture_reader(void *arg)
 	struct hazptr_torture *htp;
 	unsigned long lastsleep = jiffies;
 	long myid = (long)arg;
-	int mynumonline = myid;
+	int mynumonline = myid % nr_cpu_ids;
 	int pipe_count;
 	DEFINE_TORTURE_RANDOM(rand);
 
@@ -622,7 +622,7 @@ static int __init hazptr_torture_init(void)
 	if (nreaders >= 0) {
 		nrealreaders = nreaders;
 	} else {
-		nrealreaders = num_online_cpus() - 2 - nreaders;
+		nrealreaders = num_online_cpus() * -nreaders;
 		if (nrealreaders <= 0)
 			nrealreaders = 1;
 	}
-- 
2.40.1

