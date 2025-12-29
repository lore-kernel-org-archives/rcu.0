Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AFA292918;
	Mon, 29 Dec 2025 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035779; cv=none; b=CnSEfkR9x4KyJhwB7ehxo3MYJ++/nW06YUWq3qYgk6qPfy1VLOgEgfjP+uy/SOVA5jHK48NXuaazhmkRWtHYHd4c6jF4EZt1WRDNGAv+fmsUSl55TO8KToyXa09nk2w271sW6Y1HGvEkIZwHbmEK1c12c5pB43dsMIzvnbLouQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035779; c=relaxed/simple;
	bh=QEnEB6sroXDUTxtiJnE/HODvmxP7bOmFFYSkBvCrjUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QKVkNEQyeIBgw6bp+jNXZS9VS9kcJ7Rh572BMs+kL3hh1ezmPtoE4ZukgrzZTgEZlR0cnYUl65UAe67DSl9JGqzZL/s0SfTt1tBW1LFxlR/8rJ6PcTDK49jZLiiWJo6oCojqIkKutjSROEbGBxwLFJGYhcB7qZdN2z00tCnsHlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFsvfLp0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFsvfLp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED33C16AAE;
	Mon, 29 Dec 2025 19:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035778;
	bh=QEnEB6sroXDUTxtiJnE/HODvmxP7bOmFFYSkBvCrjUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OFsvfLp0/Vou0pehKln01X2OgNKBHiTi8aGEsBckDr1GctF0JKroCIQzcpWWD217L
	 FX0DJk5TL8sEaCtS30R9Sexfo9gGaXPQGP55Z6kN6BfbPjRCa0rZ3LWZ/dzWpnz/RC
	 klbsmwoH+TzOyOf/K7UYHizlmxC4GvPiEKx4JvtF9jLsf0+F5AIlSpy9Jwhk0JkqUY
	 0e5Vff+ZZOV6X+K4v+3Nn1zTt8xGvrb+O33Qa4vvfQmCP01VvknWwOvgK5rLeOilAc
	 zppYktVDHnZX/YGzYok9dClhZNwoC+ODCWzbpjPCl+vPPVV8c2qAY7fbC9v6BSPOjG
	 a9MVFy99HaoMw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7907CCE0CAF; Mon, 29 Dec 2025 11:16:18 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Chris Mason <clm@meta.com>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v4 2/2] rcutorture: Correctly compute probability to invoke ->exp_current()
Date: Mon, 29 Dec 2025 11:16:16 -0800
Message-Id: <20251229191616.693898-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2ca142cc-0487-45e2-830e-8ece0fcd72cb@paulmck-laptop>
References: <2ca142cc-0487-45e2-830e-8ece0fcd72cb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lack of parentheses causes the ->exp_current() function, for example,
srcu_expedite_current(), to be called only once in four billion times
instead of the intended once in 256 times.  This commit therefore adds
the needed parentheses.

Reported-by: Chris Mason <clm@meta.com>
Reported-by: Joel Fernandes <joelagnelf@nvidia.com>
Fixes: 950063c6e897 ("rcutorture: Test srcu_expedite_current()")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 63053031ade21..47ce7f49b52c6 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1749,7 +1749,7 @@ rcu_torture_writer(void *arg)
 					ulo[i] = cur_ops->get_comp_state();
 				gp_snap = cur_ops->start_gp_poll();
 				rcu_torture_writer_state = RTWS_POLL_WAIT;
-				if (cur_ops->exp_current && !torture_random(&rand) % 0xff)
+				if (cur_ops->exp_current && !(torture_random(&rand) & 0xff))
 					cur_ops->exp_current();
 				while (!cur_ops->poll_gp_state(gp_snap)) {
 					gp_snap1 = cur_ops->get_gp_state();
@@ -1771,7 +1771,7 @@ rcu_torture_writer(void *arg)
 					cur_ops->get_comp_state_full(&rgo[i]);
 				cur_ops->start_gp_poll_full(&gp_snap_full);
 				rcu_torture_writer_state = RTWS_POLL_WAIT_FULL;
-				if (cur_ops->exp_current && !torture_random(&rand) % 0xff)
+				if (cur_ops->exp_current && !(torture_random(&rand) & 0xff))
 					cur_ops->exp_current();
 				while (!cur_ops->poll_gp_state_full(&gp_snap_full)) {
 					cur_ops->get_gp_state_full(&gp_snap1_full);
-- 
2.40.1

