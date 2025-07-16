Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAD32EE96C;
	Wed, 16 Jul 2025 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752706464; cv=none; b=DtADZnOhcKXvfX5WJqL3/LYrfqGeKvB5nzh6Bgfe8/gUq9T6rsOHXwr04mMUizP65pez4/7fxxVeyClvaQzt6/TjOLHBsWV4EClvlCCj+NLBTp8523xuHmnQJLtefCnNQNrCPh5DqsHEor7OV+OvS+mXLOJvZ4+ZNB6gIpHrxZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752706464; c=relaxed/simple;
	bh=ppgYGC4q1Oa9AV1D2Y1RK6jAxATmf7IU21OLLN0T0Uo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UfQhy8lH3zvXzTaZlnNu1K4QC/S6Urr88EuGLrw+vBO2H0Fs/9rwrFoD/5hrR0YLqLIrRj+5FLlNax7EvDhDzZ54kNu28s1sk+VK3hQzO2/prwLq0iI9KSczTmArtpVtJO9U+3y4NbWv5w4nIOXrIph1yrFdyoxIDnUl2285YrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cw1/aPFi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cw1/aPFi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D945BC4CEEB;
	Wed, 16 Jul 2025 22:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752706463;
	bh=ppgYGC4q1Oa9AV1D2Y1RK6jAxATmf7IU21OLLN0T0Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cw1/aPFiepasYdCgIum3stNCEEorjYzcONWLQRoU6qeuXy8BLifeKfOuUoFS5msRW
	 umoTSZKNL+pb8YM/w5mvTcPqxosidzEbVY0wYPitgn9/Vs6yJkyvP2osNi7vH3E85w
	 BncO7l86wV1yqNcEa129i3X5paYb8towcR8UU5AMZN2A307uLcCEeGCk2O6AKGf3/1
	 znSv8gYbLbvbcU+qY7ol7C9y5a3X4XRgHQNQxA7te72MIW+QWEgrBYA9zVsvmKqiO2
	 XcUFPPrs5FQ4itmT1+6dnHrVlkfwh/MaU0osdmqT7ZoeZh/alRSmr6ddWBhwTQDLgq
	 SKex+NpsOMLWA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7D50ECE0AAF; Wed, 16 Jul 2025 15:54:23 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RFC 3/4] srcu: Add guards for notrace variants of SRCU-fast readers
Date: Wed, 16 Jul 2025 15:54:17 -0700
Message-Id: <20250716225418.3014815-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
References: <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the usual scoped_guard(srcu_fast_notrace, &my_srcu) and
guard(srcu_fast_notrace)(&my_srcu).

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/srcu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index ef65ffe152fbd..0aa2376cca0b1 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -510,4 +510,9 @@ DEFINE_LOCK_GUARD_1(srcu, struct srcu_struct,
 		    srcu_read_unlock(_T->lock, _T->idx),
 		    int idx)
 
+DEFINE_LOCK_GUARD_1(srcu_fast_notrace, struct srcu_struct,
+		    _T->scp = srcu_read_lock_fast_notrace(_T->lock),
+		    srcu_read_unlock_fast_notrace(_T->lock, _T->scp),
+		    struct srcu_ctr __percpu *scp)
+
 #endif
-- 
2.40.1

