Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A49179BC;
	Thu, 30 Jan 2025 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738262967; cv=none; b=C3CiRgfxuGmOTo5zW5h+SqmHzU5OJjTNKY6TIxuYR8xXAbRmL9TuFlqOO/oyHHPSX2M5+Mm/4pMNTkaBHud62UwC4OpbuR0Q2qBrfcWFUPFxBi173PqlCDsFgylq4lK5Ix1GIAsmc0m5bb8YpmCJOVpLJh9+Scar75DNJ5Ogfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738262967; c=relaxed/simple;
	bh=AWn5SFxUzI8JsIufek7SpD9CBh9ZRnNH+qA6EOcFSqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rPoo8wWOQvddHMpY+nG5AiPjGAn8bq79jkwh1S2NPo7MNS178FMN4Mx81hti8HUiKVCnAFxx0pDGv7NDsvFrXGXAmhtlYoF8+vg17Z/hkxHi4OxjtYNuwIwUE9hLDaYTWyaHFZVqN/azfV3oDUG3H0qGfoGPhPOahIq/tjQbbpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmBoRQYU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmBoRQYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D75CC4CED2;
	Thu, 30 Jan 2025 18:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738262967;
	bh=AWn5SFxUzI8JsIufek7SpD9CBh9ZRnNH+qA6EOcFSqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UmBoRQYUylOkaYKgPlDbmdgRXtkkRqXsNpISCQWLiGoCZ7Yw5KJviPWEH2DrnGa4J
	 eqGjGQ3myKMvr3X91jvmVBqQfQWNvz2VBuFFCNQJ151DW2TQyalyae9rZu2qEPXjvW
	 z0S2amaYE1QjLUPGQtVoXp/hUfYieN/P4gl9Zxr9GK7w01IO05xoNj3vosBkE303Ib
	 nulYKx7/TSd98b2I53jL2sgNFPGCnGL+TOmu7HAeXuN4yr39g9OYr50XdK8Y2iUTy2
	 bxQFoFNQdxoY7BS/yEL5QcUUTUqfIEQLY/bliyAv+CeXm7iYKJXkqKdFWaD5uZr4bW
	 VvKzSe3BRIo4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 29482CE37D9; Thu, 30 Jan 2025 10:49:27 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu v2 1/7] doc: Add broken-timing possibility to stallwarn.rst
Date: Thu, 30 Jan 2025 10:49:19 -0800
Message-Id: <20250130184925.1651665-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <851fd11f-6397-4411-983b-96f7234326d5@paulmck-laptop>
References: <851fd11f-6397-4411-983b-96f7234326d5@paulmck-laptop>
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
index 30080ff6f406..d1ccd6039a8c 100644
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

