Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDD7375F73;
	Tue,  3 Mar 2026 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581839; cv=none; b=KqIUyK9gRsEXJdJZqRr6jn/8/flOTUXwNy+sL+aZS7WiacFT8agVDUSiDun0YKSxicSJhZPowJwKAyTrkNNR9Gj6BjlXj0WaXdHJTFtet76RW990qIEXZn7uJf69Hm/f1kkDlT5Xh+Ixguyhc2qv0vvXMKNCEY/5ZV2Y6qbsoxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581839; c=relaxed/simple;
	bh=LsxxOfWiPlTxCH05+8fFIJs7Puc5r1ZoF+Dyd6H53mU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BpSNN5a/Qs85HZkmaZcyiboeYZA2QbL0yDh1p1KRNwK+60a3IgBXG7M1BBh10t092CdjMctlUvs5NVp5zaeCJzo8/fT405x+TknqZaZMRI7aBX3z+7jBWFxvJ+XNK7nv1oWhQmcCTeARwUQgA36Pe8EzY8G+TBolUbOeQIp3rmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyQS5Zni; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyQS5Zni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0B2C19422;
	Tue,  3 Mar 2026 23:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772581839;
	bh=LsxxOfWiPlTxCH05+8fFIJs7Puc5r1ZoF+Dyd6H53mU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gyQS5ZniSMEI8kXWSXrBmfWt13A4RYRWrUhbvZvYLpVCmkgKU7vHO1997mg/EFF62
	 7DP4jYzjCOZpBcIPknqSA77uh9+/VqXpVO/W8r6611mLtnc/PurNmL8DcrUddVAlx1
	 V1JrNTuTxjtcnrJlQInMqxgBSK+xFljjRlsnBqm5OaWkB4hf8EMAoh2nN6SP2O+7N6
	 lJ2wnqBgYvr8MhUwdp5xJJW0bKKRJJ8APPrOA4E4TdJHyq8Cz7JOuUNXqoOn1HVKXf
	 CXNQ0jBpzC3+8cJMB4JoPOx2LAKARq4mTfW3jpEyndeqixEaXG9kNMCRPmSvq3kCoX
	 NSbejYE9cSYRg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 01B6FCE10F3; Tue,  3 Mar 2026 15:50:39 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 09/11] srcu: Fix SRCU read flavor macro comments
Date: Tue,  3 Mar 2026 15:50:35 -0800
Message-Id: <20260303235037.1967017-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <50d2bb98-c912-4ba6-a723-4a4aed506fdf@paulmck-laptop>
References: <50d2bb98-c912-4ba6-a723-4a4aed506fdf@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SRCU_READ_FLAVOR_FAST and SRCU_READ_FLAVOR_FAST_UPDOWN comments
need repair.  The former fails to not that SRCU-fast can be used in NMI
handlers, and the latter says that it goes with srcu_read_lock_fast()
when it really goes with srcu_read_lock_fast_updown().  This commit
therefore fixes both comments.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index bb44a0bd76968..81b1938512d5d 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -69,8 +69,8 @@ int init_srcu_struct_fast_updown(struct srcu_struct *ssp);
 #define SRCU_READ_FLAVOR_NORMAL		0x1		// srcu_read_lock().
 #define SRCU_READ_FLAVOR_NMI		0x2		// srcu_read_lock_nmisafe().
 //					0x4		// SRCU-lite is no longer with us.
-#define SRCU_READ_FLAVOR_FAST		0x4		// srcu_read_lock_fast().
-#define SRCU_READ_FLAVOR_FAST_UPDOWN	0x8		// srcu_read_lock_fast().
+#define SRCU_READ_FLAVOR_FAST		0x4		// srcu_read_lock_fast(), also NMI-safe.
+#define SRCU_READ_FLAVOR_FAST_UPDOWN	0x8		// srcu_read_lock_fast_updown().
 #define SRCU_READ_FLAVOR_ALL		(SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
 					 SRCU_READ_FLAVOR_FAST | SRCU_READ_FLAVOR_FAST_UPDOWN)
 						// All of the above.
-- 
2.40.1

