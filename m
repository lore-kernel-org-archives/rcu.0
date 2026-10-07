Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3109041D13D;
	Wed,  7 Oct 2026 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406769; cv=none; b=IXCr6vErzRt4lwmQqs8TQtmOpU/SKTL1ElFSScDGR6ZG9FHOmVjPX6k5s3YnobfiqDXeLBhgYW7OxdgA57K809CrQSFXo+rTsaLlx6WRnmBnrYeNAgleM5XqNvQK9j/DK+QSbywqmZQsIbEvHExRZggUq8+kSYOmGshE+B/0k2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406769; c=relaxed/simple;
	bh=Nr6G1HwJjyO3gVdy3VBDkpKSKu1UBqYDHlmUKMnfp+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CG8mpzctr9CwbK9IeszgimTdAf9fNqLx0NIWSzLX35/VXAPQx2FQpXb0ZTAfijpfvOdpii/kwDLTRtEXkoVSClNSe/t6ljAjXTWJrmudkWOP7joX/dwXJjOfNHRBmJWiZneoMXEHklB+/V1LWmGnY1Wh3Zs4wL3PWfnAaLVrbS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyBk7K6h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyBk7K6h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98581F008BE;
	Wed,  7 Oct 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406766;
	bh=MgGadDGs+NQUReQILm41h6P8d3IAjttKGXALi1RokW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PyBk7K6hhY9QFRK0zLvwIrXQ2DLldpMPQSNNQGYEnUbLOQl0ajyNMwN1w5zEiqf7N
	 Ki2h+guOnAcS4O7+e1f6aZ60+GOZxWYm0he/e9qe8slk9eWZT03kCyjqAAVMVDvZWP
	 8oMTbMJzh6nGeEmRqsi37c3xBO58zEhNogoK1jxtx6wW+veGdHqaLrk2ykfU7Fj65N
	 F4HTMs0GLnDXs02JN4eU3RHbXJPZI/Y/AmrioXFzu4WtpFaE/v2OiVN+MFp5pWEINe
	 649CsFUt8Quer+oeomM50YdFhlpfN1Tfh6Lpr2z/+DWxbrLj9FxFNT+dOssDgiOkkR
	 ZwJgol2s+d4IQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3D124CE3996; Wed,  7 Oct 2026 13:59:25 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 18/21] srcutree: Skip torture to-big transition for atomic SRCU
Date: Wed,  7 Oct 2026 13:59:21 -0700
Message-Id: <20261007205924.1983367-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

Atomic SRCU does not use the srcu_node combining tree. Exclude it
from the SRCU_SIZING_IS_TORTURE() transition in
srcu_torture_stats_print(), and warn if such a transition is requested.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6a05bd8a6f390..6e37d53b412e1 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -2422,8 +2422,10 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 		}
 		pr_cont(" T(%ld,%ld)\n", s0, s1);
 	}
-	if (SRCU_SIZING_IS_TORTURE())
-		srcu_transition_to_big(ssp);
+	if (SRCU_SIZING_IS_TORTURE()) {
+		if (!WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
+			srcu_transition_to_big(ssp);
+	}
 }
 EXPORT_SYMBOL_GPL(srcu_torture_stats_print);
 
-- 
2.40.1

