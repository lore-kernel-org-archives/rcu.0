Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015B52FB0BE;
	Thu, 18 Sep 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190473; cv=none; b=BTNaun2xxIJTFokpHd3x7qcxXeFKbn7ce5zTcEXfI9VNbF3oXsAIRbgBJqalHBjAAqh9LSzjJBUUHhPkPL9ERnTprYN6o8fy7ez6jkrlkXaDnK4aIjY0UKGztdNY/StCPBccxmxcyn8+Z3XQgpIvBEbSmOFuhw/JuSrl9a1CN6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190473; c=relaxed/simple;
	bh=4cPXhN+QWntHKUlZlbENageTOLIy+prm5bNBCxP4Zmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n62JSxWwkO2QyGF1bQzkugDQ7iETYDVj14R6Fl1zHzvIcYe/a/nxEi0Jo8xbVNplj8iCtvKT2bUEucfXtJJD9TTYdG8P+/UWHTpH0tXw/sq3EDfDAR5S0o6rM77hYT0T/HOY5WI4pjggO7sKG/eaTHVKhnK+nJpOn3snr7JcfPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebNkBCJb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebNkBCJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF06C4CEF0;
	Thu, 18 Sep 2025 10:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190472;
	bh=4cPXhN+QWntHKUlZlbENageTOLIy+prm5bNBCxP4Zmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ebNkBCJbWzTviQv6xncPH4R5uQcf/9aJaR4QNACgp6R/NGTo6aWax2A7ZSrcYi7mM
	 paG2GLltTQti/1QhQLwhqvGSoDvbvaAT0V/nrxNHDtD3xFlgKSkhjgCEOn9eAGWUjD
	 E4ye5wNJ9iLlyCxy5gqVwYC7cAKbpB0RqyMmNnai6+ZZbJfkxnPK8DEfYBn7QuQ7Sh
	 ns9DtlyCGmfWsWoHR0++rQrrFIQ0shnJtq6LotQkO/ZyYurfFpdC8GEft4x43hTk10
	 TFwlTnV0U5v8TRdtqjRffPhejGzr4YwV/K4lhSxVUZ7LC931dojMpfjr8+YzgbPSrA
	 G5XghrJQXKzjw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C815BCE10DB; Thu, 18 Sep 2025 03:14:31 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 6/8] Documentation: RCU: Retitle toctree index
Date: Thu, 18 Sep 2025 03:14:28 -0700
Message-Id: <20250918101430.2592294-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <921eb978-5f39-4480-bcf6-c735f859c694@paulmck-laptop>
References: <921eb978-5f39-4480-bcf6-c735f859c694@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bagas Sanjaya <bagasdotme@gmail.com>

toctree index title ("RCU concepts") is rather a misnomer: RCU concepts
is already described in rcu.rst, whereas the toctree suggests that
the docs themes about handbook on RCU subsystem instead.

Edit the title to reflect the fact.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/index.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index e1be5b3c2c6773..ef26c78507d369 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -1,9 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. _rcu_concepts:
+.. _rcu_handbook:
 
 ============
-RCU concepts
+RCU Handbook
 ============
 
 .. toctree::
-- 
2.40.1

