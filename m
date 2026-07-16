Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D642D0C72;
	Thu, 16 Jul 2026 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161706; cv=none; b=S0QrwguevuYfIchy/iLZCQfy/yNDG2kE7y+qg+/9RZlviVe8Sr2tIMZws7yoqNHgNi+xVJhgDnc3ZIGqCw+99fomBWppyK4s52A5/3wCVC5LffTa/iqROvj8NNHAK4/0rDYNQBGs15P6vEEjq8WiHUIHcGBDYt0NZopxBc23RBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161706; c=relaxed/simple;
	bh=V0x8JStixbHIDW1+MuKIrVTSSR4cEbuv60JF37lPlrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIjfMBuuXCTgMJNYC7fndpvv1bPK9C3MwZcFU/01YormPrsKIHekUH4hkHNTyUFp3UgovetNazzAfR+/7fbt+iRcaSoodq88HyH2ERSwgGhxKmIT3t8Udbw/JrMQC2h+QXfPYyhInn85jSbV4LBPiGPWIqVHePeFH3ZNOUKrAqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5UzqIBW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5UzqIBW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402441F00ACA;
	Thu, 16 Jul 2026 00:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161705;
	bh=d7NMfMQsKZsM/KnMYq77Vza78BqqJ7HTg6z4nOU+Rvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J5UzqIBWwo6Ql78SlH2aFsBf9z2rk24QUWLmWgpOe85Jjm0lacHOBbxjb9+YWBAGF
	 HH+E9w1ZSu7hhDMxEiAdSVfXhnQ0R/P31g5Z1+FXcmxcLfWySqXjlCjV8YBf88vVBB
	 XZLPUxRS6FkJipTjXcDat3jZonuseGpQzFtbStG+dKDKA14t5fYV1ll1cw48vuG7F0
	 9ARBMsWzxKGvAUh9HJx65GuYO8r5zsZWzvh30tlwAjVMeCfxwSY16ivJM6PK4UIAi5
	 X/zLYG1RU0k+KgeZ53q0tdGccCtDm8cWo80MS4lmvwp2vb7dq63AIr5LGFvcIuJYHK
	 ZKSY5kedOmXgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EA724CE0C57; Wed, 15 Jul 2026 17:28:24 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 5/6] MAINTAINERS: add Rust SRCU files to SRCU entry
Date: Wed, 15 Jul 2026 17:28:22 -0700
Message-Id: <20260716002823.12176-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d9081db0-37e9-4187-84e1-871ab30a2b3f@paulmck-laptop>
References: <d9081db0-37e9-4187-84e1-871ab30a2b3f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Onur Özkan <work@onurozkan.dev>

Include Rust side implementation files to the SRCU maintainer
entry.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 806bd2d80d1535..b6ef971ee40856 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24933,6 +24933,7 @@ SLEEPABLE READ-COPY UPDATE (SRCU)
 M:	Lai Jiangshan <jiangshanlai@gmail.com>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Josh Triplett <josh@joshtriplett.org>
+M:	Onur Özkan <work@onurozkan.dev> (RUST)
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 L:	rcu@vger.kernel.org
@@ -24941,6 +24942,8 @@ W:	http://www.rdrop.com/users/paulmck/RCU/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
 F:	include/linux/srcu*.h
 F:	kernel/rcu/srcu*.c
+F:	rust/helpers/srcu.c
+F:	rust/kernel/sync/srcu.rs
 
 SMACK SECURITY MODULE
 M:	Casey Schaufler <casey@schaufler-ca.com>
-- 
2.40.1

