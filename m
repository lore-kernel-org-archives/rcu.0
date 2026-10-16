Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C087F471271
	for <rcu@vger.kernel.org>; Fri, 16 Oct 2026 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146436; cv=none; b=uzlIMwRvnfYkaoqBYjrHUQNXqhAg4MimS2itAoUNrMD3qEfVRrSxIqy1669Z0JjZnUg4KJM/ZEXslcbkWKNrlPm1OECzG0pWM57j3zmA9xH7WHVa9uSbZI23vTuNni+00CO3rywPBgInZrKiOamBi+2Ug4TyZwVFne5CET4oBwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146436; c=relaxed/simple;
	bh=7ERay0QnsnjtrFftpdHEfABPtld6uXZwCviUwTtwu+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZdDPXfZGcmNU5goy1B5lrJRxspZvkBHISJn81YbcaG8CnSUJLq5i+ODn+0MNMD7GP7tzFvfSgVzc/I2CSsN64Ed4CJGrSmhPIdD7bJ2GfwuYakNGmApakiqyTriHwcxdLdhWZev1qemUelmyHSqIGX3kuqrJ4BfL7M/N9b1iFIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzS1jb/w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzS1jb/w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417E81F000C4;
	Fri, 16 Oct 2026 10:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146435;
	bh=iK1OjRRxsLS9rxwCGE8caFXNJHC5d8Z/31JKwvymzSU=;
	h=From:To:Cc:Subject:Date;
	b=GzS1jb/wFHa8RB05ipxXeQzDIpMTiaNNtboUrywO2r5D/USshwFAiPpqlE+xJ/Lox
	 s59HXW0gzZkh5lRTFqe8SpC+O48saxdQClUE1SnlN9ZSReJlJAZx4ED+cbCDV7A+9P
	 zr/+Lvq20No3fU5bxMuqrcxl6A3WyETFjiB6trC/yXFBIUAvOWYxpUyw7pkCTljNjs
	 djvPBJ/0LP9f2+bNK2HIuj28mZT0Eqo5MSNFRN682rX3cww1Iyw9MPllFDazHqMiZ/
	 FVtSebWV+k9rGHm7z3Mp1iGAcpRhHs8tRca3qP1rQ0WriFq4WpCDkIaLLBxx9IEXHx
	 XcdVgR5nTOEpA==
From: Puranjay Mohan <puranjay@kernel.org>
To: rcu@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] rcutorture: Ignore KBUILD_OUTPUT in kvm.sh
Date: Fri, 16 Oct 2026 03:26:56 -0700
Message-ID: <20261016102657.2347381-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm.sh builds the kernel in the source tree, and kvm-build.sh and
configinit.sh expect .config and the build products to land there.
With KBUILD_OUTPUT set in the environment, make instead writes them to
that directory and fails with "The source tree is not clean" or, worse,
clobbers an unrelated build.  Unset it so kvm.sh works from such shells.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 86dd5c131d226..ee8266156254b 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -22,6 +22,10 @@ cd `dirname $scriptname`/../../../../../
 # This script knows only English.
 LANG=en_US.UTF-8; export LANG
 
+# The kernel is built in-tree below, so an out-of-tree KBUILD_OUTPUT in the
+# environment would send .config and the build products somewhere else.
+unset KBUILD_OUTPUT
+
 dur=$((30*60))
 dryrun=""
 RCUTORTURE="`pwd`/tools/testing/selftests/rcutorture"; export RCUTORTURE
-- 
2.53.0-Meta

