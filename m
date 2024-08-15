Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087BB29CFB;
	Thu, 15 Aug 2024 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712024; cv=none; b=OqSZCtG8xcEn5oik+KI79lnOKUwMPIzsnMpBhCdrmd5J2+venqJwBVYEEHzCBUFxkBTlm/tMXmEXJImgnlLmN48vF951iiki+yw09Xqrp+epqLTAYTLSlqf8DAOB8SUZw8foSukVyjPCfqeAUPEWqHjDak/sgVyBdJoUXb0lqRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712024; c=relaxed/simple;
	bh=U9At60163l5+UDakQ+rjMaFnvCoPHnPpJALKVDN+rpU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AX5bPcGFcaLM7gLG4xC6+lFPwMMLbJoztWIwaLg670J0WTA7tekHGGZ1f9Ak6YDsnT+58XO+rVCHNFlKOXBnPPd7kflLk54yeOg3aIdUDVqoPMBa8Au1WOSK38QL7Cb6OgwTRIjF1mzKGFyt4dY7Yscp4MTC43FwymQe1WVYCTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WkzPm4491zhXn2;
	Thu, 15 Aug 2024 16:51:40 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C96E1400D4;
	Thu, 15 Aug 2024 16:53:38 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 15 Aug
 2024 16:53:37 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <paulmck@kernel.org>, <frederic@kernel.org>, <neeraj.upadhyay@kernel.org>,
	<joel@joelfernandes.org>, <josh@joshtriplett.org>, <boqun.feng@gmail.com>,
	<urezki@gmail.com>, <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
	<jiangshanlai@gmail.com>, <qiang.zhang1211@gmail.com>
CC: <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH -next] rcu: Remove unused declaration rcu_segcblist_offload()
Date: Thu, 15 Aug 2024 16:50:53 +0800
Message-ID: <20240815085053.4157590-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit 17351eb59abd ("rcu/nocb: Simplify (de-)offloading state machine")
removed the implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 kernel/rcu/rcu_segcblist.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 259904075636..fadc08ad4b7b 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -120,7 +120,6 @@ void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
 void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v);
 void rcu_segcblist_init(struct rcu_segcblist *rsclp);
 void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
-void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload);
 bool rcu_segcblist_ready_cbs(struct rcu_segcblist *rsclp);
 bool rcu_segcblist_pend_cbs(struct rcu_segcblist *rsclp);
 struct rcu_head *rcu_segcblist_first_cb(struct rcu_segcblist *rsclp);
-- 
2.34.1

