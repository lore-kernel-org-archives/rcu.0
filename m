Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDBB12D758;
	Fri, 16 Aug 2024 07:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793036; cv=none; b=NL8qopQF7nirYSV9zV+TkjuxNdAa2PYGTnixdb6mxSr8iLv/oHVUi859tpv7vFdidewakjxrTvk2jY23RCnOwDfEJymLZebYGJHO0WBFTqJGBlLsLvC8AMnK+bnUKF/ce02rxgNTb1TYwDrPujteoRopN6MBrX7MSUoHvfXIOVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793036; c=relaxed/simple;
	bh=eGmgAaZh6wSDvQDRjeeZIys0lYofLe7O5SLfEHYjDpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=omQ9lc9TYaI/BSjyh4kcSijsZkEi+0k5YirY0dgjIHxrWQmanfPPYvt8Ttefm9frtkYkZxREL1U40qJq/KWp5s0tDkTEy63cJ5nvu4oqXjz54QwL8/vRpXV8QiSgHu9kW1Yd5E4S/8UnLWTaGjeSYDHMNnzRgBkU69O5LlUD86M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0XzHVcx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0XzHVcx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1211EC32782;
	Fri, 16 Aug 2024 07:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723793035;
	bh=eGmgAaZh6wSDvQDRjeeZIys0lYofLe7O5SLfEHYjDpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d0XzHVcx8eso+SzlLhod7g/ZK8KJGMOJvNiR8rZI+vm7vAqrL0IgFSnddRJenK5NH
	 UKZJC10sYLpY0kfForJv43RFjcNuZ8QafXOe+RCrTuDD3/E/QDieg9OuF3mv/vSVLt
	 wUcPeMtMmRz7Oxo4V+Buiq1WbYX93maqUWajlDzNJ1vnh0r/eGbo4plM6YJU15Gg+n
	 rhvLnJMVy9CsZ5xHCQb3rgCWkOlwgJMf/rjONOP9tPlvYiorQml1O+2V8JSIYWCy5x
	 fz/rZGG6LLv8HS7F2MvdTerMdEod8ErJhZ6odE1a0Sms/qgHmseO279KZ9ZmTFUIhA
	 ZLgF3nndg7YrQ==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH rcu 3/3] rcu: Annotate struct kvfree_rcu_bulk_data with __counted_by()
Date: Fri, 16 Aug 2024 12:52:54 +0530
Message-Id: <20240816072254.65928-3-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816072210.GA65644@neeraj.linux>
References: <20240816072210.GA65644@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@toblux.com>

Add the __counted_by compiler attribute to the flexible array member
records to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Increment nr_records before adding a new pointer to the records array.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Reviewed-by: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Reviewed-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0f41a81138dc..d5bf824159da 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3227,7 +3227,7 @@ struct kvfree_rcu_bulk_data {
 	struct list_head list;
 	struct rcu_gp_oldstate gp_snap;
 	unsigned long nr_records;
-	void *records[];
+	void *records[] __counted_by(nr_records);
 };
 
 /*
@@ -3767,7 +3767,8 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 	}
 
 	// Finally insert and update the GP for this page.
-	bnode->records[bnode->nr_records++] = ptr;
+	bnode->nr_records++;
+	bnode->records[bnode->nr_records - 1] = ptr;
 	get_state_synchronize_rcu_full(&bnode->gp_snap);
 	atomic_inc(&(*krcp)->bulk_count[idx]);
 
-- 
2.40.1

