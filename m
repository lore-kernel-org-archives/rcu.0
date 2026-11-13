Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531067;
	b=EQgPoBOKxQK6tqSStBRGa6rqgNXC85kcM5xeHP2CIT9x+8ElvcsQULwj3ACsEaO4lhOK
	 t5YpLJVhz52WxiSMEDQJyZJ9dgtelAlL1imHnoGGD5w+zmqlRIDh9MgzMpN8t+y+F0G5t
	 Tjd4I6SWX+CkY6Q1gpAplYGv4Eyl2Nb6geGKzdJSlvTU60sxHVsEittULSB0k/5ZoNWQh
	 DDMaPCtRnenj+JJd/hntEVWauGK1x1kL6D4uCnMKkBtM1rhBUnh9Hp5ZSvqFGDNZgKHEJ
	 W0beAJK9L4gqdI8TUC5A/te2Mi6bnUoldQzz6iZ+U0qrG2mmeJDRGNJYO2AtPBU/idg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531067;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fq75Hh8R3/vvYHD+4z8YHir5eFApjDd0qsVJ3SgP9Jo=;
	b=Gz+UpE88LzRPsnX9O/UvBRIcbd8Dzs9mJUSgiaMVYRmc0MWwTRxQPCWBIHxuA85izJ6Y
	 kMk30S++hJ5EwSD29uWyBohKrWd2fiy2p3uI0E9RBGqszH623sDLkebMD8WXz9Xy0Rlln
	 WaBD0xPno2Y5sKzeav1sP6gcZnKnTW7G02e6rvgb6N5IJaPymTPc67hSl05xZCc+qKQsq
	 WmMADZaal+/TkwYyQ5b6SgEyLvmvvHvA1SKggemP3nU3VHSelPVQKqyAVAtR4jXsorK5w
	 YeeglvCJKfj5G1CJsIQFMN+pF3ZjkmxR9P8HQzeW+KWGMbBgb/CtiH8co+HNlrby4ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpqF1bXq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3C7CB60A260E;
	Fri, 13 Nov 2026 00:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpqF1bXq
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C12621F000C4;
	Fri, 13 Nov 2026 00:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531067;
	bh=fq75Hh8R3/vvYHD+4z8YHir5eFApjDd0qsVJ3SgP9Jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gpqF1bXqm+LTol0totvV0y4Fsm+fDD93ttaBThvEfsjjBncCB1f0fBY5Nf7C+Jpu7
	 DbqLYTDUNRVW83VSuXix5MLnrtIvZo/QdQkryjyNare2Qm7l6fCtvCp5k2KTCS+m+b
	 ra97UA1AAAKI+kjPQiWeS+MXcQsXLFzOxAZ80YCturSjszAvr+aIl8i4wN/GEyghde
	 T/TRNvxs/waNAF5JspKbuFzEDW8AYiMbvdW6KGgaZyQrvOjO5K46wZMKgqIjWVKGYp
	 RbiPVVDENdSjkXJc7Yj9747SJC1kA7rlX+oGhF9UzsnpEo7kT39OCsihPBVuaQz9qK
	 sCiMarPjioARQ==
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
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org
Subject: [PATCH for-v7.5 2/5] tools/rcu: Add new APIs to rcu-updaters.sh
Date: Thu, 12 Nov 2026 19:50:51 -0500
Message-ID: <20261113005056.2793983-3-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005056.2793983-1-jfern@kernel.org>
References: <20261113005056.2793983-1-jfern@kernel.org>
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

From: Zqiang <qiang.zhang@linux.dev>

The following commit introduces some new APIs:

commit 'dab06d6f9379 ("srcutree: Add an atomic Tree SRCU")'
commit '8df13f01608e ("rcu: Add full-sized polling for cond_sync_exp_full()")'
commit 'd96c52fe4907 (rcu: Add polled expedited grace-period primitives)'

synchronize_srcu_atomic(), cond_synchronize_rcu_expedited() and
cond_synchronize_rcu_expedited_full().

Sample output when running rcutorture:

@counts[synchronize_srcu]: 48
@counts[synchronize_rcu_expedited]: 74
@counts[synchronize_rcu]: 102
@counts[poll_state_synchronize_rcu_full]: 443
@counts[call_rcu]: 2498
@counts[synchronize_srcu_atomic]: 8717
@counts[poll_state_synchronize_srcu]: 14849

@counts[call_srcu]: 22
@counts[synchronize_rcu]: 103
@counts[start_poll_synchronize_rcu]: 1093
@counts[cond_synchronize_rcu_expedited]: 5339
@counts[cond_synchronize_rcu_expedited_full]: 5375
@counts[synchronize_rcu_expedited]: 8134
@counts[get_state_synchronize_rcu_full]: 17248
@counts[get_state_synchronize_rcu]: 17266
@counts[call_rcu]: 119168

This commit therefore add thems to rcu-updaters.sh script.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Reviewed-by: Joel Fernandes <jfern@kernel.org>
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 tools/rcu/rcu-updaters.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/rcu/rcu-updaters.sh b/tools/rcu/rcu-updaters.sh
index 8a5df3f22550..a0f03a144f6a 100755
--- a/tools/rcu/rcu-updaters.sh
+++ b/tools/rcu/rcu-updaters.sh
@@ -34,6 +34,7 @@ bpftrace -e 'kprobe:kvfree_call_rcu,
 	     kprobe:synchronize_rcu_tasks_trace,
 	     kprobe:synchronize_srcu,
 	     kprobe:synchronize_srcu_expedited,
+	     kprobe:synchronize_srcu_atomic,
 	     kprobe:get_state_synchronize_rcu,
 	     kprobe:get_state_synchronize_rcu_full,
 	     kprobe:start_poll_synchronize_rcu,
@@ -44,6 +45,8 @@ bpftrace -e 'kprobe:kvfree_call_rcu,
 	     kprobe:poll_state_synchronize_rcu_full,
 	     kprobe:cond_synchronize_rcu,
 	     kprobe:cond_synchronize_rcu_full,
+	     kprobe:cond_synchronize_rcu_expedited,
+	     kprobe:cond_synchronize_rcu_expedited_full,
 	     kprobe:start_poll_synchronize_srcu,
 	     kprobe:poll_state_synchronize_srcu,
 	     kprobe:rcu_gp_init
-- 
2.54.0

