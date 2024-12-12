Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AEF2253E3;
	Thu, 12 Dec 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028778; cv=none; b=koyJ5Uh4dGeAs+gBA/NgPEDpIXh/4wCaYpl1Y0eEQ9sDdi8+N945I9ZJAfxjTDxRfnsK07ZRQznv8af5IlHIXqU9/9b9vDbTAecBEvjfKCkB7cqO86tRXNP0t/obBddAdTG/mgWMrsxa7rA/zYfc1s3KSdvFz1zfMMioCTP2U/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028778; c=relaxed/simple;
	bh=ITwhtIk0AzHqLNS7JxO3Qo0sI1AR2YzCqmCP7jHMXok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I11mB6xW7fmpqYwaeAozyeYwc9pv8G5h1+nm4aNMibzbrbh/k7tC/ANwnCyDo6pDxpesJCJMf+v+HrJqqXnJjkYsmBxgQ+g3Q3K6l4PlSbH9y5VpiUdG/bzPjPpubpoZ30l9+4yU7qNLZMvj2UxUTOWn1/vBFKHhhM2y8vFhQH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7nYw+6S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7nYw+6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27A9C4CED0;
	Thu, 12 Dec 2024 18:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734028778;
	bh=ITwhtIk0AzHqLNS7JxO3Qo0sI1AR2YzCqmCP7jHMXok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U7nYw+6SR3GAoFsJEuUlwtBN9dQ/oHrG5+sFNmEDTgoVFxB/eWIEYCI5l3HeLD/Ae
	 xB2DDA8XPFOBsi8tG3BJ3Siqdf5PgOLxVYzxqbN1q6R/bwIxnIwG37t0gQS5yARwy/
	 YWIdjRREQuMn3fFcsi+g8uvWRwyu0ilCNh/J1zU1txb8ho8KwEcN22E+mignX5aoeV
	 aoTLfUe0StYTTMX2I0idWCPHADk7/l3i0vb7zEFWrOYAfbE+E8F+hhu+w6xTWxaPa8
	 v80zpRQyTIMEEQ3rT/iTLYOPiKkhGWBgl1rvF40Gx7yQUOkx5VpMMM6akr5dzatkol
	 OfDu85jpayCsg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4ABBCCE0FF3; Thu, 12 Dec 2024 10:39:37 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 7/8] rcu: Add lockdep_assert_irqs_disabled() to rcu_exp_need_qs()
Date: Thu, 12 Dec 2024 10:39:35 -0800
Message-Id: <20241212183936.1936196-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <928b8031-2bfe-4c90-9952-7d331e027ae3@paulmck-laptop>
References: <928b8031-2bfe-4c90-9952-7d331e027ae3@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers to rcu_exp_need_qs() are supposed to disable interrupts, so this
commit enlists lockdep's aid in checking this.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_exp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index ce5b09921d04e..77efed89c79e3 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -722,6 +722,7 @@ static void rcu_exp_sel_wait_wake(unsigned long s)
 /* Request an expedited quiescent state. */
 static void rcu_exp_need_qs(void)
 {
+	lockdep_assert_irqs_disabled();
 	ASSERT_EXCLUSIVE_WRITER_SCOPED(*this_cpu_ptr(&rcu_data.cpu_no_qs.b.exp));
 	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, true);
 	/* Store .exp before .rcu_urgent_qs. */
-- 
2.40.1

