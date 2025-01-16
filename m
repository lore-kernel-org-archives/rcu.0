Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33D81DE894;
	Thu, 16 Jan 2025 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057761; cv=none; b=oB3SkmEEm+q1fx3b4WyTMBLizy0NyKO9VBDkoE8Y8rbXKSaKZ5RLWJfFu+K1OCi1+/Tas2AxQCc4s/tWVs3C5yWczBNL9bX99yRd+h70cisRmrg1dT2Q0lafWfLBMOkoGJod3Cosul+UfMveFbjOhcrhWqLTU5yk8zNdjUnNJDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057761; c=relaxed/simple;
	bh=lafpHyVaSYlRTcQ8LIw7WT/QIW65DigJmxVxCRz15TA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T/b12YEZFTmpb2TW06jRn+uQSwk1SPgSrD7iSTleabqlmJZyZ7KE8tSkKHDKyHbTUUk8ua4gyJIR+J26fpxuHyu4SYNAX+zm1HseJcBIJhcVIl0Fggq0GZIK+HNKb7YA5H+BAv8rzN5mW0f6nkfNZcsB3SKAOhum+UFqx0iW7c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GC8028aJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GC8028aJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726CFC4CED6;
	Thu, 16 Jan 2025 20:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737057761;
	bh=lafpHyVaSYlRTcQ8LIw7WT/QIW65DigJmxVxCRz15TA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GC8028aJN+2xagjw79rkzXVZmwPzhF0F8aF7sEPSO1IamPMXS5BEvFn3NmjUTU+YR
	 rwZUlFxuDaS6fVUwoazh9ft1l0NtrIdl5+CjZsyV4W5pZNGLy+IaMNFxqm15WohSH3
	 svgJnOwaRFqIWrvPN0IN1CD1c/xreBBhSv7x3lTXWYOaL2Yuu53y515TJdnRqGgwqB
	 UuIkPk9h3KPVUGncu/vgwoEjt9JtjKMoUah4rxQY8kPKTdlj2YexH50lYphRDZRXu8
	 Nqn4a61iacwkwtYFGufPeljqski1b3ObA1OSTDJ2eheyL6U/lF3b9Ky8A1MHoiS4xR
	 acmjXhyLJZfHQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 298B9CE0EDF; Thu, 16 Jan 2025 12:02:41 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/7] doc: Add broken-timing possibility to stallwarn.rst
Date: Thu, 16 Jan 2025 12:02:33 -0800
Message-Id: <20250116200239.3782374-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a2c2793d-771a-436e-8c42-4cb38def0e2f@paulmck-laptop>
References: <a2c2793d-771a-436e-8c42-4cb38def0e2f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, stallwarn.rst does not mention the fact that timer bugs can
result in false-positive RCU CPU stall warnings.  This commit therefore
adds this to the list.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/stallwarn.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index 30080ff6f4062..d1ccd6039a8c3 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -96,6 +96,13 @@ warnings:
 	the ``rcu_.*timer wakeup didn't happen for`` console-log message,
 	which will include additional debugging information.
 
+-	A timer issue causes time to appear to jump forward, so that RCU
+	believes that the RCU CPU stall-warning timeout has been exceeded
+	when in fact much less time has passed.  This could be due to
+	timer hardware bugs, timer driver bugs, or even corruption of
+	the "jiffies" global variable.	These sorts of timer hardware
+	and driver bugs are not uncommon when testing new hardware.
+
 -	A low-level kernel issue that either fails to invoke one of the
 	variants of rcu_eqs_enter(true), rcu_eqs_exit(true), ct_idle_enter(),
 	ct_idle_exit(), ct_irq_enter(), or ct_irq_exit() on the one
-- 
2.40.1

