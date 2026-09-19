Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CCF13FEE;
	Sat, 19 Sep 2026 00:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776061; cv=none; b=T2pJlcUpN4vekDB+JEE7KDoQuZMN4QhZUfkghuZzJi+S2scm3m4rjkaAc58wsEjb15vvgz46zN0X7hPITNdDgmiK8PvC2ckhX1lDdpkwjTUT5W5jiXBVLXWPcxU6uq7wtf48a0owwduUJVxyhDb3h8qIeW5zdXdEvIHVuWr4kY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776061; c=relaxed/simple;
	bh=civ/Yp5NWMPb6P1m7QLZYl/n0wjN9ZXWsxkn0yRgy7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j5gGHro2vEoEuCeKssW7qkxOn41lBkilVUCHRxZCi1hNqQ4ewSun8qjVawcXYzJdwITNgwlY6N1MmLhZjv27d9fAhINaRNe/VF6IvgKi2ANv6BVTOs/n0KqOxLxFHIbr2EcY0/4qvVMTQfUJXxgDHTnqFIEIxiPwJbuB5Elyrlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5sOWUVa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5sOWUVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99FD1F0089A;
	Sat, 19 Sep 2026 00:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776059;
	bh=yAgt4Y2qoRAXGAhC3HtoLJ/CUV4+EENQ+E585JQerzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S5sOWUVaRmc2jdVMSf/4Bpl7YyVKgiZ3yBRFbgw/zqwd4yg0KIk9xcBsS7ILUbuB5
	 6mdPlhgSoX2uQlltYcUVOBDfMl3mmHTneG2aFwIEze9OOW9qT3FZMnRPu+L4fXlJCS
	 bAwwCIg6mfWysPrJkgLhUzT0WGTAq90NNJ3xVo04Ecp8CfZTzCNCqP0qlyQKPjvIhr
	 lq0xDiwUcxxt7/E1w3qIXymL8W8Gme+8LfXesaiARAEBm1f8rlJg6F56LuPZIp7Cas
	 MOe5QKiJro734f+FHfdwC6PCTQDThv3Hxf4f1DiL/k6aK0v7xy5FQaOAxroywnv7Bw
	 KRXj2G3nilZMQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 576A0CE0A05; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
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
Subject: [PATCH 05/28] hazptrtorture: Add microsecond-scale sleep in readers
Date: Fri, 18 Sep 2026 17:00:33 -0700
Message-Id: <20260919000056.3132131-5-paulmck@kernel.org>
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

This commit adds a default-disabled reader_sleep_us module parameter
that causes the hazard-pointer reader to unconditionally sleep for the
specified number of microseconds.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 kernel/rcu/hazptrtorture.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 22a0610d0dbd..9ecb86520551 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -35,6 +35,7 @@ torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
 torture_param(int, preempt_duration, 0, "Preemption duration (ms), zero to disable");
 torture_param(int, preempt_interval, MSEC_PER_SEC, "Interval between preemptions (ms)");
+torture_param(int, reader_sleep_us, 0, "Reader sleep duration (us)");
 torture_param(int, shuffle_interval, 3, "Number of seconds between shuffles");
 torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
 torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s");
@@ -219,6 +220,8 @@ static void hazptr_read_delay(struct torture_random_state *rrsp)
 		udelay(shortdelay_us);
 	if (!preempt_count() && !(torture_random(rrsp) % (nrealreaders * 500)))
 		torture_preempt_schedule();  /* QS only if preemptible. */
+	if (reader_sleep_us > 0)
+		torture_hrtimeout_us(reader_sleep_us, 0, NULL);
 }
 
 static void hazptr_torture_read_unlock(struct hazptr_ctx *hcp, struct hazptr_torture *htp)
@@ -507,11 +510,13 @@ hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char
 		 "--- %s: nreaders=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
 		 "preempt_duration=%d preempt_interval=%d "
+		 "reader_sleep_us=%d "
 		 "shuffle_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d "
 		 "verbose=%d\n",
 		 torture_type, tag, nrealreaders,
 		 onoff_interval, onoff_holdoff,
 		 preempt_duration, preempt_interval,
+		 reader_sleep_us,
 		 shuffle_interval, shutdown_secs, stat_interval, stutter,
 		 verbose);
 }
-- 
2.40.1

