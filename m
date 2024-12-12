Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0431925BC;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029400; cv=none; b=ZibGeaEVJJGwOI0POms5W+TxJ/4CRigbVNb5HtJUCZVj21EywqBVCV3Q1y/uZiCnURKQktDkSz/LXMcOzlHsNLX5ymiuKjsmRzbRW39hefOsxWEZ/oCrAfHna9StthSQf7cUb7RNk3gC2EUS748GINg1G2HozBcZqmucUle7Dtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029400; c=relaxed/simple;
	bh=oXm7pdu/y2pIm0x3QXBX2ZtgROLA8wEBkuuwv+gFUqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eCsWA1AwX1d3a/74UGS47tS4qdLBs8o8uuLL5rzEd2QUNCA64Y8nKvYJbvgDJ0I1ctbZ47SoDbdJLwBgLOSIBVDvS+DLcVdY6IAf6LBiaudtpiPp4rmBzsNEGtb6J0CWAjLNVapQXpXf2yCAg+VmXo5DFbieK2Fexp2U7U/cgK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJYFMX56; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJYFMX56"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FA6C4AF0D;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029400;
	bh=oXm7pdu/y2pIm0x3QXBX2ZtgROLA8wEBkuuwv+gFUqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJYFMX56ZfJefwmAGRNq5EjPxkPngJMHcRoPIBBcj6yw7ariwtaXJcZ+ydhSyW8wf
	 ACNguzcrNVME8MCFLC34Y2cFqYvkZf35q51leb9lwVjmf/S4O5LCMmWOWgFTd7pRww
	 1sLzZ//zqNkBIYuHPbprnUdirsu0O11PvbOTWDnJIfG4AqRMSKpkQ9kgyhx3iZ97o7
	 VZeqNyx2MPlRo0Dt+YIBZzGdVfNZ50axwiE1CiIXwatnVPmQvJmkGdvNdrTM4/r/e5
	 BzGjgXJaMxHRxLIix9LnxEwEpSpCAfiD9uH6OOAfpLyLzpjhOdVNGy+hQdnQASPWrf
	 8DaM1Dwjpuy6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CAA5ECE10D9; Thu, 12 Dec 2024 10:49:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 09/18] rcutorture: Add full read-side contexts to "busted" torture type
Date: Thu, 12 Dec 2024 10:49:48 -0800
Message-Id: <20241212184957.2127441-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
References: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of the "busted" torture type is to test rcutorture code paths
used only when a too-short grace period is detected.  Currently, "busted"
only uses normal rcu_read_lock()-style readers, which fails to exercise
much of the "Failure/close-call rcutorture reader segments" functionality.
This commit therefore sets the .extendables field of rcu_busted_ops to
RCUTORTURE_MAX_EXTEND in order to more fully exercise the reporting.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 61b092a3dc3f3..81b3743f81dca 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -639,6 +639,7 @@ static struct rcu_torture_ops rcu_busted_ops = {
 	.exp_sync	= synchronize_rcu_busted,
 	.call		= call_rcu_busted,
 	.irq_capable	= 1,
+	.extendables	= RCUTORTURE_MAX_EXTEND,
 	.name		= "busted"
 };
 
-- 
2.40.1

