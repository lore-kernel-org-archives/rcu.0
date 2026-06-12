Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2927D331A56
	for <rcu@vger.kernel.org>; Fri, 12 Jun 2026 02:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781231723; cv=none; b=Nr8htU5Vw0MCxIoy/3EbnwVmPWXpxc0vG2xxcmGHOSQe/rZt3rzDnZPf5cV1E89Vis5Ey4rYjLmNk2WRL524G9cHMIaQlCz8GxYWDgrNWa4EWeBcg/Io+bhcTsURcSFcVbs084mtcP9OJrq4HkgjEK7LJW3cdKnpMkcdV90gbio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781231723; c=relaxed/simple;
	bh=FLu0d7B8QvnaQsKbCZJYC58kz8T3KyzJWg9wgCkuitA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LV8ghtcAWrfWI5tAQVLwc+wetpWpRMGbOftiAg24YVlwRz7/qZx5YWMkU1g7SXOIEbBGnzJ7m6P91XcxAyPVfmHnFNKY3XrtMxZaVnY1+dZ6DmsVHjVzjskqWyyNUm1OFJKtik836gszUpTEBtT2pqP3CSwiMvAdIxrK5sPZlXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s8stIotX; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s8stIotX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781231720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JU191SITecTWC0SD07RMi1rpH/CxSSF00YZEzaSXdcY=;
	b=s8stIotXYngU/xa0gOZE1mJqM4aEGz8Rf1BYrIaD0dlNn0Ij8YDCvCuEDZkUmuyvIx8pDP
	hEA0Y8ew7ZhsUxbfZw4qUUYf4GVnl3MmiKxeIGnqRjhgof7YoqRPJ69Ze9kg82Raf3wCqp
	LIAPOorcUo7oKdbwaBc3WMUdRGXJiq0=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun@kernel.org,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	dave@stgolabs.net
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH v2 0/3] rcu: Improve task-state reporting readability
Date: Fri, 12 Jun 2026 10:34:11 +0800
Message-ID: <20260612023414.679618-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <kunwu.chan@gmail.com>

This series replaces raw hexadecimal task-state values with
task_state_to_char() output in RCU-related diagnostic messages.

---
Changes in v2:
- Split the original patch into three commits, one per file.
- No code changes.

v1:
https://lore.kernel.org/rcu/442e80e0-4f91-421c-ab68-d26e0a031472@paulmck-laptop/

Based on: linux-rcu repo (dev branch)
URL: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
base-commit: 85bf11e84 ("smp: Make CSD lock acquisition atomic for debug mode")

Kunwu Chan (3):
  rcu: Use task_state_to_char() in stall-warning prints
  rcutorture: Use task_state_to_char() for task-state reporting
  hazptrtorture: Use task_state_to_char() for task-state reporting

 kernel/rcu/hazptrtorture.c |  4 ++--
 kernel/rcu/rcutorture.c    |  4 ++--
 kernel/rcu/tree_stall.h    | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.43.0

