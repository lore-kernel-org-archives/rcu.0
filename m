Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638DB23D2A4;
	Thu, 16 Jul 2026 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161422; cv=none; b=RQQ6IDUqWSiyWdD1N2CEN2C2wmNE9atMXwWb23/ho9RHyYT9SU1XpaLWZFz21tGezPReFB5BOF+qYqKQf/TtoF02uP7APZ+dlWeGjICErWN+9+4HWVJZ0XDJVMk4zW3Bi0ghCH9t+o+vs3+mvKSMzh0T79rn6Dh1oYioPkXiCXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161422; c=relaxed/simple;
	bh=YOgIfjZ9Hv3w6fqRg4OHpHpWDtOkOacsGc+bursHpzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rkz7rN8AyT4RD4XChtEQeYATCndM36oz/ZkJDwhBeIDeeYj3LWAINnEtEavTPaeYlz1RCWCH1RyxSlIfE1ZiSciZqaMfqEfvkGTcCkrbhdepDMSzeodVOTZPiscDh952ZuuOSBJukotEJ9YvGpqV6qclAUizIhlqkw1nJZAbHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQZ6FKeJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQZ6FKeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F531F000E9;
	Thu, 16 Jul 2026 00:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161421;
	bh=D0YSEH/Doqmop/Dz/KZ0B/3nd5tyCJxHYawhjRSN0dM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QQZ6FKeJFmLtnEonruCWuuT4cNO65EWsTDshzBOaTKvjxvu2PXcpjrz7ha8pUUOhE
	 QP24aTOYcbLy0tbMq0bxyc7tt3XHKq4D7yKk03rXngHwkULlkjLkzxv6hVQGCky/HR
	 u/x9GcRRW/H40qxy57MppyaNk1QWOmtm8xKEUSvnfzEzmO6Iu09YGA10kcvTDPw68U
	 S05bITcvoMyvfLqpDhliWTLaqM/X+KbYhq0KosiwbEA10LVTNAsDvnMcVSV3h6M70/
	 vyWcK3UXDCiCUqdnz5n7qmRXL97dZMO3Y63bHTCr4EiUJ+3KwbjweUdEENnuyK1Guk
	 7mE1+e2o0U1Cw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E7B69CE0569; Wed, 15 Jul 2026 17:23:40 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 01/10] rcu-tasks: TASKS_TRACE_RCU doesn't need IRQ_WORK
Date: Wed, 15 Jul 2026 17:23:30 -0700
Message-Id: <20260716002339.11717-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
References: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that Tasks Trace RCU is implemented in terms of SRCU, it no longer
has any particular need for the IRQ_WORK Kconfig option.  This commit
therefore removes the "select IRQ_WORK" from the TASKS_TRACE_RCU Kconfig
option.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 762299291e09ba..332df7a7a6347c 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -140,7 +140,6 @@ config FORCE_TASKS_TRACE_RCU
 config TASKS_TRACE_RCU
 	bool
 	default n
-	select IRQ_WORK
 
 config TASKS_TRACE_RCU_NO_MB
 	bool "Override RCU Tasks Trace inclusion of read-side memory barriers"
-- 
2.40.1

