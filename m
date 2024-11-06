Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358CA204F74;
	Wed,  6 Nov 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908967; cv=none; b=LJDAQQyCz3yPVuufAR4mHeSTz63ZNgDwJXPD0W/4xDXvUZshSBK1RTt5kQ7enF2yAxgbtQwJ/eB88MtwIGmjhSvYE4tzX0ijcQCaHxbuI2OV0zoMjS+ZKbxt24lgZUAPDkaBrSUag2r4yTAHcZq/0hR0fT8TpYhAR7HvPpbYY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908967; c=relaxed/simple;
	bh=GS00MQQCCGQlMrETLu2vYuH9LgO7xjhv1AVBlgrtGuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9KcbhjMmXKvhgF//3WeF3wIVQ/tSko0/3bYskOlZgXDyjyfx8kbAsDz+khhgcK7gN6+pADEPQJJMvrH8R/ogJchcgaNkyBY3DkkyCkbOdwbtoD2SYcZ9GVG7axhXFT3fbCkeye+teWbEpGB3fHkvdpGqrOvw0Z8XRdvDDHTJL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLjhsDnZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLjhsDnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6C8C4CECD;
	Wed,  6 Nov 2024 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730908966;
	bh=GS00MQQCCGQlMrETLu2vYuH9LgO7xjhv1AVBlgrtGuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLjhsDnZqFUJKv0ayRfHLtfvJxEVksGPtcJVXavCP5xvq/QtoAuIjcT+I4kvLUNOc
	 rtf6Rz7pt9p/IugddARHP0TzS16nX4SZWJkltoLqWaRryAujVfDO8nVZm1J2yo5GWj
	 LxUl2B/DSdcU0viLFca6t1T6m356UGug6zUTd+F/dPd6z8ArUhKAAVgvSIenYQMKc3
	 TmCFad/pT94so2ZjqBqckzJaHPiwBEetNjoVRkWO88GnMwWx3/OiKYL9sJ4iLZSMtr
	 8Jl9LvypemSiJvGRo90ZZGd5qS12J6RupJYyN7k19ZJeTZhtsUWwTlOfwYTu2SzSpV
	 rfhqeiVv6htnA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 6/6] rcuscale: Remove redundant WARN_ON_ONCE() splat
Date: Wed,  6 Nov 2024 17:02:23 +0100
Message-ID: <20241106160223.42119-7-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241106160223.42119-1-frederic@kernel.org>
References: <20241106160223.42119-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

There are two places where WARN_ON_ONCE() is called two times
in the error paths. One which is encapsulated into if() condition
and another one, which is unnecessary, is placed in the brackets.

Remove an extra WARN_ON_ONCE() splat which is in brackets.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcuscale.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index de7d511e6be4..1d8bb603c289 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -889,13 +889,11 @@ kfree_scale_init(void)
 
 		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
 			pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
-			WARN_ON_ONCE(1);
 			goto unwind;
 		}
 
 		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
 			pr_alert("ERROR: call_rcu() CBs are being too lazy!\n");
-			WARN_ON_ONCE(1);
 			goto unwind;
 		}
 	}
-- 
2.46.0

