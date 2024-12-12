Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B5F2253E7;
	Thu, 12 Dec 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028778; cv=none; b=KxmrtqfX+mdrG28sVn8Ye/2KQZ5q/WzVMHzFh1dls8dUtZCdKyF+67sRhN4Uqjr1htSznGI+DRgrtlnbjHdTFKbpwpCdttn6cNiVOdESOvvNzx7EcOLGNQYy7bLABV9bH5EaDMotAsi3WZncDNw+aC/8HYoAtaC4wY/dkno7eQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028778; c=relaxed/simple;
	bh=XLvD1/4PT/QkzXQlsrnPHd9H1NoHeOioidfUE/hkJUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bhbTT6UwKMLJwXa/u3MaJIHKqEhm0b7y1cLK1HS7wBJgfgFDHipv6VSmWCVzGRQYCXE9VjC64/CRNKhnEc3T7+mkkcY4fiEOuWhR0QU4cVw7/6Xw+KHyR+xEDc+oamxpEvt/Lgt5xczyzjl78yxp7FIaZT/JrdpkvY6IYw0QmGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7tjm1NL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7tjm1NL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3B8C4CEE5;
	Thu, 12 Dec 2024 18:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734028778;
	bh=XLvD1/4PT/QkzXQlsrnPHd9H1NoHeOioidfUE/hkJUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k7tjm1NLOqjfsPgCJ77fUmyMXrFyD0T5t8Vt7mKJdxfyFLRpWmxD57tWL1c5Js1aR
	 07u5G3IxTfpWtLvgM55I5ooRDpg0UbA2SjaYiwFhQ9XJnetnzvZ7jp1DXTd71ArpvK
	 j1dvdIT1E22ph/bUNujd5ki/e6e+IPVVlvjB+5zQe/jqeqZyTtzdysNQhgrtcvKJb6
	 UEUwFstpBBfSupSCnRQaeIRRNkG+i3Qi8bfMr8AznLdi3hdDQYvTkUzH1Dx7MwbRX0
	 vvb5jKFFyJmklHPyWPDatpzJuAT0+wBOjFF1hfMFHQd0vMtPeI1E08f7UO7j5xYsmp
	 d4TTF8jBzPYyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4D474CE109D; Thu, 12 Dec 2024 10:39:37 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Song Liu <song@kernel.org>
Subject: [PATCH rcu 8/8] MAINTAINERS: Update RCU git tree
Date: Thu, 12 Dec 2024 10:39:36 -0800
Message-Id: <20241212183936.1936196-8-paulmck@kernel.org>
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

RCU now has a shiny new shared git tree, so this commit updates
MAINTAINERS to point to it instead of my personal -rcu tree.

Reported-by: Song Liu <song@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b13..d2f0f1e350554 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13299,7 +13299,7 @@ L:	linux-kernel@vger.kernel.org
 L:	linux-arch@vger.kernel.org
 L:	lkmm@lists.linux.dev
 S:	Supported
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
 F:	Documentation/atomic_bitops.txt
 F:	Documentation/atomic_t.txt
 F:	Documentation/core-api/refcount-vs-atomic.rst
@@ -19600,7 +19600,7 @@ R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 R:	Lai Jiangshan <jiangshanlai@gmail.com>
 L:	rcu@vger.kernel.org
 S:	Supported
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
 F:	tools/testing/selftests/rcutorture
 
 RDACM20 Camera Sensor
@@ -19679,7 +19679,7 @@ R:	Zqiang <qiang.zhang1211@gmail.com>
 L:	rcu@vger.kernel.org
 S:	Supported
 W:	http://www.rdrop.com/users/paulmck/RCU/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
 F:	Documentation/RCU/
 F:	include/linux/rcu*
 F:	kernel/rcu/
@@ -21575,7 +21575,7 @@ R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 L:	rcu@vger.kernel.org
 S:	Supported
 W:	http://www.rdrop.com/users/paulmck/RCU/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
 F:	include/linux/srcu*.h
 F:	kernel/rcu/srcu*.c
 
@@ -23704,7 +23704,7 @@ M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Josh Triplett <josh@joshtriplett.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
 F:	Documentation/RCU/torture.rst
 F:	kernel/locking/locktorture.c
 F:	kernel/rcu/rcuscale.c
-- 
2.40.1

