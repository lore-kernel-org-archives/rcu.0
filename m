Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A36D14A4E0
	for <rcu@vger.kernel.org>; Mon,  2 Sep 2024 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274716; cv=none; b=Kz3FIefbYGk+iJkS63j8av6vSpetKuyZZZk+Cvr6nOBYf9TWqwvEFW3Ke4+jHgoEqIfS0Lzb3SOflTNXwgDlSS3y1jm6Eb8m2G22I5ApZp3zV0XEH/TT0A57hMtfLzaRyG/1ArKPvS5Ise4HKQbAJmQAO4N+Q1FE4vfTtIyR6f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274716; c=relaxed/simple;
	bh=wSdt3Wx7vZ4oPK76dfa7OFVYWIb88NvhXStlzaDH/Tc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hz0Sk1eqiUFGHJO3LNwsyH1qnyGIFVtuJuDV31r5/xBu7TKzKqV5++LETzCMfy1XSgk0jIjj1xXVz79BUYfk6N7ChmjlewHUbtN7yWgzQhJpqaupwtk02A5D1aXeE4hqt3Nif1S1IxETwyvqh4Tm4+P5m+7AfSYuskOjprH34uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wy5MT4m9xz2DbYZ;
	Mon,  2 Sep 2024 18:58:13 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B3D1140360;
	Mon,  2 Sep 2024 18:58:31 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Sep
 2024 18:58:30 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <paulmck@kernel.org>, <frederic@kernel.org>, <neeraj.upadhyay@kernel.org>,
	<joel@joelfernandes.org>, <josh@joshtriplett.org>, <boqun.feng@gmail.com>,
	<urezki@gmail.com>, <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
	<jiangshanlai@gmail.com>, <qiang.zhang1211@gmail.com>, <rcu@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] rcu: Use the BITS_PER_LONG macro
Date: Mon, 2 Sep 2024 19:06:54 +0800
Message-ID: <20240902110654.2685917-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)

sizeof(unsigned long) * 8 is the number of bits in an unsigned long
variable, replace it with BITS_PER_LONG macro to make it simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/rcu/tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a60616e69b66..b48864df415c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -5579,8 +5579,7 @@ void rcu_init_geometry(void)
 	 * Complain and fall back to the compile-time values if this
 	 * limit is exceeded.
 	 */
-	if (rcu_fanout_leaf < 2 ||
-	    rcu_fanout_leaf > sizeof(unsigned long) * 8) {
+	if (rcu_fanout_leaf < 2 || rcu_fanout_leaf > BITS_PER_LONG) {
 		rcu_fanout_leaf = RCU_FANOUT_LEAF;
 		WARN_ON(1);
 		return;
-- 
2.34.1

