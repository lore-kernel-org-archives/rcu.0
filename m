Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE622C178D;
	Wed,  9 Jul 2025 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058049; cv=none; b=jw9iGyhUsC9WhXBMJ/8ass1xMOwPYSw+RGgKQ9H5GKU2fBvau1TMrc/+ubjze3luSPhk1JQNDGHFjaiy8JvpZgeLIgz6IxA3ZESqKc3Uy3XSIOHEoYxumPlNlnV1QTsVvYuIlIq38sybz405tng10GOBvGUdNGUQxv/txELsaCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058049; c=relaxed/simple;
	bh=8+QgGthh07yyBXpymRCqckI8rQU9IPQHXyuQVbzDg1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ivo15w9V0aDmm8yAqTgwRScswAM5mgiVwmYE0Is74InW2Lw6lhs2BTh2F7hNCMgHqlCf3jDdt5F2l1Pw52itRXnMs963KutlLrtcrKi0cLId1BMgxBv5xqc6z9Z37X1QAInuJShb8iqNEhw+0yizcKr55gvZ3zcu3uJe47sOue8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEH0eOsi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEH0eOsi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F709C4CEEF;
	Wed,  9 Jul 2025 10:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752058049;
	bh=8+QgGthh07yyBXpymRCqckI8rQU9IPQHXyuQVbzDg1M=;
	h=From:To:Cc:Subject:Date:From;
	b=JEH0eOsiPAHKr5t6kup6HK6stn2XjwXFxHxAtqXkyjzRzEmFyTr2kok0qThpTvgc+
	 AldQDTAhJDQHSTzUNagtmDqSC4UmCGqFor8Alwp1LYO8gxN0VwV2bihgw4YlgEk/C7
	 4B2yGFuPMLxpWdTsK0zO5jS/BG6b+D8XijHc9nrqGYu7+98vmOW9isj8+QlgAtVdYW
	 wWoGHx0MY8qvnmt1OkLQ+n7+Ddw+abp5CBz+2U3fpWUkStRMf9klaGUZ9Z7hxRt9kh
	 3BV0h7XfVBTJK0VIpPT4sT8cVVqUOqcVG2QZlM+AQl/gxH5+dJVEck0TWqlydEuQgX
	 yV3ucJ1FE6ekg==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 0/1] Refscale changes for v6.17
Date: Wed,  9 Jul 2025 16:17:11 +0530
Message-Id: <20250709104712.15728-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>

Hello,

This patch series contains following updates to the refscale code (rebased
on v6.16-rc3):

Artem Sadovnikov (1):
  refscale: Check that nreaders and loops multiplication doesn't
    overflow

 kernel/rcu/refscale.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.40.1

